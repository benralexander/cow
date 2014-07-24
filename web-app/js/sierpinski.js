var cbbo = cbbo || {};

(function () {
    "use strict";

    cbbo.sierpinskiTriangle = function () {


        var chart = {},
            margin = {top: 10, right: 20, bottom: 10, left: 50},
            width = 1000 - margin.left - margin.right,
            height = 1000 - margin.top - margin.bottom,
            svg,
            levelsOfDescent = 8,
            selectionIdentifier,
            duration = 500,
            tan45 = Math.tan(45),
            xScale = d3.scale.linear()
                .domain([0, width])
                .range([0, width]),
            yScale = d3.scale.linear()
                .domain([0, 1000])
                .range([height, 0]),

            /***
             *  private: encapsulate the geometrical trick for making a triangle
             */
             geometryOfATriangle = function (d, xMultiplier, yMultiplier) {
                return (xMultiplier * xScale(d.cx - (d.h / tan45))) + ',' + (yMultiplier * yScale(d.cy - (d.h / 2))) + ' ' +
                    (xMultiplier * xScale(d.cx)) + ',' + (yMultiplier * yScale(d.cy + (d.h / 2))) + ' ' +
                    (xMultiplier * xScale(d.cx + (d.h / tan45))) + ',' + (yMultiplier * yScale(d.cy - (d.h / 2)));
            },

            /***
             * private: render a triangle and then return
             */
             renderASingleTriangle = function (cx, cy, h, level) {
                var triangle = svg.selectAll("polygon.triangle")
                    .data([
                        {cx: (((2 * cx) - (h / tan45)) / 2), cy: (((2 * cy) - (h / 2)) / 2), h: h / 2, label: 'a'},
                        {cx: cx, cy: (((2 * cy) + (h / 2)) / 2), h: h / 2, label: 'b'},
                        {cx: (((2 * cx) + (h / tan45)) / 2), cy: (((2 * cy) - (h / 2)) / 2), h: h / 2, label: 'c'}
                    ]);

                triangle.enter().append("polygon")
                    .attr("class", function (d, i) {
                        return ("recursion" + level + " sid_" + d.label);
                    })
                    .attr('points', function (d, i) {

                        return (xScale(d.cx)) + ',' + (yScale(d.cy)) + ' ' +
                            (xScale(d.cx)) + ',' + (yScale(d.cy)) + ' ' +
                            (xScale(d.cx)) + ',' + (yScale(d.cy));
                    });
                triangle.transition()
                    .duration(duration * 8)
                    .attr('points', function (d, i) {
                        return (geometryOfATriangle(d, 1, 1));
                    });
                triangle.exit().remove();

                return triangle;

            },

            /***
             *   private: break each triangle into 3 pieces and then launch a recursive
             *   descent down each one
             */
             sierpinskiRecursiveDescent = function (cx, cy, h, levels) {

                // here's the subroutine that directs the descent
                var descend = function (triangleGroup, level) {
                    if (level > 0) {
                        triangleGroup.forEach(function (d, i) {
                            var triangleDef = d3.select(d).datum();
                            sierpinskiRecursiveDescent(triangleDef.cx, triangleDef.cy, triangleDef.h, level);
                        });
                    }
                };

                if (levels > 1) {   //don't recurs forever

                    var quadOfTriangles = renderASingleTriangle(cx, cy, h, (levels -= 1));

                    descend(quadOfTriangles.filter(function (d) {
                        return(d.label === 'a');
                    })[0], levels);

                    descend(quadOfTriangles.filter(function (d) {
                        return(d.label === 'b');
                    })[0], levels);

                    descend(quadOfTriangles.filter(function (d) {
                        return(d.label === 'c');
                    })[0], levels);
                }


            };

        /***
         * public:
         * render a Sierpinski triangle
         */
        chart.render = function () {
            if (!svg) {
                svg = d3.select(selectionIdentifier).append("svg")
                    .attr("height", height)
                    .attr("width", width);
            }

            sierpinskiRecursiveDescent(width / 2, 5 * height / 8, (3 * width / 4), +levelsOfDescent + 1);

            return chart;
        };

        /***
         * public:  clear an old triangle so that we can hold a new one
         * @return {{}}
         */
        chart.clear = function () {
            if (svg) {
                svg.selectAll("polygon").remove();
            }

            return chart;
        };


        /***
         * getter setter:  how deep should we recurse
         * @param w
         * @return {*}
         */
        chart.levelsOfDescent = function (w) {
            if (!arguments.length) {
                return levelsOfDescent;
            }
            levelsOfDescent = w;
            return chart;
        };

        /***
         *  getter setter: identify the dominant element upon which we will hang this graphic
         * @param x
         * @return {*}
         */
        chart.selectionIdentifier = function (x) {
            if (!arguments.length) {
                return selectionIdentifier;
            }
            selectionIdentifier = x;
            return chart;
        };


        /***
         * public:
         * @return {*}
         */
        chart.moveAround = function () {
            var triangles = svg.selectAll("polygon");

            triangles
                .attr('points', function (d, i) {
                    return (geometryOfATriangle(d, 1, 1));
                });

            triangles.transition()
                .duration(duration * 4)
                .attr('points', function (d, i) {
                    return (geometryOfATriangle(d, 1, 0.1));
                })
                .transition()
                .duration(duration * 4)
                .attr('points', function (d, i) {
                    return (geometryOfATriangle(d, 1, 1));
                });


            return triangles;


        }

        return  chart;
    }

})();
