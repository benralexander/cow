<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 10/13/2014
  Time: 12:26 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>simp</title>
        <meta charset="utf-8">

    <meta name="layout" content="core"/>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'styles.css')}" />
<g:javascript src="d3.js" /></head>

</head>

<body>
<div>
    <style>
    .chart-example {
        margin: 20px;
        padding: 10px;
        border: solid 1px #babdb6;
    }

    /* Chapter 2 */
    .data-item {
        border: solid 1px black;
        margin: 4px;
        padding: 4px;
        background-color: #eeeeec;
    }
    </style>
</div>

<h1 class="section-title">{{page.title}}</h1>

<h2 class="section-subtitle">Method Chaining</h2>

<div class="chart-example" id="chart-01"></div>

<script>
    // Create a simple array with three elements.
    var data = ['a', 'b', 'c'];

    // Select the container div element, create a selection for the inner
    // divs. Bind the data and append the items on enter. Append a paragraph
    // to each div and set the text attribute.
    d3.select('#chart-01').selectAll('div.data-item')
            .data(data)
            .enter()
            .append('div')
            .attr('class', 'data-item')
            .append('p')
            .html(function(d) { return d; });
</script>


<h2 class="section-subtitle">Using selection.call</h2>

<div class="chart-example" id="chart-02"></div>

<script>
    // We can use selection.call to encapsulate the div content creation logic.
    d3.select('#chart-02').selectAll('div.data-item')
            .data(data)
            .enter()
            .append('div')
            .attr('class', 'data-item')
            .call(function(selection) {
                selection.each(function(d) {
                    d3.select(this).append('p').html(d+"x");
                });
            });
</script>


<h2 class="section-subtitle">Defining the Call Argument Function</h2>

<div class="chart-example" id="chart-03"></div>

<script>
    // Initialization function
    function initDiv(selection) {
        selection.each(function(data) {
            d3.select(this).append('p')
                    .text(data+"y");
        });
    }

    // Call the initDiv function on each div.data-item element.
    d3.select('#chart-03').selectAll('div.data-item')
            .data(data)
            .enter()
            .append('div')
            .attr('class', 'data-item')
            .call(initDiv);
</script>


<h2 class="section-subtitle">Creating a SVG Element</h2>

<div class="chart-example" id="chart-04"></div>

<script>
    // SVG Dimensions
    var width = 400,
            height = 40;

    // Initialization function
    function chart(selection) {
        selection.each(function(data) {

            // Bind the data to the svg selection.
            var div = d3.select(this).attr('class', 'data-item'),
                    svg = div.selectAll('svg').data([data]),
                    svgEnter = svg.enter();

            // Create the svg element and the background rectangle.
            svgEnter.append('svg')
                    .attr('width', width)
                    .attr('height', height)
                    .append('rect')
                    .attr('width', width)
                    .attr('height', height)
                    .attr('fill', 'white');
        });
    }

    // Use the chart function to append a SVG element in each div.
    d3.select('#chart-04').selectAll('div.data-item')
            .data(data)
            .enter()
            .append('div')
            .attr('class', 'data-item')
            .call(chart);
</script>


</body>
</html>