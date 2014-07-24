/**
 * Created with IntelliJ IDEA.
 * User: balexand
 * Date: 6/2/14
 * Time: 6:46 AM
 * To change this template use File | Settings | File Templates.
 */

package cbbo.ctrp

import groovy.json.JsonSlurper
import org.codehaus.groovy.grails.web.json.JSONArray

class RunDataGeneration {

    final String serverLocation = "http://chembio-lx.broadinstitute.org:3311/"
    Random random = new Random()


    private String getCoreFilePath(String directoryForFile) {
        String filePath = System.getProperty("user.home") + System.getProperty("file.separator");
        if (directoryForFile != null) {
            filePath += (directoryForFile + System.getProperty("file.separator"));
        }
        return  filePath;
    }



    private String generateFilename(String restApiCall,String directoryForFile, Date callStarted,
                                    int countDisambiguator) {
        String fileName = restApiCall.replaceAll("[\\/&=]", ".");
        if (fileName.startsWith("."))
            fileName = fileName.replaceFirst(".", "");
        if (!fileName.endsWith("."))
            fileName += ".";

        // append elapsed time to end of name
        Date currentDate = new Date();
        fileName += ((currentDate.getTime() - callStarted.getTime()) + "ms." +countDisambiguator+ ".");
        String filePath = getCoreFilePath(directoryForFile)
        return (filePath + fileName + "txt");
    }




    private void writeValuesToFile(String fileName,
                                   String parameterSummary,
                                   String returnFromApi) {
        try {
            File file = new File(fileName);

            // we have the file name.  now fill it up.  Headers go first, the the Json we received from the API
            file.createNewFile();
            FileWriter fileWriter = new FileWriter(file);
           // fileWriter.write(parameterSummary);
          //  fileWriter.write(System.getProperty("line.separator"));
            fileWriter.write(returnFromApi);
            fileWriter.flush();
            fileWriter.close();
        } catch (Exception e) {
            System.out.print("problem writing output from " + restApiCall + ".");
            e.printStackTrace();
        }
    }





    private void writeRawJsonToFile(String directoryForFile,
                                    String restApiCall,
                                    String parameterSummary,
                                    Date callStarted,
                                    String returnFromApi,
                                    int countDisambiguator) {
        String fileName = generateFilename(restApiCall, directoryForFile, callStarted,countDisambiguator)
        writeValuesToFile(fileName,
                parameterSummary,
                returnFromApi)
    }



    private void returnValuesToFile(String directoryForFile,
                                    String restApiCall,
                                    String parameterSummary,
                                    Date callStarted,
                                    JSONArray jsonArray
    ) {
        try {
            // concoct the filename out of the URL we are given.
            String fileName = restApiCall.replaceAll("[\\/&=]", ".");
            if (fileName.startsWith("."))
                fileName = fileName.replaceFirst(".", "");
            if (!fileName.endsWith("."))
                fileName += ".";

            // append elapsed time to end of name
            Date currentDate = new Date();
            fileName += ((currentDate.getTime() - callStarted.getTime()) + "ms" + ".");
  //          String filePath = System.getProperty("user.home") + System.getProperty("file.separator");
            String filePath = "\\\\dropbox\\dropbox\\balexand"
            if (directoryForFile != null) {
                filePath += (directoryForFile + System.getProperty("file.separator"));
            }
            File file = new File(filePath + fileName + "txt");

            // we have the file name.  now fill it up.  Headers go first, the the Json we received from the API
            file.createNewFile();
            FileWriter fileWriter = new FileWriter(file);
            fileWriter.write(parameterSummary);
            fileWriter.write(System.getProperty("line.separator"));
            fileWriter.write(jsonArray.toString());
            fileWriter.flush();
            fileWriter.close();
        } catch (Exception e) {
            System.out.print("problem writing output from " + restApiCall + ".");
            e.printStackTrace();
        }
    }







    static boolean executePost(String cid) {
        URL url = new URL("http://chembio-lx.broadinstitute.org:3311/cddb/ctrp2/perturbation/perCurve/correlation/")
        String header = """{"cpdID":411738,"cellSampleAnnotation":[{"sitePrimary":"biliary_tract","histSubtype":"unspecified"},{"sitePrimary":"bone","histSubtype":"unspecified"},{"sitePrimary":"bone","histSubtype":"dedifferentiated"}],"growthMode":["mixed","suspension","adherent"],"dataset":["Onco","COSMIC","TES"],"geneFeatureDataset":"GEX"}}
"""
        boolean retval = false
        try {
            def connection = url.openConnection()
            connection.setRequestMethod("POST")
            connection.doOutput = true
            def writer = new OutputStreamWriter(connection.outputStream)
            writer.write(header.toString())
            writer.flush()
            writer.close()
            connection.connect()

            InputStream inStream = url.openStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
            def slurper = new JsonSlurper()
            println "completed post"
        } catch (e) {
            e.printStackTrace()
            println "error"
        }
        return retval
    }




     boolean executePost3(String urlString, String parameters,int countDisambiguator) {
        HttpURLConnection connection = null;
        URL url = new URL(serverLocation+urlString)
         boolean retval = false
         String apiResponse
        try {
            connection = url.openConnection()
            connection.setRequestMethod("POST")
            connection.setRequestProperty("Content-Type",
                    "application/json");
            connection.setRequestProperty("user", "ctrp")
            connection.doOutput = true
            connection.setRequestProperty("Content-Length", "" +
                    Integer.toString(parameters.getBytes().length));
            connection.setRequestProperty("Content-Language", "en-US");

            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.setDoOutput(true);
            Date callStarted = new Date ()

            def writer = new OutputStreamWriter(connection.outputStream)
            writer.write(parameters.toString())
            writer.flush()
            writer.close()
            connection.connect()

            apiResponse = connection.content.text

            if ((apiResponse != null)  &&
                    (apiResponse.length() > 0)){
                JsonSlurper jsonSlurper = new JsonSlurper()
                HashMap header = jsonSlurper.parseText(apiResponse)
                List perCurveCorrelation = header["perCurveCorrelation"]
                StringBuilder sb = new StringBuilder()
                int  perCurveCorrelationSize = perCurveCorrelation.size()
                sb << "geneFeature,correlationValue"
                sb << '\n'
                for ( int i=0 ; i<perCurveCorrelationSize ; i++ ) {
                    sb << ((HashMap)perCurveCorrelation[i]) ["geneFeature"]+ ","
                    sb << +((HashMap)perCurveCorrelation[i]) ["correlationValue"]
                    if (i+1<perCurveCorrelationSize) sb << '\n'
                }


                String perCurveCorrelationText  = sb.toString()

                writeRawJsonToFile( null,
                        urlString,
                        parameters,
                        callStarted,
                        perCurveCorrelationText,
                        countDisambiguator)

            }
             println "completed post"
        } catch (e) {
            e.printStackTrace()
            println "FAILURE:  PARM="+parameters+'\n'+
                    "returned (first 100 chars) JSON="+apiResponse.substring(0,100)+"."
        }
        return retval
    }

    /***
     * retrieve data from the API, presumably nicely formatted as Json
     * @param urlString
     * @return
     */
    String executeGet(String urlString) {
        URL url = new URL(serverLocation+urlString)
        String retval = false
        try {
            HttpURLConnection connection = url.openConnection()
            connection.setRequestMethod("GET")
            connection.setRequestProperty("Content-Type",
                    "application/json");
            connection.setRequestProperty("user", "ctrp")
            connection.doOutput = true

            connection.setUseCaches(false);
            connection.setDoInput(true);
            connection.setDoOutput(true);
            Date callStarted = new Date ()

            connection.connect()

            retval = connection.content.text
            JsonSlurper jsonSlurper = new JsonSlurper()
        } catch (e) {
            e.printStackTrace()
            println "error"
        }
        return retval
    }

    List <String> randomStringSelector ( List <String> universe, int maximumElementsToReturn, boolean lessThanMaximumNumberAllowed )  {
        List <String> returnValue = []
        int elementsToReturn  =   maximumElementsToReturn
        int sizeOfTheUniverse =   universe.size()
        if (lessThanMaximumNumberAllowed)  {    // we might select a number of elements to return less than the maximum
            elementsToReturn = 1 +random.nextInt(maximumElementsToReturn)
        }
        if((elementsToReturn > 0) && (sizeOfTheUniverse > 0)) {
            def counter = 0
            while(counter<elementsToReturn) {
                returnValue.add(universe.minus(returnValue).getAt(random.nextInt(sizeOfTheUniverse-counter)))
                counter++
            }
        }
        return  returnValue
    }



    List <String>  extractCompounds (String apiReturnValues)  {
        List <String> returnValue = []
        JsonSlurper jsonSlurper = new JsonSlurper()
        HashMap compoundAnnotations = jsonSlurper.parseText(apiReturnValues)
        List compoundAnnotation =  compoundAnnotations["annotation"]
        for (HashMap annotation in compoundAnnotation)   {
            returnValue << annotation["cpdID"]
        }
        return returnValue
    }





    HashMap  extractAnnotations (String apiReturnValues)  {
        HashMap returnValue = []
        JsonSlurper jsonSlurper = new JsonSlurper()
        HashMap allAllowableAnnotations = jsonSlurper.parseText(apiReturnValues)
        // get the parts of the growth mode annotation that we need
        List <String>  growthModeList = []
        List growthModeAnnotation =  allAllowableAnnotations["growthMode"]
        for (HashMap annotation in growthModeAnnotation)   {
            growthModeList << ("\""+annotation["name"]+"\"" )
        }

        // get the parts of the growth mode annotation that we need
        List <String>  sitePrimaryList = []
        List sitePrimaryAnnotation =  allAllowableAnnotations["sitePrimary"]
        for (HashMap annotation in sitePrimaryAnnotation)   {
            String  sitePrimaryName = annotation["name"]
            List  histSubtypeList = annotation["histSubtype"]
            for (HashMap histSubtype in histSubtypeList)   {
                sitePrimaryList << ("{\"sitePrimary\":\""+sitePrimaryName+"\",\"histSubtype\":\""+histSubtype["name"]+"\"}")
            }
        }


        // get the parts of the dataset annotation that we need
        List <String>  datasetList = []
        List datasetAnnotation =  allAllowableAnnotations["dataset"]
        for (HashMap annotation in datasetAnnotation)   {
            datasetList << ("\""+annotation["name"]+"\"" )
        }

        returnValue ["growthMode"]  =  growthModeList
        returnValue ["sitePrimary"]  =  sitePrimaryList
        returnValue ["dataset"]  =  datasetList
        return returnValue
    }




    List <String> retrieveCompounds(int numberOfCompounds) {
        String apiReturnValues = executeGet("cddb/ctrp2/annotation/perCompound/");
        List <String> compoundList =  extractCompounds (apiReturnValues)
        return randomStringSelector ( compoundList, 64, false )
    }

    HashMap retrieveAnnotations() {
        String apiReturnValues = executeGet("cddb/ctrp2/facet/");
        return  extractAnnotations (apiReturnValues)
    }




String generateParametersForCorrelationPointCall ()   {
    String returnValue = ""
    return  returnValue
}



    public List <String> prepForTestRun() {
        List <String> parameterCombinations = []
        List <String> compoundList = retrieveCompounds(64);
        HashMap annotationHashMap =  retrieveAnnotations()
        for ( String oneCompound in compoundList ){
            for (int i = 0 ; i < 16; i++ ){
                String oneParameterCombo = "{\"cpdID\":" +oneCompound+ ",\"cellSampleAnnotation\":["
                // pick a random number of primary sites to use
                List< String> sitePrimaryList =  randomStringSelector ( annotationHashMap ["sitePrimary"], (i+1), true )
                for (int j = 0 ; j < sitePrimaryList.size(); j++ ){
                    oneParameterCombo += sitePrimaryList [j]
                    if  ((j+1) < sitePrimaryList.size())  {
                        oneParameterCombo+=","
                    }
                }
                oneParameterCombo += "],\"growthMode\":["

                // pick a random number of growth modes to use
                List< String> growthModeList =  randomStringSelector ( annotationHashMap ["growthMode"], annotationHashMap ["growthMode"].size(), true )
                for (int j = 0 ; j < growthModeList.size(); j++ ){
                    oneParameterCombo += growthModeList [j]
                    if  ((j+1) < growthModeList.size())  {
                        oneParameterCombo+=","
                    }
                }
                oneParameterCombo += "],\"dataset\":["

                // pick a random number of growth modes to use
                List< String> datasetList =  randomStringSelector ( annotationHashMap ["dataset"],  annotationHashMap ["dataset"].size(), true )
                for (int j = 0 ; j < datasetList.size(); j++ ){
                    oneParameterCombo += datasetList [j]
                    if  ((j+1) < datasetList.size())  {
                        oneParameterCombo+=","
                    }
                }
                oneParameterCombo += "],\"geneFeatureDataset\":"
                List< String> geneFeatureDatasetList = []
                geneFeatureDatasetList << "GEX"
                geneFeatureDatasetList << "CNV"
                oneParameterCombo+=  "\""+randomStringSelector ( geneFeatureDatasetList, 1, false )[0]+"\"}"

                parameterCombinations <<  oneParameterCombo
            }

        }
        return parameterCombinations


    }



    public testCallCorrelationPoint() {
//        executePost3("cddb/ctrp2/mutation/perGene/cellCount/byFacet",
//"""{
//    "dataset":["Onco"],
//    "growthMode":["adherent"],
//    "cellSampleAnnotation":[
//        {"sitePrimary": "lung", "histSubtype": "adenocarcinoma"},
//        {"sitePrimary": "bone", "histSubtype": "unspecified"}
//    ]
//}
//""".toString())
        executePost3("cddb/ctrp2/perturbation/perCurve/correlation/",
"""{"cpdID":411738,
    "cellSampleAnnotation":[
             {"sitePrimary":"biliary_tract","histSubtype":"unspecified"},
             {"sitePrimary":"bone","histSubtype":"unspecified"},
             {"sitePrimary":"bone","histSubtype":"dedifferentiated"}
             ],
      "growthMode":["mixed","suspension","adherent"],
      "dataset":["Onco","COSMIC","TES"],
      "geneFeatureDataset":"GEX"
}
""".toString(),1)
     }



    public RunDataGeneration() {
        println('launching RunDataGeneration')
//        List<String> listOfHeaderParms= prepForTestRun ()
//     //   List<String> randomizedListOfHeaderParms=randomStringSelector ( listOfHeaderParms,  8, false )
//        List<String> randomizedListOfHeaderParms=randomStringSelector ( listOfHeaderParms,  listOfHeaderParms.size(), false )
//        int loopCount = 1;
//        try {
//            String filePath = getCoreFilePath(null)
//            File metaFile = new File(filePath + "metafile.txt");
//
//            // Create a metafile which we will then fill as we perform all the other calls
//            metaFile.createNewFile();
//            FileWriter fileWriter = new FileWriter(metaFile);
//
//            fileWriter.write("[");
//
//            int lengthListOfHeaderParms =   randomizedListOfHeaderParms.size()
//            for (String headerParm in randomizedListOfHeaderParms) {
//                JsonSlurper jsonSlurper = new JsonSlurper()
//                HashMap header = jsonSlurper.parseText(headerParm)
//                StringBuilder sb =  new StringBuilder()
//
//                // Compound ID
//                sb << "{\"cpdId\":"+ header ["cpdID"] + ','
//
//                // Site primary
//                List cellSampleAnnotationList = header ["cellSampleAnnotation"]
//                sb << "\"sitePrimary\":["
//                int numberOfHistologyRecords = cellSampleAnnotationList.size()
//                for ( int i=0 ; i<numberOfHistologyRecords ; i++ )  {
//                    sb << "\"" +((HashMap)cellSampleAnnotationList[i]) ["sitePrimary"]+ "\""
//                    if (i+1<numberOfHistologyRecords) sb << ","
//                }
//                sb << "],"
//
//                // Histology subtype
//                sb << "\"histSubtype\":["
//                for ( int i=0 ; i<numberOfHistologyRecords ; i++ )  {
//                    sb << "\"" +((HashMap)cellSampleAnnotationList[i]) ["histSubtype"]+ "\""
//                    if (i+1<numberOfHistologyRecords) sb << ","
//                }
//                sb << "],"
//
//                // Growth mode
//                List growthModeList = header ["growthMode"]
//                sb << "\"growthMode\":["
//                for ( int i=0 ; i<growthModeList.size() ; i++ )  {
//                    sb << "\"" +(growthModeList[i])+ "\""
//                    if (i+1<growthModeList.size()) sb << ","
//                }
//                sb << "],"
//
//                // dataset
//                List datasetList = header ["dataset"]
//                sb << "\"dataset\":["
//                for ( int i=0 ; i<datasetList.size() ; i++ )  {
//                    sb << "\"" +(datasetList[i])+ "\""
//                    if (i+1<datasetList.size()) sb << ","
//                }
//                sb << "],"
//
//                // geneFeatureDataset
//                sb << "\"geneFeatureDataset\":\""+ header ["geneFeatureDataset"] + '\",'
//
//
//                // testId
//
//                sb << "\"testId\":"+ loopCount + "}"
//                if (loopCount<lengthListOfHeaderParms)  sb << (","+'\n')
//
//                fileWriter.write(sb.toString());
//                executePost3("cddb/ctrp2/perturbation/perCurve/correlation/",headerParm,loopCount++)
//            }
//            fileWriter.write("]");
//
//            fileWriter.flush();
//            fileWriter.close();
//
//        } catch (Exception e) {
//            System.out.print("problem writing output from " + restApiCall + ".");
//            e.printStackTrace();
//        }
//
       testCallCorrelationPoint()
    }

}
