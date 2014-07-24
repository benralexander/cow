<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Sierpinski triangle demot</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <style>
        .triangle {
        }
    </style>
</head>

<body>

<script>


    function triangle() {
        var _holder = {};
        var _width = 1000, _height = 1000,
                _svg,
                duration = 500,
                _xScale,
                _yScale,
                tan45 = Math.tan(45);

        _holder.render = function () {
            if (!_svg) {
                _svg = d3.select("body").append("svg")
                        .attr("height", _height)
                        .attr("width", _width);
            }

            _holder.sierpinskiTriangle(400, 400, 600, 6);
        };

        _xScale = d3.scale.linear()
                .domain([0, _width])
                .range([0, _width]);
        _yScale = d3.scale.linear()
                .domain([0, 1000])
                .range([_height, 0]);

        _holder.sierpinskiTriangle = function (cx, cy, h, levels) {

            var descend = function (triangleGroup, level) {
                if (level > 0) {
                    triangleGroup.forEach(function (d, i) {
                        var triangleDef = d3.select(d).datum();
                        _holder.sierpinskiTriangle(triangleDef.cx, triangleDef.cy, triangleDef.h, level);
                    });
                }
            }

            if (levels > 1) {

                levels -= 1;

                var quadOfTriangles = _holder.quadTriangle(cx, cy, h, levels);

                descend(quadOfTriangles.filter(function (d) {
                    return(d.label === 'a')
                })[0], levels);

                descend(quadOfTriangles.filter(function (d) {
                    return(d.label === 'b')
                })[0], levels);

                descend(quadOfTriangles.filter(function (d) {
                    return(d.label === 'c')
                })[0], levels);
            }


        }


        _holder.quadTriangle = function (cx, cy, h, level) {
            var triangle = _svg.selectAll("polygon.triangle")
                    .data([
                        {cx: (((2 * cx) - (h / tan45)) / 2), cy: (((2 * cy) - (h / 2)) / 2), h: h / 2, label: 'a'},
                        {cx: cx, cy: (((2 * cy) + (h / 2)) / 2), h: h / 2, label: 'b'},
                        {cx: (((2 * cx) + (h / tan45)) / 2), cy: (((2 * cy) - (h / 2)) / 2), h: h / 2, label: 'c'}
                    ]);

            triangle.enter().append("polygon")
                    .attr("class", function (d, i) {
                        return ("recursion" + level + " sid_" + d.label)
                    })
                    .attr('fill', function () {
                        return "rgba(255,0,0,0.2)"
                    })
                    .attr('stroke', '#00f')
                    .attr('stroke-width', '1')
                    .attr('points', function (d, i) {

                        return (_xScale(d.cx)) + ',' + (_yScale(d.cy)) + ' ' +
                                (_xScale(d.cx)) + ',' + (_yScale(d.cy)) + ' ' +
                                (_xScale(d.cx)) + ',' + (_yScale(d.cy))
                    });
            triangle.transition()
                    .duration(duration * 8)
                    .attr('points', function (d, i) {
                        return (_xScale(d.cx - (d.h / tan45))) + ',' + (_yScale(d.cy - (d.h / 2))) + ' ' +
                                (_xScale(d.cx)) + ',' + (_yScale(d.cy + (d.h / 2))) + ' ' +
                                (_xScale(d.cx + (d.h / tan45))) + ',' + (_yScale(d.cy - (d.h / 2)))
                    });
            triangle.exit().remove();

            return triangle;

        }


        _holder.reverser = function() {
            var triangles = _svg.selectAll("polygon");

            triangles
                    .attr('fill', function () {
                        return "#ff0000"
                    })
                    .attr('points', function (d, i) {
                        return (_xScale(d.cx - (d.h / tan45))) + ',' + (_yScale(d.cy - (d.h / 2))) + ' ' +
                                (_xScale(d.cx)) + ',' + (_yScale(d.cy + (d.h / 2))) + ' ' +
                                (_xScale(d.cx + (d.h / tan45))) + ',' + (_yScale(d.cy - (d.h / 2)))
                    });

            triangles.transition()
                    .duration(duration*4)
                    .attr('fill', function () {
                        return "#00ff00"
                    })
                    .attr('points', function (d, i) {
                        return (_xScale(d.cx - (d.h / tan45))) + ',' + (0.5*_yScale(d.cy - (d.h / 2))) + ' ' +
                                (_xScale(d.cx)) + ',' + (0.5*_yScale(d.cy + (d.h / 2))) + ' ' +
                                (_xScale(d.cx + (d.h / tan45))) + ',' + (0.5*_yScale(d.cy - (d.h / 2)))
                    });


            return triangles;


        }


        _holder.resetColor = function() {
            _svg.selectAll("polygon")
                    .attr('fill', function () {
                return "rgba(255,0,0,0.2)"
            });
        }


        return  _holder;
    }

    var friendlyTriangle = triangle();
    friendlyTriangle.render();


</script>

<div class="control-group">
    <button onclick="friendlyTriangle.reverser()">moveAround</button>
    <button onclick="friendlyTriangle.resetColor()">resetColor</button>
</div>

</body>

</html>