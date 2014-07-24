<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 5/18/13
  Time: 11:31 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Honolulu 311</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <link rel="stylesheet" type="text/css" href="../css/main_honol.css" />
</head>
<body>
<div>
    <h1>Honolulu 311</h1>
</div>

<div id="charts">
    <div id="hour-chart" class="chart">
        <div class="title">Time of Day</div>
    </div>
    <div id="type-chart" class="chart">
        <div class="title">report type</div>
    </div>
    <div id="map" class="map" >
        <div class="title">Locations</div>
    </div>
    <div id="date-chart" class="chart">
        <div class="title">Date</div>
    </div>
</div>

<aside id="totals"><span id="active">-</span> of <span id="total">-</span> Honolulu 311 reports selected.</aside>

<div id="lists">
    <div id="report-list" class="list"></div>
</div>

<script type="text/javascript" src="../js/crossfilter.min.js"></script>
<script type="text/javascript" src="../js/d3.js"></script>
<script type="text/javascript" src="../js/main_honol.js"></script>

</body>
</html>