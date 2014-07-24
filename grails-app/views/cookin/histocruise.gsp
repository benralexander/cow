
<head>
    <script src="../js/ctrp/d3.js"></script>
    <script src="../js/histocruise.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/histocruise.css"/>

</head>

<body>
<script>

    d3.json("/cow/cookin/retrieveJson", function (error, inData) {

        var swirlyHistogram = cbbo.swirlyHistogram().selectionIdentifier('#histogramGoesHere');

        swirlyHistogram.addSeries(inData);

        swirlyHistogram.render();

    });

</script>
<div id="histogramGoesHere"></div>
<div>
<button id="sort" >Sort</button>
<button id="reset">Reset</button>
<button id="random">Randomize</button>
</div>

</body>
