<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 4/26/14
  Time: 1:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Mandelbrot set</title>
    <meta name="layout" content="core"/>
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'doseResponse.css')}" type="text/css">

    <g:javascript src="d3.js"/>
</head>
<body>

    <script>
        d3.select('body')
                .append('svg')
                .append('rect')
                .attr("height", 250)
                .attr("width", 250);

        d3.select("body")
                .selectAll("div.fee")
                .data([4, 8, 15])
                .enter()
                .insert("div")
                .attr('class','fee')
                .text(function(d) { return ""+d; });

    </script>

</body>
</html>