<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Basic Axes</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>

<body>

<div class="control-group">
    <button onclick="renderAll('bottom')">
        horizontal bottom
    </button>
    <button onclick="renderAll('top')">
        horizontal top
    </button>
    <button onclick="renderAll('left')">
        vertical left
    </button>
    <button onclick="renderAll('right')">
        vertical right
    </button>
</div>

<script type="text/javascript">
    var height = 500, 
        width = 500, 
        margin = 25,
        offset = 50,
        axisWidth = width - 2 * margin,
        svg;
    
    function createSvg(){ // <-A
         svg = d3.select("body").append("svg") // <-B
            .attr("class", "axis") // <-C
            .attr("width", width)
            .attr("height", height);
    }
    
    function renderAxis(scale, i, orient){
        var axis = d3.svg.axis() // <-D
            .scale(scale) // <-E
            .orient(orient) // <-F
            .ticks(5); // <-G
        
        svg.append("g")        
            .attr("transform", function(){ // <-H
                if(["top", "bottom"].indexOf(orient) >= 0)
                    return "translate(" + margin + "," + i * offset + ")";
                else
                    return "translate(" + i * offset + ", " + margin + ")";
            })
            .call(axis); // <-I
    }
    
    function renderAll(orient){
        if(svg) svg.remove();
        
        createSvg();
        
        renderAxis(d3.scale.linear()
                    .domain([0, 1000])
                    .range([0, axisWidth]), 1, orient);
        renderAxis(d3.scale.pow()
                    .exponent(2)
                    .domain([0, 1000])
                    .range([0, axisWidth]), 2, orient);
        renderAxis(d3.time.scale()
                    .domain([new Date(2012, 0, 1), new Date()])
                    .range([0, axisWidth]), 3, orient);
    }
</script>

</body>

</html>