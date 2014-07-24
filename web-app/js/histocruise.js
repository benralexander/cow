var cbbo = cbbo || {};

(function () {


    cbbo.swirlyHistogram = function () {
        var chart = {},
            dataset,
            selectionIdentifier;

        var w = 900;
        var h = 500;

        chart.addSeries = function (series) {
            dataset = series;
        }


        // identify the dominant element upon which we will hang this graphic
        chart.selectionIdentifier = function (x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            return chart;
        };



        chart.render = function () {

            var xScale = d3.scale.ordinal()
                .domain(d3.range(dataset.length))
                .rangeRoundBands([0, w], 0.05);

            var yScale = d3.scale.linear()
                .domain([0, d3.max(dataset, function (d) {
                    return d.value;
                })])
                .range([0, h]);

            var key = function (d) {
                return d.key;
            };

            var colors = d3.scale.category10();

            var svg = d3.select(selectionIdentifier)
                .append("svg")
                .attr("width", w)
                .attr("height", h);


            bars = svg.selectAll("rect")
                .data(dataset, key);

            bars.enter()
                .append("rect")
                .attr("x", function (d, i) {
                    return xScale(i);
                })
                .attr("y", function (d) {
                    return h - yScale(d.value);
                })
                .attr("width", xScale.rangeBand())
                .attr("height", function (d) {
                    return yScale(d.value);
                })
                .attr("fill", function (d,i) {
                    var retColor;
                    switch (i){
                        case 0:
                        case 1:
                        case 2:
                            retColor =   colors(1);
                            break;
                        case 3:
                        case 4:
                        case 5:
                            retColor =   colors(2);
                            break;
                        case 6:
                        case 7:
                        case 8:
                            retColor =   '#8A0886';
                            break;
                        case 9:
                        case 10:
                        case 11:
                            retColor =   '#17becf';
                            break;
                        case 12:
                        case 13:
                        case 14:
                            retColor =   colors(6);
                            break;
                        default:
                            retColor =  colors(i);

                    }
                    return  retColor ;
                   // return "rgb(0, 0, " + (d.value * 10) + ")";
                })

                //Tooltip
                .on("mouseover", function (d) {
                    //Get this bar's x/y values, then augment for the tooltip
                    var xPosition = parseFloat(d3.select(this).attr("x")) + xScale.rangeBand() / 2;
                    var yPosition = parseFloat(d3.select(this).attr("y")) + 14;

                    //Update Tooltip Position & value
                    d3.select("#tooltip")
                        .style("left", xPosition + "px")
                        .style("top", yPosition + "px")
                        .select("#value")
                        .text(d.value);
                    d3.select("#tooltip").classed("hidden", false)
                })
                .on("mouseout", function () {
                    //Remove the tooltip
                    d3.select("#tooltip").classed("hidden", true);
                });

//Create labels
            svg.selectAll("text")
                .data(dataset, key)
                .enter()
                .append("text")
                .text(function (d) {
                    return d.value;
                })
                .attr("text-anchor", "middle")
                .attr("x", function (d, i) {
                    return xScale(i) + xScale.rangeBand() / 2;
                })
                .attr("y", function (d) {
                    return h - yScale(d.value) + 14;
                })
                .attr("font-family", "sans-serif")
                .attr("font-size", "11px")
                .attr("fill", "white");

            var sortOrder = false;
            var sortBars = function () {
                sortOrder = !sortOrder;

                sortItems = function (a, b) {
                    if (sortOrder) {
                        return a.value - b.value;
                    }
                    return b.value - a.value;
                };

                svg.selectAll("rect")
                    .sort(sortItems)
                    .transition()
                    .delay(function (d, i) {
                        return i * 50;
                    })
                    .duration(1000)
                    .attr("x", function (d, i) {
                        return xScale(i);
                    });

                svg.selectAll('text')
                    .sort(sortItems)
                    .transition()
                    .delay(function (d, i) {
                        return i * 50;
                    })
                    .duration(1000)
                    .text(function (d) {
                        return d.value;
                    })
                    .attr("text-anchor", "middle")
                    .attr("x", function (d, i) {
                        return xScale(i) + xScale.rangeBand() / 2;
                    })
                    .attr("y", function (d) {
                        return h - yScale(d.value) + 14;
                    });
            };

            d3.select("#sort").on("click", sortBars);

            function reset() {
                svg.selectAll("rect")
                    .sort(function (a, b) {
                        return a.key - b.key;
                    })
                    .transition()
                    .delay(function (d, i) {
                        return i * 50;
                    })
                    .duration(1000)
                    .attr("x", function (d, i) {
                        return xScale(i);
                    });

                svg.selectAll('text')
                    .sort(function (a, b) {
                        return a.key - b.key;
                    })
                    .transition()
                    .delay(function (d, i) {
                        return i * 50;
                    })
                    .duration(1000)
                    .text(function (d) {
                        return d.value;
                    })
                    .attr("text-anchor", "middle")
                    .attr("x", function (d, i) {
                        return xScale(i) + xScale.rangeBand() / 2;
                    })
                    .attr("y", function (d) {
                        return h - yScale(d.value) + 14;
                    });
            };
            // function for shuffling an array
            function shuffle(array, i0, i1) {
                var m = i1 - i0, t, i, j;
                while (m) {
                    i = Math.random() * m-- | 0;
                    t = array[m + i0], array[m + i0] = array[i + i0], array[i + i0] = t;
                }
                return array;
            };
            d3.select("#reset").on("click", reset);
            function random() {
                var randomArray = [];
                for (var i = 0; i < 15; i++) {randomArray.push(i)};
                shuffle(randomArray,0,randomArray.length) ;
                svg.selectAll("rect")
                    .sort(function (a, b) {
                        return randomArray[a.key] - randomArray[b.key];
                    })
                    .transition()
                    .delay(function (d, i) {
                        return i * 50;
                    })
                    .duration(1000)
                    .attr("x", function (d, i) {
                        return xScale(i);
                    });

                svg.selectAll('text')
                    .sort(function (a, b) {
                        return randomArray[a.key] - randomArray[b.key];
                    })
                    .transition()
                    .delay(function (d, i) {
                        return i * 50;
                    })
                    .duration(1000)
                    .text(function (d) {
                        return d.value;
                    })
                    .attr("text-anchor", "middle")
                    .attr("x", function (d, i) {
                        return xScale(i) + xScale.rangeBand() / 2;
                    })
                    .attr("y", function (d) {
                        return h - yScale(d.value) + 14;
                    });
            };
            d3.select("#random").on("click", random);
        };

        return chart;

    };

}());



