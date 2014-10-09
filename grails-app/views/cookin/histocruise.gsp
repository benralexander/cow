
<head>

    <g:javascript src="ctrp/d3.js"/>
    <g:javascript src="histocruise.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'histocruise.css')}" type="text/css">


</head>

<body>

<script>

    d3.json("${createLink(controller: 'cookin', action:'retrieveJson')}", function (error, inData) {

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
