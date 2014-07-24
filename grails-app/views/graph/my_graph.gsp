<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 5/18/13
  Time: 6:19 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<meta charset="utf-8">
<style>
body {
    font: 12px Arial;
}
text.shadow {
    stroke: #fff;
    stroke-width: 2.5px;
    opacity: 0.9;
}
path {
    stroke: steelblue;
    stroke-width: 3;
    fill: none;
}
line {
    stroke: grey;
}
.axis path,
.axis line {
    fill: none;
    stroke: grey;
    stroke-width: 1;
    shape-rendering: crispEdges;
}
.grid .tick {
    stroke: lightgrey;
    opacity: 0.7;
}
.grid path {
    stroke-width: 0;
}
.area {
    fill: lightsteelblue;
    stroke-width: 0;
}
</style>

<body>
<script src="../js/d3.js"></script>
<script>

    var validator = {

        // all available checks
        types: {},

        // error messages in the current
        // validation session
        messages: [],

        // current validation config
        // name: validation type
        config: {},

        // the interface method
        // `data` is key => value pairs
        validate: function (data) {

            var i, msg, type, checker, result_ok;

            // reset all messages
            this.messages = [];

            for (i in data) {

                if (data.hasOwnProperty(i)) {

                    type = this.config[i];
                    checker = this.types[type];

                    if (!type) {
                        continue; // no need to validate
                    }
                    if (!checker) { // uh-oh
                        throw {
                            name: "ValidationError",
                            message: "No handler to validate type " + type
                        };
                    }

                    result_ok = checker.validate(data[i]);
                    if (!result_ok) {
                        msg = "Invalid value for *" + i + "*, " + checker.instructions;
                        this.messages.push(msg);
                    }
                }
            }
            return this.hasErrors();
        },

        // helper
        hasErrors: function () {
            return this.messages.length !== 0;
        }
    };



    validator.types.isNonEmpty = {
        validate: function (value) {
            return !!value;
        },
        instructions: "the value cannot be empty"
    };

    validator.types.isNumber = {
        validate: function (value) {
            return !isNaN(Number(value));
        },
        instructions: "the value can only be a valid number, e.g. 1, 3.14 or 2010"
    };

    validator.types.isAlphaNum = {
        validate: function (value) {
            return !String(value).replace(/[a-z0-9]/ig, "").length;
        },
        instructions: "the value can only contain characters and numbers, no special symbols"
    };



    validator.config = {
        first_name: 'isNonEmpty',
        age: 'isNumber',
        username: 'isAlphaNum'
    };


    var data = {
        first_name: "Super",
        last_name: "Man",
        age: "unknown",
        username: "o_O"
    };
    validator.validate(data);
    if (validator.hasErrors()) {
        console.log(validator.messages.join("\n"));
    }


</script>
<script>
    var margin = {top: 30, right: 20, bottom: 30, left: 50},
            width = 600 - margin.left - margin.right,
            height = 270 - margin.top - margin.bottom;
    var parseDate = d3.time.format("%d-%b-%y").parse;
    var x = d3.time.scale().range([0, width]);
    var y = d3.scale.linear().range([height, 0]);
    var xAxis = d3.svg.axis()
            .scale(x)
            .orient("bottom")
            .ticks(5);
    var yAxis = d3.svg.axis()
            .scale(y)
            .orient("left")
            .ticks(5);
    var area = d3.svg.area()
            .x(function(d) { return x(d.date); })
            .y0(height)
            .y1(function(d) { return y(d.close); });
    var valueline = d3.svg.line()
            .x(function (d) {
                return x(d.date);
            })
            .y(function (d) {
                return y(d.close);
            });
    var svg = d3.select("body")
            .append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top +
                    ")");
    // function for the x grid lines
    function make_x_axis() {
        return d3.svg.axis()
                .scale(x)
                .orient("bottom")
                .ticks(5)
    }
    // function for the y grid lines
    function make_y_axis() {
        return d3.svg.axis()
                .scale(y)
                .orient("left")
                .ticks(5)
    }
                // Get the data
    d3.tsv("http://localhost:8028/cow/graph/feedMeJson", function (error, data) {
        data.forEach(function (d) {
            d.date = parseDate(d.date);
            d.close = +d.close;
        });
// Scale the range of the data
        x.domain(d3.extent(data, function (d) {
            return d.date;
        }));
        y.domain([0, d3.max(data, function (d) {
            return d.close;
        })]);
        svg.append("path")
                .datum(data)
                .attr("class", "area")
                .attr("d", area);
        // Draw the x Grid lines
        svg.append("g")
                .attr("class", "grid")
                .attr("transform", "translate(0," + height + ")")
                .call(make_x_axis()
                        .tickSize(-height, 0, 0)
                        .tickFormat("")
                )
        // Draw the y Grid lines
        svg.append("g")
                .attr("class", "grid")
                .call(make_y_axis()
                        .tickSize(-width, 0, 0)
                        .tickFormat("")
                )
        svg.append("path") // Add the valueline path.
                .attr("d", valueline(data));
        svg.append("g") // Add the X Axis
                .attr("class", "x axis")
                .attr("transform", "translate(0," + height + ")")
                .call(xAxis);
        svg.append("g") // Add the Y Axis
                .attr("class", "y axis")
                .call(yAxis);
        svg.append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("x", margin.top - (height / 2))
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .attr("class", "shadow")
                .text("Price ($)");
// Add the text label for the Y axis
        svg.append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("x", margin.top - (height / 2))
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("Price ($)");
// Add the title
        svg.append("text")
                .attr("x", (width / 2))
                .attr("y", 0 - (margin.top / 2))
                .attr("text-anchor", "middle")
                .style("font-size", "16px")
                .style("text-decoration", "underline")
                .text("Price vs Date Graph");
    });
</script>
</body>
