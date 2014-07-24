<%--
  Created by IntelliJ IDEA.
  User: balexand
  Date: 5/6/13
  Time: 11:37 AM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <title>Zeo + Crossfilter</title>

    <script src="../js/crossfilter.min.js"></script>
    <script src="../js/d3.min.js"></script>
    <script src="../js/zerofilter.js"></script>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'zerofilter.css')}" />

    <style>
    @import url(http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz:400,700);
    </style>
</head>
<body>
<div id="body">
    <!--
   <a href="javascript:filter([null, [100, 150], null, null])">arrival delay</a>?
   <a href="javascript:filter([null, null, [1700, 2000], null])">longer</a>
   <a href="javascript:filter([null, null, [0, 300], null])">shorter</a>
   <a href="javascript:filter([null, [80, 150], null, [new Date(2001, 0, 12), new Date(2001, 0, 13)]])">January 12</a>
   <a href="javascript:filter([null, null, null, [new Date(2001, 0, 27), new Date(2001, 0, 29)]])">weekends</a>
   <a href="javascript:filter([null, null, null, [new Date(2001, 0, 29), new Date(2001, 1, 3)]])">weekdays</a>
   <a href="javascript:filter([[4, 7], null, null, null])">mornings</a>
   <a href="javascript:filter([[21, 24], null, null, null])">nights</a>
   -->

    <div id="charts">
        <div id="pillow-chart" class="chart">
            <div class="title">Head-to-pillow time</div>
        </div>

        <div id="wake-chart" class="chart">
            <div class="title">Wake-up time</div>
        </div>

        <div id="hours-chart" class="chart">
            <div class="title">Hours of sleep</div>
        </div>

        <div id="awakenings-chart" class="chart">
            <div class="title">Awakenings</div>
        </div>

        <div id="weekday-chart" class="chart">
            <div class="title">Day of week</div>
        </div>

        <div id="zq-chart" class="chart">
            <div class="title">ZQ score</div>
        </div>

        <div id="date-chart" class="chart">
            <div class="title">Date</div>
        </div>
    </div>

    <aside id="totals"><span id="active">-</span> of <span id="total">-</span> nights selected.</aside>

    <div id="lists">
        <div id="night-list" class="list"></div>
    </div>
</div>
</body>
</html>
