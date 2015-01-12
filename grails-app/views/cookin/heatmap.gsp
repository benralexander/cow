<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>heat map</title>
    <meta name="layout" content="core"/>
    <script src="../js/jquery-2.0.3.min.js"></script>
    %{--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>--}%
    <g:javascript src="ctrp/d3.js"/>
    <g:javascript src="ctrp/d3tooltip.js"/>


    <!-- Styles -->
        <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.3.0/pure-min.css">
    <link rel="stylesheet" href="${resource(dir: 'css/mastering', file: 'windmill.css')}" type="text/css">

        <!-- Include the libraries -->
        <g:javascript src="masteringd3js/windmill.js"/>

</head>
<body>

<h1 class="section-title">heat map example</h1>


<style>
.box {
    padding-left: 10px;
    padding-right: 10px;
}
</style>

<div class="box">
    <h1>Heatmap Example</h1>
    <div class="pure-g">
        <div class="pure-u-1">
            <div class="box">
                <div id="chart01"></div>
            </div>
        </div>
    </div>

</div>

<script>
    // Generate a sample data array
    var data = [];
    for (var k = 0; k < 20; k += 1) {
        for (var j = 0; j < 20; j += 1) {
            data.push({row: k, column: j, value: Math.cos(Math.PI * k * j / 60)});
        }
    }

    // Create and configure the heatmap chart
    var heatmap = windmill.chart.heatmap()
            .width(600)
            .height(300)
            .colorExtent(['#f00', '#00f']);

    // Create the heatmap chart in the container selection
    d3.select('div#chart01')
            .data([data])
            .call(heatmap);
</script>

</body>
</html>
