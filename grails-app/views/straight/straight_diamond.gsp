
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>ui tests</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'cow.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'styles.css')}" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <g:javascript src="crossfilter.js" />
    <g:javascript src="d3.js" />
    <g:javascript src="bootstrap.js" />
    <g:javascript src="dc.js" />
    <style>
    body {
        font: 12px Arial;
    }
    text.shadow {
        stroke: #fff;
        stroke-width: 2.5px;
        opacity: 0.9;
    }
    h1 p {
        font-family: 'Gravitas One','Arial Black';
        color: #666666;
        font-weight: normal;
        font-size: 3em;
        margin: 0;
    }
    h2{
        font-family: 'Gravitas One','Arial Black';
        color: #b1967c;
        font-weight: normal;
        font-size: 2.3em;
        margin: 0;
    }
    p   *.intro{
        color: green;
        font-family: 'Arial Black';
        font-size: 5em;
    }
    p:hover{
        color: purple;
        font-family: 'Arial Black';
        font-size: 2em;
    }
    p.intro{
        color: yellow;
        font-family: 'Arial Black';
        font-size: 5em;
    }
    </style>
    </head>
<body>

<div id="chart"></div>
%{--<h1>--}%
%{--<p>    Hi</p>--}%
%{--</h1>--}%
%{--<h2>Ho--}%
    %{--<p>    He</p>--}%
%{--</h2>--}%
<p><span class="intro">hello 1</span></p>
<p class="intro">hello 2</p>
<p><a class="intro">hello 3</a></p>
<a class="intr">hello 4</a>
<script type="text/javascript">
    var data = [ // <-A
        {expense: 10, category: "Retail"},
        {expense: 15, category: "Gas"},
        {expense: 30, category: "Retail"},
        {expense: 50, category: "Dining"},
        {expense: 80, category: "Gas"},
        {expense: 65, category: "Retail"},
        {expense: 55, category: "Gas"},
        {expense: 30, category: "Dining"},
        {expense: 20, category: "Retail"},
        {expense: 10, category: "Dining"},
        {expense: 8, category: "Gas"}
    ];

    function render(data) {
        d3.select("#chart").selectAll("div.h-bar") // <-B
                .data(data)
                .enter().append("div")
                .attr("class", "h-bar")
                .append("span");

        d3.select("#chart").selectAll("div.h-bar") // <-C
                .data(data)
                .exit().remove();

        d3.select("#chart").selectAll("div.h-bar") // <-D
                .data(data)
                .attr("class", "h-bar")
                .style("width", function (d) {
                    return (d.expense * 5) + "px";
                })
                .select("span")
                .text(function (d) {
                    return d.category;
                });
    }

    render(data);

    function load(){ // <-E
        d3.json("<g:createLink controller='straight' action='feedMeJson'/>", function(error, json){ // <-F
            data = data.concat(json);
            render(data);
        });
    }

    // define a function
    var sayHi = function (who) {
        return "Hello" + (who ? ", " + who : "") + "!";
    };
    // invoke a function
    sayHi(); // "Hello"
    sayHi('world'); // "Hello, world!"
    // apply a function
    sayHi.apply(null, ["hello"]); // "Hello, hello!"
</script>

<div class="control-group">
    <button onclick="load()">Load Data from JSON feed</button>
</div>

</body>
</html>