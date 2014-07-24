<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>BARD : Experiment Result : 3325</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="../js/d3.min.js"></script>
    <script src="../js/dc.js"></script>
    <script src="../js/crossfilter.min.js"></script>
<style>

.bar rect {
    shape-rendering: crispEdges;
}

.xaxis path, .xaxis line {
    fill: none;
    stroke: #000;
    shape-rendering: crispEdges;
}
.xaxis text {
    fill: none;
    font-size: 12px;
    font-family: sans-serif;
    font-style: normal;
    stroke: #000;
}
.yaxis line {
    fill: none;
    stroke: #ccc;
    shape-rendering: crispEdges;
}
.yaxis path {
    display: none;
}
.yaxis text {
    fill: none;
    font-size: 12px;
    font-family: sans-serif;
    font-style: normal;
    stroke: #000;
    /*display: none;*/
    shape-rendering: crispEdges;
}

.histogramDiv {
    display: inline-block;
    border-style:solid;
    border-width: 2px;
    border-color:#000000;
    margin-right: 4px;
    margin-bottom: 4px;
    background-color:#E7FFF9;
    -moz-border-radius: 15px;
    border-radius: 15px;

}
.toolTextAppearance {
    position: relative;
    font: 16px serif;
    font-weight: bold;
    margin: 5px;
    padding: 10px;
    background: #eeeeee;
    border: 1px solid blue;
    -moz-border-radius: 15px;
    border-radius: 15px;
}
.histogramTitle {
    font-size: 18px;
    font-weight: bold;
    text-decoration: underline;
    margin-top: 20px;
}
.histogramMouseInfo {
    font-size: 9px;
    font-weight: normal;
    font-style: italic;
color: #000000;
}
</style>







<script>
    var histoHolder;
    function histogram(domMarker, oneHistogramsData) {
        "use strict";
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // This D3 graphic is implemented in three sections: definitions, tools, and then building the DOM
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        // Check your data before going any further.  If something is wrong than abandon the whole process up front
        if ((oneHistogramsData === undefined) ||
                (oneHistogramsData.histogram === undefined) ||
                (oneHistogramsData.histogram.length <= 0)) {
            return;
        }

        //
        // Part 1: definitions
        //

        // Size definitions go here
        var container_dimensions = {width: 800, height: 270},
                margin = {top: 30, right: 20, bottom: 30, left: 68},
                chart_dimensions = {
                    width: container_dimensions.width - margin.left - margin.right,
                    height: container_dimensions.height - margin.top - margin.bottom
                },

        // adjustable parameters
                barPaddingPercent = 12,
                ticksAlongHorizontalAxis = 5,
                numberOfHorizontalGridlines = 10,
                paddingOnTopForTitle = 10,
                yLabelProportion = 1, /* implies (1-yLabelProportion is) reserved for y axis labels  */
                minXValue = d3.min(oneHistogramsData.histogram, function (d) {
                    return d[1];
                }),
                maxXValue = d3.max(oneHistogramsData.histogram, function (d) {
                    return d[2];
                }),
                svg,

        // D3 scaling definitions
                xScale = d3.scale.linear()
                        .domain([minXValue, maxXValue])
                        .range([0, chart_dimensions.width]),
                yScale = d3.scale.linear()
                        .domain([0, d3.max(oneHistogramsData.histogram, function (d) {
                            return d[0];
                        })])
                        .range([chart_dimensions.height, margin.bottom]),
                histogramBarWidth = xScale(maxXValue - minXValue) / oneHistogramsData.histogram.length,
                adjustedHistogramBarWidth = histogramBarWidth - ((barPaddingPercent / 100) * histogramBarWidth),

        //
        // Part 2: tools
        //


        // D3 axis definitions
                xAxis = d3.svg.axis()
                        .scale(xScale)
                        .orient("bottom")
                        .ticks(ticksAlongHorizontalAxis),
                yAxis = d3.svg.axis()
                        .scale(yScale)
                        .orient("left")
                        .ticks(numberOfHorizontalGridlines)
                        .tickSize(-chart_dimensions.width * yLabelProportion),

        // Encapsulate the variables/methods necessary to handle tooltips
                TooltipHandler = function () {

                    // Safety trick for constructors
                    if (!(this instanceof TooltipHandler)) {
                        return new TooltipHandler();
                    }

                    // private variable =  tooltip
                    var tooltip = d3.select("body")
                            .append("div")
                            .style("position", "absolute")
                            .style("opacity", "0")
                            .attr("class", "toolTextAppearance");

                    // public methods
                    this.respondToBarChartMouseOver = function (d) {
                        var stringToReturn = tooltip.html('Compounds in bin: ' + d[0] +
                                '<br/>' + 'Minimim bin value: ' + d[1].toPrecision(3) +
                                '<br/>' + 'Maximum bin value:' + d[2].toPrecision(3));
                        tooltip
                                .transition()
                                .duration(500)
                                .style("opacity", "1");
                        d3.select(this)
                                .transition()
                                .duration(10)
                                .attr('fill', '#FFA500');
                        return stringToReturn;
                    };
                    this.respondToBarChartMouseOut = function (d) {
                        var returnValue = tooltip
                                .transition()
                                .duration(500)
                                .style("opacity", "0");
                        d3.select(this)
                                .transition()
                                .duration(250)
                                .attr('fill', 'steelblue');
                        return returnValue;
                    };
                    this.respondToBarChartMouseMove = function (d) {
                        return tooltip.style("top", (d3.event.pageY - 10) + "px").style("left", (d3.event.pageX + 10) + "px");
                    };
                },
                tooltipHandler = new TooltipHandler();

        //
        //  part 3:  Build up the Dom
        //


        var createTheBars  = function (svg,oneHistogramsData) {
            // Create the rectangles that make up the histogram
            var bar = svg.selectAll("g.bar")
                    .data(oneHistogramsData.histogram,function(d){return d[3]});

            bar.enter() // enter
                    .append("g");


            bar.attr("class", "bar")  // update
                    .attr("fill", "steelblue")
                    .append('svg:polyline')
                    .attr('points', function (d) {
                        return (xScale(d[1]) + ' ' + (yScale(0)) + ',' +
                                xScale(d[1]) + ' ' + yScale(d[0]) + ',' +
                                xScale(d[2]) + ' ' + yScale(d[0]) + ',' +
                                xScale(d[2]) + ' ' + (yScale(0)))
                    })
                    .attr('stroke-width', 2).attr("stroke", "black").attr('id', 'foo')
                    .on("mouseover", tooltipHandler.respondToBarChartMouseOver)
                    .on("mousemove", tooltipHandler.respondToBarChartMouseMove)
                    .on("mouseout", tooltipHandler.respondToBarChartMouseOut);

            bar.exit(); // exit
        }

        var sortTheBars  = function () {
            var sortFunction = function(a,b){
                return (b[0]-a[0]);
            };
            // Create the rectangles that make up the histogram

            var bar = svg.selectAll("g.bar")
                    .data(oneHistogramsData.histogram,function(d){
                        return d[3]
                    }).sort(sortFunction);
            bar.enter() // enter
                    .append("g");

            // var bar = d3.selectAll(".bar").sort(sortFunction);

            bar.attr("class", "bar").transition()
                    .delay(function (d, i) {
                        return i * 50;
                    })
                    .duration(1000)
                    .attr('fill',function () {
                return "#ff0000"
            })
                    .attr('points', function (d) {
                        return (xScale(d[1]) + ' ' + (yScale(0)) + ',' +
                                xScale(d[1]) + ' ' + yScale(d[0]) + ',' +
                                xScale(d[2]) + ' ' + yScale(d[0]) + ',' +
                                xScale(d[2]) + ' ' + (yScale(0)))
                    }) ;

        }


//        var sortTheBars  = function () {
//            var sortFunction = function(a,b){
//                return (b[0]-a[0]);
//            };
//            // Create the rectangles that make up the histogram
//            var bar = d3.selectAll(".bar");
//            // var bar = d3.selectAll(".bar").sort(sortFunction);
//
//            bar		.sort(sortFunction).transition()
//                    .delay(function (d, i) {
//                        return i * 50;
//                    })
//                    .duration(1000)
//                    .attr('fill',function () {
//                        return "#ff0000"
//                    })
//                    .attr('points', function (d) {
//                        return (xScale(d[1]) + ' ' + (yScale(0)) + ',' +
//                                xScale(d[1]) + ' ' + yScale(d[0]) + ',' +
//                                xScale(d[2]) + ' ' + yScale(d[0]) + ',' +
//                                xScale(d[2]) + ' ' + (yScale(0)))
//                    }) ;
//
//        }







        var render = function () {

            // Create a div for each histogram we make. All of those divs are held within the div with ID = histogramHere
            // Create an SVG to hold the graphics
            svg = domMarker
                    .append("div")
                    .attr("class", "histogramDiv")
                    .append("svg")
                    .attr("width", chart_dimensions.width + margin.left + margin.right)
                    .attr("height", chart_dimensions.height + margin.top + margin.bottom)
                    .append("g")
                    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            // Create grid lines
            svg.append("g")
                    .attr("class", "yaxis")
                    .attr("transform", "translate(" + chart_dimensions.width * (1 - yLabelProportion) + ",0)")
                    .attr("x", "30px")
                    .call(yAxis);

            createTheBars(svg,oneHistogramsData);
            // Create the rectangles that make up the histogram
//            var bar = svg.selectAll("rect")
//                    .data(oneHistogramsData.histogram);
//
//            bar.enter() // enter
//                    .append("g");
//
//
//            bar.attr("class", "bar")  // update
//                    .attr("fill", "steelblue")
//                    .append('svg:polyline')
//                    .attr('points', function (d) {
//                        return (xScale(d[1]) + ' ' + (yScale(0)) + ',' +
//                                xScale(d[1]) + ' ' + yScale(d[0]) + ',' +
//                                xScale(d[2]) + ' ' + yScale(d[0]) + ',' +
//                                xScale(d[2]) + ' ' + (yScale(0)))
//                    })
//                    .attr('stroke-width', 2).attr("stroke", "black").attr('id', 'foo')
//                    .on("mouseover", tooltipHandler.respondToBarChartMouseOver)
//                    .on("mousemove", tooltipHandler.respondToBarChartMouseMove)
//                    .on("mouseout", tooltipHandler.respondToBarChartMouseOut);
//
//            bar.exit(); // exit


            // Create horizontal axis
            svg.append("g")
                    .attr("class", "xaxis")
                    .attr("transform", "translate(0," + chart_dimensions.height + ")")
                    .call(xAxis);

            // Create title  across the top of the graphic
            svg.append("text")
                    .attr("x", (chart_dimensions.width / 2))
                    .attr("y", -(margin.top / 2) + paddingOnTopForTitle)
                    .attr("text-anchor", "middle")
                    .attr("class", "histogramTitle")
                    .text("Distribution of '" + oneHistogramsData.name + "'");

            // Create title  across the top of the graphic
            svg
                    .append("text")
                    .attr("x", (4 * chart_dimensions.width / 5))
                    .attr("y", -(margin.top / 2) + paddingOnTopForTitle)
                    .attr("text-anchor", "right")
                    .attr("class", "histogramMouseInfo")
                    .text("Mouse-over bars for more information");
        };



        var sort = function () {
        }

        return {
            render: render,
            sortTheBars:sortTheBars
        }
    }


</script>
<script>
        d3.json("http://localhost:8028/cow/histogram/feedMeTripleJson", function(error,dataFromServer) {
    //    d3.json("http://localhost:8028/cow/histogram/feedMeDoubleJson", function(error,dataFromServer) {
    //    d3.json("http://localhost:8028/cow/histogram/feedMeJson", function(error,dataFromServer) {

                if (error) {
                    return console.log(error);
                }


                for ( var i = 0; i < dataFromServer.length; i++)  {
                    histoHolder=histogram(d3.select('#histogramHere'),dataFromServer[i]);
                    histoHolder.render();
                }

        });

    </script>


</head>





<body>

<div id="histogramHere" />

<div class="control-group">
    <button onclick="histoHolder.sortTheBars()">sort</button>
</div>

</body>



</html>