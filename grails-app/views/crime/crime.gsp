<!DOCTYPE html>
<meta charset="utf-8">
 <head>

     <g:javascript src="crossfilter.js" />
     <g:javascript src="d3.js" />
     <g:javascript src="dc.js" />
     <script>
         var format = d3.time.format("%Y-%m-%dT%H:%M:%S"),
                 histogramChart = dc.barChart("#histogram"),
                 data,
                 cases,
                 url = "<g:createLink controller='crime' action='data'/>", // http://localhost:8028/cow/crime/data
                 days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                 times = ["12-3 AM", "4-7 AM", "8-11 AM", "12-3 PM", "4-7 PM", "8-11 PM"],
                 colors = ['#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', "#8c564b", "#e377c2", "#7f7f7f"];

         var categories = {};
         categories["-"] = "Other";
         categories["P"] = "Property";
         categories["V"] = "Violent";
         categories["Q"] = "QoL";
         d3.csv(url, function (json) {
             json.forEach(function (d) {
                 d.date = format.parse(d.crime_date);
                 d.day = days[d.date.getDay()];
                 d.times = times[Math.floor(d.crime_date.split("T")[1].slice(0, 2) / 4)];
                 d.nCategory = categories[d.category];
             });
             zx = json;
             cases = crossfilter(json);

             volume = cases.dimension(function (d) {
                 return d3.time.day(d.date);
             });
             volumeGroup = volume.group().reduceSum(function (d) {
                 return 1;
             });

             bars = volume.group().all();

             startYear = new Date(bars[0].key.getFullYear() - 0, 1, 1);
             endYear = new Date(bars[bars.length - 1].key.getFullYear() + 1, 1, 1);

             histogramChart.width(1100)
                     .height(230)
                     .margins({top: 10, right: 50, bottom: 30, left: 40})
                     .dimension(volume)
                     .group(volumeGroup)
                     .elasticY(true)
                     .centerBar(false)
                     .gap(10)
                     .round(dc.round.floor)
                     .xUnits(d3.time.days)
                     .x(d3.time.scale().domain([d3.time.year.round(startYear), d3.time.year.round(endYear)]))
                     .renderHorizontalGridLines(true)
                     .yAxis().tickFormat(d3.format("d"));

             dc.dataTable("#data-table")
                     .dimension(volume)
                     .group(function (d) {
                         return 1;
                     })
                     .size(10)
                     .columns([
                 function (d) {
                     return d.crime_date.replace("T", " ");
                 },
                 function (d) {
                     return d.nCategory;
                 },
                 function (d) {
                     return d.primary_type;
                 },
                 function (d) {
                     return d.description;
                 },
                 function (d) {
                     return d.block;
                 },
                 function (d) {
                     return d.ward;
                 },
                 function (d) {
                     return d.case_number;
                 }])
                     .order(d3.ascending);

             //several pie charts are being drawn; this function is used
             function addPieChart(id, key, colors) {
                 nature = cases.dimension(function (d) {
                     return d[key];
                 });
                 natureGroup = nature.group().reduceSum(function (d) {
                     return 1;
                 });

                 return dc.pieChart("#" + id)
                         .width(250)
                         .height(250)
                         .transitionDuration(200)
                         .radius(120)
                         .innerRadius(30)
                         .dimension(nature)
                         .group(natureGroup)
                         .colors(colors)
                         .label(function (d) {
                             return d.data.key + ": " + d.data.value;
                         });
             }

             naturePieChart = addPieChart('naturePie', 'day', colors);
             pJudgePieChart = addPieChart('pJudgePie', 'times', colors);
             //courtPieChart = addPieChart('courtPie', 'nCategory', colors);
             dispositionPieChart = addPieChart('dispositionPie', 'nCategory', colors);

             dc.renderAll();
         });

         //creates legend
         function addBlocks(divId, colors, names) {
             var html = '<div class = "legendSpace"></div>';
             var test = document.getElementById("widthTest");
             for (var i = 0; i < names.length; i++) {
                 html = html + '<div class = "legendLine">'
                 html = html + '<div class = "colorBlock" style = "background-color:' + colors[i] + ';"></div>';
                 html = html + shortenString(names[i], 280) + '</div>';
             }
             document.getElementById(divId).innerHTML = html;
         }

         function shortenString(str, width) {
             var shortened = false;
             var printStr = str;
             while (textWidth(printStr + (shortened ? '...' : '')) > width) {
                 shortened = true;
                 printStr = printStr.slice(0, -1);
             }
             return printStr + (shortened ? '...' : '');
         }

         function textWidth(str) {
             document.getElementById("widthTest").innerHTML = str;
             return document.getElementById("widthTest").clientWidth;
         }

     </script>
     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
     <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dc.css')}" />
     <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'style.css')}" />
 </head>





<style>/* CSS */</style>
<body>

<div id = "graphs">
    <div id="histogram">
        <span id = "histTitle" class="graphTitle">Histogram</span>
        <a class="reset" href="javascript:histogramChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
        <span class="reset" style="display: none;"></span>
        <div class = "clearfix"></div>
    </div>

    <div id = "pieCharts">
        <div id = "nature"  class = "pieChartContainer">
            <div id="naturePie" class="pieChart">
                <span class="graphTitle">Day of Week</span>
                <a class="reset" href="javascript:naturePieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="naturePieBlocks">
            </div>
        </div>

        <div id = "pJudge"  class = "pieChartContainer">
            <div id="pJudgePie" class="pieChart">
                <span class="graphTitle">Time of Day</span>
                <a class="reset" href="javascript:pJudgePieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="pJudgePieBlocks">
            </div>
        </div>

        <div id = "disposition"  class = "pieChartContainer">
            <div id="dispositionPie" class="pieChart">
                <span class="graphTitle">Classification</span>
                <a class="reset" href="javascript:dispositionPieChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

            <div class = "colorBlockDiv" class="graphTitle" id="dispositionPieBlocks">
            </div>
        </div>

    </div>

</div>

<table id="data-table" class="table table-hover dc-data-table">
    <thead>
    <tr class="header">
        <th>Time</th>
        <th>Category</th>
        <th>Type</th>
        <th>Description</th>
        <th>Block</th>
        <th>Ward</th>
        <th>Case Number</th>
    </tr>
    </thead>
</table>

<div id="widthTest" class="legendLine"></div>
</body>