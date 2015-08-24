<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 8/21/2015
  Time: 8:56 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Learning curves</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>
<style>
body {
  font: 10px sans-serif;
}

.axis path,
.axis line {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.x.axis path {
    display: none;
}
.y .label {
    font-family: "sans-serif";
    font-size: 18px;
}

.line {
    fill: none;
    stroke: steelblue;
    stroke-width: 2.5px;
    font-family: "sans-serif";
    font-size: 32px;
}
.lineend {
    fill: none;
    stroke: steelblue;
    stroke-width: 0.5px;
    stroke-width: 0px;
    font-family: "sans-serif";
    font-size: 24px;
}
.line2start {
    fill: none;
    stroke: red;
    stroke-width: 0px;
    font-family: "sans-serif";
    font-size: 10px;
}
.line2end {
    fill: none;
    stroke: red;
    stroke-width: 1.5px;
    font-family: "sans-serif";
    font-size: 20px;
}
.line3start {
    fill: none;
    stroke: green;
    stroke-width: 0px;
    font-family: "sans-serif";
    font-size: 10px;
}
.line3end {
    fill: none;
    stroke: green;
    stroke-width: 1.5px;
    font-family: "sans-serif";
    font-size: 20px;
}
.line4start {
    fill: none;
    stroke: purple;
    stroke-width: 0px;
    font-family: "sans-serif";
    font-size: 10px;
}
.line4end {
    fill: none;
    stroke: purple;
    stroke-width: 1.5px;
    font-family: "sans-serif";
    font-size: 20px;
}

</style>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
<script>

    var demo = demo || {};


     demo.generateSigmoidPoints = function (yMin, curveHeight, hillSlope, Ec50, logBaseOfFittedCurve, xStart, xEnd) {
        var xVector = [];
        var returnValue = [];
        // first create the X factor
        var startHere = xStart;
        var endHere = xEnd;
        var curValue = startHere;

        while (curValue < endHere){
            xVector.push(curValue);
            curValue = curValue+1;
        }
        xVector = xVector.reverse();
        // now apply x vector to the sigmoid function
        for (var i = 0; i < xVector.length; i++) {
            // sanity check.  We cannot derive a line if the X values are less than zero
            // ( strictly speaking X values less than zero are only illegal if raised to
            //  a fractional power but we're splitting hairs -- if the concentration values
            //  are less than zero and clearly something is wrong ).  Therefore every time
            //  we will avoid generating any numbers for any points unless the X values are
            // nonnegative.
            if (xVector[i] >= 0) {
                returnValue.push({x: xVector[i],
                    y: (yMin + curveHeight / (1 + Math.pow(Math.E,((Ec50-xVector[i])* (hillSlope)))))});

            }
        }
        return returnValue;
    };


    var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 960 - margin.left - margin.right,
    height = 800 - margin.top - margin.bottom;

var parseDate = d3.time.format("%d-%b-%y").parse;

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var line2 = d3.svg.line()
            .x(function(d) { return x(d.date); })
            .y(function(d) { return y(d.y); });

    var line = d3.svg.line()
            .x(function(d) { return x(d.date); })
            .y(function(d) { return (y(d.y)*0.2)+(0.8*height); })
    var lineP1 = d3.svg.line()
            .x(function(d) { return x(d.date); })
            .y(function(d) { return (y(d.y)*0.2)+(0.8*height)+4; })
    var lineP2 = d3.svg.line()
            .x(function(d) { return x(d.date); })
            .y(function(d) { return (y(d.y)*0.2)+(0.8*height)+8; })
    var lineP3 = d3.svg.line()
            .x(function(d) { return x(d.date); })
            .y(function(d) { return (y(d.y)*0.2)+(0.8*height)+12; })


    var  yMin = 2,
          curveHeight = 3,
          hillSlope = 0.01,
          Ec50 = 500,
          logBaseOfFittedCurve = 10,
          xStart =1,
          xEnd =1000;
  var points =  demo.generateSigmoidPoints (yMin, curveHeight, hillSlope, Ec50, logBaseOfFittedCurve, xStart, xEnd) ;

    data = points.map(function(d) {
        var retval={};
        retval['date']  = Date.parse('March 21, '+(d.x+1000));
        retval['y']  =  +d.y;
        return retval;
    });

   x.domain(d3.extent(data, function(d) { return d.date; }));
  y.domain(d3.extent(data, function(d) { return d.y; }));

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("class", "label")
      .attr("dy", "-1.71em")
      .style("text-anchor", "end")
      .text("difficulty");

    var v=svg.selectAll("path.line").data([data]);
    v.enter().append("path").attr('class', 'line')
            .attr("d", line);

    v.transition()
            .duration(4000)
            .delay(8000)
            .attr("d", line2);
    var t =svg.append("text")
            .text("D3")
            .attr('class','lineend')
            .attr('x',width-300)
            .attr("y",600)  ;
    t.transition()
            .duration(4000)
            .delay(8000)
            .attr('x',width-400)
            .attr("y",20)
            .attr('class', 'line');

    var v2=svg.selectAll("path.line2start").data([data]);
    v2.enter().append("path").attr('class', 'line2start')
            .attr("d", lineP1);
    v2.transition(2000)
            .delay(2000)
            .attr('class', 'line2end');
    v2.transition(2000)
            .delay(8000)
            .attr('class', 'line2start');
    var t2 =svg.append("text")
            .text("HTML")
            .attr('class','line2start')
            .attr('x',width-320)
            .attr("y",height-160)  ;
    t2.transition()
            .delay(2000)
            .attr('class', 'line2end');
    t2.transition()
            .delay(8000)
            .attr('class', 'line2start');
    var v3=svg.selectAll("path.line3start").data([data]);
    v3.enter().append("path").attr('class', 'line3start')
            .attr("d", lineP2);
    v3.transition()
            .delay(4000)
            .attr('class', 'line3end');
    v3.transition()
            .delay(8000)
            .attr('class', 'line3start');
    var t3 =svg.append("text")
            .text("CSS")
            .attr('class','line3start')
            .attr('x',width-30)
            .attr("y",height-120)  ;
    t3.transition()
            .delay(4000)
            .attr('class', 'line3end');
    t3.transition()
            .delay(8000)
            .attr('class', 'line3start');
    var v4=svg.selectAll("path.line4start").data([data]);
    v4.enter().append("path").attr('class', 'line4start')
            .attr("d", lineP3);
    v4.transition()
            .delay(6000)
            .attr('class', 'line4end');
    v4.transition()
            .delay(8000)
            .attr('class', 'line4start');
    var t4 =svg.append("text")
            .text("Javascript")
            .attr('class','line4start')
            .attr('x',width-300)
            .attr("y",height-90)  ;
    t4.transition()
            .delay(6000)
            .attr('class', 'line4end');
    t4.transition()
            .delay(8000)
            .attr('class', 'line4start');


</script>
<html>