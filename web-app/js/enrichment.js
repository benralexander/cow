addEnrichmentPlot = function(selector, width, height, values, hasFeature, minValue, midValue, maxValue, featureWithValues ) {

    var mySVG = d3.select(selector)
        .append("svg")
        .attr("width", width)
        .attr("height", height);

//	width = $(selector).width();

    //define a color scale using the min and max expression values
    var colorScale = d3.scale.linear()
        .domain([minValue, midValue, maxValue])
        .range(["blue", "white", "red"]);

    var heatmapValues = [];
    var featureIndices = [];
    var curStart = null;

    for(var i=0;i<values.length;i++) {
        if(hasFeature[i]) {
            if(curStart == null) {
                curStart = i;
            }
        } else {
            if(curStart != null) {
                featureIndices.push({start: curStart, count: i-curStart});
                curStart = null;
            }
        }

        heatmapValues.push({index: i, value: values[i]});
    }

    if(curStart != null) {
        featureIndices.push({start: curStart, count: values.length-curStart});
    }

    var w = width/values.length;

    // the heat map
    mySVG.selectAll(".heatmap")
        .data(heatmapValues)
        .enter().append("svg:rect")
        .attr('width', w)
        .attr('height', 2*height/3)
        .attr('x', function(d) { return d.index * w;} )
        .attr('y',0)
        .attr('fill', function(d) { return colorScale(d.value);});

    // feature map
    mySVG.selectAll(".featuremap")
        .data(featureIndices)
        .enter().append("svg:rect")
        .attr('width', function(d) { return d.count * w;} )
        .attr('height', 2*height/3)
        .attr('x', function(d) { return d.start * w;} )
        .attr('y',height/3)
        .attr('fill', "black")
        .attr('stroke', 'white');
}