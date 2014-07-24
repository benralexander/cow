<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
<title>Probe targets</title>

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

        var color = d3.scale.category20c();
        var colorCnt = 6;

        // Safety trick for constructors
        if (!(this instanceof ColorManagementRoutines)) {
            return new ColorManagementRoutines();
        }

        // public methods
        this.colorArcFill = function (d) {
            var returnValue = new String();
            colorCnt++;

            if (d.ac != undefined) {
                            if (d.name === "/") { // root is special cased
                                return "#ffffff";
                            } else if ((d.name.length> 4)  && (d.name.substring(0,4)==='zzul')) {
                                return "#ffffff";
                            }
                var actives = parseInt(d.ac);
                var inactives = parseInt(d.inac);
                if ((actives + inactives) === 0) // this should never happen, but safety first!
                    return "#fff";
                var prop = actives / (actives + inactives);
                returnValue = colorScale(prop);
            } else {
                if ((d.name === "/")||
                        ((d.name.length> 4)  && (d.name.substring(0,4)==='zzul'))){ // root is special cased
                    return "#ffffff";
                } else{

                }
//                returnValue ="#000";
                returnValue = color(colorCnt%20);//"#a8fafb";
            }
            return returnValue;
        };

        this.colorText = function (d) {
            if (((d.name.length> 4)  && (d.name.substring(0,4)==='zzul')))  {
                return '#ffffff'
            } else {
                return '#000';
            }

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
            if ((d.name != '/')&&
                    (!(((d.name.length> 4)  && (d.name.substring(0,4)==='zzul'))))){
                tooltip.html(d.name + '<br/>' + d.descr)
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
            if ((d.name === '/')||((d.name.length> 4)  && (d.name.substring(0,4)==='zzul')))  {
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
        var hideOrDisplayColors = 1;


        var toggleColorDisplay = function (){
            if (hideOrDisplayColors=== 1) {
                hideOrDisplayColors = 0;
            } else {
                hideOrDisplayColors = 1;
            }
        }

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
                }).sort(function(a,b){
            return d3.descending(a.name, b.name);
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
                        return ((d.name === "/")&&((d.name.length> 4)  && (d.name.substring(0,4)==='zzul')));
                    });
                    arcThatWasLastZoomed.classed('indicateZoomIn',  function(d){
                        return ((!(d.name === "/")) &&
                                (!((d.name.length> 4)  && (d.name.substring(0,4)==='zzul'))));
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
                        return ((d.name === "/")&&((d.name.length> 4)  && (d.name.substring(0,4)==='zzul')));
                    });
                    arcThatWasLastZoomed.classed('indicateZoomIn',  function(d){
                        return ((!(d.name === "/")) &&
                                (!((d.name.length> 4)  && (d.name.substring(0,4)==='zzul'))));
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
                .style("stroke", function(d){
                    if ((d.name.length> 4)  && (d.name.substring(0,4)==='zzul')) {
                        return '#ffffff';
                    }  else {
                        return '#000';
                    }
                })
                .style("stroke-width", function(d){
                    if ((d.name.length> 4)  && (d.name.substring(0,4)==='zzul')) {
                        return '0px';
                    }  else {
                        return '1px';
                    }
                })
                .style("fill", function (d) {
                    return colorManagementRoutines.colorArcFill(d);
                })
                .style("fill-opacity", function (d) {
                    return hideOrDisplayColors;
                })
                .on("click", click)
                .on("mouseover", tooltipHandler.mouseOver)
                .on("mousemove", tooltipHandler.mouseMove)
                .on("mouseout",tooltipHandler.mouseOut );


       // d3.selectAll("[id^='zzul']").style('stroke','#ffffff') ;

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
                    if ((d.depth) && (d.name.indexOf("zzul") === -1)){
                        return d.name.split(" ")[0];
                    }  else {
                        return "";
                    }
                });
        textEnter.append("tspan")
                .attr("x", 0)
                .attr("dy", "1em")
                .text(function (d) {
                    if ((d.depth) && (d.name.indexOf("zzul") === -1)){
                        return d.name.split(" ")[1]|| "";
                    }  else {
                        return "";
                    }
                });
        textEnter.append("tspan")
                .attr("x", 0)
                .attr("dy", "1em")
                .text(function (d) {
                    if ((d.depth) && (d.name.indexOf("zzul") === -1)){
                        return d.name.split(" ")[2]|| "";
                    }  else {
                        return "";
                    }
                });
        textEnter.append("tspan")
                .attr("x", 0)
                .attr("dy", "1em")
                .text(function (d) {
                    if ((d.depth) && (d.name.indexOf("zzul") === -1)){
                        return d.name.split(" ")[3]|| "";
                    }  else {
                        return "";
                    }
                });



//            d3.select(self.frameElement).style("height", height + "px");

    }
</script>



<style>
#sunburstdiv {
    font-family: sans-serif;
    font-size: 12px;
    font-weight: bold;
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



</head>
<body>


<div class="container-fluid">
<div class="row-fluid">
    <div class="span6">

    </div>

    <div class="span6" style="text-align: center; vertical-align: bottom;">
        <br/>
        <h2>Class hierarchy for for targets of active assays using MLPCN probe</h2>
        <br/>
    </div>

</div>


<script>
    var $data = [
        {"name":"/", "descr":"","size": 1,"col": 1,"children": [
            {"name":"transcription factor", "descr":"A protein required for the regulation of RNA polymerase by specific regulatory sequences in or near a gene.","size": 33,"col": 1,"children": [
                {"name":"zinc finger transcription factor", "descr":"A transcription factor containing zinc finger domain(s), which is composed of conserved cysteines and histidines co-ordinate with zinc ion(s).  Examples of zinc finger domains are C2H2 zinc finger, C3HC4 zinc finger, CHC2 zinc finger, etc.","col": 1,"size":3},
                {"name":"transcription cofactor", "descr":"A protein that has no DNA binding domains, but regulates transcription by binding to other transcription factors.","col": 1,"size":3},
                {"name":"basic helix-loop-helix transcription factor", "descr":"A transcription factor containing helix-loop-helix (HLH) DNA binding domain.","col": 1,"size":1},
                {"name":"nuclear hormone receptor", "descr":"A receptor of steroid hormones that traverses the nuclear membrane to activate transcription.","col": 1,"size":8},
                {"name":"zzull2", "descr":"invisible","col": 0,"size":18}
            ]},
            {"name":"nucleic acid binding", "descr":"A molecule that binds a nucleic acid.  It can be an enzyme or a binding protein.","size": 37,"col": 1,"children": [
                {"name":"RNA binding protein", "descr":"A protein that binds RNA and is involved in RNA processing or metabolism.","size": 8,"col": 1,"children": [
                    {"name":"mRNA processing factor", "descr":"A factor involved in mRNA processing, including capping, polyadenylation and splicing.","size": 3,"col": 1,"children": [
                        {"name":"mRNA splicing factor", "descr":"A factor involved in mRNA splicing.","col": 1,"size":1},
                        {"name":"zzull3", "descr":"invisible","col": 0,"size":2}
                    ]},
                    {"name":"translation factor", "descr":"A non-ribosomal protein involved in translation initiation, elongation or termination.","size": 2,"col": 1,"children": [
                        {"name":"translation elongation factor", "descr":"A non-ribosomal protein involved in translation elongation.","col": 1,"size":1},
                        {"name":"zzull4", "descr":"invisible","col": 0,"size":1}
                    ]},
                    {"name":"zzull5", "descr":"invisible","col": 0,"size":3}
                ]},
                {"name":"nuclease", "descr":"An enzyme that cleaves the phosphodiester bonds of a nucleic acid.","size": 3,"col": 1,"children": [
                    {"name":"exodeoxyribonuclease", "descr":"An enzyme that cleaves DNA sequentially from the free ends of a linear nucleic acid substrate.","col": 1,"size":1},
                    {"name":"endodeoxyribonuclease", "descr":"One of a large group of enzymes that cleaves DNA at an internal position in the chain.","col": 1,"size":1},
                    {"name":"zzull6", "descr":"invisible","col": 0,"size":1}
                ]},
                {"name":"DNA binding protein", "descr":"A protein that has DNA binding domains and binds DNA.  Transcription factors are DNA binding proteins, but they are not included in this category.","size": 4,"col": 1,"children": [
                    {"name":"chromatin_chromatin-binding protein", "descr":"A non-histone protein that either binds DNA to comprise chromatin or which binds chromatin.","col": 1,"size":1},
                    {"name":"zzull7", "descr":"invisible","col": 0,"size":3}
                ]},
                {"name":"helicase", "descr":"An enzyme that promotes the unwinding of duplex nucleic acids.","size": 2,"col": 1,"children": [
                    {"name":"DNA helicase", "descr":"An enzyme that promotes the unwinding of duplex DNA.","col": 1,"size":1},
                    {"name":"zzull8", "descr":"invisible","col": 0,"size":1}
                ]},
                {"name":"zzull9", "descr":"invisible","col": 0,"size":20}
            ]},
            {"name":"cytoskeletal protein", "descr":"Major constituent of the cytoskeleton found in the cytoplasm of eukaryotic cells. They form a flexible framework for the cell, provide attachment points for organelles and formed bodies, and make communication between parts of the cell possible.","size": 17,"col": 1,"children": [
                {"name":"actin family cytoskeletal protein", "descr":"A protein that is either actin itself or binds to actin to form the cytoskeleton of the cell.","size": 6,"col": 1,"children": [
                    {"name":"non-motor actin binding protein", "descr":"An actin binding protein that is not involved in motor function.","col": 1,"size":3},
                    {"name":"zzull10", "descr":"invisible","col": 0,"size":3}
                ]},
                {"name":"microtubule family cytoskeletal protein", "descr":"A protein that is either microtubule itself or binds to microtubule to form the cytoskeleton of the cell.","size": 4,"col": 1,"children": [
                    {"name":"non-motor microtubule binding protein", "descr":"A nonmotor protein that binds to microtubule cytoskeletal protein.","col": 1,"size":2},
                    {"name":"zzull11", "descr":"invisible","col": 0,"size":2}
                ]},
                {"name":"zzull12", "descr":"invisible","col": 0,"size":7}
            ]},
            {"name":"hydrolase", "descr":"Enzymes catalyzing hydrolysis of a variety of bonds, such as esters, glycosides, or peptides.  Protease and phosphatases are separate categories, so they are not included here.","size": 33,"col": 1,"children": [
                {"name":"protease", "descr":"Enzymes that hydrolyze peptide bonds.","size": 15,"col": 1,"children": [
                    {"name":"serine protease", "descr":"One of a group of endoproteases from both animal and bacterial sources that share a common reaction mechanism based on formation of an acyl enzyme intermediate on a specific active serine residue.","col": 1,"size":4},
                    {"name":"cysteine protease", "descr":"Peptide hydrolases that have a cysteine involved in the catalytic process. This group of enzymes is inactivated by sulfhydryl reagents.","col": 1,"size":2},
                    {"name":"metalloprotease", "descr":"A protease whose catalytic activity requires a transition metal.","col": 1,"size":2},
                    {"name":"zzull13", "descr":"invisible","col": 0,"size":7}
                ]},
                {"name":"lipase", "descr":"Enzymes that catalyze the hydrolysis of fats (monoglycerides, diglycerides and triglycerides) to glycerol and fatty acids. Calcium ions are usually required.","size": 2,"col": 1,"children": [
                    {"name":"phospholipase", "descr":"Enzymes that hydrolyze ester bonds in phospholipids. They comprise two types: aliphatic esterases (phospholipase A1, A2 and B) that release fatty acids, and phosphodiesterases (types C and D) that release diacyl glycerol or phosphatidic acid respectively.","col": 1,"size":1},
                    {"name":"zzull14", "descr":"invisible","col": 0,"size":1}
                ]},
                {"name":"glucosidase", "descr":"Enzymes that hydrolyze o-glucosyl-compounds.","col": 1,"size":1},
                {"name":"esterase", "descr":"Enzymes that catalyze the hydrolysis of organic esters to release an alcohol or thiol and acid.","col": 1,"size":3},
                {"name":"zzull15", "descr":"invisible","col": 0,"size":12}
            ]},
            {"name":"transferase", "descr":"Enzymes transferring a group from one compound (donor) to another compound (acceptor).  Kinase is a separate category, so it is not included here.","size": 70,"col": 1,"children": [
                {"name":"kinase", "descr":"An enzyme that catalyzes the transfer of a phosphate from ATP to a second substrate (EC2.7).","size": 52,"col": 1,"children": [
                    {"name":"protein kinase", "descr":"An enzyme that catalyzes the transfer of a phosphate from ATP to the hydroxyl side chains on proteins, causing changes in function.","size": 36,"col": 1,"children": [
                        {"name":"non-receptor serine_threonine protein kinase", "descr":"A soluble protein catalyzing transfer of phosphate from ATP to serine or threonine residue.","col": 1,"size":12},
                        {"name":"tyrosine protein kinase receptor", "descr":"A protein that has an extracellular ligand binding domain, a single transmembrane domain and an intracellular tyrosine kinase domain that phosphorylates protein tyrosine residues.","col": 1,"size":2},
                        {"name":"non-receptor tyrosine protein kinase", "descr":"A soluble protein catalyzing transfer of phosphate from ATP to tyrosine residue.","col": 1,"size":8},
                        {"name":"zzull16", "descr":"invisible","col": 0,"size":14}
                    ]},
                    {"name":"carbohydrate kinase", "descr":"An enzyme that catalyzes the phosphorylation of a sugar or carbohydrate.","col": 1,"size":1},
                    {"name":"zzull17", "descr":"invisible","col": 0,"size":15}
                ]},
                {"name":"acetyltransferase", "descr":"An enzyme that catalyzes the transfer of an acetyl group, usually from acetyl coenzyme A, to another compound.","col": 1,"size":1},
                {"name":"zzull18", "descr":"invisible","col": 0,"size":17}
            ]},
            {"name":"ligase", "descr":"A class of enzymes that catalyze the formation of a bond between two substrate molecules, coupled with the hydrolysis of a pyrophosphate bond in ATP or a similar energy donor.","size": 2,"col": 1,"children": [
                {"name":"ubiquitin-protein ligase", "descr":"An enzyme that couples ubiquitin to protein by a peptide bond between the C-terminal glycine of ubiquitin and a-amino groups of lysine residues in the protein.","col": 1,"size":1},
                {"name":"zzull19", "descr":"invisible","col": 0,"size":1}
            ]},
            {"name":"receptor", "descr":"A molecular structure within a cell or on the cell surface characterized by selective binding of a specific substance and a specific physiologic effect that accompanies the binding.","size": 40,"col": 1,"children": [
                {"name":"G-protein coupled receptor", "descr":"Cell surface receptors that are coupled to G proteins and have 7 transmembrane spanning domains.","col": 1,"size":13},
                {"name":"protein kinase receptor", "descr":"A protein that has an extracellular ligand binding domain, a single transmembrane domain and an intracellular kinase domain.","col": 1,"size":2},
                {"name":"zzull20", "descr":"invisible","col": 0,"size":25}
            ]},
            {"name":"signaling molecule", "descr":"A molecule that transduces a signal between cells.","size": 12,"col": 1,"children": [
                {"name":"growth factor", "descr":"A complex family of biological factors that are produced by the body to control growth, division and maturation of various cell types.","col": 1,"size":2},
                {"name":"cytokine", "descr":"A small protein or biological factor that is released by cells and have specific effects on cell-cell interaction, communication and behavior of other cells.  It contains interleukins, lymphokines, TNF-alpha and interferons.  Growth factors are generally not included here, although TGF-beta family members, CNTF and LIF are exceptions.","size": 2,"col": 1,"children": [
                    {"name":"tumor necrosis factor family member", "descr":"A multifunctional proinflammatory cytokine, with effects on lipid metabolism, coagulation, insulin resistance, and endothelial function.","col": 1,"size":1},
                    {"name":"zzull21", "descr":"invisible","col": 0,"size":1}
                ]},
                {"name":"zzull22", "descr":"invisible","col": 0,"size":8}
            ]},
            {"name":"enzyme modulator", "descr":"A protein that modulates the activity of a select group of an enzyme such as kinases, phosphatases, protease, and G-proteins.","size": 3,"col": 1,"children": [
                {"name":"G-protein", "descr":"A GTP-binding protein that is either part of the heterotrimeric G protein class or of the small GTP-binding class.","size": 2,"col": 1,"children": [
                    {"name":"small GTPase", "descr":"The small G proteins are a diverse group of monomeric GTPases that include ras, rab, rac and rho and that play an important part in regulating many intracellular processes including cytoskeletal organization and secretion.","col": 1,"size":1},
                    {"name":"zzull23", "descr":"invisible","col": 0,"size":1}
                ]},
                {"name":"zzull24", "descr":"invisible","col": 0,"size":1}
            ]},
            {"name":"chaperone", "descr":"A cytoplasmic protein that binds to nascent or unfolded polypeptides and ensures correct folding or transport.","size": 3,"col": 1,"children": [
                {"name":"Hsp90 family chaperone", "descr":"Widely distributed group of conserved heat-shock proteins of average weight 90 kD (HtpG in E. coli). Exact function unknown, but are found associated with steroid hormone receptors and tyrosine kinase oncogene products. May also bind actin and tubulin.","col": 1,"size":1},
                {"name":"zzull25", "descr":"invisible","col": 0,"size":2}
            ]},
            {"name":"cell adhesion molecule", "descr":"A protein that mediates cell-to-cell adhesion.","col": 1,"size":2},
            {"name":"oxidoreductase", "descr":"An enzyme that catalyzes a redox reaction.","size": 12,"col": 1,"children": [
                {"name":"dehydrogenase", "descr":"An enzyme that oxidizes a substrate by transferring hydrogen to an acceptor that is either NAD_NADP or a flavin enzyme.","col": 1,"size":2},
                {"name":"reductase", "descr":"An enzyme that introduces an electron into its substrate from an electron donor.  The reaction is usually coupled with an oxidation reaction.","col": 1,"size":3},
                {"name":"oxygenase", "descr":"An enzyme that catalyzes the incorporation of molecular oxygen into organic substrates.","col": 1,"size":1},
                {"name":"oxidase", "descr":"An enzyme that removes an electron from its substrate to an electron acceptor.  The reaction is usually coupled with a reduction reaction.","col": 1,"size":1},
                {"name":"zzull26", "descr":"invisible","col": 0,"size":5}
            ]},
            {"name":"transfer_carrier protein", "descr":"Proteins that carry specific substances in the blood or in the cell. They usually are not involved in transmembrane transport.","size": 2,"col": 1,"children": [
                {"name":"apolipoprotein", "descr":"The protein component of serum lipoproteins.","col": 1,"size":1},
                {"name":"zzull27", "descr":"invisible","col": 0,"size":1}
            ]},
            {"name":"defense_immunity protein", "descr":"A specific protein substance that is produced to take part in various defense and immune responses of the body.","size": 2,"col": 1,"children": [
                {"name":"complement component", "descr":"One of 20 distinct serum proteins that is the effector of immune cytolysis.","col": 1,"size":1},
                {"name":"zzull28", "descr":"invisible","col": 0,"size":1}
            ]},
            {"name":"membrane traffic protein", "descr":"A protein that is located on an intracellular vesicle membrane, and is responsible for the docking or fusion of the vesicle to the cytoplasma membrane.","col": 1,"size":2},
            {"name":"isomerase", "descr":"A class of enzymes that catalyze geometric or structural changes within a molecule to form a single product. The reactions do not involve a net change in the concentrations of compounds other than the substrate and the product.","size": 2,"col": 1,"children": [
                {"name":"epimerase_racemase", "descr":"Enzymes that catalyze inversion of the configuration around an asymmetric carbon in a substrate having one (racemase) or more (epimerase) center(s) of asymmetry (EC5.1).","col": 1,"size":1},
                {"name":"zzull29", "descr":"invisible","col": 0,"size":1}
            ]},
            {"name":"extracellular matrix protein", "descr":"A protein that is produced and secreted by cells and forms an intricate extracellular meshwork in which cells are embedded to construct tissues.","col": 1,"size":1}
        ]}
    ]

//
//
//
//
//
//
//
//
//
//
//
//
//    var $data = [
//        {"name":"/", "descr":"","children": [
//            {"name":"transcription factor", "descr":"A protein required for the regulation of RNA polymerase by specific regulatory sequences in or near a gene.","children": [
//                {"name":"zinc finger transcription factor", "descr":"A transcription factor containing zinc finger domain(s), which is composed of conserved cysteines and histidines co-ordinate with zinc ion(s).  Examples of zinc finger domains are C2H2 zinc finger, C3HC4 zinc finger, CHC2 zinc finger, etc.","size":1},
//                {"name":"nuclear hormone receptor", "descr":"A receptor of steroid hormones that traverses the nuclear membrane to activate transcription.","size":1},
//                {"name":"transcription cofactor", "descr":"A protein that has no DNA binding domains, but regulates transcription by binding to other transcription factors.","size":1},
//                {"name":"basic helix-loop-helix transcription factor", "descr":"A transcription factor containing helix-loop-helix (HLH) DNA binding domain.","size":1}
//            ]},
//            {"name":"nucleic acid binding", "descr":"A molecule that binds a nucleic acid.  It can be an enzyme or a binding protein.","children": [
//                {"name":"RNA binding protein", "descr":"A protein that binds RNA and is involved in RNA processing or metabolism.","children": [
//                    {"name":"mRNA processing factor", "descr":"A factor involved in mRNA processing, including capping, polyadenylation and splicing.","children": [
//                        {"name":"mRNA splicing factor", "descr":"A factor involved in mRNA splicing.","size":1}
//                    ]},
//                    {"name":"translation factor", "descr":"A non-ribosomal protein involved in translation initiation, elongation or termination.","children": [
//                        {"name":"translation elongation factor", "descr":"A non-ribosomal protein involved in translation elongation.","size":1}
//                    ]}
//                ]},
//                {"name":"nuclease", "descr":"An enzyme that cleaves the phosphodiester bonds of a nucleic acid.","children": [
//                    {"name":"exodeoxyribonuclease", "descr":"An enzyme that cleaves DNA sequentially from the free ends of a linear nucleic acid substrate.","size":1},
//                    {"name":"endodeoxyribonuclease", "descr":"One of a large group of enzymes that cleaves DNA at an internal position in the chain.","size":1}
//                ]},
//                {"name":"DNA binding protein", "descr":"A protein that has DNA binding domains and binds DNA.  Transcription factors are DNA binding proteins, but they are not included in this category.","children": [
//                    {"name":"chromatin/chromatin-binding protein", "descr":"A non-histone protein that either binds DNA to comprise chromatin or which binds chromatin.","size":1}
//                ]},
//                {"name":"helicase", "descr":"An enzyme that promotes the unwinding of duplex nucleic acids.","children": [
//                    {"name":"DNA helicase", "descr":"An enzyme that promotes the unwinding of duplex DNA.","size":1}
//                ]}
//            ]},
//            {"name":"receptor", "descr":"A molecular structure within a cell or on the cell surface characterized by selective binding of a specific substance and a specific physiologic effect that accompanies the binding.","children": [
//                {"name":"G-protein coupled receptor", "descr":"Cell surface receptors that are coupled to G proteins and have 7 transmembrane spanning domains.","size":1},
//                {"name":"protein kinase receptor", "descr":"A protein that has an extracellular ligand binding domain, a single transmembrane domain and an intracellular kinase domain.","size":1},
//                {"name":"cytokine receptor", "descr":"A receptor that binds to cytokines and signals through particular signaling pathways, such as STAT pathway.  The chemokine GPCRs are excluded from this group, and can be found under G-protein coupled receptor.","children": [
//                    {"name":"tumor necrosis factor receptor", "descr":"A transmembrane receptor protein whose ligand is tumor necrosis factor.","size":1}
//                ]}
//            ]},
//            {"name":"cytoskeletal protein", "descr":"Major constituent of the cytoskeleton found in the cytoplasm of eukaryotic cells. They form a flexible framework for the cell, provide attachment points for organelles and formed bodies, and make communication between parts of the cell possible.","children": [
//                {"name":"actin family cytoskeletal protein", "descr":"A protein that is either actin itself or binds to actin to form the cytoskeleton of the cell.","children": [
//                    {"name":"non-motor actin binding protein", "descr":"An actin binding protein that is not involved in motor function.","size":1}
//                ]},
//                {"name":"microtubule family cytoskeletal protein", "descr":"A protein that is either microtubule itself or binds to microtubule to form the cytoskeleton of the cell.","children": [
//                    {"name":"non-motor microtubule binding protein", "descr":"A nonmotor protein that binds to microtubule cytoskeletal protein.","size":1}
//                ]}
//            ]},
//            {"name":"hydrolase", "descr":"Enzymes catalyzing hydrolysis of a variety of bonds, such as esters, glycosides, or peptides.  Protease and phosphatases are separate categories, so they are not included here.","children": [
//                {"name":"protease", "descr":"Enzymes that hydrolyze peptide bonds.","children": [
//                    {"name":"serine protease", "descr":"One of a group of endoproteases from both animal and bacterial sources that share a common reaction mechanism based on formation of an acyl enzyme intermediate on a specific active serine residue.","size":1},
//                    {"name":"cysteine protease", "descr":"Peptide hydrolases that have a cysteine involved in the catalytic process. This group of enzymes is inactivated by sulfhydryl reagents.","size":1},
//                    {"name":"metalloprotease", "descr":"A protease whose catalytic activity requires a transition metal.","size":1}
//                ]},
//                {"name":"esterase", "descr":"Enzymes that catalyze the hydrolysis of organic esters to release an alcohol or thiol and acid.","size":1}
//            ]},
//            {"name":"transporter", "descr":"A class of transmembrane proteins that allows substances to cross plasma membranes far faster than would be possible by diffusion alone.   Please note that ion channel has its own category and is not included here.","children": [
//                {"name":"ion channel", "descr":"A protein creating a highly selective transmembrane pore that presents a hydrophilic channel for specific ions to cross a lipid bilayer.","children": [
//                    {"name":"voltage-gated ion channel", "descr":"A transmembrane ion channel whose permeability to ions is sensitive to the transmembrane potential difference.","children": [
//                        {"name":"voltage-gated potassium channel", "descr":"A transmembrane ion channel whose selective permeability to potassium is sensitive to the transmembrane potential difference.","size":1}
//                    ]},
//                    {"name":"potassium channel", "descr":"A transmembrane ion channel that displays selective permeability to potassium ions.","size":1}
//                ]}
//            ]},
//            {"name":"ligase", "descr":"A class of enzymes that catalyze the formation of a bond between two substrate molecules, coupled with the hydrolysis of a pyrophosphate bond in ATP or a similar energy donor.","children": [
//                {"name":"ubiquitin-protein ligase", "descr":"An enzyme that couples ubiquitin to protein by a peptide bond between the C-terminal glycine of ubiquitin and a-amino groups of lysine residues in the protein.","size":1}
//            ]},
//            {"name":"signaling molecule", "descr":"A molecule that transduces a signal between cells.","children": [
//                {"name":"growth factor", "descr":"A complex family of biological factors that are produced by the body to control growth, division and maturation of various cell types.","size":1}
//            ]},
//            {"name":"transferase", "descr":"Enzymes transferring a group from one compound (donor) to another compound (acceptor).  Kinase is a separate category, so it is not included here.","children": [
//                {"name":"kinase", "descr":"An enzyme that catalyzes the transfer of a phosphate from ATP to a second substrate (EC2.7).","children": [
//                    {"name":"protein kinase", "descr":"An enzyme that catalyzes the transfer of a phosphate from ATP to the hydroxyl side chains on proteins, causing changes in function.","children": [
//                        {"name":"tyrosine protein kinase receptor", "descr":"A protein that has an extracellular ligand binding domain, a single transmembrane domain and an intracellular tyrosine kinase domain that phosphorylates protein tyrosine residues.","size":1},
//                        {"name":"non-receptor tyrosine protein kinase", "descr":"A soluble protein catalyzing transfer of phosphate from ATP to tyrosine residue.","size":1},
//                        {"name":"non-receptor serine/threonine protein kinase", "descr":"A soluble protein catalyzing transfer of phosphate from ATP to serine or threonine residue.","size":1}
//                    ]},
//                    {"name":"carbohydrate kinase", "descr":"An enzyme that catalyzes the phosphorylation of a sugar or carbohydrate.","size":1}
//                ]},
//                {"name":"acetyltransferase", "descr":"An enzyme that catalyzes the transfer of an acetyl group, usually from acetyl coenzyme A, to another compound.","size":1}
//            ]},
//            {"name":"enzyme modulator", "descr":"A protein that modulates the activity of a select group of an enzyme such as kinases, phosphatases, protease, and G-proteins.","children": [
//                {"name":"G-protein", "descr":"A GTP-binding protein that is either part of the heterotrimeric G protein class or of the small GTP-binding class.","children": [
//                    {"name":"small GTPase", "descr":"The small G proteins are a diverse group of monomeric GTPases that include ras, rab, rac and rho and that play an important part in regulating many intracellular processes including cytoskeletal organization and secretion.","size":1},
//                    {"name":"heterotrimeric G-protein", "descr":"the heterotrimeric G proteins that associate with receptors of the seven transmembrane domain superfamily and are involved in signal transduction.","size":1}
//                ]},
//                {"name":"kinase modulator", "descr":"A protein that directly interacts with a kinase and affects its activity.","children": [
//                    {"name":"kinase activator", "descr":"A protein that directly interacts with a kinase and activates or enhance its activity.","size":1}
//                ]},
//                {"name":"G-protein modulator", "descr":"A protein that directly interacts with a G-protein and affects its activity.","size":1}
//            ]},
//            {"name":"extracellular matrix protein", "descr":"A protein that is produced and secreted by cells and forms an intricate extracellular meshwork in which cells are embedded to construct tissues.","children": [
//                {"name":"extracellular matrix glycoprotein", "descr":"An extracellular matrix protein which is conjugated with one or more covalently linked carbohydrate residues.","size":1}
//            ]},
//            {"name":"cell adhesion molecule", "descr":"A protein that mediates cell-to-cell adhesion.","children": [
//                {"name":"cadherin", "descr":"An integral membrane protein involved in calcium dependent cell adhesion.","size":1}
//            ]},
//            {"name":"oxidoreductase", "descr":"An enzyme that catalyzes a redox reaction.","children": [
//                {"name":"oxygenase", "descr":"An enzyme that catalyzes the incorporation of molecular oxygen into organic substrates.","size":1},
//                {"name":"dehydrogenase", "descr":"An enzyme that oxidizes a substrate by transferring hydrogen to an acceptor that is either NAD/NADP or a flavin enzyme.","size":1},
//                {"name":"oxidase", "descr":"An enzyme that removes an electron from its substrate to an electron acceptor.  The reaction is usually coupled with a reduction reaction.","size":1},
//                {"name":"reductase", "descr":"An enzyme that introduces an electron into its substrate from an electron donor.  The reaction is usually coupled with an oxidation reaction.","size":1}
//            ]},
//            {"name":"transfer/carrier protein", "descr":"Proteins that carry specific substances in the blood or in the cell. They usually are not involved in transmembrane transport.","children": [
//                {"name":"apolipoprotein", "descr":"The protein component of serum lipoproteins.","size":1}
//            ]},
//            {"name":"defense/immunity protein", "descr":"A specific protein substance that is produced to take part in various defense and immune responses of the body.","children": [
//                {"name":"complement component", "descr":"One of 20 distinct serum proteins that is the effector of immune cytolysis.","size":1}
//            ]},
//            {"name":"cell junction protein", "descr":"Proteins that form specialized junctions between cells.","size":1},
//            {"name":"membrane traffic protein", "descr":"A protein that is located on an intracellular vesicle membrane, and is responsible for the docking or fusion of the vesicle to the cytoplasma membrane.","size":1},
//            {"name":"chaperone", "descr":"A cytoplasmic protein that binds to nascent or unfolded polypeptides and ensures correct folding or transport.","size":1},
//            {"name":"isomerase", "descr":"A class of enzymes that catalyze geometric or structural changes within a molecule to form a single product. The reactions do not involve a net change in the concentrations of compounds other than the substrate and the product.","children": [
//                {"name":"epimerase/racemase", "descr":"Enzymes that catalyze inversion of the configuration around an asymmetric carbon in a substrate having one (racemase) or more (epimerase) center(s) of asymmetry (EC5.1).","size":1}
//            ]}
//        ]}
//    ]





    var minimumValue=0.5;
    var maximumValue=0.5;

    var continuousColorScale = d3.scale.linear()
            .domain([minimumValue, maximumValue])
//            .interpolate(d3.interpolateRgb)
//            .range(["#deffd9", "#74c476"]);
    .range(["#000", "#000"]);

</script>


<div class="row-fluid">
    <div class="span9 pull-left">

        <div id="sunburstdiv">

            <script>
                sunburst =  createASunburst;
                if ($data[0].children !== undefined) {
                    sunburst(1400, 1400, 5, 1000, continuousColorScale, 'div#sunburstdiv');
                } else {
                    d3.select('div#sunburstdiv')
                            .append('div')
                            .attr("width", 4000)
                            .attr("height", 1400)
                            .style("padding-top", '200px')
                            .style("text-align", 'center')
                            .append("h1")
                            .html("No off-embargo assay data are  available for this compound.<br /><br />" +
                                    "Please either choose a different compound, or else come<br />" +
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
                    createALegend(120, 200, 100, continuousColorScale, 'div#legendGoesHere', minimumValue, maximumValue);
                }
            </script>

        </div>

        <div style="text-align: center; vertical-align: bottom;">

            <select id="coloringOptions" style="visibility: hidden">
                <option value="1">Color by activity</option>
                <option value="2">Split classes by activity</option>
                <option value="3">Color by class</option>
            </select>

            <div style="padding-top: 320px;"></div>
            <select id="activity" style="visibility: hidden">
                <option value="1">Active only</option>
                <option value="2">Inactive only</option>
                <option value="3"
                        selected>Active and Inactive</option>
            </select>

        </div>

    </div>
</div>

<div class="row-fluid">
    <div class="span9 pull-left">
    </div>

    <div class="span3 pull-left">
        <button id="toggler" onclick="sunburst.toggleColorDisplay()">toggle color</button>
    </div>
</div>
<hr>
</div>


</body>
</html>