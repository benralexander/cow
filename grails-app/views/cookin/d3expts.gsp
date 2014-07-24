<%--
  Created by IntelliJ IDEA.
  User: balexand
  Date: 4/29/14
  Time: 8:23 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
</head>
<body>

</body>
</html>
<html>
<head>
    <title>d3 experiment</title>
    <script type="text/javascript" src="../js/d3.js"></script>
    <style type="text/css">
    .box {
        background-color: skyblue;
        width: 24px;
        height: 18px;
        padding: 4px;
        margin: 1px;
    }
    </style>
</head>
<body>
<div id="viz"></div>
<script type="text/javascript">

    var sampleSVG = d3.select("#viz")
            .append("svg")
            .attr("width", 100)
            .attr("height", 100);

    sampleSVG.append("circle")
            .style("stroke", "gray")
            .style("fill", "white")
            .attr("r", 40)
            .attr("cx", 50)
            .attr("cy", 50)
            .on("mouseover", function(){d3.select(this).style("fill", "aliceblue");})
            .on("mouseout", function(){d3.select(this).style("fill", "white");})
            .on("mousedown", animateFirstStep);

    function animateFirstStep(){
        d3.select(this)
                .transition()
                .delay(0)
                .duration(1000)
                .attr("r", 10)
                .each("end", animateSecondStep);
    };

    function animateSecondStep(){
        d3.select(this)
                .transition()
                .duration(1000)
                .attr("r", 40);
    };

</script>
</body>
</html>
