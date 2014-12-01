
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <g:javascript src="ctrp/d3.js"/>
    %{--<g:javascript base="https://api.tiles.mapbox.com/" src="/mapbox.js/v1.6.2/mapbox.js"/>--}%
    %{--<link rel="stylesheet" href="https://api.tiles.mapbox.com/mapbox.js/v1.6.2/mapbox.css" type="text/css">--}%
    <g:javascript src="/mapbox.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mapbox.css')}" type="text/css">


</head>

<body>

<h1 class="section-title">Map box</h1>



<div>
    <style>
    .map-container {
        position: relative;
        width: 500px;
        height: 500px;
    }

    #map01 {
        position: absolute;
        top: 0;
        bottom: 0;
        width: 100%;
    }

    #map02 {
        position: absolute;
        top: 0;
        bottom: 0;
        width: 100%;
    }

    .city {
        fill: #4ECDC4;
        fill-opacity: 0.3;
    }

    .highlight {
        fill-opacity: 0.8;
    }

    </style>
</div>


<h2 class="section-subtitle">Simple Map</h2>

<div class="map-container">
    <div id="map01"></div>
</div>

<script>
    // Declare the map ID, the center and zoom level of the map view
    var mapID = 'pnavarrc.hhm52af9',
            center = [12.526, -69.997],
            zoomLevel = 11;

    // Create an instance of the map and render it in the container div
    var map01 = L.mapbox.map('map01', mapID)
            .setView(center, zoomLevel);
</script>

</body>
</html>