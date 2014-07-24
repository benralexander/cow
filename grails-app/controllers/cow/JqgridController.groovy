package cow

import junit.framework.Assert

class JqgridController {
    static int TOTAL_NUMBER_SIMULATED_RECORDS = 2000

    BackendSimulatorService backendSimulatorService

    String simulatedRecord(int requestedPage,
                           int numberRowsRequested){
        //// "${TOTAL_NUMBER_SIMULATED_RECORDS/numberRowsRequested}"
       // "total":        //  total pages for the query
       // "page":   // current page of the query
       // "records":    // total number of records for the query
       // "rows" :[   // an array that contains the actual data

        String returnValue = """
{
  "total": "${TOTAL_NUMBER_SIMULATED_RECORDS}",
  "page": "${requestedPage}",
  "records": "${TOTAL_NUMBER_SIMULATED_RECORDS}",
  "rows" :[
""".toString()
        returnValue +=  backendSimulatorService.simulatedRows( ((requestedPage*numberRowsRequested)-numberRowsRequested)+1,
                 numberRowsRequested,
                TOTAL_NUMBER_SIMULATED_RECORDS )
        returnValue +=  """]
    }""".toString()
        return returnValue
    }



    def index() {
        render(view: 'jqgrid')
    }
    def jqgrid() { }
    def feedMeJson(){
      //  sleep(1000)
        String stringRequestedPage = params.page ?: "1" // get the requested page
        String stringRowsWeWant = params.rows ?: "1" // get how many rows we want to have in the grid
        String indexRow = params.sidx ?: "id"// get index row name
        String direction = params.sord ?: "desc" // get the direction
        Integer requestedPage, rowsWeWant
        try  {
            requestedPage = Integer.parseInt(stringRequestedPage)
            rowsWeWant = Integer.parseInt(stringRowsWeWant)
        }  catch (Exception exception) {
            println "whoops – bad parameter"
        }
        String proposedJson = simulatedRecord( requestedPage,rowsWeWant)
        render  proposedJson
    }

}
