<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 6/2/13
  Time: 8:34 AM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<meta charset="utf-8">
<head>
    <meta name="layout" content="core"/>

    <style> /* set the CSS */

    body { font: 12px Arial;}

    path {
        stroke: steelblue;
        stroke-width: 2;
        fill: none;
    }

    .axis path,
    .axis line {
        fill: none;
        stroke: grey;
        stroke-width: 1;
        shape-rendering: crispEdges;
    }

    div.tooltip {					/* set the CSS for tooltip divs */
        position: absolute;			/* reference for measurement */
        text-align: center;			/* align the text to the center */
        width: 60px;					/* set the width of the rectangle */
        height: 28px;					/* set the height of the rectangle */
        padding: 2px;					/* set a border around the rectangle */
        font: 12px sans-serif;		/* set the font type for the tooltips */
        background: lightsteelblue;	/* set the colour of the rectangle */
        border: 0px;					/* turn off the border (0px) */
        border-radius: 8px;			/* set how rounded the edges of the rectangle is */
        pointer-events: none;			/* 'none' tells the mouse to ignore the rectangle */
    }

    </style>

</head>
<body>

<!-- load the d3.js library -->
<g:javascript src="d3.js" />

<div>Hello</div>
<div rel="tooltip" data-container="body" data-html="true" title="&lt;nobr&gt;R-squared : 0.9888  &lt;/nobr&gt;&lt;br /&gt;&lt;nobr&gt;percent activity : -95.5809  &lt;/nobr&gt;&lt;br /&gt;&lt;nobr&gt;activity type : Inhibitor  &lt;/nobr&gt;&lt;br /&gt;&lt;nobr&gt;efficacy : 84.0177  &lt;/nobr&gt;&lt;br /&gt;&lt;nobr&gt;QC analyst : QC\'d by Chem Div  &lt;/nobr&gt;&lt;br /&gt;&lt;nobr&gt;curve-fit class : =-1.1  &lt;/nobr&gt;&lt;br /&gt;&lt;nobr&gt;curve-fit specification : Complete curve; high efficacy  &lt;/nobr&gt;&lt;br /&gt;&lt;nobr&gt;excluded points : 0 0 0 0 0 0  &lt;/nobr&gt;&lt;br /&gt;" data-trigger="hover"><font color="#F62217"><nobr>0.282 </nobr></font></div>
<script>

    // Set the dimensions of the canvas / graph
    var	margin = {top: 30, right: 20, bottom: 30, left: 50},
            width = 600 - margin.left - margin.right,
            height = 270 - margin.top - margin.bottom;

    // Parse the date / time
    var	parseDate = d3.time.format("%d-%b-%y").parse;
    var formatTime = d3.time.format("%e %B");			// Format the date / time for tooltips


    // Set the ranges
    var	x = d3.time.scale().range([0, width]);
    var	y = d3.scale.linear().range([height, 0]);

    // Define the axes
    var	xAxis = d3.svg.axis().scale(x)
            .orient("bottom").ticks(5);

    var	yAxis = d3.svg.axis().scale(y)
            .orient("left").ticks(5);

    // Define the line
    var	valueline = d3.svg.line()
            .x(function(d) { return x(d.date); })
            .y(function(d) { return y(d.close); });

    // Define 'div' for tooltips
    var div = d3.select("body").append("div")	// declare the properties for the div used for the tooltips
            .attr("class", "tooltip")				// apply the 'tooltip' class
            .style("opacity", 0);					// set the opacity to nil

    // Adds the svg canvas
    var	svg = d3.select("body")
            .append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    // Get the data
    d3.tsv("http://localhost:8028/cow/tooltips/feedMeTsv", function(error, data) {
        data.forEach(function(d) {
            d.date = parseDate(d.date);
            d.close = +d.close;
        });

        // Scale the range of the data
        x.domain(d3.extent(data, function(d) { return d.date; }));
        y.domain([0, d3.max(data, function(d) { return d.close; })]);

        // Add the valueline path.
        svg.append("path")
                .attr("class", "line")
                .attr("d", valueline(data));

        // draw the scatterplot
        svg.selectAll("dot")
                .data(data)
                .enter().append("circle")
                .attr("r", 5)											// Made slightly larger to make recognition easier
                .attr("cx", function(d) { return x(d.date); })
                .attr("cy", function(d) { return y(d.close); })			// remove semicolon
            // Tooltip stuff after this
                .on("mouseover", function(d) {							// when the mouse goes over a circle, do the following
                    div.transition()									// declare the transition properties to bring fade-in div
                            .duration(200)									// it shall take 200ms
                            .style("opacity", .9);							// and go all the way to an opacity of .9
                    div	.html(formatTime(d.date) + "<br/>"  + d.close)	// add the text of the tooltip as html
                            .style("left", (d3.event.pageX) + "px")			// move it in the x direction
                            .style("top", (d3.event.pageY - 28) + "px");	// move it in the y direction
                })													//
                .on("mouseout", function(d) {							// when the mouse leaves a circle, do the following
                    div.transition()									// declare the transition properties to fade-out the div
                            .duration(500)									// it shall take 500ms
                            .style("opacity", 0);							// and go all the way to an opacity of nil
                });														// finis

        // Add the X Axis
        svg.append("g")
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis);

        // Add the Y Axis
        svg.append("g")
                .attr("class", "y axis")
                .call(yAxis);

    });

</script>
</body>
