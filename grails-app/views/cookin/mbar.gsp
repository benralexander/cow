<!DOCTYPE html>
<html>
<head>
    <title>Dsnap - Charts</title>
    <meta name="layout" content="core"/>
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'doseResponse.css')}" type="text/css">
    <g:javascript src="d3.js"/>
    <style>
    #xaxis .domain {
        fill:none;
        stroke:#000;
    }
    #xaxis text, #yaxis text {
        font-size: 12px;
    }
    </style>
</head>
<body>
<div id="wrapper">
</div>
<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script src="../js/baget/mbarchart.js" charset="utf-8"></script>
<script>
//    var categories= ['','ddd','Accessories', 'Audiophile'];
//
//    var dollars = [213,209,190];
//
//    var colors = ['#0000b4','#0082ca','#0094ff'];
//
//    var grid = d3.range(25).map(function(i){
//        return {'x1':0,'y1':0,'x2':0,'y2':480};
//    });
//
//    var tickVals = grid.map(function(d,i){
//        if(i>0){ return i*10; }
//        else if(i===0){ return "100";}
//    });
//
//    var xscale = d3.scale.linear()
//            .domain([10,250])
//            .range([0,722]);
//
//    var yscale = d3.scale.linear()
//            .domain([0,categories.length])
//            .range([0,480]);
//
//    var colorScale = d3.scale.quantize()
//            .domain([0,categories.length])
//            .range(colors);
//
//    var canvas = d3.select('#wrapper')
//            .append('svg')
//            .attr({'width':900,'height':550});
//
//    var grids = canvas.append('g')
//            .attr('id','grid')
//            .attr('transform','translate(150,10)')
//            .selectAll('line')
//            .data(grid)
//            .enter()
//            .append('line')
//            .attr({'x1':function(d,i){ return i*30; },
//                'y1':function(d){ return d.y1; },
//                'x2':function(d,i){ return i*30; },
//                'y2':function(d){ return d.y2; },
//            })
//            .style({'stroke':'#adadad','stroke-width':'1px'});
//
//    var	xAxis = d3.svg.axis();
//    xAxis
//            .orient('bottom')
//            .scale(xscale)
//            .tickValues(tickVals);
//
//    var	yAxis = d3.svg.axis();
//    yAxis
//            .orient('left')
//            .scale(yscale)
//            .tickSize(2)
//            .tickFormat(function(d,i){ return categories[i]; })
//            .tickValues(d3.range(17));
//
//    var y_xis = canvas.append('g')
//            .attr("transform", "translate(150,0)")
//            .attr('id','yaxis')
//            .call(yAxis);
//
//    var x_xis = canvas.append('g')
//            .attr("transform", "translate(150,480)")
//            .attr('id','xaxis')
//            .call(xAxis);
//
//    var chart = canvas.append('g')
//            .attr("transform", "translate(150,0)")
//            .attr('id','bars')
//            .selectAll('rect')
//            .data(dollars)
//            .enter()
//            .append('rect')
//            .attr('height',19)
//            .attr({'x':0,'y':function(d,i){ return yscale(i)+19; }})
//            .style('fill',function(d,i){ return colorScale(i); })
//            .attr('width',function(d){ return 0; });
//
//
//    var transit = d3.select("svg").selectAll("rect")
//            .data(dollars)
//            .transition()
//            .duration(1000)
//            .attr("width", function(d) {return xscale(d); });
//
//    var transitext = d3.select('#bars')
//            .selectAll('text')
//            .data(dollars)
//            .enter()
//            .append('text')
//            .attr({'x':function(d) {return xscale(d)-200; },'y':function(d,i){ return yscale(i)+35; }})
//            .text(function(d){ return d+"$"; }).style({'fill':'#fff','font-size':'14px'});
//

</script>

<div id="chart"></div>
<script type="text/javascript">
    /***
     *   the 'data' parameter provides a fair number of display options.
     *   Value: how big is the bar.  NOTE: make this 'undefined' to see no bar at all,
     *          but to continue to take up vertical space
     *   barname: text to the left of each bar
     *   barsubname: smaller text underneath the text to the left of each bar
     *   inbar: should be text in the bar, though the code seems to have lost this ability
     *   descriptor: text to the right of the number describing the bar
     *
     * @type {{value: number, barname: string, barsubname: string, barsubnamelink: string, inbar: string, descriptor: string}[]}
     */
    var data = [
                { category: 'the',
                    value: 230,
                    color: '#0000b4'},
                { category: 'faster',
                    value: 8,
                    color: '#0082ca'}
//                ,
//                { category: 'we go',
//                    value: 20,
//                    color: '#5500ca'},
//                { category: 'the',
//                    value: 190,
//                    color: '#009400'},
//                { category: 'rounder',
//                    value: 170,
//                    color: '#3394aa'} ,
//                { category: 'we get',
//                    value: 150,
//                    color: '#0000ff'}
            ],
            roomForLabels = 120,
            maximumPossibleValue = 1,
            labelSpacer = 10;

    var margin = {top: 50, right: 20, bottom: 0, left: 30},
            width = 1500 - margin.left - margin.right,
            height = 180 - margin.top - margin.bottom;


    d3.json("${createLink(controller:'cookin', action:'retrieveJson')}", function (error, json) {

        var barChart = baget.mBar()
                .width(width)
                .height(height)
                .margin(margin)
                .showGridLines (false)
                .blackTextAfterBar (true)
                .labelSpacer (labelSpacer)
                .dataHanger("#chart",data);

        d3.select("#chart").call(barChart.render);



    });

</script>



</body>
</html>