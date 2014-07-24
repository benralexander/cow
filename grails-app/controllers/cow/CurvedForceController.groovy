package cow

class CurvedForceController {

    def index() {
        render(view: 'curvedForce')
    }
    def  curvedForce ()  {}
    def feedMeJson(){
        render (  """
{
"nodes":
[
{
    "name":"biological process",
    "id": "GO",
    "index": 0,
    "level":0
},
{
    "name":"metabolic process",
    "id": "GO",
    "index": 1,
    "level":1
},
{
    "name":"cellular process",
    "id": "GO",
    "index": 2,
    "level":1
},
{
    "name":"organic substance metabolic process",
    "id": "GO",
    "index": 3,
    "level":2
},
{
    "name":"primary metabolic process",
    "id": "GO",
    "index": 4,
    "level":2
},
{
    "name":"cellular metabolic process",
    "id": "GO",
    "index": 5,
    "level":2
},
{
    "name":"response to stimulus",
    "id": "GO",
    "index": 6,
    "level":2
},
{
    "name":"macromolecule metabolic process",
    "id": "GO",
    "index": 7,
    "level":3
},
{
    "name":"cellular nitrogen compound metabolic process",
    "id": "GO",
    "index": 8,
    "level":3
},
{
    "name":"heterocycle metabolic process",
    "id": "GO",
    "index": 9,
    "level":3
},
{
    "name":"response to stimulus",
    "id": "GO",
    "index": 10,
    "level":3
},
{
    "name":"nucleo-base containing compound metabolic process",
    "id": "GO",
    "index": 11,
    "level":4
},
{
    "name":"cellular response to stress",
    "id": "GO",
    "index": 12,
    "level":4
},
{
    "name":"nucleic acid metabolic process",
    "id": "GO",
    "index": 13,
    "level":5
},
{
    "name":"DNA metabolic process",
    "id": "GO",
    "index": 14,
    "level":6
},
{
    "name":"response to DNA damaged stimulus",
    "id": "GO",
    "index": 15,
    "level":6
},
{
    "name":"DNA repair",
    "id": "GO",
    "index": 16,
    "level":7
}
],
"links":[
{"source": 0, "target": 1, "value": 2},
{"source": 0, "target": 2, "value": 2},
{"source": 0, "target": 6, "value": 2},
{"source": 1, "target": 3, "value": 2},
{"source": 1, "target": 4, "value": 2},
{"source": 1, "target": 5, "value": 2},
{"source": 2, "target": 5, "value": 2},
{"source": 3, "target": 7, "value": 2},
{"source": 4, "target": 11, "value": 2},
{"source": 4, "target": 8, "value": 2},
{"source": 5, "target": 8, "value": 2},
{"source": 5, "target": 9, "value": 2},
{"source": 6, "target": 10, "value": 2},
{"source": 7, "target": 13, "value": 2},
{"source": 8, "target": 11, "value": 2},
{"source": 9, "target": 11, "value": 2},
{"source": 10, "target": 12, "value": 2},
{"source": 11, "target": 13, "value": 2},
{"source": 12, "target": 15, "value": 2},
{"source": 13, "target": 14, "value": 2},
{"source": 14, "target": 16, "value": 2},
{"source": 15, "target": 16, "value": 2}]
}
""")  }





//    render (  """
//[{
//"source":"Harry",
//"target":"Sally",
//"value":1.2
//},
//{
//"source":"Harry",
//"target":"Mario",
//"value":1.3
//},
//{
//"source":"Peter",
//"target":"Johan",
//"value":0.7
//}]""")  }
//










//    Sarah,Alice,0.2
//    Eveie,Alice,0.5
//    Peter,Alice,1.6
//    Mario,Alice,0.4
//    James,Alice,0.6
//    Harry,Carol,0.7
//    Harry,Nicky,0.8
//    Bobby,Frank,0.8
//    Alice,Mario,0.7
//    Harry,Lynne,0.5
//    Sarah,James,1.9
//    Roger,James,1.1
//    Maddy,James,0.3
//    Sonny,Roger,0.5
//    James,Roger,1.5
//    Alice,Peter,1.1
//    Johan,Peter,1.6
//    Alice,Eveie,0.5
//    Harry,Eveie,0.1
//    Eveie,Harry,2.0
//    Henry,Mikey,0.4
//    Elric,Mikey,0.6
//    James,Sarah,1.5
//    Alice,Sarah,0.6
//    James,Maddy,0.5
}
