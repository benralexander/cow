<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 2/15/2015
  Time: 10:53 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>testing maps with map box</title>
    <meta name="layout" content="core"/>
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'doseResponse.css')}" type="text/css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <link rel='stylesheet'  href='https://api.tiles.mapbox.com/mapbox.js/v2.1.5/mapbox.css'/>

    <!-- Latest compiled and minified bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src='https://api.tiles.mapbox.com/mapbox.js/v2.1.5/mapbox.js'></script>

    <style>
    body { margin:0; padding:0; }
    .map { position:absolute; top:0; bottom:0; width:100%; }
    .mapHolder { min-height: 800px; }
    </style>

    <g:javascript src="d3.js"/>
</head>
<body>

<div class="container">

    <div class="starter-template">
        <p class="lead">A map box example that uses  their JavaScript library and therefore allows some customization. It's interesting to imagine
        all of the things that I can specify with a map.</p>
        <p>I guess that I'll point
        my map at Dashashwamedh Ghat in the city of Varanasi, with a marker on the spot where I first met Ananda back in '97</p>
    </div>


    <div class="row">
        <div class="col-xs-12 mapHolder" >
            <div id='map-one' class='map'> </div>
        </div>
    </div>


    <script>
        L.mapbox.accessToken = 'pk.eyJ1IjoiYmVucmFsZXhhbmRlciIsImEiOiIyU0lyd01NIn0.-K124Cl1PgKSzS55XPrt2g';
        var geojson = [
            {
                "type": "FeatureCollection",
                "features": [
                    {
                        "type": "Feature",
                        "geometry": {
                            "type": "Point",
                            "coordinates": [
                                83.010368,
                                25.307073
                            ]
                        },
                        "properties": {
                            "title": "The confusion begins...",
                            "marker-color": "#9c89cc",
                            "marker-size": "large"
                        }
                    }
                ]
            }

        ];
        var map = L.mapbox.map('map-one', 'benralexander.l1la12ef', {
            scrollWheelZoom: false
        }).setView([ 25.308177,83.009932], 16);



        map.legendControl.addLegend('<div style="border: 2px solid black; padding:10px; margin: 0"><strong>I was sitting and quietly pondering mortality at the burning ghat when it all began.</strong></div>')
        var myLayer = L.mapbox.featureLayer().addTo(map);
        myLayer.setGeoJSON(geojson);

    </script>


</div><!-- /.container -->






<script>
</script>

</body>
</html>