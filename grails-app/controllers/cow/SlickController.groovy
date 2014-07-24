package cow

class SlickController {
    static int TOTAL_NUMBER_SIMULATED_RECORDS = 2000

    BackendSimulatorService backendSimulatorService

    String simulatedRecord( int requestedStart,
                            int requestedEnd
                      //      String indexName,
                      //      String direction // "asc" Or "desc"
                           ){

        String returnValue = """
{
  "start": "${requestedStart}",
  "end": "${requestedEnd}",
"headers":{
"exptHeaders": [
{"index": 0,
"pid": 1114,
"prjName":"Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase (PLAP)",
"adid": 8445,
"assayName": "Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase",
"eid":8165,
"exptName": "Luminescent assay for identification of inhibitors of bovine intestinal alkaline phosphatase",
"resultType": "IC50"
},
{"index": 1,
"pid": 1115,
"prjName":"Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase (PLAP)",
"adid": 8446,
"assayName": "Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase",
"eid":8166,
"exptName": "Luminescent assay for identification of inhibitors of bovine intestinal alkaline phosphatase",
"resultType": "EC50"
},
{"index": 2,
"pid": 1116,
"prjName":"Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase (PLAP)",
"adid": 8446,
"assayName": "Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase",
"eid":8166,
"exptName": "Luminescent assay for identification of inhibitors of bovine intestinal alkaline phosphatase",
"resultType": "Percent inhibition"
},
{"index": 3,
"pid": 1117,
"prjName":"Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase (PLAP)",
"adid": 8447,
"assayName": "Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase",
"eid":8167,
"exptName": "Luminescent assay for identification of inhibitors of bovine intestinal alkaline phosphatase",
"resultType": "Viability"
}
],
"cmpdHeaders": [
{
"cid": 64471,
"sid": 842216,
"SMILES":"CC(C)COC(=O)C1=C(NC(=O)NC2=CC=CC=C2)SN=N1",
"promiscuity": "7/47"
}
]
},
  "records": "${TOTAL_NUMBER_SIMULATED_RECORDS}",
  "rows" :[
""".toString()
        returnValue +=  backendSimulatorService.simulatedRows( requestedStart,
                requestedEnd-requestedStart,
                TOTAL_NUMBER_SIMULATED_RECORDS  )
        returnValue +=  """]
    }""".toString()
        return returnValue


    }


    def index() {
        render(view: 'slick')
    }
    def slick() { }
    def retrieveHeaders ()  {
        render """
{
"headers":{
"exptHeaders": [
{"index": 0,
"pid": 1114,
"prjName":"Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase (PLAP)",
"adid": 8445,
"assayName": "Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase",
"eid":8165,
"exptName": "Luminescent assay for identification of inhibitors of bovine intestinal alkaline phosphatase",
"resultType": "IC50"
},
{"index": 1,
"pid": 1115,
"prjName":"Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase (PLAP)",
"adid": 8446,
"assayName": "Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase",
"eid":8166,
"exptName": "Luminescent assay for identification of inhibitors of bovine intestinal alkaline phosphatase",
"resultType": "EC50"
},
{"index": 2,
"pid": 1116,
"prjName":"Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase (PLAP)",
"adid": 8446,
"assayName": "Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase",
"eid":8166,
"exptName": "Luminescent assay for identification of inhibitors of bovine intestinal alkaline phosphatase",
"resultType": "Percent inhibition"
},
{"index": 3,
"pid": 1117,
"prjName":"Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase (PLAP)",
"adid": 8447,
"assayName": "Luminescent assay for HTS discovery of chemical inhibitors of placental alkaline phosphatase",
"eid":8167,
"exptName": "Luminescent assay for identification of inhibitors of bovine intestinal alkaline phosphatase",
"resultType": "Viability"
}
],
"cmpdHeaders": [
{
"cid": 64471,
"sid": 842216,
"SMILES":"CC(C)COC(=O)C1=C(NC(=O)NC2=CC=CC=C2)SN=N1",
"promiscuity": "7/47"
}
]
}
}
"""
    }
    def feedMeJson(){
        String stringRequestedStart = params.start ?: "0" // get the requested page
        String stringRequestedEnd = params.end ?: "25" // get how many rows we want to have in the grid
        String indexRow = params.sortby ?: "id"// get index row name
        String direction = params.sord ?: "desc" // get the direction
        Integer requestedPage, rowsWeWant,requestedStart,requestedEnd
        try  {
            requestedStart = Integer.parseInt(stringRequestedStart)
            requestedEnd = Integer.parseInt(stringRequestedEnd)
        }  catch (Exception exception) {
            println "whoops – bad parameter"
        }
        String proposedJson = simulatedRecord( requestedStart,requestedEnd)
        render  proposedJson
    }
}
