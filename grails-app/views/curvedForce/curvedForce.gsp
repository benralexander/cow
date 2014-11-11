<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 7/27/13
  Time: 3:23 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
    <meta charset="utf-8">
    <script src="../js/d3.js"></script>
</head>


%{--<!DOCTYPE html>--}%
%{--<meta charset="utf-8">--}%
%{--<script src="../js/d3.js"></script>--}%
<style>

path.link {
    fill: none;
    stroke: #666;
    stroke-width: 1.5px;
}

path.link.twofive {
    opacity: 0.25;
}

path.link.fivezero {
    opacity: 0.50;
}

path.link.sevenfive {
    opacity: 0.75;
}

path.link.onezerozero {
    opacity: 1.0;
}

circle {
    fill: #ccc;
    stroke: #fff;
    stroke-width: 1.5px;
}

text {
    fill: #000;
    font: 10px sans-serif;
    pointer-events: none;
}
.nodeText
{
    padding-right: 2px;
    width: 90px;
    height: 100%;
    float: left;
    font-size: 8pt;
    border: 0;
    overflow-y: auto;
}
</style>
<body>
<div id="chart"></div>
<script>

    d3.custom = {};

    d3.custom.directedGraph = function module() {
        var width = 960,
                height = 500,
                nodeWidth = 100,
                nodeHeight = 30;

        /***
         * All the work of building the node plot goes inside the 'exports' function
         * @param _selection
         */
        function exports(_selection) {
            // So it can loop through this selection with d3.each
            _selection.each(function (_data) {

                var linkDistance = function(link){
                    if ( link.drawMe=== true ) {
                        return 100;
                    } else if  ( link.drawMe=== false ) {
                        return 500;
                    }  else if  ( link.drawMe=== undefined ) {
                        return 1000;
                    }

                } ;
                var charge = function(link){
                    if ( link.drawMe=== true ) {
                        return -1;
                    } else if  ( link.drawMe=== false ) {
                        return -30;
                    }  else if  ( link.drawMe=== undefined ) {
                        return 1000;
                    }

                } ;

                var force = d3.layout.force()
                        .size([width, height])
                        .linkDistance(linkDistance)
                        .charge(-30),

                svg = d3.select(this).append("svg")
                        .attr("width", width)
                        .attr("height", height),

                // Set the range
                v = d3.scale.linear().range([0, 100]),

                // Set the range
                verticalPlacement = d3.scale.linear().range([10, height-40]);


                /***
                *   Call for the data, and perform all the functions that are data dependent.
                */
                d3.json("<g:createLink controller='curvedForce' action='feedMeJson'/>", function (error, inData) {
                    nodePlotInternals(inData);
                });


                var createLinksBetweenNodesOnTheSameLevel = function (allLinks,nodesOnOneLevel){
                    var nodesThatHaveAlreadyBeenTreated = [];
                    nodesOnOneLevel.forEach(function (node) {
                        for ( var i = 0 ; i < nodesThatHaveAlreadyBeenTreated.length ; i++ ){
                            var treatedNode = nodesThatHaveAlreadyBeenTreated[i];
                            var newLink = {};
                            newLink.source = node.index;
                            newLink.target = treatedNode.index;
                            newLink.value = 2;
                            newLink.drawMe = false;
                            allLinks.push(newLink);
                        }
                        nodesThatHaveAlreadyBeenTreated.push(node);
                    });
                }


                var nodesOnTheSameLevelShouldRepelEachOther = function (minimumLevel,maximumLevel,nodesAndLinks )  {
                      for(var currentLevel = minimumLevel; currentLevel <= maximumLevel; currentLevel++ )   {
                         var nodesThatShareALevel = nodesAndLinks.nodes.filter(function (d){
                             return d.level==currentLevel;
                         });
                          createLinksBetweenNodesOnTheSameLevel(nodesAndLinks.links,nodesThatShareALevel);
                     }
                 }

                 /***
                 * This is the meaty part of building this force layout diagram
                 * @param links
                 */
                function nodePlotInternals(inData) {

                    var nodes = {};

                     var minimumLevel = d3.min (inData.nodes, function (d){
                         return d.level;
                     } );
                     var maximumLevel = d3.max (inData.nodes, function (d){
                         return d.level;
                     } );

                     inData.links.forEach(function (link){link.drawMe=true;});

                     nodesOnTheSameLevelShouldRepelEachOther(minimumLevel,maximumLevel,inData);

                     force.nodes(inData.nodes)
                             .links(inData.links)
                             .on("tick", tick)
                             .start();

                     // Scale the range of the data
                    v.domain([0, d3.max(inData.links, function (d) {
                        return d.value;
                    })]);

                     verticalPlacement.domain([0, maximumLevel]);


                     var createLinksBetweenNodesOnTheSameLevel = function (link){
                         link.source = nodes [link.source]  ||
                                 (nodes [link.source] = {name:link.source});
                         link.target = nodes [link.target]  ||
                                 (nodes [link.target] = {name:link.target});
                         link.value = +link.value;
                     }

                    // asign a type per value to encode opacity
                     inData.links.forEach(function (link) {
                        if (v(link.value) <= 25) {
                            link.type = "twofive";
                        } else if (v(link.value) <= 50 && v(link.value) > 25) {
                            link.type = "fivezero";
                        } else if (v(link.value) <= 75 && v(link.value) > 50) {
                            link.type = "sevenfive";
                        } else if (v(link.value) <= 100 && v(link.value) > 75) {
                            link.type = "onezerozero";
                        }
                    });


                    // build the arrow.
                    svg.append("svg:defs").selectAll("marker")
                            .data(["end"])      // Different link/path types can be defined here
                            .enter().append("svg:marker")    // This section adds in the arrows
                            .attr("id", String)
                            .attr("viewBox", "0 -5 10 10")
                            .attr("refX", 15)
                            .attr("refY", -1.5)
                            .attr("markerWidth", 6)
                            .attr("markerHeight", 6)
                            .attr("orient", "auto")
                            .append("svg:path")
                            .attr("d", "M0,-5L10,0L0,5");

                    // add the links and the arrows
                    var path = svg.append("svg:g").selectAll("path")
                            .data(force.links())
                            .enter().append("svg:path")
                            .attr("class", function (d) {
                                return "link " + d.type;
                            });

                     var drawablePaths = path.filter(function(d, i) { return (d.drawMe === true); });
                     var nondrawablePaths = path.filter(function(d, i) { return (d.drawMe === false); });
                     nondrawablePaths.attr('stroke-opacity',0);

                     drawablePaths.attr("marker-end", "url(#end)");

                    // define the nodes
                    var node = svg.selectAll(".node")
                            .data(force.nodes())
                            .enter().append("g")
                            .attr("class", "node")
                            .on("click", click)
                            .on("dblclick", dblclick)
                            .call(force.drag);

                    // add the nodes
//                    node.append("circle")
//                            .attr("r", 5);
                     node.append("rect")
                             .attr("width", nodeWidth)
                             .attr("height", nodeHeight)
                             .style("fill", d3.rgb(255,255,255))
                             .style("stroke", d3.rgb(0,0,0));


                     // add the text
                    node.append("foreignObject")
                             .attr("width", nodeWidth)
                            .attr("height", nodeHeight)
                            .append("xhtml:body")
                            .html(function(d){return '<div class="nodeText">'+d.name+'</div>';});


                     // add the curvy lines
                    function tick() {
                        path.attr("d", function (d) {
                            var dx = d.target.x - d.source.x,
                                    dy = verticalPlacement(d.target.level) - verticalPlacement(d.source.level),
                                    dr = Math.sqrt(dx * dx + dy * dy);
                            return "M" +
                                    (d.source.x+nodeWidth) + "," +
                                    (verticalPlacement(d.source.level)+nodeHeight) + "A" +
                                    dr + "," + dr + " 0 0,1 " +
                                    (d.target.x+nodeWidth) + "," +
                                    verticalPlacement(d.target.level);
                        });

                        node
                                .attr("transform", function (d) {
                                    return "translate(" + d.x + "," + verticalPlacement(d.level) + ")";
                                });
                    }

                } // nodePlotInternals


            });

            /***
            * Callbacks go here.  They are private to the directedGraph module
            */

                // action to take on mouse click
            function click() {
                d3.select(this).select("text").transition()
                        .duration(750)
                        .attr("width", 220);
                d3.select(this).select("circle").transition()
                        .duration(750)
                        .attr("r", 16)
                        .style("fill", "lightsteelblue");
            }

//            // action to take on mouse click
//            function click() {
//                d3.select(this).select("text").transition()
//                        .duration(750)
//                        .attr("x", 22)
//                        .style("fill", "steelblue")
//                        .style("stroke", "lightsteelblue")
//                        .style("stroke-width", ".5px")
//                        .style("font", "20px sans-serif");
//                d3.select(this).select("circle").transition()
//                        .duration(750)
//                        .attr("r", 16)
//                        .style("fill", "lightsteelblue");
//            }

            // action to take on mouse double click
            function dblclick() {
                d3.select(this).select("circle").transition()
                        .duration(750)
                        .attr("r", 6)
                        .style("fill", "#ccc");
                d3.select(this).select("text").transition()
                        .duration(750)
                        .attr("x", 12)
                        .style("stroke", "none")
                        .style("fill", "black")
                        .style("stroke", "none")
                        .style("font", "10px sans-serif");
            }


        }


        /***
         * This is the section for externally visible variables
         */

        exports.width = function(_x) {
            if (!arguments.length) return width;
            width = _x;
            return this;
        };

        exports.height = function(_x) {
            if (!arguments.length) return height;
            height = _x;
            return this;
        };


        return exports;


    };



    var directedGraph = d3.custom.directedGraph();
    directedGraph.width(800).height(800);
    directedGraph(d3.select("body>#chart"));

</script>
</body>
</html>
