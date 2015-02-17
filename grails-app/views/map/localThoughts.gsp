<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 2/15/2015
  Time: 10:53 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>What are people discussing in blank?</title>
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
    pre.ui-coordinates {
        position:absolute;
        bottom:10px;
        left:10px;
        padding:5px 10px;
        background:rgba(0,0,0,0.5);
        color:#fff;
        font-size:11px;
        line-height:18px;
        border-radius:3px;
    }

    </style>
    <script>

        var searchTwitterByLocale = function(searchText,latitude, longitude) {
            var success = function (data){
                var domPtr = $('#messageHolder');
               // var obj = JSON.parse(data);
                var obj = data;
                for ( var i = 0 ; i < obj["searchResults"].statuses.length ; i++ ){
                    var individualObject= obj["searchResults"].statuses[i];
                    domPtr.append('<li>'+individualObject.text+'</li>');
                }
            };
            // let's go query twitter
            $.ajax({
                cache: false,
                type: "post",
                url: "${createLink(controller:'SpringSecurityOAuth',action:'twitterLogin')}",
                data: {a: searchText,
                       latitude: latitude,
                       longitude: longitude},
                async: true,
                success: function (data) {
                    success ( data   );
                },
                error: function (jqXHR, exception) {
                    console.log('error!');
                }
            });

        };
    </script>

    <g:javascript src="d3.js"/>
</head>
<body>

<div class="container">

    <div class="starter-template">
        <div class="row">
            <div class="col-xs-offset-1 col-xs-6">
                <h3>Move the orange locator with your mouse. The system will then query twitter to find out what people are talking about in that geographical area</h3>
            </div>

            <div class="col-xs-5"></div>
        </div>

        <div class="row">
            <p><em>(still under development)</em></p>
        </div>
    </div>


    <div class="row">
        <div class="col-xs-12 mapHolder" >
            <div id='map' class='map'> </div>
            <pre id='coordinates' class='ui-coordinates'></pre>
        </div>
    </div>


    <script>
        L.mapbox.accessToken = 'pk.eyJ1IjoiYmVucmFsZXhhbmRlciIsImEiOiIyU0lyd01NIn0.-K124Cl1PgKSzS55XPrt2g';
        var map = L.mapbox.map('map', 'benralexander.l1la12ef').setView([ 0,0], 2);
        var coordinates = document.getElementById('coordinates');
        var marker = L.marker([0, 0], {
            icon: L.mapbox.marker.icon({
                'marker-color': '#f86767'
            }),
            draggable: true
        }).addTo(map);

        // every time the marker is dragged, update the coordinates container
        marker.on('dragend', ondragend);

        // Set the initial marker coordinate on load.
        ondragend();

        function ondragend() {
            var m = marker.getLatLng();
            if (( m.lat!==0)  &&  ( m.lng!==0) ){
                $('#messageHolder').empty()
                searchTwitterByLocale('',m.lat, m.lng)
                coordinates.innerHTML = 'Investigating <br />'+
                        'Latitude: ' + m.lat + '<br />Longitude: ' + m.lng;

            }
         }
    </script>

    <div class="row">
        <div class="col-xs-12" >
            <ol id="messageHolder"></ol>
        </div>
    </div>


</div><!-- /.container -->






<script>
</script>

</body>
</html>