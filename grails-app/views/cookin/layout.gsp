<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>layout example</title>
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

<h1 class="section-title">layout example</h1>


<style>
.box {
    padding-left: 10px;
    padding-right: 10px;
}

.json {
    border: solid 1px #444;
    background-color: #ddd;
    padding: 4px;
    font-size: 14px;
}
</style>

<div class="box">
    <h1>Layout Example</h1>

    <div class="pure-g">
        <div class="pure-u-1-2">
            <div class="box">
                <h2>Raw Data</h2>
                There are several values for each combination of a and b.
                <pre id="before" class="json"></pre>
            </div>
        </div>
        <div class="pure-u-1-2">
            <div class="box">
                <h2>Layout</h2>
                The values are computed using the <code>average</code> aggreation function.
                <pre id="after" class="json"></pre>
            </div>
        </div>
    </div>

</div>

<script>
    // Define the aggregation function (average)
    var average = function(values) {
        var sum = 0;
        values.forEach(function(d) { sum += d;});
        return sum / values.length;
    }

    // Create and configure a matrix layout instance
    var matrix = windmill.layout.matrix()
            .row(function(d) { return d.a; })
            .column(function(d) { return d.b; })
            .value(function(d) { return d.c; })
            .aggregate(average);

    // Sample data. Each (row, column) combination have more than one value
    var data = [];

    for (var k = 0; k < 6; k += 1) {
        for (var j = 0; j < 6; j += 1) {
            data.push({a: k, b: j, c: Math.floor(5 * Math.random())});
            data.push({a: k, b: j, c: Math.floor(5 * Math.random())});
        }
    }

    // Fill the boxes with sample code
    d3.select('pre#before').text(JSON.stringify(data.slice(0, 4), null, 4));
    d3.select('pre#after').text(JSON.stringify(matrix(data).slice(0, 2), null, 4));

    // Display the original data and the computed matrix data.
    console.log(data);
    console.log(matrix(data));
</script>


</body>
</html>
