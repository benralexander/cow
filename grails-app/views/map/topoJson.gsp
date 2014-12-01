
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <g:javascript src="ctrp/d3.js"/>

</head>

<body>

<h1 class="section-title">Topo Json</h1>

<h2 class="section-subtitle">The TopoJSON file we will be starting with</h2>


<div>
    <pre id="json"></pre>
</div>

<script>

    d3.json("${createLink(controller: 'map', action:'retrieveCountriesTopoJson')}", function (error, inData) {


        // Handles errors getting and parsing the data
        if (error) { return error; }

        // Dumps the content of the GeoJSON file in the pre element
        d3.select('pre#json').html(JSON.stringify(inData, null, 4));
    });

</script>

</body>
</html>

