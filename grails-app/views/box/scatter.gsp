<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="layout" content="core"/>
    <title>Array as Data</title>
    %{--<link rel="stylesheet" type="text/css" href="../css/styles.css"/>--}%
    %{--<script type="text/javascript" src="../js/d3.js"></script>--}%
</head>
<body>
<link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'scatter.css')}" type="text/css">

<g:javascript src="ctrp/d3.js"/>
<g:javascript src="ctrp/scatter.js"/>
<g:javascript src="ctrp/d3tooltip.js"/>
<div id="scatterPlot1"></div>
<div id="scatterPlot2"></div>
<script>

    var margin = {top: 30, right: 20, bottom: 50, left: 70},
            width = 600 - margin.left - margin.right,
            height = 400 - margin.top - margin.bottom;

    data = [
        {mrna_expression:12.1,
            cpd_auc:3.5,
            cell_primary_name:'CALU3',
            primary_site:['colon']
//             lineage:'colon'
        },
        {mrna_expression:9.3,
            cpd_auc:3.0,
            cell_primary_name:'CALU3',
            primary_site:['colon']
//             lineage:'colon'
        },
        {mrna_expression:7.6,
            cpd_auc:3.2,
            cell_primary_name:'CALU3',
            primary_site:['lung']
//             lineage:'lung'
        },
        {mrna_expression:5.0,
            cpd_auc:3.7,
            cell_primary_name:'CALU3',
            primary_site:['lung']
//             lineage:'lung'
        },
        {mrna_expression:4.0,
            cpd_auc:3.6,
            cell_primary_name:'CALU3',
            primary_site:[]
//             lineage:'endometrium'
        },
        {mrna_expression:3,
            cpd_auc:3.8,
            cell_primary_name:'CALU3',
            primary_site:['endometrium']
 //            lineage:'endometrium'
        },
        {mrna_expression:2.2,
            cpd_auc:3.1,
            cell_primary_name:'CALU3',
            primary_site:['endometrium']
 //            lineage:'endometrium'
        },
        {mrna_expression:2.0,
            cpd_auc:3.3,
            cell_primary_name:'CALU3',
            primary_site:['endometrium']
//            lineage:'endometrium'
        }
    ];


    cbbo.scatterPlot()
            .selectionIdentifier("#scatterPlot1")
            .width (width)
            .height (height)
            .margin(margin)
            .xAxisLabel ('Navitoclax AUC')
            .yAxisLabel ('BCL2 expression level')
            .xAxisAccessor(function(d){return d.cpd_auc})
            .yAxisAccessor(function(d){return d.mrna_expression})
            .assignData (data)
            .render() ;



</script>

</body>
</html>