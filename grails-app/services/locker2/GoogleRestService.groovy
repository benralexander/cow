package locker2

import grails.plugins.rest.client.RestBuilder
import grails.plugins.rest.client.RestResponse
import grails.transaction.Transactional
import org.apache.juli.logging.LogFactory
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.codehaus.groovy.grails.web.json.JSONObject
import org.scribe.model.OAuthRequest
import org.springframework.util.LinkedMultiValueMap
import org.springframework.util.MultiValueMap

@Transactional
class GoogleRestService {

    GrailsApplication grailsApplication
    private static final log = LogFactory.getLog(this)

    private  String MYSQL_REST_SERVER = ""

    JSONObject buildCallToRetrieveOneTimeCode(String oneTimeCode) {
        String destination =   "https://${grailsApplication.config.googleapi.baseUrl}/oauth2/v3/token"
      //  String encodedRedirectUrl=URLEncoder.encode(grailsApplication.config.oauth.providers.google.successUri, "UTF-8")
        String encodedRedirectUrl=URLEncoder.encode(grailsApplication.config.oauth.providers.google.callback, "UTF-8")
        String contents = "code=${oneTimeCode}&"+
                          "client_id=${grailsApplication.config.oauth.providers.google.key}&"+
                          "client_secret=${grailsApplication.config.oauth.providers.google.secret}&"+
                          "redirect_uri=${encodedRedirectUrl}&"+
                          "grant_type=authorization_code"
        JSONObject jsonObject = postGoogleRestCallBase (contents,destination)
        String idToken = jsonObject.id_token
        String accessToken = jsonObject.access_token
        JSONObject identityInformation =  postAuthorizedGoogleRestCall(accessToken,"https://www.googleapis.com/plus/v1/people/me")
        log.info(""+
        identityInformation.emails['value']+
        identityInformation.id+
        identityInformation.name ['familyName']+
        identityInformation.name ['givenName']+
        identityInformation.displayName+
        identityInformation.domain+
        identityInformation.gender+
        identityInformation.language+
        identityInformation.etag)
        return identityInformation
    }

    private JSONObject postGoogleRestCallBase(String drivingContents, String targetUrl){
        JSONObject returnValue = null as JSONObject
        Date beforeCall  = new Date()
        Date afterCall
        RestResponse response
        RestBuilder rest = new grails.plugins.rest.client.RestBuilder()
        StringBuilder logStatus = new StringBuilder()
        try {
            response  = rest.post(targetUrl)   {
                contentType "application/x-www-form-urlencoded"
                json drivingContents
            }
            afterCall  = new Date()
        } catch ( Exception exception){
            log.error("NOTE: exception on post to backend. Target=${targetUrl}, driving Json=${drivingContents}")
            log.error(exception.toString())
            logStatus <<  "NOTE: exception on post to backend. Target=${targetUrl}, driving Json=${drivingContents}"
            afterCall  = new Date()
        }
        logStatus << """
SERVER CALL:
url=${targetUrl},
parm=${drivingContents},
time required=${(afterCall.time-beforeCall.time)/1000} seconds
""".toString()
        if (response?.responseEntity?.statusCode?.value == 200) {
            returnValue =  response.json
            logStatus << """status: ok""".toString()
        }  else {
            JSONObject tempValue =  response.json
            logStatus << """status: ${response.responseEntity.statusCode.value}""".toString()
            if  (tempValue)  {
                logStatus << """is_error: ${response.json["is_error"]}""".toString()
            }  else {
                logStatus << "no valid Json returned"
            }
        }
        log.info(logStatus)
        return returnValue
    }









    private JSONObject postAuthorizedGoogleRestCall(String authorization,String targetUrl){
        JSONObject returnValue = null as JSONObject
        Date beforeCall  = new Date()
        Date afterCall
        RestResponse response
        RestBuilder rest = new grails.plugins.rest.client.RestBuilder()
        StringBuilder logStatus = new StringBuilder()
        try {
            response  = rest.get(targetUrl)   {
                contentType "application/x-www-form-urlencoded"
                header "Authorization", "Bearer ${authorization}"
            }
            afterCall  = new Date()
        } catch ( Exception exception){
            log.error("NOTE: exception on post to backend. Target=${targetUrl}, no message body")
            log.error(exception.toString())
            logStatus <<  "NOTE: exception on post to backend. Target=${targetUrl}, no message body"
            afterCall  = new Date()
        }
        logStatus << """
SERVER CALL:
url=${targetUrl},
time required=${(afterCall.time-beforeCall.time)/1000} seconds
""".toString()
        if (response?.responseEntity?.statusCode?.value == 200) {
            returnValue =  response.json
            logStatus << """status: ok""".toString()
        }  else {
            JSONObject tempValue =  response.json
            logStatus << """status: ${response.responseEntity.statusCode.value}""".toString()
            if  (tempValue)  {
                logStatus << """is_error: ${response.json["is_error"]}""".toString()
            }  else {
                logStatus << "no valid Json returned"
            }
        }
        log.info(logStatus)
        return returnValue
    }



    private JSONObject requestTwitterAuthentication(String targetUrl,
                                                    String nonce,
                                                    String callback,
                                                    String timestamp,
                                                    String consumerKey,
                                                    String oauthSignature){
        JSONObject returnValue = null as JSONObject
        Date beforeCall  = new Date()
        Date afterCall
        RestResponse response
        RestBuilder rest = new grails.plugins.rest.client.RestBuilder()
        StringBuilder logStatus = new StringBuilder()
        String combinedHeader = """
oauth_callback="${callback}",
oauth_consumer_key="${consumerKey}",
oauth_nonce="${nonce}",
oauth_signature_method="HMAC-SHA1",
oauth_timestamp="${timestamp}",

oauth_signature="${oauthSignature}", oauth_version="1.0"
""".toString()
        combinedHeader = combinedHeader.replaceAll(/\s*/, '')
        try {
            response  = rest.post(targetUrl)   {
                contentType "application/x-www-form-urlencoded"
                header "OAuth",   combinedHeader

            }
            afterCall  = new Date()
        } catch ( Exception exception){
            log.error("NOTE: exception on post to backend. Target=${targetUrl}")
            log.error(exception.toString())
            logStatus <<  "NOTE: exception on post to backend. Target=${targetUrl}"
            afterCall  = new Date()
        }
        logStatus << """
SERVER CALL:
url=${targetUrl},
parm=${drivingContents},
time required=${(afterCall.time-beforeCall.time)/1000} seconds
""".toString()
        if (response?.responseEntity?.statusCode?.value == 200) {
            returnValue =  response.json
            logStatus << """status: ok""".toString()
        }  else {
            JSONObject tempValue =  response.json
            logStatus << """status: ${response.responseEntity.statusCode.value}""".toString()
            if  (tempValue)  {
                logStatus << """is_error: ${response.json["is_error"]}""".toString()
            }  else {
                logStatus << "no valid Json returned"
            }
        }
        log.info(logStatus)
        return returnValue
    }



    private JSONObject requestTwitterAppAuthentication(String targetUrl,
                                                    String clientId,String clientSecret){
        JSONObject returnValue = null as JSONObject
        Date beforeCall  = new Date()
        Date afterCall
        RestResponse response
        RestBuilder rest = new grails.plugins.rest.client.RestBuilder()
        MultiValueMap<String, String> form = new LinkedMultiValueMap<String, String>()
        StringBuilder logStatus = new StringBuilder()
        form.add("grant_type","client_credentials")
        try {
            response  = rest.post(targetUrl)   {
                contentType "application/x-www-form-urlencoded"
                auth(clientId, clientSecret)
                body (form)
            }
            afterCall  = new Date()
        } catch ( Exception exception){
            log.error("NOTE: exception on post to backend. Target=${targetUrl}")
            log.error(exception.toString())
            logStatus <<  "NOTE: exception on post to backend. Target=${targetUrl}"
            afterCall  = new Date()
        }
        logStatus << """
SERVER CALL:
url=${targetUrl},
time required=${(afterCall.time-beforeCall.time)/1000} seconds
""".toString()
        if (response?.responseEntity?.statusCode?.value == 200) {
            returnValue =  response.json
            logStatus << """status: ok""".toString()
        }  else {
            JSONObject tempValue =  response.json
            logStatus << """status: ${response.responseEntity.statusCode.value}""".toString()
            if  (tempValue)  {
                logStatus << """is_error: ${response.json["is_error"]}""".toString()
            }  else {
                logStatus << "no valid Json returned"
            }
        }
        log.info(logStatus)
        return returnValue
    }




    private JSONObject searchTwitter(String targetUrl,String accessToken,String queryText){
        JSONObject returnValue = null as JSONObject
        Date beforeCall  = new Date()
        Date afterCall
        RestResponse response
        RestBuilder rest = new grails.plugins.rest.client.RestBuilder()
        MultiValueMap<String, String> form = new LinkedMultiValueMap<String, String>()
        StringBuilder logStatus = new StringBuilder()
        String codedAccessToken  =  accessToken
        try {
            response  = rest.get(targetUrl+ "?"+queryText)   {
                contentType "application/x-www-form-urlencoded"
                header 'Authorization', "Bearer $codedAccessToken"
                body (form)
            }
            afterCall  = new Date()
        } catch ( Exception exception){
            log.error("NOTE: exception on post to backend. Target=${targetUrl}")
            log.error(exception.toString())
            logStatus <<  "NOTE: exception on post to backend. Target=${targetUrl}"
            afterCall  = new Date()
        }
        logStatus << """
SERVER CALL:
url=${targetUrl},
time required=${(afterCall.time-beforeCall.time)/1000} seconds
""".toString()
        if (response?.responseEntity?.statusCode?.value == 200) {
            returnValue =  response.json
            logStatus << """status: ok""".toString()
        }  else {
            JSONObject tempValue =  response.json
            logStatus << """status: ${response.responseEntity.statusCode.value}""".toString()
            if  (tempValue)  {
                logStatus << """is_error: ${response.json["is_error"]}""".toString()
            }  else {
                logStatus << "no valid Json returned"
            }
        }
        log.info(logStatus)
        return returnValue
    }





    private JSONObject streamTwitter(String targetUrl,String accessToken,String queryText){
        JSONObject returnValue = null as JSONObject
        Date beforeCall  = new Date()
        Date afterCall
        RestResponse response
        RestBuilder rest = new grails.plugins.rest.client.RestBuilder()
        MultiValueMap<String, String> form = new LinkedMultiValueMap<String, String>()
        StringBuilder logStatus = new StringBuilder()
        String codedAccessToken  =  accessToken
        try {
            response  = rest.post(targetUrl+ "?"+queryText)   {
                contentType "application/x-www-form-urlencoded"
                header 'Authorization', "Bearer $codedAccessToken"
                header 'user-agent', 'Twitter Stream Reader'
                header 'Connection', 'keep-alive'
                body (form)
            }
            afterCall  = new Date()
        } catch ( Exception exception){
            log.error("NOTE: exception on post to backend. Target=${targetUrl}")
            log.error(exception.toString())
            logStatus <<  "NOTE: exception on post to backend. Target=${targetUrl}"
            afterCall  = new Date()
        }
        if (response.statusCode.value==200){
            logStatus << """
SERVER CALL:
url=${targetUrl},
time required=${(afterCall.time-beforeCall.time)/1000} seconds
""".toString()
            // Create a reader to read Twitter's stream
            BufferedReader reader = new BufferedReader(new InputStreamReader(response.getBody()));

            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }

        }  else {
            logStatus << """server call failed. code=${response.statusCode.value}
""".toString()
            log.error(logStatus.toString())
            System.out.println(logStatus.toString());
        }

    }







//    private String  twitterSignatureGenerator(){
//      String key = grailsApplication.config.auth.providers.twitter.key
//      String secret = grailsApplication.config.auth.providers.twitter.secret
//      String combo = "${key}:${secret}"
//      return combo.bytes.encodeBase64().toString()
//  }

    String retrieveTheCorrectTwitterKey () {
        String returnValue
        if ("production".equals("${grails.util.Environment.current.name}")) {
            returnValue =  grailsApplication.config.auth.providers.twitter2.key
        }  else {  // must be local development
            returnValue =  grailsApplication.config.auth.providers.twitter.key
        }
        return   returnValue
    }

    String retrieveTheCorrectTwitterSecret () {
        String returnValue
        if ("production".equals("${grails.util.Environment.current.name}")) {
            returnValue =  grailsApplication.config.auth.providers.twitter2.secret
        }  else {  // must be local development
            returnValue =  grailsApplication.config.auth.providers.twitter.secret
        }
        return   returnValue
    }



    public JSONObject generateTwitterAuthenticationString () {
        JSONObject response
        response = requestTwitterAppAuthentication  ("https://api.twitter.com/oauth2/token",  retrieveTheCorrectTwitterKey (), retrieveTheCorrectTwitterSecret ())
        return response
 }




    public String retrieveTwitterAccessToken ()  {
        JSONObject tokenHolder  = generateTwitterAuthenticationString ()
        String  accessToken =  tokenHolder ["access_token"]
        return  accessToken
    }



    public JSONObject executeTwitterRequest (String accessToken,String queryText) {
        JSONObject response = searchTwitter("https://api.twitter.com/1.1/search/tweets.json", accessToken, queryText)
        return response
    }


    public String initiateTwitterStream(String accessToken,
    String filterDefinition) {
        JSONObject response = streamTwitter("https://stream.twitter.com/1.1/statuses/filter.json", accessToken, filterDefinition)
        return response
    }




    public String buildTwitterRequest (String queryText,String latitude,String longitude,String language,String distance) {
        StringBuilder sb = new  StringBuilder()
        sb <<  "lang=${language}"
        if ((queryText !=  null )   &&
            (queryText.length()  > 0)){
            sb <<  "&q=$queryText"
        }
        sb <<  "&count=100"
        if ((latitude !=  null )   &&
            (latitude.length()  > 0) &&
            (longitude !=  null )   &&
            (longitude.length()  > 0)){
            sb <<  "&geocode=${latitude},${longitude},"
            if ( (distance !=  null )   &&
                 (distance.length()  > 0)){
                sb <<  "${distance}km"
            }  else {
                sb <<  "100km"
            }
        }
        return sb.toString()
    }

//
//    public void run(){
//        try{
//            System.out.println("Starting Twitter public stream consumer thread.");
//
//            // Enter your consumer key and secret below
//            OAuthService service = new ServiceBuilder()
//                    .provider(TwitterApi.class)
//                    .apiKey("YOUR CONSUMER KEY")
//                    .apiSecret("YOUR CONSUMER SECRET")
//                    .build();
//
//            // Set your access token
//            Token accessToken = new Token("YOUR OAuth ACCESS TOKEN", "YOUR OAuth ACCESS TOKEN SECRET");
//
//            // Let's generate the request
//            System.out.println("Connecting to Twitter Public Stream");
//            OAuthRequest request = new OAuthRequest(Verb.POST, STREAM_URI);
//            request.addHeader("version", "HTTP/1.1");
//            request.addHeader("host", "stream.twitter.com");
//            request.setConnectionKeepAlive(true);
//            request.addHeader("user-agent", "Twitter Stream Reader");
//            request.addBodyParameter("track", "java,heroku,twitter"); // Set keywords you'd like to track here
//            service.signRequest(accessToken, request);
//            Response response = request.send();
//
//            // Create a reader to read Twitter's stream
//            BufferedReader reader = new BufferedReader(new InputStreamReader(response.getStream()));
//
//            String line;
//            while ((line = reader.readLine()) != null) {
//                System.out.println(line);
//            }
//        }
//        catch (IOException ioe){
//            ioe.printStackTrace();
//        }
//
//    }







}
