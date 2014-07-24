// One dimensional heatmap.

(function() {

    d3.heatmap = function() {

        // the variables we intend to surface
        var
            width = 1,
            height = 1,
            selectionIdentifier = '',
            data={},
            featureName = '',
            compoundName,
            compoundId,
            fromFeaturePage,

        // the variables that will never be exposed
            xAxis = {},
            instance={},
            selection = {},
            svg = {},
            heatmap = {},
            featuremap = {},
            formatTooltipNumericValue = d3.format(".3g"),

            /***
             *  This module adds a handler for clicks on the colored bars in the
             *  enrichment plot, and then retrieves the data necessary to insert
             *  a viability curve into a pop-up div.  We use d3 to capture the
             *  mouse events in this module instead of JQuery.
             */
                clickHandling = (function () {

                var popUpGraphic;
                function givePopUpTheRightParent (){
                    var correctSelection;
                    if (fromFeaturePage){
                        correctSelection = d3.select('#cdtCmpTabs-2').selectAll('div.toolTextAppearance').data([1]);
                    }else {
                        correctSelection = d3.select('#cdtGeneTabs-2').selectAll('div.toolTextAppearance').data([1]);
                    }
                    return correctSelection;
                }
//                    var popUpGraphic = d3.select('#cdtCmpTabs-2').selectAll('div.toolTextAppearance').data([1]);
//                    popUpGraphic.enter()
//                    .append("div")
//                    .style("opacity", "0")
//                    .style("position", "absolute")
//                    .style("z-index", "100")
//                    .attr("class", "toolTextAppearance");

                appear = function(d,i,g) {

                    popUpGraphic = givePopUpTheRightParent ();
                    popUpGraphic.enter()
                        .append("div")
                        .style("opacity", "0")
                        .style("position", "absolute")
                        .style("z-index", "100")
                        .attr("class", "toolTextAppearance");


                    if (d.name != '/') {
                        popUpGraphic.html(contentForGraphicWindow ())
                            .transition()
                            .duration(200)
                            .style("opacity", "1")
                            .style("width", "400px")
                            .style("height", "400px")
                            .style("top", (d3.event.pageY - 130) + "px")
                            .style("left", (d3.event.pageX - 70) + "px")
                            .style("z-index", "100");

                        // if we know the compound name/ID then pass that information down to the callback click handler
                        if ( typeof compoundId !== "undefined" ){
                            d.compoundId = compoundId;
                        }
                        if ( typeof compoundName !== "undefined" ){
                            d.compoundName = compoundName;
                        }
                        if ( typeof fromFeaturePage !== "undefined" ){
                            d.fromFeaturePage = fromFeaturePage;
                        }

                        clickCallback(d,i,g);

                        return;
                    }
                    else {
                        return popUpGraphic
                            .html(null)
                            .style("opacity", "0")
                            .style("z-index", "-1");
                    }

                } ,
                    mouseMove = function (d) {
                        popUpGraphic = givePopUpTheRightParent ();
                        if (d.name === '/')  {
                            return popUpGraphic.html(null).style("opacity", "0");
                        }  else {
                            return popUpGraphic .style("top", (d3.event.pageY - 10) + "px")
                                .style("left", (d3.event.pageX + 10) + "px");
                        }

                    },
                    disappear =  function () {
                        popUpGraphic = givePopUpTheRightParent ();
                        return popUpGraphic
                            .style("opacity", "0")
                            .style("z-index", "-1");
                    },
                    contentForGraphicWindow = function ()    {
                        var retVal;
                        if (fromFeaturePage){
                            retVal = "<div id='doseResponseFromEnrichment'></div>" +
                                "<div id='doseResponseCloser' style='position:relative; top: 0px; left: 10px'><button onclick='heatmapPlot.activatePopUpClose()'>Close window</button></div>" +
                                "</table>";
                        } else {
                            retVal = "<div id='doseResponseFromFeatureTab'></div>" +
                                "<div id='doseResponseCloserFromFeatureTab' style='position:relative; top: 0px; left: 10px'><button onclick='heatmapPlot.activatePopUpClose()'>Close window</button></div>" +
                                "</table>";
                        }

                        return retVal;
                    };

                return {
                    appear:appear,
                    disappear:disappear

                }

            }()),


            closingPopUpCallback =  clickHandling.disappear,
            clickCallback = function (d, i, g){

                var cmpd = $('#imageHolder').data('compound'),
                // compoundId = cmpd.compound_id,
                    compoundId ,
                    cellId = d.cellSampleId,
                    compoundName,
                    parentDomElement='#doseResponseFromEnrichment';
                if ( typeof d.compoundId!== "undefined"){
                    compoundId = d.compoundId;
                }
                if ( typeof d.compoundName!== "undefined"){
                    compoundName = d.compoundName;
                }
                if (d.fromFeaturePage){
                    parentDomElement='#doseResponseFromEnrichment';
                } else {
                    parentDomElement='#doseResponseFromFeatureTab';
                }
                setWaitCursor();
                // parentDomElement = $(selectionIdentifier).closest(".enrichmentTab");
                DTGetDoseResponsePoints(compoundId, cellId, function (data){
                    var chart =  d3.doseResponse()
                        .displayGridLines(false)
                        .xAxisLabel('log ['+compoundName+']')
                        .yAxisLabel('Viability')
                        .width('390')
                        .height('380')
                        .title(data.cell_primary_name)
                        .selectionIdentifier(parentDomElement)
                        .autoScale(false)
                        .areaUnderTheCurve ([5,13]) // Shade points 5 - 13
                        .x(d3.scale.log().domain([0.001, 40]))
                        .y(d3.scale.linear().domain([0,1.5]));
                    var curves=[data];
                    curves.forEach(function (series) {
                        chart.addSeries(series);
                    });

                    chart.render();
                    removeWaitCursor();
                });
            },




        // Where do you want your plot?
            margin = {top: 10, right: 20, bottom: 10, left: 50},
            width = 300 - margin.left - margin.right,
            height = 100 - margin.top - margin.bottom,


        //  private variable  handles the tooltip popup
            tip = d3.tip()
                .attr('class', 'd3-tip')
                .offset([-10, 0])
                .html(function (d) {
                    var textToPresent = "";
                    var textColor = '#000000';
                    if (d){
                        if(d.featureExists){
                            textColor = '#00ffff';
                            textToPresent = "CCL: " +
                                d.name+
                                "<br/>Lineage: " +
                                d.line+
                                "<br/>Compound: " +
                                compoundName+
                                "<br/>Feature: " +
                                featureName +
                                "<br/>AUC: " +
                                formatTooltipNumericValue (d.value)   ;
                        }  else {
                            textColor = '#00ff00';
                            textToPresent = "CCL: "+
                                d.name+
                                "<br/>Lineage: " +
                                d.line +
                                "<br/>Compound: " +
                                compoundName  +
                                "<br/>AUC: " +
                                formatTooltipNumericValue (d.value)   ;
                        }

                    }
                    return "<strong></strong><span style='color:" +textColor +"'>" +textToPresent+ "</span> ";
                });

        // initialize
        // we might be coming back after having run this routine previously. Let's make sure there are no pop-up windows hanging around
        clickHandling.disappear();

        /***
         * Two externally visible methods
         *  assignData
         *  render
         *
         */


            // assign data to the DOM
        instance.assignData = function (x) {
            if (!arguments.length) return data;
            data = x;
            if (typeof data.featureName !== undefined) {
                featureName =  data.featureName;
            }
            if (typeof data.compoundName !== undefined) {
                compoundName =  data.compoundName;
            }
            if (typeof data.compoundId !== undefined) {
                compoundId =  data.compoundId;
            }
            selection
                .selectAll("svg")
                .data(data.enrichmentData)
                .enter()
                .append("svg")
                .call(tip);
            return instance;
        };


        // Now walk through the DOM and create the enrichment plot
        instance.render=function (g) {

            //  create the on screen display
            selection
                .selectAll("svg")
                .attr("width", width*1.2)
                .attr("height", height)
                .append("g");            //  create the on screen display



            selection
                .selectAll("svg")
                .each(function(d, i) {
                    d = d.sort(function(a, b) { return  (a.value)-(b.value)});
                    var g = d3.select(this),
                        dataLength = d.length,
                        minValue = d[0].value,
                        midValue = d[Math.floor(dataLength/2)].value,
                        maxValue  = d[dataLength - 1].value,
                        averageWidth = (maxValue-minValue)/( dataLength-1); // Average width


                    //define a color scale using the min and max expression values
                    var colorScale = d3.scale.linear()
                        .domain([minValue, midValue, maxValue])
                        .range(["red", "white", "blue"]);

                    var xScale = d3.scale.linear()
                        .domain([minValue, maxValue])
                        .range([0,width]);

                    xAxis = d3.svg.axis()
                        .scale(xScale)
                        .orient("bottom");

                    var zoom = d3.behavior.zoom()
                        .x(xScale)
                        //.y(yScale)
                        .scaleExtent([1, 100])
                        .on("zoom", zoomed);

                    selection.call(zoom);


                    // Here is the colorful part of the heat map
                    var dVector = d;
                    var heatmap = g.selectAll(".heatmap")
                        .data(d)
                        .enter().append("svg:rect")
                        .on('mouseover', tip.show)
                        .on('mouseout', tip.hide)
                        .attr('width', function(d,i) {
                            return  calculateWidth(dVector,d,i,xScale, averageWidth) ;
                        })
                        .attr('height', 2*height/3)
                        .attr('x', function(d,i) {
                            // return xScale(dVector[dVector[i].index].value);
                            return xScale(dVector[d.index].value);
                        } )
                        .attr('y',0)
                        .attr('fill', function(d) {
                            return colorScale(d.value);
                        })
                        .on("click", function click(d,i,g)
                        {
                            clickHandling.appear(d,i,g);
                        });

                    // Here is the indicator that the feature under consideration
                    //   is present in this cell line
                    dVector = d;
                    var featuremap = g.selectAll(".featuremap")
                        .data(d)
                        .enter().append("svg:rect")
                        .filter ( function(d,i) {
                        return d.featureExists;
                    })
                        .attr('width',function(d,i) {
                            return  calculateWidth(dVector,d,i,xScale, averageWidth) ;
                        })
                        .attr('height',  function(d,i) {
                            return (height/2);
                        })
                        .attr('x', function(d,i) {
                            return xScale(dVector[d.index].value);
                        })
                        .on('mouseover', tip.show)
                        .on('mouseout', tip.hide)
                        .attr('y',height/3)
                        .attr('fill', "black")
                        .attr('stroke', 'black')
                        .on("click", function click(d,i,g)
                        {
                            clickHandling.appear(d,i,g);
                        });

                    function zoomed() {
                        selection.select(".x.axis").call(xAxis);
                        heatmap.attr('x', function(d,i) {
                            return xScale(dVector[d.index].value);
                        })
                            .attr('width', function(d,i) {
                                return  calculateWidth(dVector,d,i,xScale, averageWidth) ;
                            }) ;
                        featuremap.attr('x', function(d,i) {
                            return xScale(dVector[d.index].value);
                        })
                            .attr('width', function(d,i) {
                                return  calculateWidth(dVector,d,i,xScale, averageWidth) ;
                            });
                    }


                    function calculateWidth(dataVector,currentElement,currentPosition,scale,aveWidth) {
                        var rectangleWidth;
                        var curPos = currentElement.index;
                        if ((curPos>=0)&&
                            (curPos < (dataLength-1))){
                            var f = scale(dataVector[curPos].value-dataVector[curPos+1].value);
                            rectangleWidth =  (scale(dataVector[curPos+1].value)-scale(dataVector[curPos].value));
                        } else {
                            rectangleWidth = (scale(aveWidth)-scale(0));
                        }
                        return rectangleWidth;



                    }




                });


        };

        /***
         * And now some getter/setters...
         */

        instance.width = function(x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };

        instance.height = function(x) {
            if (!arguments.length) return height;
            height = x;
            return instance;
        };

        // May alternatively be passed in through initial Json data assignment
        instance.featureName = function(x) {
            if (!arguments.length) return featureName;
            featureName = x;
            return instance;
        };

        // May alternatively be passed in through initial Json data assignment
        instance.compoundName = function(x) {
            if (!arguments.length) return compoundName;
            compoundName = x;
            return instance;
        };

        // May alternatively be passed in through initial Json data assignment
        instance.compoundId = function(x) {
            if (!arguments.length) return compoundId;
            compoundId = x;
            return instance;
        };


        // May alternatively be passed in through initial Json data assignment
        instance.fromFeaturePage = function(x) {
            if (!arguments.length) return fromFeaturePage;
            fromFeaturePage = x;
            return instance;
        };


        instance.selectionIdentifier = function(x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };

        instance.closingPopUpCallback = function(x) {
            if (!arguments.length) return closingPopUpCallback;
            closingPopUpCallback = x;
            return instance;
        };

        instance.clickCallback = function(x) {
            if (!arguments.length) return clickCallback;
            clickCallback = x;
            return instance;
        };

        instance.activatePopUpClose = function(){
            closingPopUpCallback ();
            return instance;
        }

        return instance;
    };



})();