<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 3/2/14
  Time: 8:51 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Working with Array</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
</head>

<body>

<div class="code">var array = [3, 2, 11, 7, 6, 4, 10, 8, 15]</div>

<div>d3.min => <span id="min"></span></div>
<div>d3.max => <span id="max"></span></div>
<div>d3.extent => <span id="extent"></span></div>
<div>d3.sum => <span id="sum"></span></div>
<div>d3.median => <span id="median"></span></div>
<div>d3.mean => <span id="mean"></span></div>
<div>array.sort(d3.ascending) => <span id="asc"></span></div>
<div>array.sort(d3.descending) => <span id="desc"></span></div>
<div>d3.quantile(array.sort(d3.ascending), 0.25) => <span id="quantile"></span></div>
<div>d3.bisect(array.sort(d3.ascending), 6) => <span id="bisect"></span></div>

<div class="code">
    <pre>
        var records = [
        {date: "2011-11-14T16:17:54Z", quantity: 2, total: 190, tip: 100, type: "tab"},
        {date: "2011-11-14T16:20:19Z", quantity: 2, total: 190, tip: 100, type: "tab"},
        {date: "2011-11-14T16:28:54Z", quantity: 1, total: 300, tip: 200, type: "visa"},
        {date: "2011-11-14T16:30:43Z", quantity: 2, total: 90, tip: 0, type: "tab"},
        {date: "2011-11-14T16:48:46Z", quantity: 2, total: 90, tip: 0, type: "tab"},
        {date: "2011-11-14T16:53:41Z", quantity: 2, total: 90, tip: 0, type: "tab"},
        {date: "2011-11-14T16:54:06Z", quantity: 1, total: 100, tip: 0, type: "cash"},
        {date: "2011-11-14T16:58:03Z", quantity: 2, total: 90, tip: 0, type: "tab"},
        {date: "2011-11-14T17:07:21Z", quantity: 2, total: 90, tip: 0, type: "tab"},
        {date: "2011-11-14T17:22:59Z", quantity: 2, total: 90, tip: 0, type: "tab"},
        {date: "2011-11-14T17:25:45Z", quantity: 2, total: 200, tip: 0, type: "cash"},
        {date: "2011-11-14T17:29:52Z", quantity: 1, total: 200, tip: 100, type: "visa"}
        ];

        d3.nest()
        .key(function(d){return d.type;})
        .key(function(d){return d.tip;})
        .entries(records) =>
    </pre>
</div>

<div>
    <pre id="nest"></pre>
</div>


<script type="text/javascript">
    var array = [3, 2, 11, 7, 6, 4, 10, 8, 15];

    d3.select("#min").text(d3.min(array));
    d3.select("#max").text(d3.max(array));
    d3.select("#extent").text(d3.extent(array));
    d3.select("#sum").text(d3.sum(array));
    d3.select("#median").text(d3.median(array));
    d3.select("#mean").text(d3.mean(array));
    d3.select("#asc").text(array.sort(d3.ascending));
    d3.select("#desc").text(array.sort(d3.descending));
    d3.select("#quantile").text(
            d3.quantile(array.sort(d3.ascending), 0.25)
    );
    d3.select("#bisect").text(
            d3.bisect(array.sort(d3.ascending), 6)
    );

    var records = [
        {quantity: 2, total: 190, tip: 100, type: "tab"},
        {quantity: 2, total: 190, tip: 100, type: "tab"},
        {quantity: 1, total: 300, tip: 200, type: "visa"},
        {quantity: 2, total: 90, tip: 0, type: "tab"},
        {quantity: 2, total: 90, tip: 0, type: "tab"},
        {quantity: 2, total: 90, tip: 0, type: "tab"},
        {quantity: 1, total: 100, tip: 0, type: "cash"},
        {quantity: 2, total: 90, tip: 0, type: "tab"},
        {quantity: 2, total: 90, tip: 0, type: "tab"},
        {quantity: 2, total: 90, tip: 0, type: "tab"},
        {quantity: 2, total: 200, tip: 0, type: "cash"},
        {quantity: 1, total: 200, tip: 100, type: "visa"}
    ];

    var nest = d3.nest()
            .key(function (d) { // <- A
                return d.type;
            })
            .key(function (d) { // <- B
                return d.tip;
            })
            .entries(records); // <- C

    d3.select("#nest").html(printNest(nest, ""));

    function printNest(nest, out, i) {
        if(i === undefined) i = 0;

        var tab = ""; for(var j = 0; j < i; ++j) tab += " ";

        nest.forEach(function (e) {
            if (e.key)
                out += tab + e.key + "<br>";
            else
                out += tab + printObject(e) + "<br>";

            if (e.values)
                out = printNest(e.values, out, ++i);
            else
                return out;
        });

        return out;
    }

    function printObject(obj) {
        var s = "{";
        for (var f in obj) {
            s += f + ": " + obj[f] + ", ";
        }
        s += "}";
        return s;
    }
</script>

</body>

</html>