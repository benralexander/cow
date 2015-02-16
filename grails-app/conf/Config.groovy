import grails.util.Environment

// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

site.title = 'Small-scale graphics demos'  // could be 'SIGMA T2D' or 'Type 2 Diabetes Genetics'

if  (Environment.current == Environment.DEVELOPMENT)  {
    println('\n\n*** Preparing DEV environment ***\n\n')
} else if  (Environment.current == Environment.TEST)  {
    println('\n\n*** Preparing TEST environment ***\n\n')
}   else if  (Environment.current == Environment.PRODUCTION)  {
    println('\n\n*** Preparing PROD environment ***\n\n')
}  else {
    println("\n\n*** Preparing ${Environment.current} environment ***\n\n")
}


/**
 * Loads external config files from the .grails subfolder in the user's home directory
 * Home directory in Windows is usually: C:\Users\<username>\.grails
 * In Unix, this is usually ~\.grails
 *
 * dataExport-commons-config.groovy is used to holed generic, non envrironment-specific configurations such as external api credentials, etc.
 */
if (appName) {
    grails.config.locations = []

    // If the developer specifies a directory for the external config files at the command line, use it.
    // This will look like 'grails -DprimaryConfigDir=[directory name] [target]'
    // Otherwise, look for these files in the user's home .grails/projectdb directory
    // If there are no external config files in either location, don't override anything in this Config.groovy
    String primaryOverrideDirName = System.properties.get('overrideConfigDir')
    String secondaryOverrideDirName = "${userHome}/.grails/${appName}"

    println (">>>>>>>>>>>Note to developers: config files may be placed in the directory  = ${secondaryOverrideDirName}")
    println (">>>>>>>>>>>Alternatively, specify the directory you are drawing from with the grails option -DoverrideConfigDir=myDirectoryWhichMightBeNamedWhateverIWant")


    List<String> fileNames = ["${appName}-commons-config.groovy", "${appName}-${Environment.current.name}-config.groovy"]
    fileNames.each { fileName ->
        String primaryFullName = "${primaryOverrideDirName}/${fileName}"
        String secondaryFullName = "${secondaryOverrideDirName}/${fileName}"

        if (new File(primaryFullName).exists()) {
            println "Overriding Config.groovy with $primaryFullName"
            grails.config.locations << "file:$primaryFullName"
        } else if (new File(secondaryFullName).exists()) {
            println "Overriding Config.groovy with $secondaryFullName"
            grails.config.locations << "file:$secondaryFullName"
        }
    }
}

if (grails.config.locations.isEmpty()){
    println "\n** No config override  in effect **"
} else {
    println "\n** !! config override is in effect !! **"
    for (location in grails.config.locations )   {
        println "!!!!! ${location} !! **"
    }
}



grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

environments {
    development {
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        grails.serverURL = "http://graphicscow.org"
    }
}


oauth {

    providers {

        google {
            api = org.grails.plugin.springsecurity.oauth.GoogleApi20
            key = '975413760331-d2nr5vq7sbbppjfog0cp9j4agesbeovt.apps.googleusercontent.com'

            successUri = "${baseURL}/springSecurityOAuth/onSuccess"
            failureUri = '/oauth/google/error'
            callback = "${baseURL}/springSecurityOAuth/codeExchange?provider=google"
            scope = 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
        }

    }
}
auth {

    providers {

        twitter {
            key = 'mAbvjXZycxMSBCXQUYttdFm5L'
            secret = 'l3dJBs3w9QraAuivcfaqdjVGkJ4cxQSMMNNkZ6v9bwz8nXBCXQ'
            callback = "${baseURL}/springSecurityOAuth/oauthInit"
        }

    }
}


googleapi {
    baseUrl = 'www.googleapis.com'
}





// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'cow.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'cow.UserRole'
grails.plugin.springsecurity.authority.className = 'cow.Role'

// minimal nec. to get going
grails.plugin.springsecurity.authority.defaultTargetUrl = '/home'
grails.plugin.springsecurity.securityConfigType = "InterceptUrlMap"
grails.plugin.springsecurity.interceptUrlMap = [
        '/':                        ['permitAll'],
        '/**':                        ['permitAll'],
        '/home':                    ['permitAll'],
        '/home/**':                 ['permitAll']];


grails.plugin.springsecurity.controllerAnnotations.staticRules = [
        '/':                              ['permitAll'],
        '/index':                         ['permitAll'],
        '/index.gsp':                     ['permitAll'],
        '/assets/**':                     ['permitAll'],
        '/**/js/**':                      ['permitAll'],
        '/**/css/**':                     ['permitAll'],
        '/**/images/**':                  ['permitAll'],
        '/**/favicon.ico':                ['permitAll']
]


// Added by the Spring Security OAuth plugin:
grails.plugin.springsecurity.oauth.domainClass = 'cow.OAuthID'





// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}


// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'cow.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'cow.UserRole'
grails.plugin.springsecurity.authority.className = 'cow.Role'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/':                              ['permitAll'],
	'/index':                         ['permitAll'],
	'/index.gsp':                     ['permitAll'],
	'/assets/**':                     ['permitAll'],
	'/**/js/**':                      ['permitAll'],
	'/**/css/**':                     ['permitAll'],
	'/**/images/**':                  ['permitAll'],
	'/**/favicon.ico':                ['permitAll']
]


// Added by the Spring Security OAuth plugin:
grails.plugin.springsecurity.oauth.domainClass = 'cow.OAuthID'

auth.providers.twitter.secret = 'ccc'
oauth.providers.google.secret = 'bbb'
mapbox.secret.token='aaa'