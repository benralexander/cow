<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Script-Type" content="text/javascript; charset=utf-8">
    <title>Jasmine Spec Runner</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="../css/sierpinski.css">
    <script src="../js/d3.js" charset="utf-8"></script>
    <script src="../js/crossfilter.js"></script>
    <script src="../js/topojson.js"></script>
    <link rel="stylesheet" type="text/css" href="../js/jasmine/jasmine.css">
    <script type="text/javascript" src="../js/jasmine/jasmine.js"></script>
    <script type="text/javascript" src="../js/jasmine/jasmine-html.js"></script>
    <!-- include spec files here... -->
    <script type="text/javascript" src="../js/sierpinski.js"></script>
    <!-- include source files here... -->
    <script type="text/javascript" src="../js/sierpinskiSpec.js"></script>
    <script type="text/javascript">
        (function() {
            var jasmineEnv = jasmine.getEnv();
            jasmineEnv.updateInterval = 1000;

            var trivialReporter = new jasmine.TrivialReporter();

            jasmineEnv.addReporter(trivialReporter);

            jasmineEnv.specFilter = function (spec) {
                return trivialReporter.specFilter(spec);
            };

            var currentWindowOnload = window.onload;

            window.onload = function () {
                if (currentWindowOnload) {
                    currentWindowOnload();
                }
                execJasmine();
            };

            function execJasmine() {
                jasmineEnv.execute();
            }
        })();
    </script>
</head>
<body ng-app="App" ng-controller="Controller">
<div class="container">
    <div class="row">
        <div class="span12">
            <h3>Code</h3>
        </div>
    </div>
</div>
</body>
</html>
