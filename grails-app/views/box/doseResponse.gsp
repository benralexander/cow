<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="core"/>
    <title>Line Chart</title>

    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'doseResponse.css')}" type="text/css">
    %{--<script type="text/javascript" src="../js/d3.js"></script>--}%
    %{--<script type="text/javascript" src="../js/d3.js"></script>--}%
    <g:javascript src="d3.js"/>
    <g:javascript src="ctrp/d3tooltip.js"/>
    <g:javascript src="ctrp/doseResponse.js"/>

    <style>
        .errorbar {
            fill: #379;
            stroke: #0099ff;
            stroke-width: 1.1px;
        }
    </style>
</head>

<body>

<script type="text/javascript">


    function update() {

        for (var i = 0; i < data.length; ++i) {
            var series = data[i];
            series.length = 0;
            for (var j = 0; j < numberOfDataPoint; ++j)
                series.push({x: j, y:  Math.random() * 9});
        }

        chart.render();
    }

    var numberOfSeries = 2,
            numberOfDataPoint = 11,
            data = [];
    var curves =  [
        {
            "curveInflectionPoint": 1.0914,
            "inflectionPointUpperCI": 29.035,
            "curveBaseline": 0.2156,
            "curveSlope": -0.10978,
            "maxConcAUC08": 36.8,
            "cpdAUC": 3.3268,
            "curveHeight": 0.62897,
            "pvPoint": [
                {
                    "pvError": 0.11172,
                    "pv": 0.963065667456791,
                    "cpdConc": 0.0011254
                },
                {
                    "pvError": 0.11172,
                    "pv": 1.0861674195306,
                    "cpdConc": 0.0022508
                },
                {
                    "pvError": 0.11172,
                    "pv": 1.0125526695726,
                    "cpdConc": 0.0045016
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.961082107912598,
                    "cpdConc": 0.0090032
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.778476091025291,
                    "cpdConc": 0.018005999999999998
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.948958726025352,
                    "cpdConc": 0.036012999999999996
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.745154528467278,
                    "cpdConc": 0.07202599999999999
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.574434720322612,
                    "cpdConc": 0.14404999999999998
                },
                {
                    "pvError": 0.11172,
                    "pv": 0.604261596569457,
                    "cpdConc": 0.2881
                },
                {
                    "pvError": 0.11171,
                    "pv": 0.771532402217735,
                    "cpdConc": 0.5762
                },
                {
                    "pvError": null,
                    "pv": 0.52585186554098,
                    "cpdConc": 1.1524
                },
                {
                    "pvError": 1.1346,
                    "pv": 0.382398860349926,
                    "cpdConc": 2.3048
                },
                {
                    "pvError": 0.18215,
                    "pv": 0.176171960892228,
                    "cpdConc": 4.6096
                },
                {
                    "pvError": 0.20414,
                    "pv": 0.243164629820139,
                    "cpdConc": 9.2193
                },
                {
                    "pvError": 0.20414,
                    "pv": 0.168381244537229,
                    "cpdConc": 18.439
                },
                {
                    "pvError": 0.20414,
                    "pv": 0.274036081054617,
                    "cpdConc": 36.877
                }
            ],
            "nominalEC50": 2.1308,
            "pvPredValueLast": 0.2156,
            "inflectionPointLowerCI": -26.852,
            "concUnit": "uM"
        }    ];


    var viabilityChart =  cbbo.doseResponse();
    var calculatedAucIndexRange = viabilityChart.calculateBoundsForShading (curves[0].pvPoint,
                    data.maxConcAUC08, 8),
            boundsForXAxis = viabilityChart.calculateBoundsForXAxis(curves[0].pvPoint);
    viabilityChart.displayGridLines(false)
            .xAxisLabel('log Concentration')
            .yAxisLabel('Viability')
            .selectionIdentifier('body')
            .title('this is my title')
            .width(400)
            .autoScale(false)
            .areaUnderTheCurve ([5,13]) // Shade points 5 - 13
            //.domainMultiplier(1.2)    only used if autoscale==true
            .areaUnderTheCurve([calculatedAucIndexRange.minIndex,calculatedAucIndexRange.maxIndex ])
            .x(d3.scale.log().domain([boundsForXAxis.min, boundsForXAxis.max]))
            .y(d3.scale.linear().domain([0, 1.5]));

//    var c = chart.generateSigmoidPoints(10,  //  yMin
//                                        100, //  yMax
//                                        -5,  // hillSlope
//                                        900,  // Ec50
//                                        100,  //  numberOfPoints
//                                        200,  //   xStart
//                                        1400 //   xEnd
//    );
//    var d = chart.generateSigmoidPoints( 50,  //  yMin
//            90, //  yMax
//            -6,  // hillSlope
//            900,  // Ec50
//            1000,  //  numberOfPoints
//            400,  //   xStart
//            1600 //   xEnd
//    );

 //   curves[1].elements =  c;
 //   curves[2].elements =  d;

    curves.forEach(function (series) {
        viabilityChart.addSeries(series);
    });

    viabilityChart.render();
</script>

<div class="control-group">
    <button onclick="update()">Update</button>
</div>

</body>

</html>