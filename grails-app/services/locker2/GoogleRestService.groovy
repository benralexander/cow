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

import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import java.security.InvalidKeyException

@Transactional
class GoogleRestService {

    GrailsApplication grailsApplication
    private static final log = LogFactory.getLog(this)
    Random random = new Random()

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

    private String nonceGenerator() {
        String returnValue
       Date date = new Date()
        returnValue = Math.abs(random.nextInt()).toString()+date.getTime().toString()+  Math.abs(random.nextInt()).toString()+date.getTime().toString()
        return  returnValue.substring(0,32)
    }



    private String toUrlParameters(Map params)  {
        StringBuilder returnValue  = new  StringBuilder ()
        int  numberOfParameters = params.size ()
        if (numberOfParameters>0){
            returnValue << '?'
        }
        int pcount = 0
        params.each{k,v->
            pcount++
            returnValue << k << '='  << params [k]
            if  (pcount<numberOfParameters) {
                returnValue << '&'
            }
        }
        return  returnValue.toString()
    }



    /***
     * build up everything we need for twitter OAuth1 style authentication
     * @param method
     * @param url
     * @param params
     * @return
     */
    private String retrieveOauth1Materials (String method,String url,Map params){
        String  consumerKey="${grailsApplication.config.auth.providers.twitterStream.consumerKey}"
        String  nonce=nonceGenerator()
        String  signatureMethod="HMAC-SHA1"
        String timestamp=Math.floor(new Date().getTime() / 1000L).toInteger()
        String token="${grailsApplication.config.auth.providers.twitterStream.accessToken }"
        String version="1.0"
        // clone the original map.  We will pass in the clone (along with all of the oauth fields) ffor further processing
        Map extendedParams  = [:]
        params.each{k,v->
            extendedParams [k]  = v
        }
        extendedParams['oauth_consumer_key']="${consumerKey}".toString()
        extendedParams['oauth_nonce']= "${nonce}".toString()
        extendedParams['oauth_signature_method']="${signatureMethod}".toString()
        extendedParams['oauth_timestamp']="${timestamp}".toString()
        extendedParams['oauth_token']="${token}".toString()
        extendedParams['oauth_version']="${version}".toString()
        String  signature=twitterBigSignatureGenerator(method,url,extendedParams)
        String retval = """OAuth oauth_consumer_key="${java.net.URLEncoder.encode(consumerKey)}",
 oauth_nonce="${java.net.URLEncoder.encode(nonce)}",
 oauth_signature="${java.net.URLEncoder.encode(signature)}",
 oauth_signature_method="${java.net.URLEncoder.encode(signatureMethod)}",
 oauth_timestamp="${java.net.URLEncoder.encode(timestamp)}",
 oauth_token="${java.net.URLEncoder.encode(token)}",
 oauth_version="${java.net.URLEncoder.encode(version)}"
""".toString().replaceAll("[\n\r]", "")
        return retval
    }

    //stream
    private JSONObject streamTwitter(String method,String targetUrl,Map parms,Map body){
        JSONObject returnValue = null as JSONObject
        Date beforeCall  = new Date()
        Date afterCall
        RestResponse response
        RestBuilder rest = new grails.plugins.rest.client.RestBuilder()
        String oAuth1Materials = retrieveOauth1Materials( method, targetUrl, parms)
        MultiValueMap<String, String> form = new LinkedMultiValueMap<String, String>()
//        form.add("grant_type","client_credentials")
        StringBuilder logStatus = new StringBuilder()
        try {
            if (method=="POST") {

                response  = rest.post(targetUrl+toUrlParameters(parms)) {
                    contentType "application/x-www-form-urlencoded"
                    header 'Authorization', "${oAuth1Materials}"
                    header 'user-agent', 'Twitter Stream Reader'
                    header 'Connection', 'keep-alive'
                    //       body   (form)
                }
            } else if (method=="GET") {
                    response  = rest.get(targetUrl+toUrlParameters(parms)) {
                        contentType "application/x-www-form-urlencoded"
                        header 'Authorization', "${oAuth1Materials}"
                        header 'user-agent', 'Twitter Stream Reader'
                        header 'Connection', 'keep-alive'
                    }
            }
            afterCall  = new Date()
        } catch ( Exception exception){
            log.error(exception.toString())
            logStatus <<  "NOTE: exception on post to backend."
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




/**
 * @param secretKey
 * @param data
 * @return HMAC/SHA256 representation of the given string
 */
    def hmac_sha256(String secretKey, String data) {
        try {  SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256")
            Mac mac = Mac.getInstance("HmacSHA256")
            mac.init(secretKeySpec)
            byte[] digest = mac.doFinal(data.getBytes("UTF-8"))
            return byteArrayToString(digest)
        } catch (InvalidKeyException e) {  throw new RuntimeException("Invalid key exception while converting to HMac SHA256")
        }
    }

    def hmac_sha(String secretKey, String data) {
        try {  SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA1")
            Mac mac = Mac.getInstance("HmacSHA1")
            mac.init(secretKeySpec)
            byte[] digest = mac.doFinal(data.getBytes("UTF-8"))
            return digest.encodeHex().toString()
           // return byteArrayToString(digest)
        } catch (InvalidKeyException e) {  throw new RuntimeException("Invalid key exception while converting to HMac SHA1")
        }
    }


    String myhmac_sha(String secretKey, String data) {
        try {  SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA1")
            Mac mac = Mac.getInstance("HmacSHA1")
            mac.init(secretKeySpec)
            byte[] digest = mac.doFinal(data.getBytes("UTF-8"))
            return digest.encodeBase64().toString()
        } catch (InvalidKeyException e) {  throw new RuntimeException("Invalid key exception while converting to HMac SHA1")
        }
    }


    private def byteArrayToString(byte[] data) {
        BigInteger bigInteger = new BigInteger(1, data)
        String hash = bigInteger.toString(16)
        //Zero pad it
        while (hash.length() < 64) {
            hash = "0" + hash
        }
        return hash
    }



    private String  twitterBigSignatureGenerator(String method,String url,Map<String,String> allParms){
        String sig
        String signatureBaseString
        String signatureKey
        String encodedParmHolder = ""
        List<String> parms = []
        allParms.each{k,v->
            parms << java.net.URLEncoder.encode(k)+"="+java.net.URLEncoder.encode(v)
        }
        List<String> sortedParms = parms.sort()
        for (  int  i = 0 ; i < sortedParms.size() ; i++ ) {
            encodedParmHolder += parms[i]
            if (i+1<parms.size()) {
                encodedParmHolder += "&"
            }
        }
        signatureBaseString = "${method.toUpperCase()}&${java.net.URLEncoder.encode(url)}&${java.net.URLEncoder.encode(encodedParmHolder)}"
        signatureKey =  twitterSigningKey()
        sig =  myhmac_sha(signatureKey, signatureBaseString)
        return sig
        //return returnValue.bytes.encodeBase64().toString()
    }
    private String  twitterSigningKey(){
        String consumerSecret = grailsApplication.config.auth.providers.twitterStream.consumerSecret
        String tokenSecret =  grailsApplication.config.auth.providers.twitterStream.accessTokenSecret
        String combo = "${consumerSecret}&${tokenSecret}"
        return combo
//        return combo.bytes.encodeBase64().toString()

    }
//    private String  twitterSignatureGenerator(){
//        String key = grailsApplication.config.auth.providers.twitter.key
//        String secret = grailsApplication.config.auth.providers.twitter.secret
//        String combo = "${key}:${secret}"
//        return combo.bytes.encodeBase64().toString()
//    }

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

    // stream
    public String initiateTwitterStream(Map parameters,Map body) {
        JSONObject response = streamTwitter("POST","https://stream.twitter.com/1.1/statuses/filter.json", parameters, body)
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
