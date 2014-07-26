<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Array as Data</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>
<body>
<link media="all" rel="stylesheet" href="../css/ctrp/scatter.css">
<script src="../js/d3.js"></script>
<script src="../js/gew/qqplot.js"></script>
<script src="../js/ctrp/d3tooltip.js"></script>
<script src="../js/ctrp/slider.js"></script>
<div id="scatterPlot1"></div>
<div id="scatterPlot2"></div>
<div id='slider'></div>
<script>

    var margin = {top: 30, right: 20, bottom: 50, left: 70},
            width = 600 - margin.left - margin.right,
            height = 400 - margin.top - margin.bottom;

    data = [
        {x:3.5,
         y:3.5,
         popup:'rs79716074'
        },
        {x:4.9,
            y:4.99,
            popup:'more useful information'
        },
        {x:7,
            y:8,
            popup:'more information'
        }
    ];
    var significanceValue = 100,
            newSignificanceValue = significanceValue;
    var qqPlot;
    d3.json("http://localhost:8028/cow/box/qqPlotData", function (error, json) {



         qqPlot  =gew.qqPlot()
                 .selectionIdentifier("#scatterPlot1")
                 .width(width)
                 .height(height)
                 .margin(margin)
                 .xAxisLabel('expected')
                 .yAxisLabel('observed')
                 .xAxisAccessor(function (d) {
                     return d.x;
                 })
                 .yAxisAccessor(function (d) {
                     return d.y;
                 })
                 .tooltipAccessor(function (d) {
                     return d.popup
                 })
                 .displayIdentityLine (true)
                 .significanceLine (significanceValue)
                 .assignData(json);
         qqPlot.render();









//        qqPlot = gew.qqPlot()
//                .selectionIdentifier("#scatterPlot1")
//                .width(width)
//                .height(height)
//                .margin(margin)
//                .xAxisLabel('expected')
//                .yAxisLabel('observed')
//                .xAxisAccessor(function (d) {
//                    return d.x;
//                })
//                .yAxisAccessor(function (d) {
//                    return d.y;
//                })
//                .tooltipAccessor(function (d) {
//                    return d.popup
//                })
//                .displayIdentityLine (true)
//                .significanceLine (significanceValue)
//                .assignData(json);
//        qqPlot.render();
    } );


    var defaultInterquartileMultiplier = function(d){
        console.log('a'+ d.toString());
    };
    var onBrushMoveDoThis = function(d){
        console.log('b'+ d.toString());
        newSignificanceValue=  d;
    };
    var onBrushEndDoThis = function(d){
        qqPlot.oldSignificanceLine (significanceValue) ;
        qqPlot.significanceLine (newSignificanceValue) ;
        qqPlot.render();
        significanceValue =   newSignificanceValue;
    };
    var minimumInterquartileMultiplier = 180,
            maximumInterquartileMultiplier = 0,
            onScreenStart = 10,
            onScreenEnd = 200;

    var slider = d3.slider(minimumInterquartileMultiplier,
            maximumInterquartileMultiplier,
            onScreenStart,
            onScreenEnd,
            'vertical',defaultInterquartileMultiplier,onBrushMoveDoThis,onBrushEndDoThis) ;
    //onBrushMoveDoThis(minimumInterquartileMultiplier);






</script>

</body>
</html>