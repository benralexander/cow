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

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <link rel='stylesheet'  href='https://api.tiles.mapbox.com/mapbox.js/v2.1.5/mapbox.css'/>

    <!-- Latest compiled and minified bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script src='https://api.tiles.mapbox.com/mapbox.js/v2.1.5/mapbox.js'></script>

    <g:javascript src="d3.js"/>
</head>
<body>

<div class="container">

    <div class="starter-template">
        <p class="lead">First experiment using map box.  Trivially simple to build --  no JavaScript libraries required, and about one line of embedding code</p>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <iframe width='100%' height='500px' frameBorder='0' src='https://a.tiles.mapbox.com/v4/benralexander.l1la12ef/attribution,zoompan,zoomwheel,geocoder,share.html?access_token=pk.eyJ1IjoiYmVucmFsZXhhbmRlciIsImEiOiIyU0lyd01NIn0.-K124Cl1PgKSzS55XPrt2g'>

            </iframe>
        </div>
    </div>

</div><!-- /.container -->



<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>



<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>


<script>
</script>

</body>
</html>