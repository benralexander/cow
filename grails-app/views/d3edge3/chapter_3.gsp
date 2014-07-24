<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Script-Type" content="text/javascript; charset=utf-8">
    <link href="../css/bootstrap.css" type="text/css" rel="stylesheet"/>
    <link href="../lib/css/style.css" type="text/css" rel="stylesheet"/>
    <script src="../js/d3.js"></script>
    <script src="../js/angular.js"></script>
    <script src="../js/controller.js"></script>
</head>
<body ng-app="App" ng-controller="Controller">
<div class="container">
    <div class="row">
        <div class="span12 page-header">
            <h1>
                Chapter 3 - The Reusable API
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="span12 lead">
            Expected output below: 4 lines of "Hello World", 2 of them black, two of them green and with a larger font size.
        </div>
    </div>
    <div class="row">
        <div class="span3 offset4">
            <div id="figure"></div>
        </div>
    </div>
    <div class="row">
        <div class="span12">
            <h3>Code</h3>
        </div>
    </div>
    <div class="row">
        <div class="span12">
            <div>
               <html:render file="snippet.html"/>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="../js/script.js"></script>
</body>
</html>