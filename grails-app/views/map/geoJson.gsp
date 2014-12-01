<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 11/23/2014
  Time: 10:50 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <g:javascript src="ctrp/d3.js"/>

</head>

<body>

<h1 class="section-title">Geo Json</h1>

<h2 class="section-subtitle">GeoJSON file</h2>


<div>
    <pre id="json"></pre>
</div>

<script>

    d3.json("${createLink(controller: 'map', action:'retrieveCountriesGeoJson')}", function (error, inData) {


        // Handles errors getting and parsing the data
        if (error) { return error; }

        // Dumps the content of the GeoJSON file in the pre element
        d3.select('pre#json').html(JSON.stringify(inData, null, 4));
    });

</script>

</body>
</html>