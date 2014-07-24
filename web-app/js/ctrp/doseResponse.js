var cbbo = cbbo || {};

(function () {

    cbbo.doseResponse = function () {
        var _chart = {};

        var _width = 360, _height = 360,
            _margins = {top: 5, left: 55, right: 5, bottom: 40},
            _x = null,
            _y = null,
            _data = [],
            _colors = d3.scale.category10(),
            _title,
            _lineColors = d3.scale.linear()
                .domain([0, 1,2])
                .range(["black", "red", "green"]),
            _svg,
            _autoScale = true,
            _derivedXMin,
            _derivedXMax,
            _bodyG,
            _line,
            _domainMultiplier = 1.1,  // 110% of the data we get by default
            _displayGridLines,
            _areaUnderTheCurve,
            _xAxisLabel = '',
            _yAxisLabel = '',
            _selectionIdentifier,
        // private variables
            _expansionPercent = 10.0, // percent we extend beyond the min max of the raw data
            _logBaseOfFittedCurve = 1.1;// the curve we generate from the four parameters is a series of
        // straight-line segments. This exponent determines how many line segments we generate


        //  private variable
        var tip = d3.tip()
            .attr('class', 'd3-tip dose-tip')
            .style('z-index', 51)
            .offset([-10, 0])
            .html(function (d) {
                var textToPresent = "";
                if (d) {
                   textToPresent = "conc: " + d.x.toPrecision (3)+'<br\>' +
                                   "viab: "+ d.y.toPrecision (3) ;
                }
                return "<strong><span>" + textToPresent + "</span></strong> ";
            });



        _chart.render = function () {

            var previouslyExistingdoseResponseCurve = d3.select(_selectionIdentifier).selectAll("svg");
            if (previouslyExistingdoseResponseCurve) {
                previouslyExistingdoseResponseCurve.remove();
            }

            if (!_svg) { // adjust this logic if you want multiple curves on a single set of axes.
                _svg = d3.select(_selectionIdentifier).append("svg")
                    .classed('viability',true)
                    .attr("height", _height)
                    .attr("width", _width)
                    .call(tip);

                if (_autoScale){
                    autoScale(_data);
                }

                renderAxes(_svg, _displayGridLines);


                defineBodyClip(_svg);
            }

            renderBody(_svg);
        };

        /***
         * pay attention to 'lines' and 'elements'
         *
         * Find the minimum and maximum X values, calculate the range, increase it by a fixed
         *  percentage, and then calculate a linear scale to include that expanded range.         *
         * @param data
         */
        function autoScale(data) {
            // Private variables
            var xExtremesForRawValues={max:0,min:0},
                yExtremesForRawValues={max:0,min:0},
                xExtremesForCalculatedLines,
                yExtremesForCalculatedLines,
                minimumDataValue,
                maximumDataValue,
                collectExtremes = function (dataElement, extremeDetector, currentCollector) {
                    var temper;
                    if (typeof currentCollector === "undefined") {
                        currentCollector = extremeDetector(dataElement);
                    } else {
                        temper = extremeDetector(dataElement);
                        if (currentCollector.max < temper.max) {
                            currentCollector.max = temper.max;
                        }
                        if (currentCollector.min > temper.min) {
                            currentCollector.min = temper.min;
                        }
                    }
                    return  currentCollector;
                },
                /***
                 * find maximum and minimum values along the x-axis, including error bars if they exist
                 * @param incomingArray
                 * @returns {{max: undefined, min: undefined}}
                 */
                    findHorizontalExtremes = function (incomingArray) {
                    var returnValue = {max: undefined, min: undefined};
                    if ((typeof incomingArray !== "undefined") &&
                        (incomingArray.length > 0)) {
                        var tempValue;
                        returnValue.max = d3.max(incomingArray.map(function (element) {
                            return element.x
                        }));
                        returnValue.min = d3.min(incomingArray.map(function (element) {
                            return element.x
                        }));
                        tempValue = d3.max(incomingArray.map(function (element) {
                            return element.x + element.dxp
                        }));
                        if ((typeof tempValue !== "undefined") &&
                            (tempValue > returnValue.max)) {
                            returnValue.max = tempValue;
                        }
                        tempValue = d3.min(incomingArray.map(function (element) {
                            return element.x - element.dxn
                        }));
                        if ((typeof tempValue !== "undefined") &&
                            (tempValue < returnValue.min)) {
                            returnValue.min = tempValue;
                        }
                    }
                    _derivedXMin = returnValue.min;
                    _derivedXMax = returnValue.max;
                    return  returnValue;
                },
                /***
                 * find maximum and minimum values along the y-axis, including error bars if they exist
                 * @param incomingArray
                 * @returns {{max: undefined, min: undefined}}
                 */
                    findVerticalExtremes = function (incomingArray) {
                    var returnValue = {max: undefined, min: undefined};
                    if ((typeof incomingArray !== "undefined") &&
                        (incomingArray.length > 0)) {
                        var tempValue;
                        returnValue.max = d3.max(incomingArray.map(function (element) {
                            return element.y
                        }));
                        returnValue.min = d3.min(incomingArray.map(function (element) {
                            return element.y
                        }));
                        tempValue = d3.max(incomingArray.map(function (element) {
                            return element.y + element.dyp
                        }));
                        if ((typeof tempValue !== "undefined") &&
                            (tempValue > returnValue.max)) {
                            returnValue.max = tempValue;
                        }
                        tempValue = d3.min(incomingArray.map(function (element) {
                            return element.y - element.dyn
                        }));
                        if ((typeof tempValue !== "undefined") &&
                            (tempValue < returnValue.min)) {
                            returnValue.min = tempValue;
                        }
                    }
                    return  returnValue;
                },
                setXRangeBasedOnData = function (minimumValue,maximumValue) {
                    var range = maximumValue-minimumValue,
                        expandedRange = range*_domainMultiplier,
                        rangeMidpoint =  (maximumValue+minimumValue)*0.5;
                    _chart.x([(rangeMidpoint - (expandedRange*0.5)),(rangeMidpoint + (expandedRange*0.5))]);
                },
                setYRangeBasedOnData = function (minimumValue,maximumValue) {
                    var range = maximumValue-minimumValue,
                        expandedRange = range*_domainMultiplier,
                        rangeMidpoint =  (maximumValue+minimumValue)*0.5;
                    _chart.y([(rangeMidpoint - (expandedRange*0.5)),(rangeMidpoint + (expandedRange*0.5))]);

                };


            if (_x === null) {
                data.forEach(function (arrayElement) {
                        xExtremesForRawValues = collectExtremes(arrayElement.elements, findHorizontalExtremes, xExtremesForRawValues);
                        xExtremesForCalculatedLines = collectExtremes(arrayElement.lines, findHorizontalExtremes, xExtremesForCalculatedLines);
                    }
                );
                // Calculate extremes for horizontal
                maximumDataValue = d3.max([xExtremesForRawValues.max, xExtremesForCalculatedLines.max]);
                minimumDataValue = d3.min([xExtremesForRawValues.min, xExtremesForCalculatedLines.min]);
                setXRangeBasedOnData(minimumDataValue, maximumDataValue);
            }

            if (_y ===null) {
                data.forEach(function (arrayElement) {
                        yExtremesForRawValues = collectExtremes(arrayElement.elements, findVerticalExtremes, yExtremesForRawValues);
                        yExtremesForCalculatedLines = collectExtremes(arrayElement.lines, findVerticalExtremes, yExtremesForCalculatedLines);
                    }
                );
                // Calculate extremes for vertical
                maximumDataValue = d3.max([yExtremesForRawValues.max, yExtremesForCalculatedLines.max]);
                minimumDataValue = d3.min([yExtremesForRawValues.min, yExtremesForCalculatedLines.min]);
                setYRangeBasedOnData (minimumDataValue,maximumDataValue);

            }









        }


        function renderTitle (svg) {
            svg.append("text")
                .attr('id','titleBox')
                .attr('class','dsTitle')
                .attr("x", (_width / 2))
                .attr("y", (0 - (_margins.top / 2))+25)
                .attr("text-anchor", "middle")
                .text(_title);

        }


        function renderAxes(svg, displayGridLines) {
            var axesG = svg.append("g")
                .attr("class", "dsaxes");

            renderXAxis(axesG, displayGridLines);

            renderYAxis(axesG, displayGridLines);
        }

        function renderXAxis(axesG, displayGridLines) {
            var xAxis = d3.svg.axis()
                .scale(_x.range([0, quadrantWidth()]))
                .orient("bottom")
                .ticks(5,d3.format(".2g"));

            var xAxisTextGoesHere = axesG.append("g")
                .attr("class", "x dsaxis")
                .attr("transform", function () {
                    return "translate(" + xStart() + "," + yStart() + ")";
                })
                .call(xAxis);

            if ((_xAxisLabel) &&
                (_xAxisLabel)) {
                xAxisTextGoesHere
                    .append("text")
                    .attr("class", "label")
                    .attr("x", _width / 2)
                    .attr("y", _margins.bottom-5)
                    .style("text-anchor", "middle")
                    .style("font-weight", "bold")
                    .text(_xAxisLabel);
            }

            if (displayGridLines) {
                d3.selectAll("g.x g.tick")
                    .append("line")
                    .classed("dsgrid-line", true)
                    .attr("x1", 0)
                    .attr("y1", 0)
                    .attr("x2", 0)
                    .attr("y2", -quadrantHeight());
            }
        }

        function renderYAxis(axesG, displayGridLines) {
            var yAxis = d3.svg.axis()
                .scale(_y.range([quadrantHeight(), 0]))
                .orient("left");

            var yAxisTextGoesHere = axesG.append("g")
                .attr("class", "y dsaxis")
                .attr("transform", function () {
                    return "translate(" + xStart() + "," + yEnd() + ")";
                })
                .call(yAxis);

            if ((_yAxisLabel) &&
                (_yAxisLabel)) {
                yAxisTextGoesHere
                    .append("text")
                    .attr("class", "label")
                    .attr("transform", "rotate(-90)")
                    .attr("y", 0)  // works together with dy
                    .attr("dy", "-3em") // how far from the y-axis should the word appear
                    .attr("x", -_height / 2)    // how far up the y-axis
                    .style("text-anchor", "middle")
                    .style("font-weight", "bold")
                    .text(_yAxisLabel);
            }

            if (displayGridLines) {
                d3.selectAll("g.y g.tick")
                    .append("line")
                    .classed("dsgrid-line", true)
                    .attr("x1", 0)
                    .attr("y1", 0)
                    .attr("x2", quadrantWidth())
                    .attr("y2", 0);
            }
        }

        function defineBodyClip(svg) {
            var padding = 5;

            svg.append("defs")
                .append("clipPath")
                .attr("id", "body-clip_"+_selectionIdentifier)
                .append("rect")
                .attr("x", 0 - padding)
                .attr("y", 0)
                .attr("width", quadrantWidth() + 2 * padding)
                .attr("height", quadrantHeight());
        }

        function renderBody(svg) {
            if (!_bodyG)
                _bodyG = svg.append("g")
                    .attr("class", "body")
                    .attr("transform", "translate("
                        + xStart() + ","
                        + yEnd() + ")")
                    .attr("clip-path", "url(#body-clip_"+_selectionIdentifier+")");

            // the fitted lines
            renderLines();

            // the area underneath the fitted lines (approximates AUC)
            renderAreas();

            // title for the plot
            renderTitle(_svg);

            // the raw data elements
            renderElements();

            // error bars for raw elements
            renderErrorBars();
        }

        function renderLines() {
            var filteredLines = _data.filter(function(d,i){
                return (d.linesExist);
            });

            _line = d3.svg.line()
                .x(function (d) {
                    return _x(d.x);
                })
                .y(function (d) {
                    return _y(d.y);
                });

            _bodyG.selectAll("path.line")
                .data(filteredLines)
                .enter()
                .append("path")
                .style("stroke", function (d, i) {
                    return _lineColors(i);
                })
                .attr("class", "line");

            _bodyG.selectAll("path.line")
                .data(filteredLines)
                .transition()
                .attr("d", function (d) {
                    return _line(d.lines);
                });
        }


        function renderErrorBars() {

            var crossbarWidth = 5;


            /***
             * we only need to deal with points that have delta specifiers.   This method goes through the array
             * of points we might consider an pulls back a filtered array of only those points that have a particular
             * set of Delta specifiers that interest us based on orientation and direction
             *
             * @param sourceArray
             * @param orientation
             * @param direction
             * @returns {Array}
             */
            var relevantDataOnly = function (sourceArray, orientation, direction) {
                var filtered = [];
                if (orientation === 'vertical') {
                    sourceArray.forEach(function (d) {
                        if ((typeof d.dyp !== "undefined") &&
                            (direction === "up")) {
                            filtered.push(d);
                        } else if ((typeof d.dyn !== "undefined") &&
                            (direction === "down")) {
                            filtered.push(d);
                        }
                    });
                } else {
                    sourceArray.forEach(function (d) {
                        sourceArray.forEach(function (d) {
                            if ((typeof d.dxp !== "undefined") &&
                                (direction === "left")) {
                                filtered.push(d);
                            } else if ((typeof d.dxn !== "undefined") &&
                                (direction === "right")) {
                                filtered.push(d);
                            }
                        });
                    });
                }
                ;
                return filtered;
            };

            /***
             * Build a particular piece of an error bar.  This might be the centerpiece ( 'mainline' or 'crossbar',
             * as specified by portion), and is further specified by orientation and direction
             *
             * @param dataset
             * @param name
             * @param orientation
             * @param direction
             * @param portion
             * @param i
             */
            var addSegmentToErrorBar = function (dataset, name, orientation, direction, portion, i) {

                var extractOffset = function (d, orientation, direction) {
                    var offset;
                    if (orientation === 'vertical') {
                        if (direction === 'up') {
                            offset = d.dyp;
                        } else {// direction must be down
                            offset = (0 - d.dyn);
                        }
                    } else {  // orientation must be horizontal
                        if (direction === 'right') {
                            offset = d.dxp;
                        } else {// direction must be left
                            offset = (0 - d.dxn);
                        }
                    }
                    return offset;
                }

                /***
                 * Here is the meat of the error bar creation, namely the d3 enter, update, exit
                 * handling of the data (as refined by relevantDataOnly), sent in the direction
                 * as extracted by extractOffset.
                 *
                 * @type {*}
                 */
                var dataNeedingErrorBars = _bodyG.selectAll(name + i)
                    .data(relevantDataOnly(dataset, orientation, direction));

                dataNeedingErrorBars
                    .enter()
                    .append("line")
                    .attr("class", orientation + " " + portion + " _" + i);

                dataNeedingErrorBars
                    .classed('errorbar', true)
                    .attr("x1", function (d) {
                        if (orientation === 'vertical') {
                            if (portion === 'mainline') {
                                return _x(d.x);
                            } else if (portion === 'crossbar') {
                                return _x(d.x) - crossbarWidth;
                            }
                        } else { // orientation must be horizontal
                            var offset = extractOffset(d, orientation, direction);
                            if (portion === 'mainline') {
                                return _x(d.x);
                            } else if (portion === 'crossbar') {
                                return _x(d.x) - offset;
                            }
                        }
                    })
                    .attr("y1", function (d) {
                        if (orientation === 'vertical') {
                            var offset = extractOffset(d, orientation, direction);
                            if (portion === 'mainline') {
                                return _y(d.y);
                            } else if (portion === 'crossbar') {
                                return _y(d.y + offset);
                            }
                        } else { // orientation must be horizontal
                            if (portion === 'mainline') {
                                return _y(d.y);
                            } else if (portion === 'crossbar') {
                                return _y(d.y - crossbarWidth);
                            }
                        }
                    })
                    .attr("x2", function (d) {
                        if (orientation === 'vertical') {
                            if (portion === 'mainline') {
                                return _x(d.x);
                            } else if (portion === 'crossbar') {
                                return  _x(d.x) + crossbarWidth;
                            }
                        } else { // orientation must be horizontal
                            var offset = extractOffset(d, orientation, direction);
                            if (portion === 'mainline') {
                                return _x(d.x - offset);
                            } else if (portion === 'crossbar') {
                                return _x(d.x) - offset;
                            }

                        }
                    })
                    .attr("y2", function (d) {
                        if (orientation === 'vertical') {
                            var offset = extractOffset(d, orientation, direction);
                            if (portion === 'mainline') {
                                return _y(d.y + offset);
                            } else if (portion === 'crossbar') {
                                return _y(d.y + offset);
                            }
                        } else { // orientation must be horizontal
                            if (portion === 'mainline') {
                                return _y(d.y);
                            } else if (portion === 'crossbar') {
                                return _y(d.y + crossbarWidth);
                            }
                        }
                    })
                    .style("stroke", function (d) {
                        return _lineColors(i);
                    });

                dataNeedingErrorBars
                    .exit()
                    .remove();

            };


            _data.forEach(function (list, i) {

                if ((! list.elements) ||
                    (list.elements.length === 0)) {
                    console.log ('list length === 0');
                }   else {

                    addSegmentToErrorBar(list.elements, 'line.errorbar.m',
                        'vertical', 'up', 'mainline', i);
                    addSegmentToErrorBar(list.elements, 'line.errorbar.m',
                        'vertical', 'up', 'crossbar', i);

                    addSegmentToErrorBar(list.elements, 'line.errorbar.m',
                        'vertical', 'down', 'mainline', i);
                    addSegmentToErrorBar(list.elements, 'line.errorbar.m',
                        'vertical', 'down', 'crossbar', i);

                    addSegmentToErrorBar(list.elements, 'line.errorbar.c',
                        'horizontal', 'left', 'mainline', i);
                    addSegmentToErrorBar(list.elements, 'line.errorbar.c',
                        'horizontal', 'left', 'crossbar', i);

                    addSegmentToErrorBar(list.elements, 'line.errorbar.c',
                        'horizontal', 'right', 'mainline', i);
                    addSegmentToErrorBar(list.elements, 'line.errorbar.c',
                        'horizontal', 'right', 'crossbar', i);
                }

            });
        }


        function renderElements() {

            var filteredElements = _data.filter(function(d,i){
                return (d.elementsExist);
            });



            // go here to draw circles
            filteredElements.forEach(function (list, i) {
                _bodyG.selectAll("rect._" + i)
                    .data(list.elements)
                    .enter()
                    .append("rect")
                    .on('mouseover', tip.show)
                    .on('mouseout', tip.hide)
                    .attr("class", "dot _" + i);

                _bodyG.selectAll("rect._" + i)
                    .data(list.elements)
                    .style("stroke", function (d) {
                        return _lineColors(0);
                    })
                    .transition()
                    .attr("x", function (d) {
                        return (_x(d.x)-3);
                    })
                    .attr("y", function (d) {
                        return (_y(d.y)-3);
                    })
                    .attr("width", "6")
                    .attr("height", "6");
            });


            // go here to draw shapes
//            filteredElements.forEach(function (list, i) {
//                _bodyG.selectAll("path._" + i)
//                    .data(list.elements)
//                    .enter()
//                    .append("path")
//                    .attr("class", "symbol _" + i);
//
//                _bodyG.selectAll("path._" + i)
//                    .data(list.elements)
//                    .classed('cross', true)
//                    .style("stroke", function (d) {
//                        return _lineColors(i);
//                    })
//                    .style("fill", function (d) {
//                        return '#ffffff';
//                    })
//                    .transition()
//                    .attr("transform", function (d) {
//                        return "translate("
//                            + _x(d.x)
//                            + ","
//                            + _y(d.y)
//                            + ")";
//                    })
//                    .attr("d",
//                        d3.svg.symbol()
//                            .type('cross')
//                    )
//                    .on('mouseover', tip.show)
//                    .on('mouseout', tip.hide)
//                ;

//                .attr("cx", function (d) {
//                        return _x(d.x);
//                    })
//                    .attr("cy", function (d) {
//                        return _y(d.y);
//                    })
//                    .attr("r", 4.5);
//            });


        }


        function renderAreas() {
            // only looked data sets if they have a fitted curve
            var filteredLines = _data.filter(function(d,i){
                    return (d.linesExist);
                }),

            // only shade those points that fall inside the area we were told to shade
                filterXRange = function (incoming){
                    return incoming.filter( function(d,i){
                        return ((d.x>xMinimumForShading)&&(d.x<xMaximumForShading));
                    });
                },

                area = d3.svg.area()
                    .x(function (d) {
                        return _x(d.x);
                    })
                    .y0(yStart())
                    .y1(function (d) {
                        return _y(d.y);
                    }),

                xMinimumForShading,
                xMaximumForShading;

            // perform a calculation to map the indexes of points aim for shading
            //  to actual domain values.  We have to do this because we are shading
            //  under a line built with many more points than the actual raw points
            //  we were given ( since we want the curve to be smooth) but we haven't
            //  yet mapped index values into our range of X values


            // TODO: remove this sorting line after the API starts giving us values in a sorted order
            var sortedDataElements = _data[0].elements.sort(function (a,b){
                return  (a.x - b.x);
            })

            if (typeof _areaUnderTheCurve !== "undefined")   {
                if ((_areaUnderTheCurve[0] > 0) &&
                    (_areaUnderTheCurve[1] < _data[0].elements.length)  &&
                    (_areaUnderTheCurve[1] > _areaUnderTheCurve[0]) ){
                    xMinimumForShading = _data[0].elements[_areaUnderTheCurve[0]].x;
                    xMaximumForShading = _data[0].elements[_areaUnderTheCurve[1]].x;
                }
            }

            _bodyG.selectAll("path.area")
                .data(filteredLines)
                .enter()
                .append("path")
                .style("fill", function (d, i) {
                    return _colors(i);
                })
                .attr("class", "area");

            _bodyG.selectAll("path.area")
                .data(filteredLines)
                .transition()
                .attr("d", function (d) {
                    return area(filterXRange(d.lines));
                });
        }


        function xStart() {
            return _margins.left;
        }

        function yStart() {
            return _height - _margins.bottom;
        }

        function xEnd() {
            return _width - _margins.right;
        }

        function yEnd() {
            return _margins.top;
        }

        function quadrantWidth() {
            return _width - _margins.left - _margins.right;
        }

        function quadrantHeight() {
            return _height - _margins.top - _margins.bottom;
        }

        _chart.displayGridLines = function (w) {
            if (!arguments.length) return _displayGridLines;
            _displayGridLines = w;
            return _chart;
        };

        _chart.xAxisLabel = function (w) {
            if (!arguments.length) return _xAxisLabel;
            _xAxisLabel = w;
            return _chart;
        };

        _chart.yAxisLabel = function (w) {
            if (!arguments.length) return _yAxisLabel;
            _yAxisLabel = w;
            return _chart;
        };

        _chart.width = function (w) {
            if (!arguments.length) return _width;
            _width = w;
            return _chart;
        };

        _chart.height = function (h) {
            if (!arguments.length) return _height;
            _height = h;
            return _chart;
        };

        _chart.margins = function (m) {
            if (!arguments.length) return _margins;
            _margins = m;
            return _chart;
        };

        _chart.colors = function (c) {
            if (!arguments.length) return _colors;
            _colors = c;
            return _chart;
        };

        _chart.x = function (x) {
            if (!arguments.length) return _x;
            _x = x;
            return _chart;
        };

        _chart.y = function (y) {
            if (!arguments.length) return _y;
            _y = y;
            return _chart;
        };

        _chart.autoScale = function (autoScale) {
            if (!arguments.length) return _autoScale;
            _autoScale = autoScale;
            return _chart;
        };

        _chart.domainMultiplier = function (domainMultiplier) {
            if (!arguments.length) return _domainMultiplier;
            _domainMultiplier = domainMultiplier;
            return _chart;
        };


        // identify the dominant element upon which we will hang this graphic
        _chart.selectionIdentifier = function (x) {
            if (!arguments.length) return _selectionIdentifier;
            _selectionIdentifier = x;
            return _chart;
        };


        // an array indicating the indices corresponding to the raw points used
        //  to calculate the area under the curve.  These will be visually represented
        //  with a shaded area
        _chart.areaUnderTheCurve = function (x) {
            if (!arguments.length) return _areaUnderTheCurve;
            _areaUnderTheCurve = x;
            return _chart;
        };


        // a block of text to describe the title of the plot
        _chart.title = function (x) {
            if (!arguments.length) return _title;
            _title = x;
            return _chart;
        };


        /***
         * Add another data set. Each additional data set will contribute both
         * a line (based on the four sigmoid line spec properties) as well as
         * a set of points intended to represent the raw data from which the line
         * is generated. The accumulation of all of these data sets will appear
         * on the same set of axes.
         *
         * Calculate the range of the calculated line based on the minimum/maximum
         * of the x/y points given plus _expansionPercent  on all sides.
         *
         * @param series
         * @returns {{}}
         */
        _chart.addSeries = function (series) {
            var generatedLine,
                elementsExist = true,
                points;
            // convert the Json field names, whatever they are, into an
            //  internal form we can depend on
            if (series.pvPoint){
                points = series.pvPoint.map(function (element){
                    var returnValue;
                    if ((element.pvError) && (element.pvError !==null)) {
                        returnValue = {
                            x: element.cpdConc,
                            y: element.pv,
                            dyp: element.pvError/2.0,
                            dyn: element.pvError/2.0
                        }
                    } else {
                        returnValue = {
                            x: element.cpdConc,
                            y: element.pv
                        };
                    }
                    return returnValue;
                });
            }
            if ((!points)   || (points.length === 0)) {
                elementsExist = false;
            } else {
                var minimumX = d3.min(points, function (d) {
                        return d.x;
                    }),
                    maximumX = d3.max(points, function (d) {
                        return d.x;
                    }),
                    minimumY = d3.min(points, function (d) {
                        return d.y;
                    }),
                    maximumY = d3.max(points, function (d) {
                        return d.y;
                    }),
                // special restriction.  X values must be nonnegative in order for the EC50 calculation
                // to be valid.  Therefore we can go ahead and increase the range, but we cannot increase
                // to include x-values smaller than zero.
                    lowXRange = minimumX,
                    highXRange = maximumX + ((maximumX - minimumX) * (_expansionPercent / 100.0)),
                    lowYRange = minimumY - ((maximumY - minimumY) * (_expansionPercent / 100.0)),
                    highYRange = maximumY + ((maximumY - minimumY) * (_expansionPercent / 100.0)),
                    linesExist = true;

                if ((series.curveBaseline===null) ||
                    (series.curveHeight===null) ||
                    (series.curveSlope===null) ||
                    (series.nominalEC50===null)) {
                    linesExist =false;
                }  else {
                    generatedLine = _chart.generateSigmoidPoints(series.curveBaseline,
                        series.curveHeight,
                        series.curveSlope,
                        series.nominalEC50,
                        _logBaseOfFittedCurve,
                        lowXRange,
                        highXRange);
                }
            }
            dataHolder = { linesExist: linesExist,
                lines: generatedLine,
                elementsExist: elementsExist,
                elements: points };
            _data.push(dataHolder);
            return _chart;
        };

        _chart.generateSigmoidPoints = function (yMin, curveHeight, hillSlope, Ec50, logBaseOfFittedCurve, xStart, xEnd) {
            var xVector = [];
            var returnValue = [];
            // first create the X factor
            var startHere = xStart*0.33;
            var endHere = xEnd*3;
            var curValue = startHere;

            while (curValue < endHere){
                xVector.push(curValue);
                curValue = curValue*logBaseOfFittedCurve;
            }
            xVector = xVector.reverse();
            // now apply x vector to the sigmoid function
            for (var i = 0; i < xVector.length; i++) {
                // sanity check.  We cannot derive a line if the X values are less than zero
                // ( strictly speaking X values less than zero are only illegal if raised to
                //  a fractional power but we're splitting hairs -- if the concentration values
                //  are less than zero and clearly something is wrong ).  Therefore every time
                //  we will avoid generating any numbers for any points unless the X values are
                // nonnegative.
                if (xVector[i] >= 0) {
                    returnValue.push({x: xVector[i],
                        y: (yMin + curveHeight / (1 + Math.pow(Math.E,((Ec50-xVector[i])* (hillSlope)))))});

                }
            }
            return returnValue;
        };

        // we will be given a data array,  a maximum value for the shading area, and then the number of points below maximum
        //  that we should consider shaded.  Convert these numbers and indexes which we can return (and which will presumably
        //  be used immediately by the areaUnderTheCurve method).
        _chart.calculateBoundsForShading = function (dataArray,maximumShadingValue,numberOfPoints) {

            // private method:
            // we need to match the value we are given with one of the array values, but the
            //  match might not be precise, therefore we need this epsilon equivalence.  Yuck.
            var almostEqual = function (a, b, epsilonAsMultiplier){
                    var allowableSpread = a*epsilonAsMultiplier,
                        lowerValue = a-allowableSpread,
                        upperValue = a+allowableSpread;
                    return (( b < upperValue)  && ( b > lowerValue));
                },
                returnValue = {maxIndex: 0,minIndex: 0};

            // now we begin the coding.  Start with some parameter checking
            if ((typeof dataArray!== "undefined") &&
                (typeof dataArray.length!== "undefined") &&
                ( dataArray.length > 0)) {

                // loop until we find the number we are trying to identify as the maximum
                for ( var concentrationIndex = 0 ; concentrationIndex <dataArray.length; concentrationIndex++){
                    if (almostEqual(maximumShadingValue,dataArray[concentrationIndex].cpdConc,.001)) {
                        returnValue.maxIndex = concentrationIndex;
                    }
                }

                // if we never found the number we were looking for then loop again and choose the first number
                //  past the maximum we been given
                if (returnValue.maxIndex === 0) {
                    for ( var concentrationIndex = 0 ; concentrationIndex <dataArray.length; concentrationIndex++){
                        if (maximumShadingValue<dataArray[concentrationIndex].cpdConc) {
                            returnValue.maxIndex = concentrationIndex;
                            break;
                        }
                    }
                }

                // if we never found the number we were looking for then choose the largest index as the default
                if (returnValue.maxIndex === 0) {
                    returnValue.maxIndex = dataArray.length;
                }

                if (returnValue.maxIndex > numberOfPoints)  {
                    returnValue.minIndex = returnValue.maxIndex - numberOfPoints;
                }

            }
            return returnValue;

        };


        // we will be given a data array and we simply need to go a little above and a little
        // below the range of the data we start this
        _chart.calculateBoundsForXAxis = function (dataArray) {

            // private method:
            // we need to match the value we are given with one of the array values, but the
            //  match might not be precise, therefore we need this epsilon equivalence.  Yuck.
            var  returnValue = {maxIndex: 0,minIndex: 0};

            // now we begin the coding.  Start with some parameter checking
            if ((typeof dataArray!== "undefined") &&
                (typeof dataArray.length!== "undefined") &&
                ( dataArray.length > 0)) {

                // get the range of the concentrations
                returnValue.max = d3.max(dataArray.map(function (element) {
                    return element.cpdConc
                }));
                returnValue.min = d3.min(dataArray.map(function (element) {
                    return element.cpdConc
                }));

                // our data and our axes are all log base 2.  Is therefore simple enough to
                //  extend the range in either direction
                returnValue.min = returnValue.min*0.25;
                returnValue.max = returnValue.max*4;

            }
            return returnValue;

        };

        return _chart;
    };


})();
