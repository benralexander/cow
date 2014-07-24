package cow

class GraphController {

    def index() {
        render(view: 'my_graph')
    }
    def very_cross() { }
    def feedMeJson(){
        render (
"date"+'\t'+"close"+'\n'+
        "1-May-12"+'\t'+"58.13"+'\n'+
        "30-Apr-12"+'\t'+"53.98"+'\n'+
        "27-Apr-12"+'\t'+"67.00"+'\n'+
        "26-Apr-12"+'\t'+"89.70"+'\n'+
        "25-Apr-12"+'\t'+"99.00"+'\n'+
        "23-Apr-12"+'\t'+"98.00"+'\n'+
        "22-Apr-12"+'\t'+"103.70"+'\n'+
        "19-Apr-12"+'\t'+"91.00"+'\n'

        )
    }
}
