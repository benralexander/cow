<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
<title>26k</title>

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
        <h2>visualize data hierarchy for the new 26K data set</h2>
        <br/>
    </div>

</div>


<script>
    var $data = [
        {"name":"ROOT", "descr":"76","size": 86,"col": 1,"children": [
            {"name":"ExSeq_13k", "descr":"76.1","size": 9,"col": 1,"children": [
                {"name":"13k", "descr":"76.1.2","size": 8,"col": 1,"children": [
                    {"name":"13k_ea_genes", "descr":"76.1.2.3","size": 1,"col": 1,"children": [
                        {"name":"zzull0", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"13k_aa_genes", "descr":"76.1.2.4","size": 1,"col": 1,"children": [
                        {"name":"zzull1", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"13k_eu", "descr":"76.1.2.5","size": 3,"col": 1,"children": [
                        {"name":"13k_eu_genes", "descr":"76.1.2.5.6","size": 1,"col": 1,"children": [
                            {"name":"zzull2", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"13k_eu_go", "descr":"76.1.2.5.7","size": 1,"col": 1,"children": [
                            {"name":"zzull3", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"zzull4", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"13k_sa_genes", "descr":"76.1.2.8","size": 1,"col": 1,"children": [
                        {"name":"zzull5", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"13k_hs_genes", "descr":"76.1.2.9","size": 1,"col": 1,"children": [
                        {"name":"zzull6", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"zzull7", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull8", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"ExSeq_26k", "descr":"76.12","size": 30,"col": 1,"children": [
                {"name":"26k", "descr":"76.12.13","size": 29,"col": 1,"children": [
                    {"name":"26k_sa_genes", "descr":"76.12.13.10","size": 3,"col": 1,"children": [
                        {"name":"26k_sa_genes_sl", "descr":"76.12.13.10.14","size": 1,"col": 1,"children": [
                            {"name":"zzull9", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"26k_sa_genes_ss", "descr":"76.12.13.10.15","size": 1,"col": 1,"children": [
                            {"name":"zzull10", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"zzull11", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"26k_ea_genes", "descr":"76.12.13.16","size": 3,"col": 1,"children": [
                        {"name":"26k_ea_genes_es", "descr":"76.12.13.16.17","size": 1,"col": 1,"children": [
                            {"name":"zzull12", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"26k_ea_genes_ek", "descr":"76.12.13.16.19","size": 1,"col": 1,"children": [
                            {"name":"zzull13", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"zzull14", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"26k_eu", "descr":"76.12.13.18","size": 8,"col": 1,"children": [
                        {"name":"26k_eu_go", "descr":"76.12.13.18.20","size": 1,"col": 1,"children": [
                            {"name":"zzull15", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"26k_eu_esp", "descr":"76.12.13.18.21","size": 1,"col": 1,"children": [
                            {"name":"zzull16", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"26k_eu_genes", "descr":"76.12.13.18.22","size": 4,"col": 1,"children": [
                            {"name":"26k_eu_genes_ua", "descr":"76.12.13.18.22.23","size": 1,"col": 1,"children": [
                                {"name":"zzull17", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"26k_eu_genes_um", "descr":"76.12.13.18.22.24","size": 1,"col": 1,"children": [
                                {"name":"zzull18", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"zzull19", "descr":"null","col": 1,"size":2}
                        ]}
                        ,
                        {"name":"26k_eu_lucamp", "descr":"76.12.13.18.25","size": 1,"col": 1,"children": [
                            {"name":"zzull20", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"zzull21", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"26k_aa", "descr":"76.12.13.26","size": 5,"col": 1,"children": [
                        {"name":"26k_aa_esp", "descr":"76.12.13.26.27","size": 1,"col": 1,"children": [
                            {"name":"zzull22", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"26k_aa_genes", "descr":"76.12.13.26.28","size": 3,"col": 1,"children": [
                            {"name":"26k_aa_genes_aw", "descr":"76.12.13.26.28.29","size": 1,"col": 1,"children": [
                                {"name":"zzull23", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"26k_aa_genes_aj", "descr":"76.12.13.26.28.30","size": 1,"col": 1,"children": [
                                {"name":"zzull24", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"zzull25", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"zzull26", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"26k_hs", "descr":"76.12.13.31","size": 9,"col": 1,"children": [
                        {"name":"26k_hs_genes", "descr":"76.12.13.31.32","size": 3,"col": 1,"children": [
                            {"name":"26k_hs_genes_hs", "descr":"76.12.13.31.32.33","size": 1,"col": 1,"children": [
                                {"name":"zzull27", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"26k_hs_genes_ha", "descr":"76.12.13.31.32.34","size": 1,"col": 1,"children": [
                                {"name":"zzull28", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"zzull29", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"26k_hs_sigma", "descr":"76.12.13.31.35","size": 5,"col": 1,"children": [
                            {"name":"26k_hs_sigma_mexb2", "descr":"76.12.13.31.35.36","size": 1,"col": 1,"children": [
                                {"name":"zzull30", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"26k_hs_sigma_mexb3", "descr":"76.12.13.31.35.37","size": 1,"col": 1,"children": [
                                {"name":"zzull31", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"26k_hs_sigma_mexb1", "descr":"76.12.13.31.35.38","size": 1,"col": 1,"children": [
                                {"name":"zzull32", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"26k_hs_sigma_mec", "descr":"76.12.13.31.35.39","size": 1,"col": 1,"children": [
                                {"name":"zzull33", "descr":"null","col": 1,"size":1}
                            ]}
                            ,
                            {"name":"zzull34", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"zzull35", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"zzull36", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull37", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"ExChip_82k_v1", "descr":"76.40","size": 2,"col": 1,"children": [
                {"name":"82k", "descr":"76.40.41","size": 1,"col": 1,"children": [
                    {"name":"zzull38", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull39", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"ExChip_82k_v2", "descr":"42","size": 3,"col": 1,"children": [
                {"name":"82k", "descr":"76.42.41","size": 2,"col": 1,"children": [
                    {"name":"zzull40", "descr":"null","col": 1,"size":2}
                ]}
                ,
                {"name":"zzull41", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_MAGIC_v1", "descr":"76.44","size": 2,"col": 1,"children": [
                {"name":"MAGIC", "descr":"76.44.45","size": 1,"col": 1,"children": [
                    {"name":"zzull42", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull43", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_MAGIC_v2", "descr":"76.46","size": 2,"col": 1,"children": [
                {"name":"MAGIC", "descr":"76.46.45","size": 1,"col": 1,"children": [
                    {"name":"zzull44", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull45", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_PGC_v1", "descr":"76.47","size": 2,"col": 1,"children": [
                {"name":"PGC", "descr":"76.47.48","size": 1,"col": 1,"children": [
                    {"name":"zzull46", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull47", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_PGC_v2", "descr":"49","size": 3,"col": 1,"children": [
                {"name":"PGC", "descr":"76.49.48","size": 2,"col": 1,"children": [
                    {"name":"zzull48", "descr":"null","col": 1,"size":2}
                ]}
                ,
                {"name":"zzull49", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_GIANT_v1", "descr":"76.51","size": 7,"col": 1,"children": [
                {"name":"GIANT", "descr":"76.51.52","size": 6,"col": 1,"children": [
                    {"name":"GIANT_females", "descr":"76.51.52.53","size": 1,"col": 1,"children": [
                        {"name":"zzull50", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"GIANT_males", "descr":"76.51.52.54","size": 1,"col": 1,"children": [
                        {"name":"zzull51", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"GIANT_eu", "descr":"76.51.52.55","size": 3,"col": 1,"children": [
                        {"name":"GIANT_eu_females", "descr":"76.51.52.55.56","size": 1,"col": 1,"children": [
                            {"name":"zzull52", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"GIANT_eu_males", "descr":"76.51.52.55.57","size": 1,"col": 1,"children": [
                            {"name":"zzull53", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"zzull54", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"zzull55", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull56", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_GIANT_v2", "descr":"76.50","size": 7,"col": 1,"children": [
                {"name":"GIANT", "descr":"76.50.52","size": 6,"col": 1,"children": [
                    {"name":"GIANT_females", "descr":"76.50.52.53","size": 1,"col": 1,"children": [
                        {"name":"zzull57", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"GIANT_males", "descr":"76.50.52.54","size": 1,"col": 1,"children": [
                        {"name":"zzull58", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"GIANT_eu", "descr":"76.50.52.55","size": 3,"col": 1,"children": [
                        {"name":"GIANT_eu_females", "descr":"76.50.52.55.56","size": 1,"col": 1,"children": [
                            {"name":"zzull59", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"GIANT_eu_males", "descr":"76.50.52.55.57","size": 1,"col": 1,"children": [
                            {"name":"zzull60", "descr":"null","col": 1,"size":1}
                        ]}
                        ,
                        {"name":"zzull61", "descr":"null","col": 1,"size":1}
                    ]}
                    ,
                    {"name":"zzull62", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull63", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_CARDIoGRAM_v1", "descr":"76.58","size": 4,"col": 1,"children": [
                {"name":"CARDIoGRAM", "descr":"76.58.59","size": 1,"col": 1,"children": [
                    {"name":"zzull64", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"C4D", "descr":"76.58.60","size": 1,"col": 1,"children": [
                    {"name":"zzull65", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"CARDIoGRAMplusC4D", "descr":"76.58.61","size": 1,"col": 1,"children": [
                    {"name":"zzull66", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull67", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_CARDIoGRAM_v2", "descr":"76.62","size": 4,"col": 1,"children": [
                {"name":"CARDIoGRAM", "descr":"76.62.59","size": 1,"col": 1,"children": [
                    {"name":"zzull68", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"C4D", "descr":"76.62.60","size": 1,"col": 1,"children": [
                    {"name":"zzull69", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"CARDIoGRAMplusC4D", "descr":"76.62.61","size": 1,"col": 1,"children": [
                    {"name":"zzull70", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull71", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_CKDGen", "descr":"76.66","size": 2,"col": 1,"children": [
                {"name":"CKDGen", "descr":"76.66.67","size": 1,"col": 1,"children": [
                    {"name":"zzull72", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull73", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_GLGC_v1", "descr":"76.68","size": 2,"col": 1,"children": [
                {"name":"GLGC", "descr":"76.68.69","size": 1,"col": 1,"children": [
                    {"name":"zzull74", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull75", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_GLGC_v2", "descr":"76.70","size": 2,"col": 1,"children": [
                {"name":"GLGC", "descr":"76.70.69","size": 1,"col": 1,"children": [
                    {"name":"zzull76", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull77", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_DIAGRAM_v1", "descr":"76.72","size": 2,"col": 1,"children": [
                {"name":"DIAGRAM", "descr":"76.72.73","size": 1,"col": 1,"children": [
                    {"name":"zzull78", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull79", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"GWAS_DIAGRAM_v2", "descr":"76.74","size": 2,"col": 1,"children": [
                {"name":"DIAGRAM", "descr":"76.74.73","size": 1,"col": 1,"children": [
                    {"name":"zzull80", "descr":"null","col": 1,"size":1}
                ]}
                ,
                {"name":"zzull81", "descr":"null","col": 1,"size":1}
            ]}
            ,
            {"name":"zzull82", "descr":"null","col": 1,"size":1}
        ]}
    ]

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

        <div id="sunburstdiv" style="margin-top: -140px;">

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