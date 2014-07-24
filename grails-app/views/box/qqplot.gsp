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
<div id="scatterPlot1"></div>
<div id="scatterPlot2"></div>
<script>

    var margin = {top: 30, right: 20, bottom: 50, left: 70},
            width = 600 - margin.left - margin.right,
            height = 400 - margin.top - margin.bottom;

    data = [
        {quantiles1:3.5,
         quantiles2:3.5,
         popup:'rs79716074'
        },
        {quantiles1:4.9,
            quantiles2:4.99,
            popup:'more useful information'
        },
        {quantiles1:7,
            quantiles2:8,
            popup:'more information'
        }
    ];

    d3.json("http://localhost:8028/cow/box/qqPlotData", function (error, json) {

        gew.qqPlot()
                .selectionIdentifier("#scatterPlot1")
                .width(width)
                .height(height)
                .margin(margin)
                .xAxisLabel('expected')
                .yAxisLabel('observed')
                .xAxisAccessor(function (d) {
                    //return d.quantiles1;
                    return d.x;
                })
                .yAxisAccessor(function (d) {
                   // return d.quantiles2;
                    return d.y;
                })
                .tooltipAccessor(function (d) {
                    return d.popup
                })
                .displayIdentityLine (true)
                .assignData(json)
                .render();
    } );


</script>

</body>
</html>