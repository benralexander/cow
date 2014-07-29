package cow

import baget.BagetService

class BagetController {
    BagetService bagetService
    String tempDataStore = null


    def upload() {
        println('got a file')
        println('delete old one')
        new File('./tempStorage.txt').delete()
        def incomingFile = request.getFile('myFile')
        if (incomingFile.empty) {
            flash.message = 'file cannot be empty'
            render(view: 'bagetLandingPage')
            return
        }
        println('type='+incomingFile.getClass().name+'.')
        incomingFile.transferTo(new File('./tempStorage.txt'))
        println('transferred.')
        render(view: 'bagetLandingPage',model:[dataFileBased:1])
    }


    def returnToDefaultJsonData() {
        tempDataStore = null
        render(view: 'bagetLandingPage')
    }




    def rawJson = """
[{"x":-36.53621405,"y":1},
{"x":-27.73397927,"y":4},
{"x":-22.16777112,"y":6},
{"x":-17.99178059,"y":7},
{"x":-14.60302072,"y":7},
{"x":-11.72499342,"y":7},
{"x":-9.2067716,"y":8},
{"x":-6.956506316,"y":9},
{"x":-4.913948826,"y":9},
{"x":-3.03734171,"y":9},
{"x":-1.296494898,"y":10},
{"x":0.331161791,"y":11},
{"x":1.862967483,"y":11},
{"x":3.312546898,"y":11},
{"x":4.690812017,"y":12},
{"x":6.006645888,"y":12},
{"x":7.267382744,"y":13},
{"x":8.479153382,"y":13},
{"x":9.647138926,"y":13},
{"x":10.77576075,"y":13},
{"x":11.86882501,"y":14},
{"x":12.92963419,"y":14},
{"x":13.96107444,"y":14},
{"x":14.96568467,"y":14},
{"x":15.9457119,"y":16},
{"x":16.90315594,"y":16},
{"x":17.8398059,"y":16},
{"x":18.75727016,"y":16},
{"x":19.65700129,"y":18},
{"x":20.54031673,"y":18},
{"x":21.40841632,"y":18},
{"x":22.26239701,"y":18},
{"x":23.10326543,"y":19},
{"x":23.93194863,"y":20},
{"x":24.74930331,"y":20},
{"x":25.55612382,"y":20},
{"x":26.35314908,"y":20},
{"x":27.14106863,"y":21},
{"x":27.92052794,"y":21},
{"x":28.69213308,"y":21},
{"x":29.45645485,"y":21},
{"x":30.21403243,"y":22},
{"x":30.96537668,"y":23},
{"x":31.71097303,"y":23},
{"x":32.45128414,"y":23},
{"x":33.18675228,"y":23},
{"x":33.91780148,"y":23},
{"x":34.6448395,"y":23},
{"x":35.36825965,"y":24},
{"x":36.08844244,"y":24},
{"x":36.80575712,"y":27},
{"x":37.52056314,"y":28},
{"x":38.23321147,"y":28},
{"x":38.94404589,"y":28},
{"x":39.6534042,"y":29},
{"x":40.36161935,"y":30},
{"x":41.06902058,"y":30},
{"x":41.77593451,"y":31},
{"x":42.48268618,"y":32},
{"x":43.18960011,"y":32},
{"x":43.89700134,"y":32},
{"x":44.60521649,"y":34},
{"x":45.31457479,"y":35},
{"x":46.02540922,"y":35},
{"x":46.73805755,"y":36},
{"x":47.45286357,"y":36},
{"x":48.17017825,"y":37},
{"x":48.89036104,"y":37},
{"x":49.61378119,"y":39},
{"x":50.34081921,"y":39},
{"x":51.07186841,"y":40},
{"x":51.80733655,"y":41},
{"x":52.54764766,"y":44},
{"x":53.29324401,"y":44},
{"x":54.04458826,"y":44},
{"x":54.80216584,"y":45},
{"x":55.56648761,"y":45},
{"x":56.33809275,"y":46},
{"x":57.11755206,"y":47},
{"x":57.90547161,"y":48},
{"x":58.70249687,"y":49},
{"x":59.50931738,"y":50},
{"x":60.32667206,"y":52},
{"x":61.15535526,"y":59},
{"x":61.99622368,"y":59},
{"x":62.85020437,"y":61},
{"x":63.71830396,"y":63},
{"x":64.6016194,"y":64},
{"x":65.50135053,"y":64},
{"x":66.41881479,"y":65},
{"x":67.35546475,"y":66},
{"x":68.31290879,"y":71},
{"x":69.29293602,"y":73},
{"x":70.29754625,"y":73},
{"x":71.3289865,"y":76},
{"x":72.38979568,"y":77},
{"x":73.48285994,"y":78},
{"x":74.61148176,"y":78},
{"x":75.77946731,"y":79},
{"x":76.99123795,"y":80},
{"x":78.2519748,"y":82},
{"x":79.56780867,"y":84},
{"x":80.94607379,"y":85},
{"x":82.39565321,"y":85},
{"x":83.9274589,"y":89},
{"x":85.55511559,"y":91},
{"x":87.2959624,"y":96},
{"x":89.17256952,"y":97},
{"x":91.21512701,"y":97},
{"x":93.46539229,"y":108},
{"x":95.98361411,"y":110,"u":"http://www.ncbi.nlm.nih.gov/snp/?term=rs104893892"},
{"x":98.86164141,"y":115,"u":"http://www.ncbi.nlm.nih.gov/snp/?term=rs104893892"},
{"x":102.2504013,"y":118,"p":"rs79716074","u":"http://www.ncbi.nlm.nih.gov/snp/?term=rs79716074"},
{"x":106.4263918,"y":122,"p":"rs104893897","u":"http://www.ncbi.nlm.nih.gov/snp/?term=rs104893897"},
{"x":111.9926,"y":135,"p":"rs79716074","u":"http://www.ncbi.nlm.nih.gov/snp/?term=rs79716074"},
{"x":120.7948347,"y":168,"p":"rs104893892","u":"http://www.ncbi.nlm.nih.gov/snp/?term=rs104893892"}
]
"""

    def index() {
        render(view: 'bagetLandingPage')
    }




    def qqplot() {
        render(view:'bagetLandingPage',model:[dataFileBased:0])
    }
    def qqPlotData(){
        String dataFileBased = params.id
        response.setContentType("application/json")
        if (!dataFileBased) {
            render(rawJson)
        } else {
            File readFileOfDisk = new File('./tempStorage.txt')
            int howManyLines =  bagetService.howManyLines(readFileOfDisk)
            tempDataStore = bagetService.convertFileToJson (readFileOfDisk,howManyLines)
            render(tempDataStore)
        }

    }




}
