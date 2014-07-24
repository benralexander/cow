<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <title>Sunburst</title>
    <title>BARD : Compound Bio-Activity Summary</title>

    %{--<script src="/bardwebclient/static/plugins/jquery-1.7.1/js/jquery/jquery-1.7.1.min.js" type="text/javascript" ></script>--}%

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="/bardwebclient/static/images/favicon.ico" type="image/x-icon">
<style>
    .g {
        color: #dbffd5;
        color: #c7e9c0;
        color: #c7e9c0;
        color: #c7e9c0;
    }
</style>
    <script src="../js/d3.js"></script>
<script>
    var createALegend = function (legendWidth, legendHeight, numberOfDivisions, colorScale, domSelector, minimumValue, maximumValue) {
        var  numberOfTics = 10,
             dynamicRange = maximumValue - minimumValue;

        //
        // First build the core the legend, which is used no matter what the dynamic range
        //

        var rootLegendHolder = d3.select(domSelector).append("div")
                .attr("id", "sunburstlegend")
                .attr("class", "legendHolder")
                .html('<br />Color assignment:<br /> x = active / <br />(active + inactive)');

        rootLegendHolder.append('hr')
                .attr("width", '100%')
                .attr("color", '#000');

        //
        // Define a few private methods that we will use later
        //
        var zeroDynamicRange = function (rootLegendHolder,maximumValue) {
            rootLegendHolder.append('div')
                    .attr('class', 'legendExplanation')
                    .html('Dynamic range is 0.   All arcs had value <strong>'+maximumValue+'</strong> and the color scheme is therefore constant.');
        }


        var nonzeroDynamicRange = function (numberOfTics,rootLegendHolder,legendWidth,legendHeight,colorScale,numberOfDivisions) {
            var arr = Array.apply(null, {length:numberOfDivisions + 1}).map(Number.call, Number),
                    intervals = (legendHeight) / numberOfDivisions;

            var legendHolder = rootLegendHolder.append("svg")
                    .attr("width", legendWidth)
                    .attr("height", legendHeight + 10)
                    .attr("transform", "translate(" + legendWidth / 2 + "," + (legendHeight * 0.5 + 5) + ")");

            var theLegend = legendHolder.selectAll('g')
                    .data(arr)
                    .enter()
                    .append('g')
                    .attr('class', 'legend');
            theLegend.append('rect')
                    .attr('x', legendWidth - 80)
                    .attr('y', function (d, i) {
                        return (i * intervals) + 6;
                    })
                    .attr('width', 10)
                    .attr('height', intervals)
                    .style('fill', function (d, i) {
                        return colorScale(i / numberOfDivisions);//color(d.name);
                    });

            var textSpacing = (legendHeight) / (numberOfTics * 2);
            theLegend.append('text')
                    .attr('x', legendWidth - 60)
                    .attr('y', function (d, i) {
                        return (i * 2) + 11;
                    })
                    .text(function (d, i) {
                        if ((i % textSpacing) === 0) {
                            var valToWrite = (i / numberOfDivisions);
                            return valToWrite.toString();
                        }
                        else
                            return '';
                    });
        }



        // Finally build the rest of the legends depending on whether the dynamic range
        //  is 0 or nonzero
        if (dynamicRange === 0) {
            zeroDynamicRange(rootLegendHolder,maximumValue);

        } else {
                nonzeroDynamicRange (numberOfTics,rootLegendHolder,legendWidth,legendHeight,colorScale,numberOfDivisions);

        }
    }
</script>
    <script>

        // Encapsulate the variables/methods necessary to handle tooltips

        // Encapsulate the variables/methods necessary to handle tooltips
        var ColorManagementRoutines = function (colorScale) {

                    // Safety trick for constructors
                    if (!(this instanceof ColorManagementRoutines)) {
                        return new ColorManagementRoutines();
                    }

                    // public methods
                    this.colorArcFill = function (d) {
                        var returnValue = new String();
                        if (d.ac != undefined) {
//                            if (d.name === "/") { // root is special cased
//                                return "#ffff99";
//                            }
                            var actives = parseInt(d.ac);
                            var inactives = parseInt(d.inac);
                            if ((actives + inactives) === 0) // this should never happen, but safety first!
                                return "#fff";
                            var prop = actives / (actives + inactives);
                            returnValue = colorScale(prop);
                        } else {
                            returnValue = "#FF00FF";
                        }
                        return returnValue;
                    };

                    this.colorText = function (d) {
                        return '#000';
                    };
                };


        var TooltipHandler = function ()  {
                    // Safety trick for constructors
                    if (! (this instanceof TooltipHandler)){
                        return new TooltipHandler ();
                    }

                    var tooltip = d3.select("body")
                            .append("div")
                            .style("opacity", "0")
                            .style("position", "absolute")
                            .style("z-index", "10")
                            .attr("class", "toolTextAppearance");

                    this.mouseOver = function(d) {
                        if (d.name != '/') {
                            tooltip.html(d.name + '<br/>' + 'active in ' + d.ac + '<br/>' + 'inactive in ' + d.inac)
                                    .transition()
                                    .duration(200)
                                    .style("opacity", "1");
                            return;// tooltip.html(d.name + '<br/>' + 'active in ' + d.ac + '<br/>' + 'inactive in ' + d.inac);
                        }
                        else {
                            return tooltip.html(null).style("opacity", "0");
                        }

                    };
                    this.mouseMove = function (d) {
                        if (d.name === '/')  {
                            return tooltip.html(null).style("opacity", "0");
                        }  else {
                            return tooltip .style("top", (d3.event.pageY - 10) + "px")
                                    .style("left", (d3.event.pageX + 10) + "px");
                        }

                    };
                    this.mouseOut =  function () {
                        return tooltip.style("opacity", "0");
                    };
                };





        function createASunburst(width, height, padding, duration, colorScale, domSelector) {

            var tooltipHandler  = new TooltipHandler ();
            var colorManagementRoutines = new ColorManagementRoutines(colorScale);
            var radius = Math.min(width, height) / 2;


            var SunburstAnimation = function ()  {
                // Safety trick for constructors
                if (! (this instanceof SunburstAnimation)){
                    return new SunburstAnimation ();
                }

                // Need to keep track of how Zoomed we are
                var currentZoomLevel = 0;
                this.zoomLevel = function (newZoomLevel){
                    if (newZoomLevel === undefined){
                        return  currentZoomLevel;
                    }  else {
                        currentZoomLevel =  newZoomLevel;
                    }
                }


                this.arcTween = function (d) {
                    var my = maxY(d),
                            xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
                            yd = d3.interpolate(y.domain(), [d.y, my]),
                            yr = d3.interpolate(y.range(), [d.y ? 100 : 0, radius]);
                    return function (d) {
                        return function (t) {
                            x.domain(xd(t));
                            y.domain(yd(t)).range(yr(t));
                            return arc(d);
                        };
                    };
                };

                var maxY = function (d) {
                    return d.children ? Math.max.apply(Math, d.children.map(maxY)) : d.y + d.dy;
                }

                var isParentOf = function (p, c) {
                    if (p === c) return true;
                    if (p.children) {
                        return p.children.some(function (d) {
                            return isParentOf(d, c);
                        });
                    }
                    return false;
                };

                this.isParentOf = isParentOf;

                    },
             sunburstAnimation = SunburstAnimation();

            var pict = d3.select("body")
                    .append("div")
                    .style("position", "absolute")
                    .style("top", "550px")
                    .style("border", "1")
                    .style("left", "450px")
                    .attr("height", "150")
                    .attr("width", "150")
                    .style("z-index", "100")
                    .attr("class", "molstruct")
                    .append("img")
                    .attr("src", "../images/mol1.png");

            var svg = d3.select(domSelector).append("svg")
                    .attr("width", width)
                    .attr("height", height )
                    .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + (height /2 ) + ")");


            var x = d3.scale.linear()
                    .range([0, 2 * Math.PI]);

            var y = d3.scale.linear()
                    .range([0, radius]);


            var partition = d3.layout.partition()
                    .value(function (d) {
                        return d.size;
                    });

            var arc = d3.svg.arc()
                    .startAngle(function (d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x)));
                    })
                    .endAngle(function (d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx)));
                    })
                    .innerRadius(function (d) {
                        return Math.max(0, y(d.y));
                    })
                    .outerRadius(function (d) {
                        return Math.max(0, y(d.y + d.dy));
                    });

            // Method local to createASunburst to keep track of our depth
            var createIdForNode = function (incomingName) {
                var returnValue = 'null';
                var preliminaryGeneratedId = String(incomingName).replace(/\s/g,'_');
                if (preliminaryGeneratedId === '/') {
                    returnValue = 'root';
                } else {
                    returnValue = preliminaryGeneratedId;
                }
                return returnValue;
            }

             //
            // Change the cursor to zoom-in or zoom-out or nothing, all depending on the current expansion
            //  level of the sunburst.
            //
            var adjustSunburstCursor = function (d) {
                //
                // first deal with all non-root arcs
                //
                if ( !(d.parent  === undefined) &&
                     !(d.parent.name  === undefined) )  {
                    sunburstAnimation.zoomLevel(d.depth);
                    var parentName =  d.parent.name;
                    var nodeName =  d.name;
                    // reset the cursor for the last center of the sunburst, since it is no longer
                    // ready to support a zoom out.  Note that this select statement will also grab
                    // nny other stray classes indicating zoom out.
                    var previousCenterpiece = d3.select('.indicateZoomOut');
                    if (!(previousCenterpiece === undefined)){
                        previousCenterpiece.classed('indicateZoomIn', true)
                                .classed('indicateZoomOut', false)
                                .classed('indicateNoZoomingPossible', false);
                    }
                    var arcThatWasLastZoomed = d3.selectAll('.indicateNoZoomingPossible');
                    if (!(arcThatWasLastZoomed === undefined)){
                        arcThatWasLastZoomed.classed('indicateNoZoomingPossible', function(d){
                            return (d.name === "/");
                        });
                        arcThatWasLastZoomed.classed('indicateZoomIn',  function(d){
                            return (!(d.name === "/"));
                        });
                    }
                    // Now deal with the parent node, which DOES need to adopt
                    // a cursor indicating that a zoom out is possible.
                    var parentNode =  d3.select('#'+createIdForNode(parentName));
                    if (sunburstAnimation.zoomLevel()>0)   {
                        parentNode.classed('indicateZoomOut', true)
                                .classed('indicateZoomIn', false)
                                .classed('indicateNoZoomingPossible', false);
                    }
                    // Take the current arc ( the one that was clicked ) and
                    // turn off any mouse handling at all, since After clicking an arc
                    // it becomes fully expanded, and there is no purpose to clicking it again.
                    var currentNode =  d3.select('#'+createIdForNode(nodeName));
                    currentNode.classed('indicateZoomOut', false)
                            .classed('indicateZoomIn', false)
                            .classed('indicateNoZoomingPossible', true);

                }  // next deal with the root arc, in case the user clicked it.
                else if ( !(d  === undefined) &&
                        !(d.name  === undefined) ) {  // Root node clicked -- reset mouse ptr
                    sunburstAnimation.zoomLevel(d.depth);
                    var nodeName =  d.name;
                    // whatever had no cursor needs to be turned on
                    var arcThatWasLastZoomed = d3.selectAll('.indicateNoZoomingPossible');
                    if (!(arcThatWasLastZoomed === undefined)){
                        arcThatWasLastZoomed.classed('indicateNoZoomingPossible', function(d){
                            return (d.name === "/");
                        });
                        arcThatWasLastZoomed.classed('indicateZoomIn',  function(d){
                            return (!(d.name === "/"));
                        });
                    }
                    // take the current arc and turn the cursor off
                    var currentNode =  d3.select('#'+createIdForNode(nodeName));
                    currentNode.classed('indicateZoomOut', false)
                            .classed('indicateZoomIn', false)
                            .classed('indicateNoZoomingPossible', true);
                }
            }


            var path = svg.datum($data[0]).selectAll("path")
                    .data(partition.nodes)
                    .enter().append("path")
                    .attr("d", arc)
                    .attr("id", function (d) {
                        return createIdForNode(d.name);
                    })
                    .classed('indicateZoomIn', function(d) { return (d.depth || d.name!='/');} )
                    .classed('indicateNoZoomingPossible', function(d) { return (!(d.depth || d.name!='/'));} )
                    .style("stroke", "#fff")
                    .style("fill", function (d) {
                        return colorManagementRoutines.colorArcFill(d);
                    })
                    .on("click", click)
                    .on("mouseover", tooltipHandler.mouseOver)
                    .on("mousemove", tooltipHandler.mouseMove)
                    .on("mouseout",tooltipHandler.mouseOut );


            var text = svg.datum($data[0]).selectAll("text").data(partition.nodes);


            // Interpolate the scales!
            function click(d) {
                 adjustSunburstCursor(d);
                 path.transition()
                        .duration(duration)
                        .attrTween("d", sunburstAnimation.arcTween(d));

                // Somewhat of a hack as we rely on arcTween updating the scales.
                text.style("visibility", function (e) {
                    return sunburstAnimation.isParentOf(d, e) ? null : d3.select(this).style("visibility");
                })
                        .transition()
                        .duration(duration)
                        .attrTween("text-anchor", function (d) {
                            return function () {
                                return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
                            };
                        })
                        .attrTween("transform", function (d) {
                            var multiline = (d.name || "").split(" ").length > 1;
                            return function () {
                                var angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                                        rotate = angle + (multiline ? -.5 : 0);
                                return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
                            };
                        })
                        .style("fill-opacity", function (e) {
                            return sunburstAnimation.isParentOf(d, e) ? 1 : 1e-6;
                        })
                        .each("end", function (e) {
                            d3.select(this).style("visibility", sunburstAnimation.isParentOf(d, e) ? null : "hidden");
                        });
            }


            var textEnter = text.enter().append("svg:text")
                    .style("fill-opacity", 1)
                    .style("pointer-events", "none")
                    .style("fill", function (d) {
                        return  colorManagementRoutines.colorText(d);
                    })
                    .attr("text-anchor", function (d) {
                        return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
                    })
                    .attr("dy", ".2em")
                    .attr("transform", function (d) {
                        var multiline = (d.name || "").split(" ").length > 1,
                                angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                                rotate = angle + (multiline ? -.5 : 0);
                        return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
                    })
                    .on("click", click);
//                    .on("mouseover", tooltipHandler.mouseOver)
//                    .on("mousemove", tooltipHandler.mouseMove)
//                    .on("mouseout",tooltipHandler.mouseOut );

            textEnter.append("tspan")
                    .attr("x", 0)
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[0] : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[1] || "" : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[2] || "" : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[3] || "" : "";
                    });


//            d3.select(self.frameElement).style("height", height + "px");
        }
    </script>



<style>
#sunburstdiv {
    font-family: sans-serif;
    font-size: 12px;
    position: relative;
}
#molstruct {
    position: absolute;
    width: 150px;
    height: 150px;
    left: 375px;
    top: 475px;
}

.toolTextAppearance {
    font: 20px serif;
    font-weight: bold;
    margin: 5px;
    padding: 10px;
    background: #eeeeee;
    border: 1px solid blue;
    -moz-border-radius: 15px;
    border-radius: 15px;
}

.legend {
    font: 14px sans-serif;
    font-weight: bold;
}

.legendExplanation {
    font: 14px sans-serif;
    font-weight: normal;
    padding-top: 10px;
    padding-bottom: 15px;
    padding-left: 12px;
    padding-right: 12px;
}



.legendHolder {
    border: 3px solid black;
    font: 12px sans-serif;
    font-weight: bold;
    text-align: center;
    background: #eeeeee;
    width: 160px;
}
.indicateZoomIn {
    cursor:crosshair;
    cursor:-webkit-zoom-in;
    cursor:-moz-zoom-in;
}
.indicateZoomOut {
    cursor:crosshair;
    cursor:-webkit-zoom-out;
    cursor:-moz-zoom-out;
}
.indicateNoZoomingPossible {
    cursor:auto;
}

</style>

<script>
//    window.onload = function () {
//        $('#activity').change(function () {
//            if (this.value == "1") {
//                location.href = "./bigSunburst?actives=t&inactives=f";
//            }
//            if (this.value == "2") {
//                location.href = "./bigSunburst?actives=f&inactives=t";
//            }
//            if (this.value == "3") {
//                location.href = "./bigSunburst?actives=t&inactives=t";
//            }
//
//        });
//        $('#coloringOptions').change(function () {
//            if (this.value == "1") {
//                location.href = "./bigSunburst?colorOption=1";
//            }
//            if (this.value == "2") {
//                location.href = "./bigSunburst?colorOption=2";
//            }
//            if (this.value == "3") {
//                location.href = "./bigSunburst?colorOption=3";
//            }
//        });
//    }
</script>

</head>
<body>


<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6">

            <a href="/bardwebclient/bardWebInterface/index">
                <img src="/bardwebclient/static/images/bard_logo_med.png" alt="BioAssay Research Database"/>
            </a>

        </div>

        <div class="span6" style="text-align: center; vertical-align: bottom;">
            <br/>
            <h2>Panther class hierarchy</h2>
        </div>

    </div>


    <script>
        //empty
//        var $data = [{"name":"/", "ac":"0", "inac":"0", "size":1}]
//         monochrome

//var $data = [{"name":"/", "ac":"0", "inac":"0", "children": [
//    {"name":"enzyme modulator", "ac":"0", "inac":"19", "children": [
//        {"name":"G-protein", "ac":"0", "inac":"6", "children": [
//            {"name":"heterotrimeric G-protein", "ac":"0", "inac":"1", "size":1},
//            {"name":"small GTPase", "ac":"0", "inac":"2", "size":2}
//        ]},
//        {"name":"G-protein modulator", "ac":"0", "inac":"5", "size":5}
//    ]},
//    {"name":"signaling molecule", "ac":"0", "inac":"6", "size":6},
//    {"name":"receptor", "ac":"0", "inac":"7", "children": [
//        {"name":"G-protein coupled receptor", "ac":"0", "inac":"3", "size":3}
//    ]},
//    {"name":"extracellular matrix protein", "ac":"0", "inac":"2", "children": [
//        {"name":"extracellular matrix glycoprotein", "ac":"0", "inac":"1", "size":1}
//    ]},
//    {"name":"cell adhesion molecule", "ac":"0", "inac":"5", "children": [
//        {"name":"cadherin", "ac":"0", "inac":"1", "size":1}
//    ]},
//    {"name":"hydrolase", "ac":"0", "inac":"1", "size":1},
//    {"name":"nucleic acid binding", "ac":"0", "inac":"11", "children": [
//        {"name":"DNA binding protein", "ac":"0", "inac":"2", "size":2},
//        {"name":"nuclease", "ac":"0", "inac":"3", "children": [
//            {"name":"exodeoxyribonuclease", "ac":"0", "inac":"1", "size":1},
//            {"name":"endodeoxyribonuclease", "ac":"0", "inac":"1", "size":1}
//        ]},
//        {"name":"helicase", "ac":"0", "inac":"2", "children": [
//            {"name":"DNA helicase", "ac":"0", "inac":"1", "size":1}
//        ]},
//        {"name":"RNA binding protein", "ac":"0", "inac":"1", "size":1}
//    ]},
//    {"name":"transferase", "ac":"0", "inac":"7", "children": [
//        {"name":"kinase", "ac":"0", "inac":"5", "children": [
//            {"name":"carbohydrate kinase", "ac":"0", "inac":"1", "size":1},
//            {"name":"protein kinase", "ac":"0", "inac":"2", "children": [
//                {"name":"non-receptor serine/threonine protein kinase", "ac":"0", "inac":"1", "size":1}
//            ]}
//        ]}
//    ]},
//    {"name":"transporter", "ac":"0", "inac":"2", "children": [
//        {"name":"ion channel", "ac":"0", "inac":"1", "size":1}
//    ]},
//    {"name":"membrane traffic protein", "ac":"0", "inac":"1", "size":1},
//    {"name":"cell junction protein", "ac":"0", "inac":"1", "size":1}
//]}];


        var $data = [{"name":"/", "ac":"0", "inac":"0", "children": [
            {"name":"signaling molecule", "ac":"4", "inac":"5", "size":6},
            {"name":"nucleic acid binding", "ac":"5", "inac":"14", "children": [
                {"name":"DNA binding protein", "ac":"1", "inac":"4", "children": [
                    {"name":"DNA strand-pairing protein", "ac":"0", "inac":"1", "size":1}
                ]},
                {"name":"nuclease", "ac":"3", "inac":"3", "children": [
                    {"name":"exodeoxyribonuclease", "ac":"1", "inac":"1", "size":1},
                    {"name":"endodeoxyribonuclease", "ac":"1", "inac":"1", "size":1}
                ]},
                {"name":"helicase", "ac":"0", "inac":"2", "children": [
                    {"name":"DNA helicase", "ac":"0", "inac":"1", "size":1}
                ]},
                {"name":"RNA binding protein", "ac":"0", "inac":"1", "size":1}
            ]},
            {"name":"hydrolase", "ac":"1", "inac":"1", "size":2},
            {"name":"cell adhesion molecule", "ac":"2", "inac":"3", "children": [
                {"name":"cadherin", "ac":"1", "inac":"0", "size":1}
            ]},
            {"name":"cell junction protein", "ac":"1", "inac":"0", "size":1},
            {"name":"enzyme modulator", "ac":"0", "inac":"19", "children": [
                {"name":"G-protein", "ac":"0", "inac":"6", "children": [
                    {"name":"heterotrimeric G-protein", "ac":"0", "inac":"1", "size":1},
                    {"name":"small GTPase", "ac":"0", "inac":"2", "size":2}
                ]},
                {"name":"G-protein modulator", "ac":"0", "inac":"5", "size":5}
            ]},
            {"name":"receptor", "ac":"0", "inac":"7", "children": [
                {"name":"G-protein coupled receptor", "ac":"0", "inac":"3", "size":3}
            ]},
            {"name":"transferase", "ac":"0", "inac":"7", "children": [
                {"name":"kinase", "ac":"0", "inac":"5", "children": [
                    {"name":"protein kinase", "ac":"0", "inac":"2", "children": [
                        {"name":"non-receptor serine/threonine protein kinase", "ac":"0", "inac":"1", "size":1}
                    ]},
                    {"name":"carbohydrate kinase", "ac":"0", "inac":"1", "size":1}
                ]}
            ]},
            {"name":"transporter", "ac":"0", "inac":"33", "children": [
                {"name":"ion channel", "ac":"0", "inac":"23", "children": [
                    {"name":"potassium channel", "ac":"0", "inac":"5", "size":5},
                    {"name":"voltage-gated ion channel", "ac":"0", "inac":"10", "children": [
                        {"name":"voltage-gated potassium channel", "ac":"0", "inac":"5", "size":5}
                    ]},
                    {"name":"anion channel", "ac":"0", "inac":"1", "size":1}
                ]},
                {"name":"ATP-binding cassette (ABC) transporter", "ac":"0", "inac":"2", "size":2}
            ]},
            {"name":"extracellular matrix protein", "ac":"0", "inac":"2", "children": [
                {"name":"extracellular matrix glycoprotein", "ac":"0", "inac":"1", "size":1}
            ]},
            {"name":"membrane traffic protein", "ac":"0", "inac":"1", "size":1}
        ]}]

//        var $data = [
//            {"name":"rootname", "children": [
//                {"name":"transcription factor", "children": [
//                    {"name":"zinc finger transcription factor", "size":1},
//                    {"name":"nuclear hormone receptor", "size":1},
//                    {"name":"transcription cofactor", "size":1},
//                    {"name":"basic helix-loop-helix transcription factor", "size":1},
//                ]},
//                {"name":"nucleic acid binding", "children": [
//                    {"name":"RNA binding protein", "children": [
//                        {"name":"mRNA processing factor", "children": [
//                            {"name":"mRNA splicing factor", "size":1},
//                        ]},
//                        {"name":"translation factor", "children": [
//                            {"name":"translation elongation factor", "size":1},
//                        ]},
//                    ]},
//                    {"name":"nuclease", "children": [
//                        {"name":"exodeoxyribonuclease", "size":1},
//                        {"name":"endodeoxyribonuclease", "size":1},
//                    ]},
//                    {"name":"DNA binding protein", "children": [
//                        {"name":"chromatin/chromatin-binding protein", "size":1},
//                    ]},
//                    {"name":"helicase", "children": [
//                        {"name":"DNA helicase", "size":1},
//                    ]},
//                ]},
//                {"name":"receptor", "children": [
//                    {"name":"G-protein coupled receptor", "size":1},
//                    {"name":"protein kinase receptor", "size":1},
//                    {"name":"cytokine receptor", "children": [
//                        {"name":"tumor necrosis factor receptor", "size":1},
//                    ]},
//                ]},
//                {"name":"cytoskeletal protein", "children": [
//                    {"name":"actin family cytoskeletal protein", "children": [
//                        {"name":"non-motor actin binding protein", "size":1},
//                    ]},
//                    {"name":"microtubule family cytoskeletal protein", "children": [
//                        {"name":"non-motor microtubule binding protein", "size":1},
//                    ]},
//                ]},
//                {"name":"hydrolase", "children": [
//                    {"name":"protease", "children": [
//                        {"name":"serine protease", "size":1},
//                        {"name":"cysteine protease", "size":1},
//                        {"name":"metalloprotease", "size":1},
//                    ]},
//                    {"name":"esterase", "size":1},
//                ]},
//                {"name":"transporter", "children": [
//                    {"name":"ion channel", "children": [
//                        {"name":"voltage-gated ion channel", "children": [
//                            {"name":"voltage-gated potassium channel", "size":1},
//                        ]},
//                        {"name":"potassium channel", "size":1},
//                    ]},
//                ]},
//                {"name":"ligase", "children": [
//                    {"name":"ubiquitin-protein ligase", "size":1},
//                ]},
//                {"name":"signaling molecule", "children": [
//                    {"name":"growth factor", "size":1},
//                ]},
//                {"name":"transferase", "children": [
//                    {"name":"kinase", "children": [
//                        {"name":"protein kinase", "children": [
//                            {"name":"tyrosine protein kinase receptor", "size":1},
//                            {"name":"non-receptor tyrosine protein kinase", "size":1},
//                            {"name":"non-receptor serine/threonine protein kinase", "size":1},
//                        ]},
//                        {"name":"carbohydrate kinase", "size":1},
//                    ]},
//                    {"name":"acetyltransferase", "size":1},
//                ]},
//                {"name":"enzyme modulator", "children": [
//                    {"name":"G-protein", "children": [
//                        {"name":"small GTPase", "size":1},
//                        {"name":"heterotrimeric G-protein", "size":1},
//                    ]},
//                    {"name":"kinase modulator", "children": [
//                        {"name":"kinase activator", "size":1},
//                    ]},
//                    {"name":"G-protein modulator", "size":1},
//                ]},
//                {"name":"extracellular matrix protein", "children": [
//                    {"name":"extracellular matrix glycoprotein", "size":1},
//                ]},
//                {"name":"cell adhesion molecule", "children": [
//                    {"name":"cadherin", "size":1},
//                ]},
//                {"name":"oxidoreductase", "children": [
//                    {"name":"oxygenase", "size":1},
//                    {"name":"dehydrogenase", "size":1},
//                    {"name":"oxidase", "size":1},
//                    {"name":"reductase", "size":1},
//                ]},
//                {"name":"transfer/carrier protein", "children": [
//                    {"name":"apolipoprotein", "size":1},
//                ]},
//                {"name":"defense/immunity protein", "children": [
//                    {"name":"complement component", "size":1},
//                ]},
//                {"name":"cell junction protein", "size":1},
//                {"name":"membrane traffic protein", "size":1},
//                {"name":"chaperone", "size":1},
//                {"name":"isomerase", "children": [
//                    {"name":"epimerase/racemase", "size":1},
//                ]},
//            ]},
//        ]






        var minimumValue=0.5;
    var maximumValue=0.5;

    var continuousColorScale = d3.scale.linear()
            .domain([minimumValue, maximumValue])
            .interpolate(d3.interpolateRgb)
            .range(["#deffd9", "#74c476"]);

    </script>


    <div class="row-fluid">
        <div class="span9 pull-left">

            <div id="sunburstdiv">

                    <script>
                        if ($data[0].children !== undefined) {
                            createASunburst( 1000, 1000,5,1000,continuousColorScale,'div#sunburstdiv');
                        } else {
                            d3.select('div#sunburstdiv')
                                    .append('div')
                                    .attr("width", 1000)
                                    .attr("height", 1000 )
                                    .style("padding-top", '200px' )
                                    .style("text-align", 'center' )
                                    .append("h1")
                                    .html("No off-embargo assay data are  available for this compound.<br /><br />"+
                                    "Please either choose a different compound, or else come<br />"+
                                    "back later when more assay data may have accumulated.");
                        }
                    </script>
            </div>

        </div>

        <div class="span3" style="padding-top: 50px;  height: 600px;">
            <div style="float:right;">

                <div id="legendGoesHere"></div>
                <script>
                    if ($data[0].children !== undefined) {
                        createALegend(120, 200,100,continuousColorScale,'div#legendGoesHere',minimumValue, maximumValue);
                    }
                </script>

            </div>

            <div style="text-align: center; vertical-align: bottom;">

                <select id="coloringOptions" style="visibility: hidden">
                    <option value="1"
                    >Color by activity</option>
                    <option value="2"
                    >Split classes by activity</option>
                    <option value="3" >Color by class</option>
                </select>
                <div  style="padding-top: 320px;"></div>
                <select id="activity" style="visibility: hidden">
                    <option value="1" >Active only</option>
                    <option value="2" >Inactive only</option>
                    <option value="3"
                            selected>Active and Inactive</option>
                </select>

            </div>

        </div>
    </div>
</div>

</body>
</html>