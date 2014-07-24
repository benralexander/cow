<%--
Minimal coding example in D3 for May 22 demo
--%>

<html>
<head>

    <title>Graphical representation</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <link rel="stylesheet" type="text/css" href="../css/sierpinski.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <script type="text/javascript" src="../js/fundamental.js"></script>
    <style>
    #container {
        height: 400px;
    }

        #controls {
            position: relative;
            margin: : 10px;
        }
    </style>
</head>

<body>


<div id="container"></div>


<script>
    // Usage
    /////////////////////////////////

    var chart = cbbo.barChart();

    var myDataSet = [30,70,100,80,50];


    d3.select('#container')
      .datum(myDataSet)
      .call(chart.render);



</script>


<div id="controls">
    <button id="moveAroundButton" onclick="chart.changeForm()">change form</button>
    <button id="changeRoundButton" onclick="chart.changeRound()">change round</button>
    <button id="changeColorButton" onclick="chart.changeColor()">change color</button>
</div>


</body>
</html>