(function() {

// Inspired by http://informationandvisualization.de/blog/box-plot
    d3.boxWhiskerPlot = function() {
        var instance={},
            width = 1,
            height = 1,
            selectionIdentifier = '',
            duration = 500,
            domain = null,
            min = Infinity,
            max = -Infinity,

        // the variables that will never be exposed
            value = Number,
            whiskers = boxWhiskers,
            quartiles = boxQuartiles,
            tickFormat = null,
            selection = {};

        //  private variable
        var tip = d3.tip()
            .attr('class', 'd3-tip')
            .offset([-10, 0])
            .html(function(d) {
                var nodeData =  d3.select(this.parentNode).datum()[d];
                return "<strong></strong> <span style='color:red'>" + nodeData.description + "</span>";
            });




        // For each small multiple…
        instance.render=function () {

            selection
             .selectAll("svg")
            .each(function(d, i) {
                d = d.sort(function(a,b){
                    return a.value - b.value;
                });
                var g = d3.select(this),
                    n = d.length;

                // Compute quartiles. Must return exactly 3 elements.
                var quartileData = d.quartiles = quartiles(d);

                // Compute whiskers. Must return exactly 2 elements, or null.
                var whiskerIndices = whiskers && whiskers.call(this, d, i),
                    whiskerData = whiskerIndices && whiskerIndices.map(function(i) { return d[i].value; });

                // Compute outliers. If no whiskers are specified, all data are "outliers".
                // We compute the outliers as indices, so that we can join across transitions!
                var outlierIndices = whiskerIndices
                    ? d3.range(0, whiskerIndices[0]).concat(d3.range(whiskerIndices[1] + 1, n))
                    : d3.range(n);
                     console.log ('number of outlierIndices(i='+i+') ='+outlierIndices.length+'.')

                // Compute the new x-scale.
                var x1 = d3.scale.linear()
                    .domain(domain && domain.call(this, d, i) || [min, max])
                    .range([height, 0]);

                // Retrieve the old x-scale, if this is an update.
                var x0 = this.__chart__ || d3.scale.linear()
                    .domain([0, Infinity])
                    .range(x1.range());

                // Stash the new scale.
                this.__chart__ = x1;

                // Note: the box, median, and box tick elements are fixed in number,
                // so we only have to handle enter and update. In contrast, the outliers
                // and other elements are variable, so we need to exit them! Variable
                // elements also fade in and out.

                // Update center line: the vertical line spanning the whiskers.
                var center = g.selectAll("line.center")
                    .data(whiskerData ? [whiskerData] : []);

                center.enter().insert("line", "rect")
                    .attr("class", "center")
                    .attr("x1", width / 2)
                    .attr("y1", function(d) {
                        return x0(d[0]);
                    })
                    .attr("x2", width / 2)
                    .attr("y2", function(d) {
                        return x0(d[1]);
                    })
                    .style("opacity", 1e-6)
                    .transition()
                    .duration(duration)
                    .style("opacity", 1)
                    .attr("y1", function(d) { return x1(d[0]); })
                    .attr("y2", function(d) { return x1(d[1]); });

                center.transition()
                    .duration(duration)
                    .style("opacity", 1)
                    .attr("y1", function(d) { return x1(d[0]); })
                    .attr("y2", function(d) { return x1(d[1]); });

                center.exit().transition()
                    .duration(duration)
                    .style("opacity", 1e-6)
                    .attr("y1", function(d) { return x1(d[0]); })
                    .attr("y2", function(d) { return x1(d[1]); })
                    .remove();

                // Update innerquartile box.
                var box = g.selectAll("rect.box")
                    .data([quartileData]);

                box.enter().append("rect")
                    .attr("class", "box")
                    .attr("x", 0)
                    .attr("y", function(d) { return x0(d[2]); })
                    .attr("width", width)
                    .attr("height", function(d) { return x0(d[0]) - x0(d[2]); })
                    .transition()
                    .duration(duration)
                    .attr("y", function(d) { return x1(d[2]); })
                    .attr("height", function(d) { return x1(d[0]) - x1(d[2]); });

                box.transition()
                    .duration(duration)
                    .attr("y", function(d) { return x1(d[2]); })
                    .attr("height", function(d) { return x1(d[0]) - x1(d[2]); });

                box.exit().remove ();

                // Update median line.
                var medianLine = g.selectAll("line.median")
                    .data([quartileData[1]]);

                medianLine.enter().append("line")
                    .attr("class", "median")
                    .attr("x1", 0)
                    .attr("y1", x0)
                    .attr("x2", width)
                    .attr("y2", x0)
                    .transition()
                    .duration(duration)
                    .attr("y1", x1)
                    .attr("y2", x1);

                medianLine.transition()
                    .duration(duration)
                    .attr("y1", x1)
                    .attr("y2", x1);

                medianLine.exit().remove ();

                // Update whiskers. These are the lines outside
                //  of the boxes, but not including text or outliers.
                var whisker = g.selectAll("line.whisker")
                    .data(whiskerData || []);

                whisker.enter().insert("line", "circle, text")
                    .attr("class", "whisker")
                    .attr("x1", 0)
                    .attr("y1", x0)
                    .attr("x2", width)
                    .attr("y2", x0)
                    .style("opacity", 1e-6)
                    .transition()
                    .duration(duration)
                    .attr("y1", x1)
                    .attr("y2", x1)
                    .style("opacity", 1);

                whisker.transition()
                    .duration(duration)
                    .attr("y1", x1)
                    .attr("y2", x1)
                    .style("opacity", 1);

                whisker.exit().transition()
                    .duration(duration)
                    .attr("y1", x1)
                    .attr("y2", x1)
                    .style("opacity", 1e-6)
                    .remove();

                // Update outliers.  These are the circles that Mark data outside of the whiskers.
                var outlier = g.selectAll("circle.outlier")
                    .data(outlierIndices, Number);



                outlier.enter().insert("circle", "text")
                    .attr("class", "outlier")
                    .attr("r", 5)
                    .attr("cx", width / 2)
                    .attr("cy", function(i) {
                        return x0(d[i].value);
                    })
                    .style("opacity", 1e-6)
                    .on('mouseover', tip.show)
                    .on('mouseout', tip.hide)
                    .transition()
                    .duration(duration)
                    .attr("cy", function(i) {
                        console.log ('enter outlier =' +d[i].value);
                        return x1(d[i].value);
                    })
                    .style("opacity", 1)
                   ;

                outlier.transition()
                    .duration(duration)
                    .attr("cy", function(i) {
                        console.log ('update outlier =' +d[i].value);
                        return x1(d[i].value);
                    })
                    .style("opacity", 1);

                outlier.exit()
                    .transition()
                    .duration(duration)
                    .attr("cy", function(i) {
                        console.log ('exit outlier =' +d[i].value);
                        return x1(d[i].value);
                    })
                    .style("opacity", 1e-6)
                    .remove();

                // Compute the tick format.
                var format = tickFormat || x1.tickFormat(8);

                // Update box ticks. These are the numbers on the
                //     sides of the box
                var boxTick = g.selectAll("text.box")
                    .data(quartileData);

                boxTick.enter().append("text")
                    .attr("class", "box")
                    .attr("dy", ".3em")
                    .attr("dx", function(d, i) { return i & 1 ? 6 : -6 })
                    .attr("x", function(d, i) { return i & 1 ? width : 0 })
                    .attr("y", x0)
                    .attr("text-anchor", function(d, i) { return i & 1 ? "start" : "end"; })
                    .text(format)
                    .transition()
                    .duration(duration)
                    .attr("y", x1);

                boxTick.transition()
                    .duration(duration)
                    .text(format)
                    .attr("y", x1);

                // Update whisker ticks. These are the numbers on the side of the whiskers.
                //
                // These are handled separately from the box
                // ticks because they may or may not exist, and we want don't want
                // to join box ticks pre-transition with whisker ticks post-.
                var whiskerTick = g.selectAll("text.whisker")
                    .data(whiskerData || []);

                whiskerTick.enter().append("text")
                    .attr("class", "whisker")
                    .attr("dy", ".3em")
                    .attr("dx", 6)
                    .attr("x", width)
                    .attr("y", x0)
                    .text(format)
                    .style("opacity", 1e-6)
                    .transition()
                    .duration(duration)
                    .attr("y", x1)
                    .style("opacity", 1);

                whiskerTick.transition()
                    .duration(duration)
                    .text(format)
                    .attr("y", x1)
                    .style("opacity", 1);

                whiskerTick.exit().transition()
                    .duration(duration)
                    .attr("y", x1)
                    .style("opacity", 1e-6)
                    .remove();
            });
            d3.timer.flush();
        }

        // Note:  this method will assign data to the DOM
        instance.assignData = function (x) {
            if (!arguments.length) return data;
            data = x;
            selection
                .selectAll("svg")
                .data(data)
                .enter()
                .append("svg")
                .attr("class", "box")
                 .attr("class", "box")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.bottom + margin.top)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
                .call(tip);

            return instance;
        };

        instance.width = function(x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };


        instance.min = function(x) {
            if (!arguments.length) return min;
            min = x;
            return instance;
        };

        instance.max = function(x) {
            if (!arguments.length) return max;
            max = x;
            return instance;
        };


        instance.domain = function(x) {
            if (!arguments.length) return instance;
            domain = x == null ? x : d3.functor(x);
            return instance;
        };

        instance.height = function(x) {
            if (!arguments.length) return height;
            height = x;
            return instance;
        };

        instance.tickFormat = function(x) {
            if (!arguments.length) return tickFormat;
            tickFormat = x;
            return instance;
        };

        instance.value = function(x) {
            if (!arguments.length) return value;
            value = x;
            return instance;
        };


        instance.whiskers = function(x) {
            if (!arguments.length) return whiskers;
            whiskers = x;
            return instance;
        };

        instance.quartiles = function(x) {
            if (!arguments.length) return quartiles;
            quartiles = x;
            return instance;
        };

        // identify the dominant element upon which we will hang this graphic
        instance.selectionIdentifier = function(x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };




        return instance;
    };

    function boxWhiskers(d) {
        return [0, d.length - 1];
    }

    function boxQuartiles(d) {
        var accumulator = [];
        d.forEach(function(x){accumulator.push(x.value)});
        return [
            d3.quantile(accumulator, .25),
            d3.quantile(accumulator, .5),
            d3.quantile(accumulator, .75)
        ];
    }

})();
