<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Multi-Element Transition</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>

<body>

<script type="text/javascript">
    var id= 500,
        data = [], 
        duration = 500, 
        chartHeight = 500,
        chartWidth = 680,
        color = d3.scale.category20b(),
        colorCycler = 1;

    for(var i = 0; i < 20; i++) push(data);   

    function render(data) {
        var selection = d3.select("body")
                .selectAll("div.v-bar")
                .data(data, function(d){return d.id;}); // <-A

        // enter
        selection.enter()
                .append("div")
                    .attr("class", "v-bar")
                    .style("position", "fixed")
                    .style("top", chartHeight + "px")
                    .style("left", function(d, i){
                        return barLeft(i+1) + "px"; // <-B
                    })
                .style("height", "0px") // <-C
                .style("background-color",  function(d, i){
                    return d.color;
                }
                ) // <-C
                .append("span");

        // update
        selection
            .transition().duration(duration) // <-D
                .style("top", function (d) { 
                    return chartHeight - barHeight(d) + "px"; 
                })
                .style("left", function(d, i){
                    return barLeft(i) + "px";
                })
                .style("height", function (d) { 
                    return barHeight(d) + "px"; 
                })
                .select("span")
                    .text(function (d) {return d.id;});

        // exit
        selection.exit()
                .transition().duration(duration) // <-E
                .style("left", function(d, i){
                    return barLeft(-1) + "px"; //<-F
                })
                .remove(); // <-G
    }

    function push(data) {
        data.push({
            color: color((colorCycler++)%20),
            id: ++id, 
            value: Math.round(Math.random() * chartHeight)
        });
    }
    
    function barLeft(i) {
        return i * (30 + 2);
    }

    function barHeight(d) {
        var h= (chartHeight*0.5)+(Math.sin(d.id/10)*(chartHeight*0.5));
        console.log('h='+h);
        return h;
    }

    setInterval(function () {
        data.shift();
        push(data);
        render(data);
    }, 20);

    render(data);

    d3.select("body")
       .append("div")
           .attr("class", "baseline")
           .style("position", "fixed")
           .style("top", chartHeight + "px")
           .style("left", "0px")
           .style("width", chartWidth + "px");
</script>

</body>

</html>