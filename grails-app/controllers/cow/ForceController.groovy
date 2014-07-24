package cow

class ForceController {

    def index() {
        render(view: 'force')
    }
    def force() { }
    def feedMeJson(){
        render (  """
{"nodes":[{"name":"Myriel","group":1},
{"name":"Napoleon","group":1},
{"name":"Myriel","group":1},
{"name":"Napoleon","group":1}],
"links": [{"source": 0, "target": 1, "value": 2},
{"source": 1, "target": 2, "value": 2},
{"source": 1, "target": 3, "value": 2},
{"source": 2, "target": 0, "value": 2}]}
""")  }
//    render (  """
//{"nodes":[{},
//{},
//{}],
//"links": [{"source": 0, "target": 1, "value": 2},
//{"source": 1, "target": 2, "value": 2},
//{"source": 2, "target": 0, "value": 2}]}
//""")  }




//    render (  """
//{"nodes":[{"index": 0},
//{"index": 1},
//{"index": 2}],
//"links": [{"source": 0, "target": 1, "value": 2},
//{"source": 1, "target": 2, "value": 2},
//{"source": 2, "target": 0, "value": 2}]}
//""")  }
    def feedMeLinks(){
        render (  """
[{"index": 0},
{"index": 1},
{"index": 2}]
""")  }
//        render (  """
//{
// "name": "flair",
// "children": [
// {   "name": "flower1",
//      "children": [{"name": "flow1"}, {"name": "flow2"}]
//      },
// {   "name": "flower2"},
// {   "name": "flower3",
//       "children": [{"name": "flow3"}, {"name": "flow4"},{"name": "flow6"}, {"name": "flow7"}]
//},
// ]
//}
//"""

}
