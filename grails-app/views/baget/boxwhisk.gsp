<%--
  Created by IntelliJ IDEA.
  User: balexand
  Date: 2/18/14
  Time: 7:43 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
  <title>boxwhisk</title>
    <meta name="layout" content="core"/>
    <script src="../js/jquery-2.0.3.min.js"></script>
        %{--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>--}%
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'boxWhiskerPlot.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'clickablePopUp.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'slider.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'd3tooltip.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'scatter.css')}" type="text/css">
    <g:javascript src="ctrp/d3.js"/>
    <g:javascript src="ctrp/d3tooltip.js"/>

</head>
<!DOCTYPE html>
<meta charset="utf-8">
<script>
//    $('#imageHolder').data('compound')='999';
setWaitCursor=function(){console.log('stub setWaitCursor');};
removeWaitCursor=function(){console.log('stub removeWaitCursor');};
</script>

<body>
<table style='margin-top: 50px; border-top: 50px;'>
    <tr>
                      <td id='correlationPlotLayout'>
                          <span id='plot'></span>
                      </td>
                      <td id='correlationPlotControllers'>
                          <div class='iqmLabel'>
                              Interquartile multiplier
                          </div>
                          %{--<div id='slider'--}%
                               %{--style="border: 2px outset #ad0000;--}%
                              %{--">                          --}%
                              <div id='slider'>
                              %{--<span style="margin-left: -35px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 12px; text-decoration: underline">--}%
                                  %{--<nobr>Interquartile multiplier</nobr>--}%
                              %{--</span>--}%
                              </div>

                          %{--<div id="outlierRadiusDiv" style="border: 2px outset red; width: 131px;margin-left: 10px;">--}%
                              %{--<div class='outlierRadiusLabel' style="font-size: 10pt; margin-left:5px;padding-top:10px;  text-decoration : underline">Outlier radius:</div>--}%

                              <div id='outlierRadiusDiv' >
                                  <div class='outlierRadiusLabel'>Outlier radius:</div>
                                    <form id="outlierRadius">
                                  <table class='options'>
                                      <tr>
                                          <td>
                                              <input type="radio"  name="outlierRadius" value="1">tiny</input>
                                          </td>
                                          <td>
                                              <input type="radio"  name="outlierRadius" value="2">small</input>
                                          </td>
                                      </tr>
                                      <tr>
                                          <td>
                                              <input type="radio"  name="outlierRadius" value="4">medium</input>
                                          </td>
                                          <td>
                                              <input type="radio"  name="outlierRadius" value="6" checked>large</input>
                                          </td>
                                      </tr>
                                  </table>

                              </form>
                          </div>

                      </td>
                      <td style='margin-right: 0px;'></td>
                  </tr>





</table>

<script src="../js/baget/boxWhiskerPlot.js"></script>
<script src="../js/ctrp/scatter.js"></script>
<script src="../js/ctrp/slider.js"></script>
<div id='imageHolder'></div>
<script>
    // for stub only
    var compound = {compound_id:123456,
        compound_name:'benzaldehyde' };

    $('#imageHolder').data('compound',compound);
</script>


<script>

    var
      // these sizes referred to each individual bar in the bar whisker plot
      margin = {top: 50, right: 50, bottom: 20, left: 50},
            width = 420 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom,

    // minimum and maximum values across all bars
     globalMinimum = Infinity,
            globalMaximum = -Infinity;

    // initial value of the interquartile multiplier. Note that this value
    //  is adjustable via a UI slider
    var defaultInterquartileMultiplier = 1.5,
            maximumInterquartileMultiplier = 3,
            minimumInterquartileMultiplier = 0,
            onScreenStart = 0,
            onScreenEnd = 100;

    // build those portions of the box whisker plot that are data independent
    var chart = baget.boxWhiskerPlot()
            .width(width)
            .height(height)
            .boxWhiskerName ('3,4,5-trimethoxy benzaldehyde');


    // build a slider and attach the callback methods
    var slider = d3.slider(minimumInterquartileMultiplier,
            maximumInterquartileMultiplier,
            onScreenStart,
            onScreenEnd,
            'vertical',defaultInterquartileMultiplier,onBrushMoveDoThis,onBrushEndDoThis) ;
    onBrushMoveDoThis(minimumInterquartileMultiplier);

    // get your data
    d3.json("<g:createLink controller='box' action='retrieveBoxData'/>", function (error, json) {

        var data = [],
         stubDataGenes = [
            "MYC",
            "BRCA2",
            "STAT6",
            "PDE4DIP",
            "PDCD1",
            "LRP1"
        ];

        // loop through the data to find the global minimum/maximum
        json.forEach(function (x,i) {
                var e = Math.floor(x.Expt - 1),
                        s = x.Value,
                        e=0;
                        d = data[e];
                if (!d) d = data[e] = [{value:s,
                    description:'first value of '+s}];
                else d.push({value:s,
                             description:stubDataGenes [(i %stubDataGenes.length)]});
                if (s > globalMaximum) globalMaximum = s;
                if (s < globalMinimum) globalMinimum = s;
         });


        /***
         * Sample JSON data:
         [
             {
                value:0.8,
                description:'MYC',
             },
             {
                value:0.2,
                description:'STAT6',
             },

             {
                value:-0.3,
                description:'BRCA2',
             }
         ]
         */
        function respondToScatterData(data)  {
            var margin = {top: 80, right: 20, bottom: 50, left: 70},
                    width = 400 - margin.left - margin.right,
                    height = 400 - margin.top - margin.bottom;
            cbbo.scatterPlot()
                    .selectionIdentifier("#scatterPlot1")
                    .width (width)
                    .height (height)
                    .margin(margin)
                    .assignData (data)
                    .xAxisLabel ('Navitoclax AUC')
                    .yAxisLabel ('BCL2 expression level')
                    .yAxisAccessor(function(d){return d.value})
                    .xAxisAccessor(function(d){return d.cpd_auc})
                    .clickCallback(function(){console.log('stub clickCallback')})
                    .render() ;

        }



        var clickCallback = function (compoundId, geneName) {
                var regObj = new Object();
                regObj.cpd_id = compoundId;
                regObj.gene_primary_name = geneName;


                var res = $.ajax({
                    url: './correlationPoints',
                    type: 'post',
                    context: document.body,
                    data: JSON.stringify(regObj),
                    contentType: 'application/json',
                    async: true,
                    success: function (data) {
                        var obj = (JSON.parse(data));
                        respondToScatterData(obj.results);
                    },
                    error: function () {
                        alert('Contact message failed');
                    }
                });
            } ;

        chart
                .min(globalMinimum)
                .max(globalMaximum)
                .whiskers(iqr(defaultInterquartileMultiplier))
                .scatterDataCallback( respondToScatterData )
                .retrieveCorrelationData(clickCallback);



        d3.select('#plot').selectAll('svg.data-item')
                .data(data)
                .enter()
                .append('div')
                .attr('class', 'data-item')
                .call(chart.render);



    });






    //  The adjustment we should make every time the slider moves a little
    function onBrushMoveDoThis (value)  {
        chart.whiskers(iqr(value));
    }

    //  What to do when the slider has stopped moving
    function onBrushEndDoThis () {

        d3.select('#plot').selectAll('div.data-item')
//                .data(data)
//                .enter()
                .call(chart.render);


       //chart.render();
    }

    // Returns a function to compute the interquartile range, which is represented
    // through the whiskers attached to the quartile boxes.  Without this function the
    // whiskers will expand to cover the entire data range. With it they will
    // shrink to cover a multiple of the interquartile range.  Set the parameter
    // two zero and you'll get a box with no whiskers
    function iqr(k) {
        return function(d, i) {
            var q1 = d.quartiles[0],
                    q3 = d.quartiles[2],
                    iqr = (q3 - q1) * k,
                    i = -1,
                    j = d.length;
            while ((d[++i].value) < q1 - iqr);
            while ((d[--j].value) > q3 + iqr);
            return [i, j];
        };
    }

    $("#outlierRadius").click(function(d,x) {
        var  integerOutlierRadius = parseInt( $('input:radio[name=outlierRadius]:checked').val());
        chart.outlierRadius(integerOutlierRadius);
        d3.select('#plot').selectAll('div.data-item')
                .call(chart.render);
    }) ;

</script>
<div class="messagepop pop" id="examineCorrelation">
    <form method="post" id="new_message" action="/messages">
        <div id='scatterPlot1'></div>
        <p><a id='scatterPlotCloser' class='close' href='/'>Close window</a></p>
    </form>
</div>

<script>

</script>



</body>
</html>