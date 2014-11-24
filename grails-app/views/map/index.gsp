<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 11/23/2014
  Time: 11:55 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>mapping</title>

    <h2> Let's see what we can do with maps.</h2>
    <h5>Experiments:</h5>
    <ul>
        <li><a href="${createLink(controller: 'map', action:'geoJson')}">raw Geo JSON data</a></li>
        <li><a href="${createLink(controller: 'map', action:'topoJson')}">raw topo JSON data</a></li>
        <li><a href="${createLink(controller: 'map', action:'chloropleth')}">chloropleth</a></li>
        <li><a href="${createLink(controller: 'map', action:'topology')}">topology</a></li>
        <li><a href="${createLink(controller: 'map', action:'mapbox')}">map box</a></li>
    </ul>
</head>

<body>

</body>
</html>