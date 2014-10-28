<%--
Minimal coding example in D3 for May 22 demo
--%>

<html>
<head>

    <title>Sierpinski triangle demo</title>
    <meta name="layout" content="core"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'styles.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'sierpinski.css')}" type="text/css">
    <g:javascript src="d3.js"/>
    <g:javascript src="sierpinski.js"/>
    %{--<script type="text/javascript" src="../js/sierpinski.js"></script>--}%

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