/*
 * Copyright 2012 the original author or authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package googlesignin

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.oauth.OAuthToken
import grails.plugin.springsecurity.userdetails.GormUserDetailsService
import grails.plugin.springsecurity.userdetails.GrailsUser
import cow.OAuthID
import cow.Role
import cow.User
import cow.UserRole
import locker2.GoogleRestService
import locker2.SpringManipService
import org.apache.juli.logging.LogFactory
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.security.core.authority.GrantedAuthorityImpl
import org.springframework.security.core.context.SecurityContextHolder
import uk.co.desirableobjects.oauth.scribe.OauthService

/**
 * Simple helper controller for handling OAuth authentication and integrating it
 * into Spring Security.
 */
class SpringSecurityOAuthController {

    public static final String SPRING_SECURITY_OAUTH_TOKEN = 'springSecurityOAuthToken'

    GrailsApplication grailsApplication
    OauthService oauthService
    SpringSecurityService springSecurityService
    GoogleRestService googleRestService
    SpringManipService springManipService
    private static final log = LogFactory.getLog(this)

    /**
     * This can be used as a callback for a successful OAuth authentication
     * attempt. It logs the associated user in if he or she has an internal
     * Spring Security account and redirects to <tt>targetUri</tt> (provided as a URL
     * parameter or in the session). Otherwise it redirects to a URL for
     * linking OAuth identities to Spring Security accounts. The application must implement
     * the page and provide the associated URL via the <tt>oauth.registration.askToLinkOrCreateAccountUri</tt>
     * configuration setting.
     */
    def onSuccess = {
        // Validate the 'provider' URL. Any errors here are either misconfiguration
        // or web crawlers (or malicious users).
        params.provider="google"
        if (!params.provider) {
            renderError 400, "The Spring Security OAuth callback URL must include the 'provider' URL parameter."
            return
        }

        def sessionKey = oauthService.findSessionKeyForAccessToken(params.provider)
        if (!session[sessionKey]) {
            renderError 500, "No OAuth token in the session for provider '${params.provider}'!"
            return
        }

        // Create the relevant authentication token and attempt to log in.
        OAuthToken oAuthToken = createAuthToken(params.provider, session[sessionKey])

        if (oAuthToken.principal instanceof GrailsUser) {
            authenticateAndRedirect(oAuthToken, defaultTargetUrl)
        } else {
            // This OAuth account hasn't been registered against an internal
            // account yet. Give the oAuthID the opportunity to create a new
            // internal account or link to an existing one.
            session[SPRING_SECURITY_OAUTH_TOKEN] = oAuthToken

            def redirectUrl = SpringSecurityUtils.securityConfig.oauth.registration.askToLinkOrCreateAccountUri
            assert redirectUrl, "grails.plugin.springsecurity.oauth.registration.askToLinkOrCreateAccountUri" +
                    " configuration option must be set!"
            log.debug "Redirecting to askToLinkOrCreateAccountUri: ${redirectUrl}"
            redirect(redirectUrl instanceof Map ? redirectUrl : [uri: redirectUrl])
        }
    }

    def onFailure = {
        authenticateAndRedirect(null, defaultTargetUrl)
    }

    def askToLinkOrCreateAccount = {
        if (springSecurityService.loggedIn) {
            def currentUser = springSecurityService.currentUser
            OAuthToken oAuthToken = session[SPRING_SECURITY_OAUTH_TOKEN]
            assert oAuthToken, "There is no auth token in the session!"
            currentUser.addToOAuthIDs(provider: oAuthToken.providerName, accessToken: oAuthToken.socialId, user: currentUser)
            if (currentUser.validate() && currentUser.save()) {
                oAuthToken = updateOAuthToken(oAuthToken, currentUser)
                authenticateAndRedirect(oAuthToken, defaultTargetUrl)
                return
            }
        }
    }


    def twitterLogin(){
        JSONObject searchResults = googleRestService.executeTwitterRequest(googleRestService.retrieveTwitterAccessToken (),
                googleRestService.buildTwitterRequest (params.a,params.latitude,params.longitude,params.language,params.radius))
              //  "q=${params.a}&lang=en&count=100&geocode=${params.latitude},${params.longitude},500km")
        render(status:200, contentType:"application/json") {
                [searchResults:searchResults]
        }
    }


    //stream
    def twitterStream(){
        Map parameters = [:]
        Map body = [:]
//        parameters['delimited']='length'
//        parameters['lang']='en'
//        parameters['geocode']='13.239945499286312,-12.65625,400km'

          parameters['track']='twitter'
        body['track']=['twitter']
        JSONObject searchResults = googleRestService.initiateTwitterStream(parameters,body)
               // "delimited=length&lang=en&geocode=13.239945499286312,-12.65625,400km")
        //  "q=${params.a}&lang=en&count=100&geocode=${params.latitude},${params.longitude},500km")
        render(status:200, contentType:"application/json") {
            [searchResults:searchResults]
        }
    }





    /**
     * Associates an OAuthID with an existing account. Needs the user's password to ensure
     * that the user owns that account, and authenticates to verify before linking.
     */
    def linkAccount = { OAuthLinkAccountCommand command ->
        OAuthToken oAuthToken = session[SPRING_SECURITY_OAUTH_TOKEN]
        assert oAuthToken, "There is no auth token in the session!"

        if (request.post) {
            boolean linked = command.validate() && User.withTransaction { status ->
                User user = User.findByUsernameAndPassword(
                        command.username, springSecurityService.encodePassword(command.password))
                if (user) {
                    user.addToOAuthIDs(provider: oAuthToken.providerName, accessToken: oAuthToken.socialId, user: user)
                    if (user.validate() && user.save()) {
                        oAuthToken = updateOAuthToken(oAuthToken, user)
                        return true
                    }
                } else {
                    command.errors.rejectValue("username", "OAuthLinkAccountCommand.username.not.exists")
                }

                status.setRollbackOnly()
                return false
            }

            if (linked) {
                authenticateAndRedirect(oAuthToken, defaultTargetUrl)
                return
            }
        }

        render view: 'askToLinkOrCreateAccount', model: [linkAccountCommand: command]
        return
    }



   def codeExchange  = {
       // Validate the 'provider' URL. Any errors here are either misconfiguration
       // or web crawlers (or malicious users).
       params.provider="google"
       if (!params.provider) {
           renderError 400, "The Spring Security OAuth callback URL must include the 'provider' URL parameter."
           return
       }

       String code = params.code
       JSONObject jsonObject =   googleRestService.buildCallToRetrieveOneTimeCode(code)

       log.debug "jsonObject = ${jsonObject}"

       String identifier = jsonObject.emails['value']

       // break out the fields we want
       String email = jsonObject.emails['value'][0]
       String ID = jsonObject["id"]
       String domain = jsonObject["domain"]
       String language = jsonObject["language"]
       String displayName = jsonObject["displayName"]
       String objectType = jsonObject["objectType"]

       springManipService.forceLogin(identifier,session)

       render (view: 'hello', model:[email: email,
       ID: ID,
       domain: domain,
       language: language,
       displayName:displayName,
       objectType:objectType])
   }









    def createAccount = { OAuthCreateAccountCommand command ->
        OAuthToken oAuthToken = session[SPRING_SECURITY_OAUTH_TOKEN]
        assert oAuthToken, "There is no auth token in the session!"

        if (request.post) {
            if (!springSecurityService.loggedIn) {
                def config = SpringSecurityUtils.securityConfig

                boolean created = command.validate() && User.withTransaction { status ->
                    User user = new User(username: command.username, password: command.password1, enabled: true)
                    user.addToOAuthIDs(provider: oAuthToken.providerName, accessToken: oAuthToken.socialId, user: user)

                    // updateUser(user, oAuthToken)

                    if (!user.validate() || !user.save()) {
                        status.setRollbackOnly()
                        return false
                    }

                    for (roleName in config.oauth.registration.roleNames) {
                        UserRole.create user, Role.findByAuthority(roleName)
                    }

                    oAuthToken = updateOAuthToken(oAuthToken, user)
                    return true
                }

                if (created) {
                    authenticateAndRedirect(oAuthToken, defaultTargetUrl)
                    return
                }
            }
        }

        render view: 'askToLinkOrCreateAccount', model: [createAccountCommand: command]
    }

    // utils

    protected renderError(code, msg) {
        log.error msg + " (returning ${code})"
        render status: code, text: msg
    }

    protected OAuthToken createAuthToken(providerName, scribeToken) {
        def providerService = grailsApplication.mainContext.getBean("${providerName}SpringSecurityOAuthService")
        OAuthToken oAuthToken = providerService.createAuthToken(scribeToken)

        def oAuthID = OAuthID.findByProviderAndAccessToken(oAuthToken.providerName, oAuthToken.socialId)
        if (oAuthID) {
            updateOAuthToken(oAuthToken, oAuthID.user)
        }

        return oAuthToken
    }

    protected OAuthToken updateOAuthToken(OAuthToken oAuthToken, User user) {
        def conf = SpringSecurityUtils.securityConfig

        // user

        String usernamePropertyName = conf.userLookup.usernamePropertyName
        String passwordPropertyName = conf.userLookup.passwordPropertyName
        String enabledPropertyName = conf.userLookup.enabledPropertyName
        String accountExpiredPropertyName = conf.userLookup.accountExpiredPropertyName
        String accountLockedPropertyName = conf.userLookup.accountLockedPropertyName
        String passwordExpiredPropertyName = conf.userLookup.passwordExpiredPropertyName

        String username = user."${usernamePropertyName}"
        String password = user."${passwordPropertyName}"
        boolean enabled = enabledPropertyName ? user."${enabledPropertyName}" : true
        boolean accountExpired = accountExpiredPropertyName ? user."${accountExpiredPropertyName}" : false
        boolean accountLocked = accountLockedPropertyName ? user."${accountLockedPropertyName}" : false
        boolean passwordExpired = passwordExpiredPropertyName ? user."${passwordExpiredPropertyName}" : false

        // authorities

        String authoritiesPropertyName = conf.userLookup.authoritiesPropertyName
        String authorityPropertyName = conf.authority.nameField
        Collection<?> userAuthorities = user."${authoritiesPropertyName}"
        def authorities = userAuthorities.collect { new GrantedAuthorityImpl(it."${authorityPropertyName}") }

        oAuthToken.principal = new GrailsUser(username, password, enabled, !accountExpired, !passwordExpired,
                !accountLocked, authorities ?: [GormUserDetailsService.NO_ROLE], user.id)
        oAuthToken.authorities = authorities
        oAuthToken.authenticated = true

        return oAuthToken
    }




    protected Map getDefaultTargetUrl() {
        def config = SpringSecurityUtils.securityConfig
        def savedRequest = SpringSecurityUtils.getSavedRequest(session)
        def defaultUrlOnNull = '/'

        if (savedRequest && !config.successHandler.alwaysUseDefault) {
            return [url: (savedRequest.redirectUrl ?: defaultUrlOnNull)]
        } else {
            return [uri: (config.successHandler.defaultTargetUrl ?: defaultUrlOnNull)]
        }
    }

    protected void authenticateAndRedirect(OAuthToken oAuthToken, redirectUrl) {
        session.removeAttribute SPRING_SECURITY_OAUTH_TOKEN

        SecurityContextHolder.context.authentication = oAuthToken
        redirect(redirectUrl instanceof Map ? redirectUrl : [uri: redirectUrl])
    }

}

class OAuthCreateAccountCommand {

    String username
    String password1
    String password2

    static constraints = {
        username blank: false, validator: { String username, command ->
            User.withNewSession { session ->
                if (username && User.countByUsername(username)) {
                    return 'OAuthCreateAccountCommand.username.error.unique'
                }
            }
        }
        password1 blank: false, minSize: 8, maxSize: 64, validator: { password1, command ->
            if (command.username && command.username.equals(password1)) {
                return 'OAuthCreateAccountCommand.password.error.username'
            }

            if (password1 && password1.length() >= 8 && password1.length() <= 64 &&
                    (!password1.matches('^.*\\p{Alpha}.*$') ||
                     !password1.matches('^.*\\p{Digit}.*$') ||
                     !password1.matches('^.*[!@#$%^&].*$'))) {
                return 'OAuthCreateAccountCommand.password.error.strength'
            }
        }
        password2 nullable: true, blank: true, validator: { password2, command ->
            if (command.password1 != password2) {
                return 'OAuthCreateAccountCommand.password.error.mismatch'
            }
        }
    }
}

class OAuthLinkAccountCommand {

    String username
    String password

    static constraints = {
        username blank: false
        password blank: false
    }

}
