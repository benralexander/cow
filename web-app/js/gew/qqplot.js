var gew = gew || {};

(function () {

    gew.qqPlot = function () {

        // the variables we intend to surface
        var
            width = 1,
            height = 1,
            margin = {},
            selectionIdentifier = '',
            data = {},
            xAxisLabel = '',
            yAxisLabel = '',
            xAxisAccessor,
            yAxisAccessor,
            displayIdentityLine = true,
            significanceLine,
            oldSignificanceLine,
            clickCallback = function (d, i) {
                console.log ('default callback function for dot click')
            },


        // private variables
            instance = {},
            selection = {},
            x,
            y,
            color,
            legendColor = d3.scale.category10(),
            xAxis,
            yAxis,
            svg,

        //  private variable
            tip = d3.tip()
                .attr('class', 'd3-tip scatter-tip')
                .style('z-index', 51)
                .offset([-10, 0])
                .html(function (d) {
                    var textToPresent = "";
                    if (d) {
                        if ((typeof(tooltipAccessor) !== "undefined")&&
                            (typeof(tooltipAccessor(d)) !== "undefined")){
                            textToPresent = tooltipAccessor(d);
                        }  else {
                            var number = parseFloat(xAxisAccessor(d));
                            textToPresent = "Expected p = "+number.toPrecision(3) ;
                        }
                    }
                    return "<strong><span>" + textToPresent + "</span></strong> ";
                });


        // assign data to the DOM
        instance.assignData = function (x) {
            if (!arguments.length) return data;
            data = x;
            return instance;
        };


        // Now walk through the DOM and create the enrichment plot
        instance.render = function (g) {

            x = d3.scale.linear()
                .range([0, width]);

            y = d3.scale.linear()
                .range([height, 0]);

            color = function (d){
                if (typeof significanceLine!=="undefined") {
                    if (yAxisAccessor (d) > significanceLine){
                        return d3.rgb("#ff00ff");
                    } else {
                        return d3.rgb("#ffffff");
                    }
                } else {
                    return d3.rgb("#ffffff");
                }
            }


            xAxis = d3.svg.axis()
                .scale(x)
                .orient("bottom");

            yAxis = d3.svg.axis()
                .scale(y)
                .orient("left");

//            var previouslyExistingScatterPlot = selection.selectAll("svg");
//            if (previouslyExistingScatterPlot) {
//                previouslyExistingScatterPlot.remove();
//            }

            if (!svg) {
                svg = selection
                    .append("svg")
                    .attr("width", width + margin.left + margin.right)
                    .attr("height", height + margin.top + margin.bottom)
                    .append("g")
                    .attr("class", "scatter")
                    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
                    .call(tip);
            }

            // find the maximum in the minimums in order to scale the plot
            x.domain(d3.extent(data, xAxisAccessor)).nice();
            y.domain(d3.extent(data, yAxisAccessor)).nice();

            if (displayIdentityLine){
                // The identity line we want to draw should fit inside the axes defined
                //  by the set of points that constitute a queue queue plot. Therefore
                //  we establish the minimum/maximum values for each axis, and then compare
                //  those extremes against one another to generate 'the minimum of the maximums'
                //  and 'the maximum of the minimums'.  These points defined the identity line
                //  in the qqplot
                var globalMinimum = (x.domain()[0] > y.domain()[0])? x.domain()[0]:  y.domain()[0],
                globalMaximum = (x.domain()[1] < y.domain()[1])? x.domain()[1]:  y.domain()[1],

                identityLine = svg.append("line")
                    .attr("x1", x(globalMinimum))
                    .attr("y1", y(globalMinimum))
                    .attr("x2", x(globalMaximum))
                    .attr("y2", y(globalMaximum))
                    .attr("stroke-width", 2)
                    .attr("stroke", "black");

//                identityLine.transition()
//                    .duration(2000)
//                    .style("opacity", 0.5);

            }

            if (significanceLine) {
                var significanceDifferentiator  =  svg.selectAll(".significanceLine").data([significanceLine]);

                significanceDifferentiator.enter().append("line")
                    .attr("class", "significanceLine")
                    .attr("x1", x(x.domain()[0]))
                    .attr("y1", function(d){
                            return y(d);
                     })
                    .attr("x2", x(x.domain()[1]))
                    .attr("y2", function(d){
                        return y(d);
                    })
                    .attr("stroke-width", 2)
                    .attr("stroke", "red");

                significanceDifferentiator.transition()
                    .duration(1000)
                    .attr("y1", function(d){
                        console.log('t2');
                        return y(d);
                    })
                    .attr("y2", function(d){
                        return y(d);
                    });

                significanceDifferentiator.exit().remove();

            }

            svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis)
                .append("text")
                .attr("class", "label")
                .attr("x", width / 2)
                .attr("y", 40)
                .style("text-anchor", "middle")
                .style("font-weight", "bold")
                .text(xAxisLabel);

            svg.append("g")
                .attr("class", "y axis")
                .call(yAxis)
                .append("text")
                .attr("class", "label")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", "-3em")
                .attr("x", -height / 2)
                .style("text-anchor", "middle")
                .style("font-weight", "bold")
                .text(yAxisLabel);

            /***
             * data.handling
             */
            var dataDots = svg.selectAll(".dot")
                .data(data);

            dataDots.enter()
                .append("circle")
                .on('mouseover', tip.show)
                .on('mouseout', tip.hide)
                .on('click', clickCallback)

                .attr("class", "dot")
                .attr("r", 3)
                .attr("cx", function (d) {
                    return x(xAxisAccessor(d));
                })
                .attr("cy", function (d) {
                    return y(yAxisAccessor(d));
                })
                .style("fill", function (d) {
                    return color(d);
                });
            dataDots.transition()
                    .duration(1000)
                    .style("opacity", 0.1);

//                .style("opacity", 0)
//                .transition()
//                .duration(1000)
//                .attr("r", 3.5)
//                .style("opacity", 1);

            dataDots.transition()
                .duration(2000)
                .style("fill", function (d) {
                    return color(d);
                });

            dataDots.exit().transition()
                .style("fill", function (d) {
                    return color(d);
                })
                .remove();


            /***
             * legend handling
             */
            var legend = svg.selectAll(".legend")
                .data(legendColor.domain())
                .enter().append("g")
                .attr("class", "legend")
                .attr("transform", function (d, i) {
                    return "translate(0," + ((i * 20) - margin.top) + ")";
                });

            legend.append("rect")
                .attr("x", width - 18)
                .attr("width", 18)
                .attr("height", 18)
                .style("fill", legendColor);

            legend.append("text")
                .attr("x", width - 24)
                .attr("y", 9)
                .attr("dy", ".35em")
                .style("text-anchor", "end")
                .text(function (d) {
                    return d;
                });

        };
        instance.xAxisAccessor = function (x) {
            if (!arguments.length) return xAxisAccessor;
            xAxisAccessor = x;
            return instance;
        };

        instance.yAxisAccessor = function (x) {
            if (!arguments.length) return yAxisAccessor;
            yAxisAccessor = x;
            return instance;
        };
        instance.tooltipAccessor = function (x) {
            if (!arguments.length) return tooltipAccessor;
            tooltipAccessor = x;
            return instance;
        };


        instance.width = function (x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };

        instance.height = function (x) {
            if (!arguments.length) return height;
            height = x;
            return instance;
        };


        instance.xAxisLabel = function (x) {
            if (!arguments.length) return xAxisLabel;
            xAxisLabel = x;
            return instance;
        };

        instance.yAxisLabel = function (x) {
            if (!arguments.length) return yAxisLabel;
            yAxisLabel = x;
            return instance;
        };

        instance.margin = function (x) {
            if (!arguments.length) return margin;
            margin = x;
            return instance;
        };

        instance.clickCallback = function (x) {
            if (!arguments.length) return clickCallback;
            clickCallback = x;
            return instance;
        };

        instance.displayIdentityLine = function (x) {
            if (!arguments.length) return displayIdentityLine;
            displayIdentityLine = x;
            return instance;
        };

        instance.significanceLine = function (x) {
            if (!arguments.length) return significanceLine;
            significanceLine = x;
            return instance;
        };

        instance.oldSignificanceLine = function (x) {
            if (!arguments.length) return oldSignificanceLine;
            oldSignificanceLine = x;
            return instance;
        };


        instance.selectionIdentifier = function (x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };

        return instance;
    };

})();