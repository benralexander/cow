var cbbo = cbbo || {};


(function () {
    "use strict";

    cbbo.barChart = function module() {

        var chart = {},
            margin = {top: 20, right: 20, bottom: 40, left: 10},
            width = 500,
            height = 500,
            gap = 10,
            ease = "cubic",
            chartClass = "chart",
            x1,
            y1,
            bars,
            container,
            svg,
            saveData,
            barH,
            lines,pie;

        chart.render = function (selection) {
            selection.each(function (data) {

                var chartW = width - margin.left - margin.right,
                    chartH = height - margin.top - margin.bottom;

                    barH = 40;


                x1 = d3.scale.linear()
                    .domain([0, d3.max(data, function (d, i) {
                        return d;
                    })])
                    .range([0, 400]);

                y1 = d3.scale.linear()
                    .domain([0, 60])
                    .range([chartH, 0]);


                svg = d3.select(this)
                        .selectAll("svg")
                        .data([data]);

                saveData = data;

                container = svg.enter().append("svg")
                    .classed(chartClass, true)
                    .append("g").classed("container-group", true)
                    .append("g").classed("chart-group", true);


                bars = svg.select(".chart-group")
                    .selectAll(".bar")
                    .data(data);

                bars.enter().append("rect")
                    .classed("bar", true)
                    .attr({x: margin.left,
                        width: 0,
                        y: function (d, i) {
                            return (barH + gap) * i;
                        },
                        height: function (d, i) {
                            return barH;
                        }
                    });

                bars.transition()
                    .ease(ease)
                    .attr({x: margin.left,
                        width: function (d, i) {
                            return x1(d);
                        },
                        y: function (d, i) {
                            return (barH + gap) * i;
                        },
                        height: function (d, i) {
                            return barH;
                        }
                    });

            });
            return chart.render;
        };
        chart.width = function (x) {
            if (!arguments.length) {
                return width;
            }
            width = parseInt(x, 10);
            return this;
        };
        chart.height = function (x) {
            if (!arguments.length) {
                return height;
            }
            height = parseInt(x, 10);
            return this;
        };
        chart.gap = function (x) {
            if (!arguments.length) {
                return gap;
            }
            gap = x;
            return this;
        };
        chart.ease = function (x) {
            if (!arguments.length) {
                return ease;
            }
            ease = x;
            return this;
        };


        /***
         * public: Put The bars in a line
         * @return {*}
         */
        chart.changeForm = function () {

            var lengthsOfPrevious = function(d,count){
                var accumulator = 0;
                for ( var i = 0 ; i < count ; i++ ) {
                    accumulator += (saveData[i]+5);
                }
                return accumulator;
            }

            lines = svg.select(".chart-group")
                .selectAll(".barLine")
                .data(saveData);


            lines.enter().append("rect")
                .classed("bar", true)
                .attr({x: margin.left,
                    width: function (d, i) {
                        return x1(d);
                    },
                    y: function (d, i) {
                        return (barH + gap) * i;
                    },
                    height: function (d, i) {
                        return barH;
                    }
                });
            bars.remove();
            lines.transition()
                .duration(1500)
                .attr({x: function (d, i) {
                    return margin.left +x1(lengthsOfPrevious(d,i));
                },
                width: function (d, i) {
                        return x1(d);
                    },
                    y: function (d, i) {
                        return (barH + gap) * i;
                    },
                    height: function (d, i) {
                        return barH;
                    }
                })
                .transition()
                .duration(1200)
                .attr({x: function (d, i) {
                    return margin.left +x1(lengthsOfPrevious(d,i));
                },
                    width: function (d, i) {
                        return x1(d);
                    },
                    y: function (d, i) {
                        return 0;
                    },
                    height: function (d, i) {
                        return barH;
                    }
                })
            ;


        }






        /***
         * public: Put The bars in a line
         * @return {*}
         */
        chart.changeRound = function () {
            var color = d3.scale.ordinal()
                .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]),
            radius = 150,

            arc = d3.svg.arc()
                .outerRadius(radius - 10)
                .innerRadius(0),
                total;

            saveData.forEach(function(d) {
                total = +d;
            });

            pie = d3.layout.pie()
                .sort(null)
                .value(function(d) { return total; });

            lines.remove();

            var svg = d3.select("body").append("svg")
                .attr("width", width)
                .attr("height", height)
                .append("g")
                .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
            var g = svg.selectAll(".arc")
                .data(pie(saveData))
                .enter().append("g")
                .attr("class", "arc");

            g.append("path")
                .attr("d", arc)
                .style("fill", function(d,i) {
                    return color(i);
                });

            g.append("text")
                .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
                .attr("dy", ".35em")
                .style("text-anchor", "middle")
                .text(function(d) { return d.data.age; });

        }


        /***
         * public: Put The bars in a line
         * @return {*}
         */
        chart.changeColor = function () {
            var color = d3.scale.ordinal()
                    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]),
                radius = 150,

                arc = d3.svg.arc()
                    .outerRadius(radius - 10)
                    .innerRadius(0),
                total;

            saveData.forEach(function(d) {
                total = +d;
            });

            d3.selectAll('svg').select('g').remove()
             pie = d3.layout.pie()
                .sort(null)
                .value(function(d) { return total; });

            lines.remove();

            var svg = d3.select("body").append("svg")
                .attr("width", width)
                .attr("height", height)
                .append("g")
                .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
            var g = svg.selectAll(".arc")
                .data(pie(saveData))
                .enter().append("g")
                .attr("class", "arc")
                .style("fill", function(d,i) {
                    return color(0);
                });;

            g.append("path")
                .attr("d", arc)
                .style("fill", function(d,i) {
                    return color(i);
                });

            g.append("text")
                .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
                .attr("dy", ".35em")
                .style("text-anchor", "middle")
                .text(function(d) { return d.data.age; });
            g.transition()
                .duration(1500)
                .style("fill", function(d,i) {
                    return color(i);
                });

        }




        return chart;
    }

})();
