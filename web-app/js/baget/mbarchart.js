/***
 *               --------------Bar chart--------------
 *
 * This JavaScript file should be sufficient for creating a bar chart.
 *
 * In an effort to provide more flexibility this routine can support either an ordinal vertical
 * axis (which will space the bars out for you) or else a linear vertical axis (in which case
 * you need to provide the coordinates on the y-axis to describe where every bar goes).  I incorporated
 * this switch in order to allow for grouped bar charts.  Include a "position" field in your data
 * if you want to use the linear scaling.
 *
 */



var baget = baget || {};  // encapsulating variable

(function () {

    baget.mBar = function (barChartName) {// name is optional, but allows you to clear specifically

//
//   Here's an example of the sort of data that this routine expect
//
//        var data = [
//                { value: 12,
//                    barname: 'Have T2D',
//                    barsubname: '(cases)',
//                    barsubnamelink:'http://www.google.com',
//                    inbar: '',
//                    descriptor: '(8 out of 6469)'},
//                {value: 33,
//                    barname: 'Do not have T2D',
//                    barsubname: '(controls)',
//                    barsubnamelink:'http://www.google.com',
//                    inbar: '',
//                    descriptor: '(21 out of 6364)'}
//            ],
//            roomForLabels = 120,
//            maximumPossibleValue = 100,
//            labelSpacer = 10;

        // public variables
        var data, // no defaults because we can't make a plot without some data to plot
            roomForLabels = 120,
            maximumPossibleValue = 100,
            labelSpacer = 10,
            integerValues = 0,// by default we show percentages, set value to one to show integers
            logXScale = 0,// by default go with a linear x axis.  Set value to 1 for log
            customBarColoring = 0,// by default don't color the bars differently.  Otherwise each one gets its own class
            customLegend = 0,// by default skip the legend.  Note that this legend (and legends in general) are tough to implement in a general form
            selection;   // no default because we can't make a plot without a place to put it

        // private variables
        var  instance = {},
            internalMin;

        var margin = {top: 30, right: 20, bottom: 50, left: 70},
            width = 800 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;

        instance.render = function(currentSelection) {

            var subGroupHolder  = currentSelection.selectAll('svg.chart');
            subGroupHolder
                .each(function (data, eachGroupI) {      // d3 each: d=datum, i=index

                    var categories= [];
                    var dollars = [];
                    var colors = [];

                    data.map(function(d,i){
                        categories.push(d.category);
                        dollars.push(d.dollar);
                        colors.push(d.color);
                    });

                    var grid = d3.range(25).map(function(i){
                        return {'x1':margin.left,'y1':margin.top,'x2':margin.left,'y2':height};
                    });

                    var tickVals = grid.map(function(d,i){
                        if(i>0){ return i*10; }
                        else if(i===0){ return "100";}
                    });

                    var xscale = d3.scale.linear()
                        .domain([10,250])
                        .range([margin.left,width]);

                    var yscale = d3.scale.linear()
                        .domain([0,categories.length])
                        .range([margin.top,height]);

                    var colorScale = d3.scale.quantize()
                        .domain([0,categories.length])
                        .range(colors);

                    var canvas = d3.select('#wrapper')
                        .append('svg')
                        .attr({'width':width,'height':height});

                    canvas.append('g')
                        .attr('id','grid')
                        .attr('transform','translate(150,10)')
                        .selectAll('line')
                        .data(grid)
                        .enter()
                        .append('line')
                        .attr({'x1':function(d,i){ return i*30; },
                            'y1':function(d){ return d.y1; },
                            'x2':function(d,i){ return i*30; },
                            'y2':function(d){ return d.y2; }
                        })
                        .style({'stroke':'#adadad','stroke-width':'1px'});

                    var	xAxis = d3.svg.axis();
                    xAxis
                        .orient('bottom')
                        .scale(xscale)
                        .tickValues(tickVals);

                    var	yAxis = d3.svg.axis();
                    yAxis
                        .orient('left')
                        .scale(yscale)
                        .tickSize(2)
                        .tickFormat(function(d,i){ return categories[i]; })
                        .tickValues(d3.range(17));

                    canvas.append('g')
                        .attr("transform", "translate("+margin.left+","+margin.top+")")
                        .attr('id','yaxis')
                        .call(yAxis);

                    canvas.append('g')
                        .attr("transform", "translate("+margin.left+","+(margin.top+height)+")")
                        .attr('id','xaxis')
                        .call(xAxis);

                    canvas.append('g')
                        .attr("transform", "translate("+margin.left+","+margin.top+")")
                        .attr('id','bars')
                        .selectAll('rect')
                        .data(dollars)
                        .enter()
                        .append('rect')
                        .attr('height',19)
                        .attr({'x':0,'y':function(d,i){ return (yscale(i)+19); }})
                        .style('fill',function(d,i){ return colorScale(i); })
                        .attr('width',function(d){ return 0; });


                    d3.select("svg").selectAll("rect")
                        .data(dollars)
                        .transition()
                        .duration(1000)
                        .attr("width", function(d) {return xscale(d); });

                    d3.select('#bars')
                        .selectAll('text')
                        .data(dollars)
                        .enter()
                        .append('text')
                        .attr({'x':function(d) {return xscale(d)-200; },'y':function(d,i){ return yscale(i)+35; }})
                        .text(function(d){ return d+"$"; }).style({'fill':'#fff','font-size':'14px'});


                });

        }



        instance.dataHanger = function (selectionIdentifier, data) {

            selection = d3.select(selectionIdentifier)
                .selectAll('svg.chart')
                .data([data])
                .enter()
                .append('svg')
                .attr('class', 'chart')
                .attr('width', width*1.5)
                .attr('height', height*1.4);

            return instance;
        };


        // assign data to the DOM
        instance.assignData = function (x) {
            if (!arguments.length) return data;
           // data = x;
            return instance;
        };

        instance.roomForLabels = function (x) {
            if (!arguments.length) return roomForLabels;
            roomForLabels = x;
            return instance;
        };

        instance.maximumPossibleValue = function (x) {
            if (!arguments.length) return maximumPossibleValue;
            maximumPossibleValue = x;
            return instance;
        };

        instance.labelSpacer = function (x) {
            if (!arguments.length) return labelSpacer;
            labelSpacer = x;
            return instance;
        };

        instance.margin = function (x) {
            if (!arguments.length) return margin;
            margin = x;
            return instance;
        };

        instance.width = function (x) {
            if (!arguments.length) return width;
            width = x;
            return instance;
        };

        instance.height = function (x) {
            if (!arguments.length) return height;
            height = x;
            return instance;
        };

        instance.integerValues = function (x) {
            if (!arguments.length) return integerValues;
            integerValues = x;
            return instance;
        };

        instance.logXScale = function (x) {
            if (!arguments.length) return logXScale;
            logXScale = x;
            return instance;
        };

        instance.customBarColoring = function (x) {
            if (!arguments.length) return customBarColoring;
            customBarColoring = x;
            return instance;
        };

        instance.customLegend = function (x) {
            if (!arguments.length) return customLegend;
            customLegend = x;
            return instance;
        };



        instance.selectionIdentifier = function (x) {
            if (!arguments.length) return selectionIdentifier;
            selectionIdentifier = x;
            selection = d3.select(selectionIdentifier);
            return instance;
        };

        instance.clear = function(barChartName){ // if there is a name then only clear the svg with that class
            if (typeof barChartName === 'undefined') {
                d3.select('svg').remove();
            } else {
                d3.select('svg.'+barChartName).remove();
            }

            return instance;
        };

        return instance;
    };

})();