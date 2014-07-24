<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Function as Data</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>

<body>
<div id="container"></div>

<script type="text/javascript">
    var data = []; // <- A

    var next = function (x) { // <- B
        return 15 + x * x;
    };

    var newData = function () { // <- C
        data.push(next);
        return data;
    };

    function render(){
        var selection = d3.select("#container")
                .selectAll("div")
                .data(newData); // <- D

        selection.enter().append("div").append("span");

        selection.exit().remove();

        selection.attr("class", "v-bar")
                .style("height", function (d, i) {
                    return d(i) + "px"; // <- E
                })
                .select("span")
                .text(function(d, i){
                    return d(i); // <- F
                });
    }

    setInterval(function () {
        render();
    }, 1500);

    render();
</script>

</body>

</html>