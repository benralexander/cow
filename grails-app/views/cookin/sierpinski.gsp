<%--
Minimal coding example in D3 for May 22 demo
--%>

<html>
<head>

    <title>Sierpinski triangle demo</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <link rel="stylesheet" type="text/css" href="../css/sierpinski.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <script type="text/javascript" src="../js/sierpinski.js"></script>

</head>

<body>


<div id="triangleGoesHere" />





<div id="controlWidgets">
    <input id="levelSpinner" type="number" min="1" max="10" step="1" value="6" size="2"
           oninput="myTriangle.levelsOfDescent(this.value).clear().render()">
    Levels of descent
    </input>
    <button id="moveAroundButton" onclick="myTriangle.moveAround()">moveAround</button>
</div>

<script>


    var myTriangle = cbbo.sierpinskiTriangle()
            .selectionIdentifier("#triangleGoesHere")
            .levelsOfDescent(6)
            .render();


</script>


</body>
</html>