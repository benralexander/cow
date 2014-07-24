<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 2/13/14
  Time: 12:26 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>ctrp test</title>
    <link media="all" rel="stylesheet" href="../css/ctrp/enrichmentPlot.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/d3tooltip.css">
    <link media="all" rel="stylesheet" href="../css/ctrp/doseResponse.css">
    <script src="../js/ctrp/d3.js"></script>
    <script src="../js/ctrp/enrichmentPlot.js"></script>
    <script src="../js/ctrp/d3tooltip.js"></script>
    <script src="../js/ctrp/doseResponse.js"></script>
    <script src="../js/ctrp/jquery-1.9.1.js"></script>
    <style>
    .toolTextAppearance {
        font: 20px serif;
        font-weight: bold;
        margin: 5px;
        padding: 10px;
        background: #eeeeee;
        border: 1px solid blue;
        -moz-border-radius: 15px;
        border-radius: 15px;
    }

    </style>
</head>
<body>
<h1>Enrichment plot</h1>
  <div class="heatmap"></div>
  <div class="featuremap"></div>
<div id='cdtCmpTabs-2'>

<table border="1" style="margin:10px;">
    <tr>
        <td style="padding:10px">
            Information
        </td>
        <td style="padding:10px">
            <div id="eplot1"></div>
        </td>
    </tr>
    <tr>
        <td style="padding:10px">
            Information
        </td>
        <td style="padding:10px">
            <div id="eplot2"></div>
        </td>
    </tr>
    <tr>
        <td style="padding:10px">
            Information
        </td>
        <td style="padding:10px">
            <div id="eplot3"></div>
        </td>
    </tr>
</table>
</div>
<script>

    // make up some data
    var enrichData = [];
    var fakeData = [
        {ccl:'1321N1',lineage:'central nervous system'},
        {ccl:'22Rv1',lineage:'prostate'},
        {ccl:'23132/87',lineage:'stomach'},
        {ccl:'253J',lineage:'urinary tract'},
        {ccl:'1321N1',lineage:'urinary tract'},
        {ccl:'143B',lineage:'bone'}
    ];



    ///    Each data array described the data associated with a single feature/compound combination. We should
    //      probably have the feature in combination available for display as needed.
    var numberOfBars = 9;
   for (var i = 0; i < numberOfBars; i++) {
        ///  Each data element needs to hold:
        ///    Cancer cell line name
        ///    AUC value
        ///    + A way to get to the underlying growth curve.  URL? Parameters?
        enrichData.push({ index: i,
            value:  (((i / numberOfBars)-0.5)), // AUC value
            name: fakeData [(i % fakeData.length)].ccl,  //   CCL name
            line: fakeData [(i % fakeData.length)].lineage, // Name of lineage
            link: '<a href=\'#\'>Parameter number ' +i +'</a>', // Parameter (?) get the data for this growth curve
            featureExists: (i % 3 == 0) ? 1 : 0});
    }
    // demonstrate that we can draw multiple enrichment plots simultaneously
    //var enrichArray = [enrichData, enrichData];
  //  var enrichArray = [enrichData];
    var dataForEnrichmentHeatMap1 = {
        featureName:'PDE4DIP',
        compoundName:'parbendazole',
        enrichmentData:[enrichData]
    }

    var dataForEnrichmentHeatMap2 = {
        featureName:'IGFBP5',
        compoundName:'4-methylfasudil',
        enrichmentData:[enrichData]
    }


    /***
     * Sample JSON data:
     {
     featureName:'PDE4DIP',
     compoundName:'parbendazole',
     enrichmentData:[
     {
        value:0.11,
        name:'1321N1',
        line:'central nervous system',
        link: ----not sure about this yet---,
        featureExists:1
     },
     {
        value:0.13,
        name:'22Rv1',
        line:'prostate',
        link: ----not sure about this yet---,
        featureExists:0
     }
     ]
     */


    /***
     * Realistic data: */

var realdata= {
     featureName:'STK11',
     compoundName:'10-DEBChe',
     enrichmentData:[[
     {
        featureExists:0,
        index: 0,
        line: 'lung',
        link: '#no-link',
        name:'T3M10',
        value:5.6399
     },
         {
             featureExists:0,
             index: 1,
             line: 'lung',
             link: '#no-link',
             name:'HCC2935',
             value:5.8119000000000005
         },
         {
             featureExists:1,
             index: 2,
             line: 'lung',
             link: '#no-link',
             name:'HCC4006',
             value:5.8377
         },
         {
             featureExists:0,
             index: 3,
             line: 'lung',
             link: '#no-link',
             name:'SKLU1',
             value:6.0929

         },
         {
             featureExists:true,
             index: 4,
             line: 'lung',
             link: '#no-link',
             name:'CAL12T',
             value:6.1115
         },
         {
             featureExists:0,
             index: 5,
             line: 'lung',
             link: '#no-link',
             name:'T3M10',
             value:6.2096
         },
         {
             featureExists:0,
             index: 6,
             line: 'endometrium',
             link: '#no-link',
             name:'JHUEM2',
             value:6.28780000000000
         },
         {
             featureExists:1,
             index: 7,
             line: 'lung',
             link: '#no-link',
             name:'HCC2108',
             value:6.365
         },
         {
             featureExists:0,
             index: 8,
             line: 'lung',
             link: '#no-link',
             name:'HCC1833',
             value:6.365200000000001
         },
         {
             featureExists:0,
             index: 9,
             line: 'lung',
             link: '#no-link',
             name:'HCC827',
             value:6.423
         },
         {
             featureExists:0,
             index: 10,
             line: 'lung',
             link: '#no-link',
             name:'SQ1',
             value:6.4381
         },
         {
             featureExists:0,
             index: 11,
             line: 'lung',
             link: '#no-link',
             name:'HCC1195',
             value:6.500500000000001
         },
         {
             featureExists:0,
             index: 12,
             line: 'lung',
             link: '#no-link',
             name:'HCC1359',
             value:6.6662
         },
         {
             featureExists:0,
             index: 13,
             line: 'lung',
             link: '#no-link',
             name:'CORL23',
             value:7.216200000000001
         }
     ]]
    };





    var testStubCallback = function () {

        var curves = [
            { cell_primary_name: 'OVCOR8',
                curve_baseline: 2.5,
                curve_height: 93.1,
                nominal_ec50: 26.0,
                curve_slope: -2,
                points:[
                    {cpd_pv_error: 0.1318,
                        cpd_pv_measured_value: 0.324434474079502,
                        pert_conc: 4.6096
                    },
                    {
                        cpd_pv_error: 0.16274,
                        cpd_pv_measured_value: 0.545953173554408,
                        pert_conc: 0.5762
                    },
                    {
                        cpd_pv_error: 0.16288,
                        cpd_pv_measured_value: 1.19459763383528,
                        pert_conc: 0.14404999999999998
                    }, {
                        cpd_pv_error: 0.16404,
                        cpd_pv_measured_value: 0.149170758931566,
                        pert_conc: 18.439
                    }, {
                        cpd_pv_error: 0.14105,
                        cpd_pv_measured_value: 1.08706946062705,
                        pert_conc: 0.0011254
                    }, {
                        cpd_pv_error: 0.19055,
                        cpd_pv_measured_value: 0.0668850140667255,
                        pert_conc: 36.877
                    }, {
                        cpd_pv_error: 0.13658,
                        cpd_pv_measured_value: 1.05569766581735,
                        pert_conc: 0.0022508
                    }, {
                        cpd_pv_error: 0.13569,
                        cpd_pv_measured_value: 0.290083305298151,
                        pert_conc: 9.2193
                    }, {
                        cpd_pv_error: 0.1758,
                        cpd_pv_measured_value: 0.435199909443407,
                        pert_conc: 1.1524
                    }, {
                        cpd_pv_error: 0.13312,
                        cpd_pv_measured_value: 1.0630196586361,
                        pert_conc: 0.07202599999999999
                    }, {
                        cpd_pv_error: 0.10862,
                        cpd_pv_measured_value: 1.1742602289787,
                        pert_conc: 0.036012999999999996
                    }, {
                        cpd_pv_error: 0.10774,
                        cpd_pv_measured_value: 1.00368884863886,
                        pert_conc: 0.018005999999999998
                    }, {
                        cpd_pv_error: 0.11862,
                        cpd_pv_measured_value: 1.05802786878813,
                        pert_conc: 0.0090032
                    }, {
                        cpd_pv_error: 0.16129,
                        cpd_pv_measured_value: 0.51925804315052,
                        pert_conc: 2.3048
                    }, {
                        cpd_pv_error: 0.16677,
                        cpd_pv_measured_value: 0.577750380861931,
                        pert_conc: 0.2881
                    }, {
                        cpd_pv_error: 0.12924,
                        cpd_pv_measured_value: 1.11152987671054,
                        pert_conc: 0.0045016}                ]

            }

        ];

        var chart =  d3.doseResponse()
                .displayGridLines(false)
                .xAxisLabel('log ['+'Concentration'+']')
                .yAxisLabel('Viability')
                .width('390')
                .height('380')
                .title('my title')
                .selectionIdentifier('#doseResponseFromEnrichment')
                .autoScale(false)
                .areaUnderTheCurve ([5,13]) // Shade points 5 - 13
                .x(d3.scale.log().domain([0.001, 40]))
                .y(d3.scale.linear().domain([0,1.5]));

        curves.forEach(function (series) {
            chart.addSeries(series);
        });

        chart.render();
    }

    // Where do you want your plot?
    var margin = {top: 10, right: 20, bottom: 10, left: 50},
            width = 300 - margin.left - margin.right,
            height = 100 - margin.top - margin.bottom,

    // create a  heatmap and populate it with data
    heatmapPlot  = d3.heatmap()
            .selectionIdentifier("#eplot1")
            .width(width + margin.left + margin.right)
            .height(height + margin.bottom + margin.top)
            .fromFeaturePage(true)
            .assignData(realdata)
            .clickCallback(testStubCallback);
    heatmapPlot.render();
//
    // create a  heatmap and populate it with data
    heatmapPlot = d3.heatmap()
            .selectionIdentifier("#eplot2")
            .width(width + margin.left + margin.right)
            .height(height + margin.bottom + margin.top)
            .fromFeaturePage(true)
            .assignData(dataForEnrichmentHeatMap2)
            .clickCallback(testStubCallback);
    heatmapPlot.render();

//
//    // create a  heatmap and populate it with data.
//    d3.heatmap()
//            .selectionIdentifier("#eplot3")
//            .width(width + margin.left + margin.right)
//            .height(height + margin.bottom + margin.top)
//            .assignData(dataForEnrichmentHeatMap1)
//            .render();
//


</script>
</body>
</html>