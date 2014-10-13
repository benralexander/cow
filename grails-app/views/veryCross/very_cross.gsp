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
<meta name="layout" content="minimal"/>




<script>

    var sharedStructures = (function () {
        var
                assayIndex = {},
                biologicalProcessPieChart,
                assayFormatPieChart,
                assayIdDimensionPieChart,
                assayTypePieChart,
                allDataDcTable,
                widgetsGoHere,
                widgetWidthWithoutSpacing=21,
                widgetHeightWithTitle=240,
                displayWidgetX=0,
                displayWidgetY=300,
                displayWidgetWidth=1000,
                displayWidgetHeight=1000,
                compressedPos = [
                    {'x': '0.5', 'y': 10},
                    {'x': '22.5', 'y': 10},
                    {'x': '44.5', 'y': 10},
                    {'x': '66.5', 'y': 10}
                ],
                expandedPos = [
                    {'x': '6', 'y': 10},
                    {'x': '37', 'y': 10},
                    {'x': '69', 'y': 10}
                ],



        // standard setters.   We need to save these variables
                setBiologicalProcessPieChart = function (localBiologicalProcessPieChart) {
                    biologicalProcessPieChart = localBiologicalProcessPieChart;
                },
                setAssayFormatPieChart = function (localAssayFormatPieChart) {
                    assayFormatPieChart = localAssayFormatPieChart;
                },
                setAssayIdDimensionPieChart = function (localAssayIdDimensionPieChart) {
                    assayIdDimensionPieChart = localAssayIdDimensionPieChart;
                },
                setAssayTypePieChart = function (localAssayTypePieChart) {
                    assayTypePieChart = localAssayTypePieChart;
                },
                setAllDataDcTable = function (localAllDataDcTable) {
                    allDataDcTable = localAllDataDcTable;
                },


        // reset these variables. These methods are called from the reset button above the pie chart managed by DC.js
                resetBiologicalProcessPieChart = function () {
                    biologicalProcessPieChart.filterAll();
                    dc.redrawAll();
                },
                resetAssayFormatPieChart = function () {
                    assayFormatPieChart.filterAll();
                    dc.redrawAll();
                },
                resetAssayIdDimensionPieChart = function () {
                    assayIdDimensionPieChart.filterAll();
                    dc.redrawAll();
                },
                resetAssayTypePieChart = function () {
                    assayTypePieChart.filterAll();
                    dc.redrawAll();
                },

        // these are our cross filter variables.
                setAssay = function (localAssay) {
                    assay = localAssay;
                },

        // these are our cross filter variables.
                setAssayIndex = function (localAssayIndex) {
                    assayIndex = localAssayIndex;
                },
                getAssayIndex = function () {
                    return assayIndex;
                },
                widgetsGoHere = function (){
                    var placementInfo = [
                        {    index: 0,
                            orig: {
                                coords: {
                                    x: compressedPos[0].x,
                                    y: compressedPos[0].y },
                                size: {
                                    width: widgetWidthWithoutSpacing,
                                    height: widgetHeightWithTitle }
                            },
                            display: {
                                coords: {
                                    x: displayWidgetX,
                                    y: displayWidgetY },
                                size: {
                                    width: displayWidgetWidth,
                                    height: displayWidgetHeight }
                            }
                        },
                        {    index: 1,
                            orig: {
                                coords: {
                                    x: compressedPos[1].x,
                                    y: compressedPos[1].y },
                                size: {
                                    width: widgetWidthWithoutSpacing,
                                    height: widgetHeightWithTitle }
                            },
                            display: {
                                coords: {
                                    x: displayWidgetX,
                                    y: displayWidgetY },
                                size: {
                                    width: displayWidgetWidth,
                                    height: displayWidgetHeight }
                            }
                        },
                        {    index: 2,
                            orig: {
                                coords: {
                                    x: compressedPos[2].x,
                                    y: compressedPos[2].y },
                                size: {
                                    width: widgetWidthWithoutSpacing,
                                    height: widgetHeightWithTitle }
                            },
                            display: {
                                coords: {
                                    x: displayWidgetX,
                                    y: displayWidgetY },
                                size: {
                                    width: displayWidgetWidth,
                                    height: displayWidgetHeight }
                            }
                        },
                        {   index: 3,
                            orig: {
                                coords: {
                                    x: compressedPos[3].x,
                                    y: compressedPos[3].y },
                                size: {
                                    width: widgetWidthWithoutSpacing,
                                    height: widgetHeightWithTitle }
                            },
                            display: {
                                coords: {
                                    x: displayWidgetX,
                                    y: displayWidgetY },
                                size: {
                                    width: displayWidgetWidth,
                                    height: displayWidgetHeight }
                            }
                        }
                    ];
                    return placementInfo;
                };


        return {

            setBiologicalProcessPieChart: setBiologicalProcessPieChart,
            resetBiologicalProcessPieChart:resetBiologicalProcessPieChart,

            setAssayFormatPieChart: setAssayFormatPieChart,
            resetAssayFormatPieChart:resetAssayFormatPieChart,

            setAssayIdDimensionPieChart: setAssayIdDimensionPieChart,
            resetAssayIdDimensionPieChart:resetAssayIdDimensionPieChart,

            setAssayTypePieChart: setAssayTypePieChart,
            resetAssayTypePieChart:resetAssayTypePieChart,

            setAllDataDcTable:setAllDataDcTable,  //no reset needed – table is read only

            getAssayIndex: getAssayIndex,
            setAssayIndex: setAssayIndex,

            setAssay:setAssay,

            widgetsGoHere:widgetsGoHere
        };
    }());  // sharedStructures


</script>




    <title>Linked pies</title>
<g:javascript src="jquery-2.0.3.min.js" />
<g:javascript src="crossfilter.js" />
<g:javascript src="d3.js" />
<g:javascript src="bootstrap.js" />
<g:javascript src="dc.js" />

<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'dc.css')}" />
<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'bootstrap.css')}" />
    <style>
    body{
        margin: 0 auto;
        max-width: 1400px;
    }

    .pieChart{
        position: relative;
    }
    .legendLine{
        line-height: 250%;
    }

    #graphs{

    }

    #pieCharts{
        position: absolute;
        width: 100%;
        height: 300px;
        left: 0px;
        top: 0px;
    }
    .pieChartContainer{
        position: absolute;
        /*border:  2px solid black;*/
        /*padding-left: 5px;*/

        border-radius: 8px;
        -moz-border-radius: 8px;
        -webkit-border-radius: 8px;
    }
    #widthTest{
        position: absolute;
        visibility: hidden;
        height: auto;
        width: auto;
    }

    .graphTitle{
        font-size: 130%;
        font-weight: 700;
    }

    .expandedGraphTitle{
        font-size: 160%;
        font-weight: 900;
        position: absolute;
    }


    /*table#data-table td, th  {*/
        /*text-align: left;*/
        /*margin: 0;*/
        /*outline: 0 none;*/
        /*list-style: none;*/
        /*border-spacing: 0px;*/
        /*border-bottom: 1px solid #6C6C6C;*/
        /*font-family: 'Open Sans';*/
        /*font-size: 18px;*/
        /*font-weight: bold;*/
        /*max-height: 20px;*/
        /*width: 97px;*/
    /*}*/


    table{
        clear: both;
        /*display: block;*/
        display: table;
        min-width: 100%;
        max-width: 1100px;
        font-family: 'Cabin';
        font-size: 14pt;
        border: 1px solid #6C6C6C;
        margin-top: 0;
        margin-left: 0px;
        border-spacing: 0px;
    }
    table#data-table tr:first-child td {
        height: 0;
        padding: 0;
    }
    .expandButton{
        float: right;
        border: 1px solid #5d9046;
        background: #67AA25;
        color: #fff;
        font-family: Arial, Helvetica, Sans-Serif;
        text-decoration: none;
        width: 70px;
        font-size: 10px;
        font-weight: bold;
        padding-right: 0px;
        padding-bottom: 0px;
        margin-right: 0px;
        margin-bottom: 0px;
        right: 0px;
        top: 0px;
        text-align: center;
        display: block;
        border-radius: 4px;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;
        text-shadow: 1px 1px 1px #666;
        -moz-box-shadow: 0 1px 3px #111;
        -webkit-box-shadow: 0 1px 3px #111;
        box-shadow: 0 1px 3px #111;
        background: #3F8EB5; /* old browsers */
        background: -moz-linear-gradient(top, #3F8EB5 0%, #1D76A0 100%); /* firefox */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#3F8EB5), color-stop(100%,#1D76A0)); /* webkit */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3F8EB5', endColorstr='#1D76A0',GradientType=0 );
    }
    .drillLabel {
        font-family: Arial, Helvetica, Sans-Serif;
        text-decoration: none;
        width: auto;
        font-size: 16px;
        font-weight: bold;
    }
    .drill{
        /*float: left;*/
        border: 1px solid #000000;
        background: #ccc;
        color: #000;
        font-family: Arial, Helvetica, Sans-Serif;
        text-decoration: none;
        width: auto;
        font-size: 14px;
        padding-left: 10px;
        padding-right: 10px;
        margin-left: 10px;
        margin-right: 10px;
        text-align: center;
        display: block;
    }
    .resetDrillButtons{
        position: absolute;
        padding-left: 5px;
    }
    .contractButton{
        position:relative;
        float: right;
        border: 1px solid #5d9046;
        background: #67AA25;
        color: #fff;
        font-family: Arial, Helvetica, Sans-Serif;
        text-decoration: none;
        width: 150px;
        font-size: 14px;
        vertical-align: top;
        font-weight: bold;
        padding-right: 0px;
        padding-top: 0px;
        margin-right: 0px;
        margin-top: 0px;
        right: 0px;
        bottom: 0px;
        text-align: center;
        display: block;
        border-radius: 4px;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;
        text-shadow: 1px 1px 1px #666;
        -moz-box-shadow: 0 1px 3px #111;
        -webkit-box-shadow: 0 1px 3px #111;
        box-shadow: 0 1px 3px #111;
        background: #3F8EB5; /* old browsers */
        background: -moz-linear-gradient(top, #3F8EB5 0%, #1D76A0 100%); /* firefox */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#3F8EB5), color-stop(100%,#1D76A0)); /* webkit */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3F8EB5', endColorstr='#1D76A0',GradientType=0 );
        z-index: 10;
    }


    #sunburstplaceholder {
        font-family:  sans-serif;
        font-size: 12px;
        margin: auto;
        position: relative;
    }
    #sunburstdiv {
        font-family: sans-serif;
        font-size: 12px;
        position: relative;
    }
    #molstruct {
        position: absolute;
        width: 150px;
        height: 150px;
        left: 375px;
        top: 485px;
    }

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

    .legend {
        font: 14px sans-serif;
        font-weight: bold;
    }

    .legendExplanation {
        font: 14px sans-serif;
        font-weight: normal;
        padding-top: 10px;
        padding-bottom: 15px;
        padding-left: 12px;
        padding-right: 12px;
    }

    .legendHolder {
        border: 3px solid black;
        font: 12px sans-serif;
        font-weight: bold;
        text-align: center;
        background: #eeeeee;
        width: 160px;
    }
    .indicateZoomIn {
        cursor:crosshair;
        cursor:-webkit-zoom-in;
        cursor:-moz-zoom-in;
    }
    .indicateZoomOut {
        cursor:crosshair;
        cursor:-webkit-zoom-out;
        cursor:-moz-zoom-out;
    }
    .indicateNoZoomingPossible {
        cursor:auto;
    }

    .bordered {
        border: solid #ccc 1px;
        -moz-border-radius: 6px;
        -webkit-border-radius: 6px;
        border-radius: 6px;
        -webkit-box-shadow: 0 1px 1px #ccc;
        -moz-box-shadow: 0 1px 1px #ccc;
        box-shadow: 0 1px 1px #ccc;
    }

    .bordered tr:hover {
        background: #fbf8e9;
        -o-transition: all 0.1s ease-in-out;
        -webkit-transition: all 0.1s ease-in-out;
        -moz-transition: all 0.1s ease-in-out;
        -ms-transition: all 0.1s ease-in-out;
        transition: all 0.1s ease-in-out;
    }

    .bordered td, .bordered th {
        border-left: 2px solid #111;
        border-top: 1px solid #111;
        padding: 4px;
        text-align: left;
        margin: 0;
        outline: 0 none;
        list-style: none;
        border-spacing: 0px;
        border-bottom: 1px solid #6C6C6C;
        font-family: 'Open Sans';
        font-size: 18px;
        font-weight: normal;
        max-height: 20px;
        }



    .bordered th {
        background-color: #dce9f9;
        background-image: -webkit-gradient(linear, left top, left bottom, from(#ebf3fc), to(#dce9f9));
        background-image: -webkit-linear-gradient(top, #ebf3fc, #dce9f9);
        background-image:    -moz-linear-gradient(top, #ebf3fc, #dce9f9);
        background-image:     -ms-linear-gradient(top, #ebf3fc, #dce9f9);
        background-image:      -o-linear-gradient(top, #ebf3fc, #dce9f9);
        background-image:         linear-gradient(top, #ebf3fc, #dce9f9);
        -webkit-box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
        -moz-box-shadow:0 1px 0 rgba(255,255,255,.8) inset;
        box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
        border-top: none;
        padding: 10px;
        text-shadow: 0 1px 0 rgba(255,255,255,.5);
        color: #111111;
        font-weight: 200;
        font-size: 120%;
    }


    .bordered td:first-child, .bordered th:first-child {
        border-left: none;
    }

    .bordered th:first-child {
        -moz-border-radius: 6px 0 0 0;
        -webkit-border-radius: 6px 0 0 0;
        border-radius: 6px 0 0 0;
    }

    .bordered th:last-child {
        -moz-border-radius: 0 6px 0 0;
        -webkit-border-radius: 0 6px 0 0;
        border-radius: 0 6px 0 0;
    }

    .bordered th:only-child{
        -moz-border-radius: 6px 6px 0 0;
        -webkit-border-radius: 6px 6px 0 0;
        border-radius: 6px 6px 0 0;
    }

    .bordered tr:last-child td:first-child {
        -moz-border-radius: 0 0 0 6px;
        -webkit-border-radius: 0 0 0 6px;
        border-radius: 0 0 0 6px;
    }

    .bordered tr:last-child td:last-child {
        -moz-border-radius: 0 0 6px 0;
        -webkit-border-radius: 0 0 6px 0;
        border-radius: 0 0 6px 0;
    }
    .bordered tr:nth-child(odd) {
        background: #f0ffff;
        }

    .bordered tr:nth-child(even) {
        background: #FFF;
        }


    .bordered tr:hover {
        background-color: #cff;
        }

    .columnsAssociatedWithPies {

    }




    </style>

<script>
   // linkedVizData.js
    var linkedVizData = (function () {


        /***
         * First we have code that attempts to validate the data we receive before going any further.  This code
         * is built around abstract definitions that are later received various implementations in accordance
         * with the 'Strategy' pattern.
         *
         * @type {{types: {}, messages: Array, config: {}, validate: Function, hasErrors: Function}}
         */
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
        // make sure that every element inside the category group passes some basic tests
        validator.types.categoryCheck = {
            validate: function (value) {
                var returnVal = true;
                if (value.length != 4) {
                    returnVal = false;
                }
                if (returnVal) {
                    for (var loopCount = 0; loopCount < value.length; loopCount++) {
                        if (returnVal) {
                            returnVal = !isNaN(Number(value[loopCount].CatIdx));
                        }
                        if (returnVal) {
                            returnVal = !String(value[loopCount].CatName).replace(/[a-z0-9\s]/ig, "").length;
                        }
                        if (returnVal) {
                            returnVal = !String(value[loopCount].CatDescr).replace(/[a-z0-9\s]/ig, "").length;
                        }
                        if (returnVal) {
                            returnVal = !String(value[loopCount].CatIdentity).replace(/[a-z0-9_]/ig, "").length;
                        }
                    }
                }
                return returnVal;
            },
            instructions: "failed core category check"
        };
        // make sure that every element inside the hierarchy group passes some basic tests
        validator.types.hierarchyCheck = {
            validate: function (value) {
                var returnVal = true;
                if (value.length != 4) {
                    returnVal = false;
                }
                if (returnVal) {
                    for (var loopCount = 0; loopCount < value.length; loopCount++) {
                        if (returnVal) {
                            returnVal = !isNaN(Number(value[loopCount].CatRef));
                        }
                        if (returnVal) {
                            returnVal = ((value[loopCount].HierType === 'Graph') ||
                                    (value[loopCount].HierType === 'Tree'));
                        }
                    }
                }
                return returnVal;
            },
            instructions: "failed core hierarchy check"
        };
        // make sure that every element inside the hierarchy group passes some basic tests
        validator.types.assayCheck = {
            validate: function (value) {
                var returnVal = true;

                if (returnVal) {
                    for (var loopCount = 0; loopCount < value.length; loopCount++) {
                        if (returnVal) {
                            returnVal = !isNaN(Number(value[loopCount].AssayIdx));
                        }
                        if (returnVal) {
                            var currentAssayIdx = Number(value[loopCount].AssayIdx);
                            returnVal = (assayIdList.indexOf(currentAssayIdx) < 0);
                            if (!returnVal) {
                                additionalErrorInfo += ('repeated assay IDX=' + currentAssayIdx);
                            } else {
                                assayIdList.push(currentAssayIdx);
                            }
                        }
                        if (returnVal) {
                            returnVal = !String(value[loopCount].AssayName).replace(/[a-z0-9\s\'\(\)\/_:;\-\[\]\,\+\.]/ig, "").length;
                            if (!returnVal) {
                                additionalErrorInfo += ('undesirable character=' + String(value[loopCount].AssayName).replace(/[a-z0-9\s\'\(\)\/_:;\-\[\]\,\+\.]/ig, ""));
                            }
                        }
                        if (!returnVal) alert(value[loopCount].AssayName);
                        if (returnVal) {
                            returnVal = !isNaN(Number(value[loopCount].AssayId));
                        }
                        if (!returnVal) {
                            break;
                        }

                    }

                }
                return returnVal;
            },
            instructions: "failed core assay check"
        };
        // make sure that every element inside the hierarchy group passes some basic tests
        validator.types.assayCrossCheck = {
            validate: function (value) {
                var returnVal = true;
                if (returnVal) {
                    for (var loopCount = 0; loopCount < value.length; loopCount++) {
                        if (returnVal) {
                            var assayReferenceNumber = Number(value[loopCount].AssayRef);
                            returnVal = !isNaN(assayReferenceNumber);
                            if (assayIdList.indexOf(assayReferenceNumber) < 0) {
                                returnVal = false;
                            }
                        }
                        if (!returnVal) {
                            break;
                        }

                    }

                }
                return returnVal;
            },
            instructions: "failed core assay check"
        };


        validator.config = {
            Category: 'categoryCheck',
            Hierarchy: 'hierarchyCheck',
            Assays: 'assayCheck',
            AssayCross: 'assayCrossCheck'
        };


        /***
         * Below find an assortment of data types and methods that everybody else calls upon.  'linkedData', for example,
         * is one of the highest level data structures, which is filled with incoming data and then  later drawn upon by
         * methods far and wide.
         *
         * @type {{}}
         */
        var linkedData = {},

                cidHolder = 0,

                additionalErrorInfo = "",

                assayIdList = [],

                parseData = function (incomingData) {
                    linkedData = incomingData;
                },

                numberOfWidgets = function () {
                    return linkedData.Category.length;
                },

                validateLinkedData = function () {
                    var returnVal = true;
                    validator.validate(linkedData);
                    if (validator.hasErrors()) {
                        returnVal = false;
                        var errorMessageReport = validator.messages.join("\n");
                        console.log(errorMessageReport);
                        alert(errorMessageReport);
                    }
                    return returnVal;
                },

        // try this more flexible 'getter is your setter' pattern
                cid = function (_x) {
                    if (!arguments.length) return cidHolder;
                    cidHolder = _x;
                    return this;
                },

                appendConditionalStatusFields = function () {
                    var returnVal = true;
                    // Make a way to keep track of which elements of been selected as part of the drill down, sunburst visualization
                    for (var loopCount = 0; loopCount < linkedData.Hierarchy.length; loopCount++) {
                        var hierarchyPointer = linkedData.Hierarchy[loopCount];
                        if (hierarchyPointer.HierType === 'Tree') {
                            hierarchyPointer.Structure['rootName'] = '/';
                            if ((!(hierarchyPointer.Structure === undefined)) &&
                                    (!(hierarchyPointer.Structure.struct === undefined)) &&
                                    (hierarchyPointer.Structure.struct.length > 0))
                                addAMembershipIndicator(hierarchyPointer.Structure.struct[0], loopCount);
                        } else if (hierarchyPointer.HierType === 'Graph') {
                            hierarchyPointer.Structure['rootName'] = '/';
                        }
                    }
                    // Make a way to keep track of which elements have been selected through the cross-linking, pie-based selection mechanism
                    for (var loopCount = 0; loopCount < linkedData.AssayCross.length; loopCount++) {
                        var AssayCrossPointer = linkedData.AssayCross[loopCount];
                        AssayCrossPointer ["AssaySelected"] = 1;
                    }
                    return returnVal;
                },
                findAssayId = function (assayRef) {
                    // new way, which may be more robust
                    var listOfAllAssayIdxs = [];
                    for (var i = 0; i < linkedData.Assays.length; i++) {
                        listOfAllAssayIdxs.push(linkedData.Assays[i].AssayIdx);
                    }
                    var indexOfMatch = listOfAllAssayIdxs.indexOf(assayRef);
                    if (!(indexOfMatch === -1)) {
                        return linkedData.Assays[indexOfMatch].AssayId;
                    } else {
                        return -1;
                    }
                    //old way, which seemed to basically work
                    //return linkedData.Assays[assayRef].AssayId;
                },
                retrieveLinkedData = function () {
                    var developingAssayList = [];
                    var weHaveDataToDisplay = false;
                    if (!(linkedData.AssayCross === null)) {
                        var totalNumberOfAssayCrosses = linkedData.AssayCross.length;
                        for (var i = 0; i < totalNumberOfAssayCrosses; i++) {
                            if (linkedData.AssayCross[i] != null) {
                                weHaveDataToDisplay = true;
                                break;
                            }
                        }
                        if (weHaveDataToDisplay) {
                            for (var i = 0; i < totalNumberOfAssayCrosses; i++) {
                                var assayCross = linkedData.AssayCross[i];
                                if (assayCross != null) {
                                    developingAssayList.push({
                                        index: assayCross.AssayRef,
                                        assayId: findAssayId(assayCross.AssayRef),
                                        assayBId: assayCross.AssayBId,
                                        GO_biological_process_term: assayCross.data[0],
                                        assay_format: assayCross.data[1],
                                        assay_type: assayCross.data[2],
                                        protein_target: assayCross.data[3]
                                    });
                                }
                            }
                        }
                    }
                    return  developingAssayList;
                },


                retrieveCurrentHierarchicalData = function (datatypeIndex) {
                    var returnValue = {}; // this will be the current node in the tree
                    var currentRootName = linkedData.Hierarchy[datatypeIndex].Structure.rootName;
                    var currentRootNode = linkedData.Hierarchy[datatypeIndex].Structure.struct;
                    returnValue = findNodeInTreeByName(currentRootNode[0], currentRootName);
                    if (returnValue === undefined) {
                        alert(' problem: could not find node named ' + currentRootName + '.')
                    } else {
                        return returnValue;
                    }
                },


                /***
                 *  Exhaustive recursive descent. We do this one at the beginning to add both a
                 *  membership  indicator ( which gets set on an off pending on what the user clicks )
                 *  and a tree identifier ( since we have multiple sunburst trees and we need to be
                 *  able to tell them apart in the click handler )
                 */
                        addAMembershipIndicator = function (currentNode, treeIdentifier) {
                    if (!(currentNode.children === undefined)) {
                        for (var i = 0; i < currentNode.children.length; i++) {
                            addAMembershipIndicator(currentNode.children[i], treeIdentifier);
                            currentNode["member"] = 1;
                            currentNode["treeid"] = treeIdentifier;
                        }
                    } else {
                        currentNode["member"] = 1;
                        currentNode["treeid"] = treeIdentifier;
                    }
                },


                /***
                 *  Exhaustive recursive descent.  set the membership of every node at or below the current node
                 *  to 'value'
                 */
                        setMembershipIndicatorToValue = function (currentNode, value) {
                    if (!(currentNode.children === undefined)) {
                        for (var i = 0; i < currentNode.children.length; i++) {
                            setMembershipIndicatorToValue(currentNode.children[i], value);
                            currentNode.member = value;
                        }
                    } else {
                        currentNode.member = value;
                    }
                },

                /***
                 * Abortive recursive descent.  This time we are looking for particular node, which
                 * we identify by matching its name against a given string. Once we find node then
                 * abort the descent and don't look any further
                 */
                        findNodeInTreeByName = function (currentNode, nameWeAreLookingFor) {
                    if (currentNode.name === nameWeAreLookingFor) {
                        return   currentNode;
                    }
                    if (!(currentNode.children === undefined)) {
                        for (var i = 0; i < currentNode.children.length; i++) {
                            var currentAttempt = findNodeInTreeByName(currentNode.children[i], nameWeAreLookingFor);
                            if ((!( currentAttempt === undefined)) &&
                                    ( currentAttempt.name === nameWeAreLookingFor)) {
                                return  currentAttempt;
                            }
                        }
                    }
                },

                /***
                 * Exhaustive recursive descent. In order to build the legend we need to know both the maximum
                 * and the minimum numerical values that we will use to assign colors. Therefore we need to write
                 * and calculate what the color of each node will be. We throw away all these calculated numbers
                 * (except the max and the men that we came here for) because were going to be forced to walk through
                 * the tree again anyway when it comes time to build the Sunburst, so we may as well recalculate
                 * the color value at that time.
                 *
                 * The first method ( findMinimumAndMaximumRatiosForColoring ) only exists to set up the
                 * return value that will then be used by the routine that does the recursive descent,
                 * namely findMinimumAndMaximumRatiosByWalkingTheTree.
                 */
                        findMinimumAndMaximumRatiosForColoring = function (currentNode) {
                    var returnValue = {
                        minimum: undefined,
                        maximum: undefined
                    };
                    findMinimumAndMaximumRatiosByWalkingTheTree(currentNode, returnValue);
                    return returnValue;
                },
                findMinimumAndMaximumRatiosByWalkingTheTree = function (currentNode,returnValue) {

                    // we are expecting inputs of type string
                    calcColorNumber = function (activeString, inactiveString) {
                        var actives = 0,
                                inactives = 0,
                                quotient;
                        if (!(activeString === undefined)) {
                            actives = parseInt(activeString);
                        }
                        if (!(inactiveString === undefined)) {
                            inactives = parseInt(inactiveString);
                        }
                        if ((actives + inactives) === 0) {// this shouldn't happen based on the
                            // business rules by which we select data (if this category contains no
                            // assays then we shouldn't be giving it a node), BUT if for some reason
                            // that assumption turns out to be wrong impossible happens then I'd rather
                            // catch it and return a fake value than to crash the browser.
                            quotient = 0;
                        } else {
                            quotient = actives / (actives + inactives);
                        }
                        return quotient;
                    },

                        // first parameter must be an object, the second one must be numerical
                            setTheMinimumOrMaximumAsNeeded = function (minMaxHolder, candidateValue) {
                                if (minMaxHolder === undefined)  return;// just to be ridiculously cautious...
                                // I'll do the minimum values first
                                if (minMaxHolder.minimum === undefined) {
                                    minMaxHolder.minimum = candidateValue;
                                } else if (minMaxHolder.minimum > candidateValue) {
                                    minMaxHolder.minimum = candidateValue;
                                }
                                // now do the maximum values
                                if (minMaxHolder.maximum === undefined) {
                                    minMaxHolder.maximum = candidateValue;
                                } else if (minMaxHolder.maximum < candidateValue) {
                                    minMaxHolder.maximum = candidateValue;
                                }
                            };
                    // now that we have all the private methods out of the way we can go ahead
                    //  and step through the recursive descent.
                    if (!(currentNode.children === undefined)) {
                        for (var i = 0; i < currentNode.children.length; i++) {
                            findMinimumAndMaximumRatiosByWalkingTheTree(currentNode.children[i], returnValue);
                            setTheMinimumOrMaximumAsNeeded(returnValue, calcColorNumber(currentNode.ac, currentNode.inac));
                        }
                    } else {
                        setTheMinimumOrMaximumAsNeeded(returnValue, calcColorNumber(currentNode.ac, currentNode.inac));
                    }
                },


                accumulatingAssays,
                getAssaysForActivatedNodes = function (currentNode) {
                    if (!(currentNode.children === undefined)) {
                        for (var i = 0; i < currentNode.children.length; i++) {
                            getAssaysForActivatedNodes(currentNode.children[i]);
                            if (currentNode.member === 1) {
                                if (!(currentNode.assays === undefined)) {
                                    accumulatingAssays = accumulatingAssays.concat(currentNode.assays);
                                }
                            }
                        }
                    } else {
                        if (currentNode.member === 1) {
                            if (!(currentNode.assays === undefined)) {
                                accumulatingAssays = accumulatingAssays.concat(currentNode.assays);
                            }
                        }
                    }
                },

        // Recursive descent: find a node by name
                generateUniqueListOfActivatedAssays = function (hierarchyId) {
                    accumulatingAssays = Array();
                    getAssaysForActivatedNodes(linkedData.Hierarchy[hierarchyId].Structure.struct [0]);
                    var uniqueArray = [];
                    if (accumulatingAssays.length > 0) {
                        accumulatingAssays.sort();
                        uniqueArray = accumulatingAssays.filter(function (elem, pos) {
                            return accumulatingAssays.indexOf(elem) == pos;
                        })
                    }
                    return uniqueArray;
                },

                /***
                 * This is one of the key methods that underlies the functioning of the whole visualization. When
                 * a user clicks on an arc within the hierarchy then we want to restrict the assays that are
                 * available to the pie charts. This method does it.
                 */
                        adjustMembershipBasedOnSunburstClick = function (nodeName, possibleNode, hierarchyId) {
                    // This is where we mark things as clicked!
                    var retrievedNode = findNodeInTreeByName(linkedData.Hierarchy[hierarchyId].Structure.struct [0], nodeName);
                    // First set the whole tree membership to off
                    setMembershipIndicatorToValue(linkedData.Hierarchy[hierarchyId].Structure.struct [0], 0);
                    // Now set the selected subtree to on
                    setMembershipIndicatorToValue(retrievedNode, 1);
                    // Now we need a list of all the nodes that are turned on
                    var activatedAssayList = generateUniqueListOfActivatedAssays(hierarchyId);
                    sharedStructures.getAssayIndex().filterFunction(function (d) {
                        return (activatedAssayList.indexOf(d) > -1);
                    });
                    dc.redrawAll();
                    return activatedAssayList;
                },
                filteredHierarchyData = function (hierarchyId) {
                    var originalTree = retrieveCurrentHierarchicalData(hierarchyId);
                    var listOfActiveAssays = retrieveListOfActiveAssays();
                    var revisedTree = copyThisTree(originalTree, listOfActiveAssays);
                    var activeInactiveCounts = {active: 0, inactive: 0};
                    updateActiveInactiveCounts(revisedTree, activeInactiveCounts);
                    return revisedTree;
                },
                cleanupOriginalHierarchyData = function (hierarchyId) {
                    var originalTree = retrieveCurrentHierarchicalData(hierarchyId);
                    var listOfActiveAssays = retrieveListOfActiveAssays();
                    var activeInactiveCounts = {active: 0, inactive: 0};
                    updateActiveInactiveCounts(originalTree, activeInactiveCounts);
                    return originalTree;
                },

                updateActiveInactiveCounts = function (currentNode, activeInactiveCounts) {
                    if (!(currentNode.children === undefined)) {
                        // first go through all the children, and add up everything we get
                        for (var i = 0; i < currentNode.children.length; i++) {
                            var newActiveInactiveCount = updateActiveInactiveCounts(currentNode.children[i], {active: 0, inactive: 0});
                            activeInactiveCounts.active += newActiveInactiveCount.active;
                            activeInactiveCounts.inactive += newActiveInactiveCount.inactive;
                        }
                        // now add in anything directly associated with this node
                        if ((!(currentNode.assays === undefined)) &&
                                (currentNode.assays.length > 0)) {
                            for (var i = 0; i < currentNode.assays.length; i++) {
                                var assayAssociatedWithThisNode = currentNode.assays[i];// assayref, so treat as index
                                activeInactiveCounts.active += linkedData.Assays[assayAssociatedWithThisNode].AssayAc;
                                activeInactiveCounts.inactive += linkedData.Assays[assayAssociatedWithThisNode].AssayIn;
                            }
                        }
                        // we have the numbers we wanted. Store them in the tree, and then passed on to the caller
                        currentNode.ac = activeInactiveCounts.active;
                        currentNode.inac = activeInactiveCounts.inactive;
                        currentNode.size = activeInactiveCounts.active + activeInactiveCounts.inactive;
                        return activeInactiveCounts;
                    } else {
                        if ((!(currentNode.assays === undefined)) &&
                                (currentNode.assays.length > 0)) {
                            for (var i = 0; i < currentNode.assays.length; i++) {
                                var assayAssociatedWithThisNode = currentNode.assays[i];// assayref, so treat as index
                                activeInactiveCounts.active = activeInactiveCounts.active + linkedData.Assays[assayAssociatedWithThisNode].AssayAc;
                                activeInactiveCounts.inactive = activeInactiveCounts.inactive + linkedData.Assays[assayAssociatedWithThisNode].AssayIn;
                            }
                        }
                        currentNode.ac = activeInactiveCounts.active;
                        currentNode.inac = activeInactiveCounts.inactive;
                        currentNode.size = activeInactiveCounts.active + activeInactiveCounts.inactive;
                        return activeInactiveCounts;
                    }
                },
                copyThisTree = function (currentNode, listOfActiveAssays) {
                    if (!(currentNode.children === undefined)) {
                        var newNodeWithKids = {};
                        newNodeWithKids["name"] = currentNode.name;
                        newNodeWithKids["member"] = currentNode.member;
                        newNodeWithKids["treeid"] = currentNode.treeid;
                        if (!(currentNode.assays === undefined)) {
                            newNodeWithKids["assays"] = [];
                            for (var i = 0; i < currentNode.assays.length; i++) {
                                // only copy in an assay if it is known to be active
                                var assayPreviouslyAssociatedWithThisNode = currentNode.assays[i];
                                if (listOfActiveAssays.indexOf(assayPreviouslyAssociatedWithThisNode) > -1) {
                                    newNodeWithKids["assays"].push(assayPreviouslyAssociatedWithThisNode);
                                }
                            }
                        }
                        newNodeWithKids["ac"] = currentNode.ac;
                        newNodeWithKids["inac"] = currentNode.inac;
                        newNodeWithKids["children"] = [];
                        for (var i = 0; i < currentNode.children.length; i++) {
                            if (youOrAnyOfYourChildrenWorthSaving(currentNode.children[i], listOfActiveAssays)) {
                                newNodeWithKids["children"].push(copyThisTree(currentNode.children[i], listOfActiveAssays));
                            }
                        }
                        // special case. If none of your kids were worth saving then add a size parameter.  You might perhaps
                        //  be a valuable node, my friend, even if all your children are worthless.
                        if (newNodeWithKids.children.length == 0) {
                            newNodeWithKids["size"] = currentNode.ac + currentNode.inac;
                        }
                        return newNodeWithKids;
                    } else {
                        var newNode = {};
                        newNode["name"] = currentNode.name;
                        newNode["member"] = currentNode.member;
                        newNode["treeid"] = currentNode.treeid;
                        if (!(currentNode.assays === undefined)) {
                            newNode["assays"] = [];
                            for (var i = 0; i < currentNode.assays.length; i++) {
                                // only copy in an assay if it is known to be active
                                var assayPreviouslyAssociatedWithThisNode = currentNode.assays[i];
                                if (listOfActiveAssays.indexOf(assayPreviouslyAssociatedWithThisNode) > -1) {
                                    newNode["assays"].push(assayPreviouslyAssociatedWithThisNode);
                                }

                            }
                        }
                        newNode["ac"] = currentNode.ac;
                        newNode["inac"] = currentNode.inac;
                        newNode["size"] = currentNode.size;
                        return newNode;
                    }
                },
                youOrAnyOfYourChildrenWorthSaving = function (currentNode, thoseWorthSaving) {
                    var worthSaving = false;
                    if (thoseWorthSaving.length > 0) {
                        if (!(currentNode.assays === undefined)) {
                            for (var j = 0; j < currentNode.assays.length; j++) {
                                if (thoseWorthSaving.indexOf(currentNode.assays[j]) > -1) {
                                    worthSaving = true;
                                    return worthSaving;
                                }
                            }
                        }
                        if (!(currentNode.children === undefined)) {
                            for (var j = 0; j < currentNode.children.length; j++) {
                                for (var i = 0; i < currentNode.children.length; i++) {
                                    worthSaving = youOrAnyOfYourChildrenWorthSaving(currentNode.children[i], thoseWorthSaving);
                                    if (worthSaving) {
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                    return worthSaving;
                },
                adjustedPartitionSize = function (d) {
                    return d.size;
                },
                retrieveListOfActiveAssays = function () {
                    var listOfAssayCrossObjects = sharedStructures.getAssayIndex().top(1000);
                    var listOfAssayRef = [];
                    for (var i = 0; i < listOfAssayCrossObjects.length; i++) {
                        listOfAssayRef.push(listOfAssayCrossObjects[i].index);
                    }
                    return listOfAssayRef;
                },
                resetRootForHierarchy = function (currentNode, hierarchyId) {
                    var hierarchyOfChoice = linkedData.Hierarchy[hierarchyId];
                    if (!(hierarchyOfChoice.Structure === undefined)) {
                        // We want to actually the parent of the currently selected node. It isn't always trivial to find your parent, but we can try...
                        var potentialParent = parentIdentificationTool(hierarchyOfChoice.Structure.struct [0], currentNode);
                        if (!(potentialParent === null)) {   // We found the parent, make the assignment
                            hierarchyOfChoice.Structure.rootName = potentialParent.name;
                        } else {    // Could not find the parent, stick with the existing node.  This should only happen if they picked the root.
                            hierarchyOfChoice.Structure.rootName = currentNode.name;
                        }

                    }
                },

                /***
                 * As users click on various arcs within a sunburst, the root note for the hierarchy  can end up
                 * being set to any given node. Sometimes it's useful, however, to go back to where we started.
                 * Do this, for example, if the user clicks the button that is used to reset their hierarchy drill down.
                 */
                        resetDerivedHierarchyRouteToOriginalRoot = function (hierarchyId) {
                    resetRootForHierarchy(linkedData.Hierarchy[hierarchyId].Structure.struct [0], hierarchyId);
                },

                /***
                 * Do we have any hierarchy at all? Better to be safe and make sure the hierarchy is'nt null before
                 * this analysis goes any further
                 */
                        extendedHierarchyDataExists = function (hierarchyId) {
                    var hierarchyOfChoice = linkedData.Hierarchy[hierarchyId];
                    return (!(hierarchyOfChoice.Structure.struct === undefined));
                },

                /***
                 *  How can you find the parent of any given node if the pointers only point down the tree? Well, it's a bother. We start
                 *  at the top of the tree and perform a recursive descent until eventually you find the node that is the parent of
                 *  the input parameter, namely the  nodeThatIsTheBasisForOurSearch
                 * @param currentNode
                 * @param nodeThatIsTheBasisForOurSearch
                 * @returns {*}
                 */
                        parentIdentificationTool = function (currentNode, nodeThatIsTheBasisForOurSearch) {
                    if (!(currentNode === undefined)) {
                        // If you have children then you might be the one
                        if (!(currentNode.children === undefined)) {
                            // Are you the parent we are searching for?
                            for (var i = 0; i < currentNode.children.length; i++) {
                                var child = currentNode.children [i];
                                if (!(child === undefined)) {
                                    if (child.name === nodeThatIsTheBasisForOurSearch.name) {
                                        return currentNode;
                                    }
                                }
                            }
                            //  You want the parent we want exactly, but maybe one of your kids is the one
                            for (var i = 0; i < currentNode.children.length; i++) {
                                var child = currentNode.children [i];
                                if (!(child === undefined)) {
                                    var potentialParent = parentIdentificationTool(child, nodeThatIsTheBasisForOurSearch);
                                    if (!(potentialParent === null)) {
                                        return  potentialParent;
                                    }
                                }
                            }
                        }
                    }
                    return(null);
                }


        return {
            parseData: parseData,
            cid: cid,
            findMinimumAndMaximumRatiosForColoring: findMinimumAndMaximumRatiosForColoring,
            appendConditionalStatusFields: appendConditionalStatusFields,
            validateLinkedData: validateLinkedData,
            numberOfWidgets: numberOfWidgets,
            retrieveCurrentHierarchicalData: retrieveCurrentHierarchicalData,
            retrieveLinkedData: retrieveLinkedData,
            adjustMembershipBasedOnSunburstClick: adjustMembershipBasedOnSunburstClick,
            filteredHierarchyData: filteredHierarchyData,
            adjustedPartitionSize: adjustedPartitionSize,
            resetRootForHierarchy: resetRootForHierarchy,
            cleanupOriginalHierarchyData: cleanupOriginalHierarchyData,
            extendedHierarchyDataExists: extendedHierarchyDataExists,
            resetDerivedHierarchyRouteToOriginalRoot: resetDerivedHierarchyRouteToOriginalRoot
        }

    }());










   //linkedvizmodule










   var linkedVisualizationModule = (function () {
       //
       //  Variables to describe the layout of the whole page, with special attention
       //   to the unexpanded widgets
       //
       var grandWidth = 1052,// width of the entire display
               totalWidgetNumber = 4, // how many widgets are we dealing with
               widgetHeight = 270, // how tall is each individual widget
               widgetSpacing = 7, // how much vertical space between widgets
               margin = {top: 30, right: 20, bottom: 30, left: 10},  // boundaries of displayable area
               width = grandWidth - margin.left - margin.right, // displayable width
               height = widgetHeight - margin.top - margin.bottom, // displayable height
               widgetWidth = 25,//grandWidth / totalWidgetNumber,   // each individual widget width
               quarterWidgetWidth = widgetWidth / 4,   // useful spacer
               allowThisMuchExtraSpaceInWidgetForATitle = 30, // the title in your widget
               widgetWidthWithoutSpacing = 24,//widgetWidth - (widgetSpacing * 0.5),
               widgetHeightWithTitle = widgetHeight + allowThisMuchExtraSpaceInWidgetForATitle, // final widget width

       // We have to explicitly pass in the size of the pie charts, so describe those here
               pieChartWidth = 250,// widgetWidth - 13,  // how wide is the pie chart
               pieChartRadius = pieChartWidth / 2, // pie chart reuse
               innerRadius = 30, // open circle in pie
               innerRadiusWhenExpanded = 100, // open circle in pie

       // The expanded widgets are described below. These numbers can't be derived from anything else, because you could
       //  in principle put this display anywhere.
               displayWidgetX = 10,// expanded widget X location.
               displayWidgetY = 320, // expanded widget Y location.
               displayWidgetWidth = 1000, // expanded widget Y width.
               displayWidgetHeight = 1000, // expanded widget Y height.
               bigPie = (displayWidgetWidth / 2) - displayWidgetX, // size of pie in display mode

       //  I need to have a color for every possible pie slice. Since the color map is largely arbitrary, d3 does not
       //   seem to provide An easy way to say "please give me another color unlike when you've given me before".  Note
       //   that the colors I want are not _entirely_ arbitrary because really light colors don't seem to look good in
       //   a pie chart filled with brighter colors, so I can't simply use randomizing function with a seed
               colors = [ '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#8c6d31', '#bd9e39',
                   '#e7ba52', '#e7cb94', '#843c39', '#ad494a', '#d6616b', '#e7969c', '#7b4173', '#a55194', '#ce6dbd', '#de9ed6',
                   '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',
                   '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5',
                   '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
                   '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#8c6d31', '#bd9e39',
                   '#e7ba52', '#e7cb94', '#843c39', '#ad494a', '#d6616b', '#e7969c', '#7b4173', '#a55194', '#ce6dbd', '#de9ed6',
                   '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',
                   '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5',
                   '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
                   '#5254a3', '#6b6ecf', '#9c9ede', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#8c6d31', '#bd9e39',
                   '#e7ba52', '#e7cb94', '#843c39', '#ad494a', '#d6616b', '#e7969c', '#7b4173', '#a55194', '#ce6dbd', '#de9ed6',
                   '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',
                   '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5',
                   '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf',
                   '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#8c6d31', '#bd9e39',
                   '#e7ba52', '#e7cb94', '#843c39', '#ad494a', '#d6616b', '#e7969c', '#7b4173', '#a55194', '#ce6dbd', '#de9ed6',
                   '#1f77b4', '#aec7e8', '#ff7f0e', '#ffbb78', '#2ca02c', '#98df8a', '#d62728', '#ff9896', '#9467bd', '#c5b0d5',
                   '#8c564b', '#c49c94', '#e377c2', '#f7b6d2', '#7f7f7f', '#c7c7c7', '#bcbd22', '#dbdb8d', '#17becf', '#9edae5',
                   '#1f77b4', '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2', '#7f7f7f', '#bcbd22', '#17becf'],
       blueColors = [
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF',
           '#3182bd', '#6baed6', '#9ecae1', '#c6dbef', '#393b79', '#5254a3', '#6b6ecf', '#9c9ede', '#17becf', '#9edae5', '#1f77b4', '#aec7e8', '#B4FCFF','#82B6FA', '#00FFFF'],


       reddishColors = [
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500',
           '#e6550d', '#fd8d3c', '#fdae6b', '#fdd0a2', '#ad494a', '#d6616b', '#e7969c', '#ff7f0e', '#d62728', '#ff9896', '#EF6546','#E6933C', '#FFA500'],

       greenishColors = [
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100',
           '#31a354', '#74c476', '#a1d99b', '#c7e9c0', '#637939', '#8ca252', '#b5cf6b', '#cedb9c', '#2ca02c', '#98df8a', '#EDDA74','#00E100'],


       brownishColors = [
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74',
           '#8c6d31', '#bd9e39', '#e7ba52', '#e7cb94', '#bcbd22', '#dbdb8d', '#bcbd22', '#fdd0a2', '#F7E47E','#FFFFA6', '#CFBC56','#EDDA74'],



           // below are some names and text strings
       piename = ['a0', 'a1', 'a2', 'a3'], // internal names for the widgets
               textForExpandingButton = 'Drill down', // text on button to expand to full display
               textForContractingButton = 'click to contract', //text on button to contract unexpended widget

           //  This next set of variables are only for convenience.  They are derived strictly from those above,
           //   and they are consumed below in preference to those above.  The idea was to conceptually simplify
           //   some of the variables above and to those that describe either compressed or uncompressed widgets.
//               compressedPos = [
//                   {'x': margin.left + ((widgetWidth + widgetSpacing) * 0), 'y': 10},
//                   {'x': margin.left + ((widgetWidth + widgetSpacing) * 1), 'y': 10},
//                   {'x': margin.left + ((widgetWidth + widgetSpacing) * 2), 'y': 10},
//                   {'x': margin.left + ((widgetWidth + widgetSpacing) * 3), 'y': 10}
//               ],
//               expandedPos = [
//                   {'x': (widgetWidth * 0) + (quarterWidgetWidth * 1), 'y': 10},
//                   {'x': (widgetWidth * 1) + (quarterWidgetWidth * 2), 'y': 10},
//                   {'x': (widgetWidth * 2) + (quarterWidgetWidth * 3), 'y': 10}
//               ],
               compressedPos = [
                   {'x': '0.5', 'y': 10},
                   {'x': '25.5', 'y': 10},
                   {'x': '50.5', 'y': 10},
                   {'x': '75.5', 'y': 10}
               ],
               expandedPos = [
                   {'x': '6', 'y': 10},
                   {'x': '37', 'y': 10},
                   {'x': '69', 'y': 10}
               ],

           //  dc vars
               maximumRowsInTable = 150,


           //-------widgetPosition------
           // JavaScript module. This portion of the code allows us to keep track of which widgets are expanded
           // and which remain in their original positions. There are a functions that allow you to ask the constructor
           // about its status ( examples:  isAnyWidgetExpanded() returns a Boolean to tell you if anything's expanded,
           // while expandedWidget () returns a number to tell you which widget has been expanded.
           //---------------------------
               widgetPosition = (function () {
                   // private property
                   var currentWidgetPosition = { 'up': [0, 1, 2, 3],
                               'down': [] },

                           isAnyWidgetExpanded = function () {   // returns a Boolean
                               return currentWidgetPosition.down.length > 0;
                           },

                           expandedWidget = function () {   // returns a number
                               if (currentWidgetPosition.down.length == 1) {
                                   return currentWidgetPosition.down[0];
                               } else {
                                   return -1;
                               }
                           },

                           unexpandedWidgets = function () {   // returns an array
                               return currentWidgetPosition.up;
                           },

                   // the main action routine.
                           expandThisWidget = function (widgetToBeExpanded) {  // number: 1 = success, 0 = failure
                               var indexOfDesiredWidget = 0;
                               // first make sure the incoming argument is inside the acceptable range
                               if ((widgetToBeExpanded < 0) || (widgetToBeExpanded > 3)) {
                                   return -1;
                               }
                               // another way to go wrong is to try to expand a widget that isn't in the top row to begin with
                               indexOfDesiredWidget = currentWidgetPosition.up.indexOf(widgetToBeExpanded);
                               if (indexOfDesiredWidget == -1) {
                                   return indexOfDesiredWidget;
                               }
                               // you can also go wrong if there is already a widget expanded
                               if (currentWidgetPosition.down.length != 0) {
                                   indexOfDesiredWidget = -1;
                               }

                               if (indexOfDesiredWidget > -1) {
                                   // everything looks good. Let's do what the caller has asked us to do.
                                   //First copy the widget to the down position
                                   currentWidgetPosition.down.push(currentWidgetPosition.up[indexOfDesiredWidget]);
                                   // Now remove it from the top row and collapse those around it
                                   currentWidgetPosition.up = currentWidgetPosition.up.slice(0, indexOfDesiredWidget).concat(
                                           currentWidgetPosition.up.slice(indexOfDesiredWidget + 1, 4));
                               }
                               return indexOfDesiredWidget;
                           },

                   // the other action routine, though this one is much simpler since there's only one choice
                           unexpandAllWidgets = function () {
                               currentWidgetPosition.up.push(currentWidgetPosition.down.pop());
                               currentWidgetPosition.up.sort(function (a, b) {
                                   return a - b;
                               });
                               currentWidgetPosition.down = [];
                           };
                   // end var

                   // now present the public API
                   return {
                       unexpandAllWidgets: unexpandAllWidgets,
                       expandThisWidget: expandThisWidget,
                       unexpandedWidgets: unexpandedWidgets,
                       expandedWidget: expandedWidget,
                       isAnyWidgetExpanded: isAnyWidgetExpanded
                   };


               }()); // widgetPosition


       var displayManipulator = (function () {
           var rememberClickEffectors = [],
                   disableAllPieClickEffectors = function () {
                       for (var widgetCounter = 0; widgetCounter < totalWidgetNumber; widgetCounter++) {
                           rememberClickEffectors [widgetCounter] = d3.selectAll('#a' + widgetCounter + '-chart>svg>g>.pie-slice>path').on('click');
                           d3.selectAll('#a' + widgetCounter + '-chart>svg>g>.pie-slice>path').on('click', null);
                       }
                   },
                   reenableAllPieClickEffectors = function () {
                       if (rememberClickEffectors === undefined) {
                           alert(' JavaScript error--an attempt was made to reenableAllPieClickEffectors before originally disabling those ClickEffectors');
                       } else {
                           for (var widgetCounter = 0; widgetCounter < totalWidgetNumber; widgetCounter++) {
                               d3.selectAll('#a' + widgetCounter + '-chart>svg>g>.pie-slice>path').on('click', rememberClickEffectors [widgetCounter]);
                           }
                       }
                   } ,
                   eraseAnyOrphanedTooltips = function () {
                       var orphanedTooltips = d3.selectAll('.toolTextAppearance');
                       if (!(orphanedTooltips === undefined)) {
                           orphanedTooltips.style('opacity', 0);
                       }
                   },
                   cleanUpAnyGraphicsWeAreDoneWith = function () {
                       var potentialOrphanedGraphics = d3.select('div#sunburstdiv>svg');
                       if ((!(potentialOrphanedGraphics === null)) &&
                               (!(potentialOrphanedGraphics[0] === null)) &&
                               (!(potentialOrphanedGraphics[0][0] === null))) {
                           potentialOrphanedGraphics.remove();
                       }

                       var potentialOrphanedLegend = d3.select('div#sunburstlegend');
                       if ((!(potentialOrphanedLegend === null)) &&
                               (!(potentialOrphanedLegend[0] === null)) &&
                               (!(potentialOrphanedLegend[0][0] === null))) {
                           potentialOrphanedLegend.remove();
                       }
                   },
                   createAResetButtonIfWeSwitchedARoot = function () {
                       // Instead of looking to see which widget is closing let's just check them all, and create a reset button
                       // whenever the root is not equal to the user-specified Global parent
                       for (var i = 0; i < X; i++) {

                       }
                   },

           // convenience routine for adding a pie chart
                   addPieChart = function (crossFilterVariable, id, key, colors, localPieChartWidth, localPieChartRadius, localInnerRadius) {
                       var dimensionVariable = crossFilterVariable.dimension(function (d) {
                                   return d[key];
                               }),
                               dimensionVariableGroup = dimensionVariable.group().reduceSum(function (d) {
                                   return 1;
                               }),
                               displayDataGroup = function (d) {
                                   var returnValue = d.data.key.toString() + " (" + d.data.value + ")";
                                   returnValue = returnValue.replace("http://amigo.geneontology.org/cgi-bin/amigo/term_details?term=", "[GO]");
                                   returnValue = returnValue.replace("http://www.ncbi.nlm.nih.gov/gquery/?term=", "[NCBI]");
                                   return returnValue;
                               };

                       var colorSet = {};
                       switch(id){
                           case 'a0-chart':
                               colorSet=blueColors;
                               break;
                           case 'a1-chart':
                               colorSet=greenishColors ;
                               break;
                           case 'a2-chart':
                               colorSet=reddishColors ;
                               break;
                           case 'a3-chart':
                               colorSet=brownishColors ;
                               break;
                           default:;
                       }

                       return dc.pieChart("#" + id)
                               .width(localPieChartWidth)
                               .height(localPieChartWidth)
                               .transitionDuration(200)
                               .radius(localPieChartRadius)
                               .innerRadius(localInnerRadius)
                               .dimension(dimensionVariable)
                               .group(dimensionVariableGroup)
                               .colors(colorSet)
                               .label(displayDataGroup)
                               .renderTitle(true);
                   },


                   addDcTable = function (crossFilterVariable, id, key) {
                       var dimensionVariable = crossFilterVariable.dimension(function (d) {
                                   return d[key];
                               }),
                               dimensionVariableGroup = function (d) {
                                   return "";
                               },
                               dimensionVariableGroupTotal = function (d) {
                                   return dimensionVariable.groupAll();
                               };

                       var theTable = dc.dataTable("#" + id)
                               .dimension(dimensionVariable)
                               .group(dimensionVariableGroup)
                               .size(maximumRowsInTable)
                               .columns([
                                   function (d) {
                                       return d.GO_biological_process_term;
                                   },
                                   function (d) {
                                       return d.assay_format;
                                   },
                                   function (d) {
                                       return d.protein_target;
                                   },
                                   function (d) {
                                       return d.assay_type;
                                   },
                                   function (d) {
                                       return "<a href='/bardwebclient/bardWebInterface/showAssay/" + d.assayBId + "'>" + d.assayId + "</a>";
                                   }
                               ])
                               .order(d3.ascending)
                               .sortBy(function (d) {
                                   return d.GO_biological_process_term;
                               });
                       //                        This datecount  function below doesn't seem to work for me. What's wrong?
                       //                        dc.dataCount("#data-count")
                       //                                .dimension(dimensionVariable)
                       //                                .group(dimensionVariableGroupTotal);

                       return  theTable;
                   },


                   expandDataAreaForAllPieCharts = function (pieChartHolderElement) {
                       pieChartHolderElement.attr('height', displayWidgetY);
                   },


                   moveDataTableOutOfTheWay = function (dataTable) {
                       dataTable
                               .transition()
                               .duration(500)
                               .style("top", 50 + displayWidgetY + displayWidgetHeight + "px");  // Extra spaces for 'click to contract' button
                   },

                   moveDataTableBackToItsOriginalPosition = function (dataTable) {
                       dataTable
                               .transition()
                               .delay(1000)
                               .duration(500)
                               .style("top", "300px");  // Extra spaces for 'click to contract' button
                   },


                   shiftBackgroundWidgets = function (domDescription, horizontalPosition) {
                       domDescription
                               .transition()
                               .duration(1000)
                               .style("left", horizontalPosition + "%");
                   },


           // buttons are supplied to allow the user to reset their hierarchy drill down, but the buttons only work
           // from the pie mode
                   deactivateDrillDownResetButtons = function () {

                       // turn off the reset buttons, and they are deactivated when the Sunburst is visible
                       var drillDownButtons = d3.selectAll('.drill');
                       if (!(drillDownButtons.empty())) {
                           drillDownButtons.style('pointer-events', 'none')
                                   .style('opacity', 0.5)
                                   .style('cursor', 'pointer');
                       }

                       // If there is a drill down explanation then fade it  out
                       var drillLabelExplanation = d3.select('.drillLabel');
                       if (!(drillLabelExplanation.empty())) {
                           drillLabelExplanation.style('opacity', 0.5);
                       }

                   },

           // buttons are supplied to allow the user to reset their hierarchy drill down. These were deactivated when a sunburst
           //   was displayed, but they need to be reactivated again when we get back to pie mode
                   activateDrillDownResetButtons = function () {

                       // do we have any drill down reset buttons to deal with
                       var drillDownResetButtonsExist = false;
                       var drillDownButtons = d3.selectAll('.drill');
                       if (!(drillDownButtons.empty())) {

                           drillDownResetButtonsExist = true;
                           drillDownButtons.style('pointer-events', 'auto')
                                   .style('opacity', 1)
                                   .style('cursor', 'pointer');

                       }

                       var drillLabelExplanation = d3.select('.drillLabel');
                       if (!(drillLabelExplanation.empty())) {
                           // we have an explanation line

                           if (drillDownResetButtonsExist) {   // if buttons exist
                               drillLabelExplanation.style('opacity', 1);
                               ;
                           } else {    // if no buttons exist
                               // this should never happen ( an explanation exists without any buttons ), but
                               // but if it should happen somehow then let's clean it up
                               drillLabelExplanation.remove();
                           }

                       }


                   },


                   spotlightOneAndBackgroundThree = function (index, spotlight, backgroundIndex1, backgroundIndex2, backgroundIndex3, origButton, expandedPos) {

                       deactivateDrillDownResetButtons();


                       var widgetsGoHere = sharedStructures.widgetsGoHere();
                       // first handle the spotlight element and then the three backup singers
                       // movedown
                       spotlight
                               .transition()
                               .duration(200)
                               .style("top", widgetsGoHere[index].display.coords.y + "px");

                         // moveover
                       spotlight
                               .transition()
                               .delay(200)
                               .duration(200)
                           //    .style("left", d.display.coords.x + "%");
                       .style("left", "10px");

                     spotlight
                               .transition()
                             .delay(400)
                               .duration(200)
                               .style('height', widgetsGoHere[index].display.size.height + "px")
                               .style('max-width', widgetsGoHere[index].display.size.width + "px")
                               .style('width', '100%');
                       shiftBackgroundWidgets(d3.select('#a' +backgroundIndex1), expandedPos[0].x);
                       shiftBackgroundWidgets(d3.select('#a' +backgroundIndex2), expandedPos[1].x);
                       shiftBackgroundWidgets(d3.select('#a' +backgroundIndex3), expandedPos[2].x);

                       //   Turn off the text label based on click event for background widgets
                       d3.select('#a' +backgroundIndex1).selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'none');
                       d3.select('#a' +backgroundIndex2).selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'none');
                       d3.select('#a' +backgroundIndex3).selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'none');

                       //  Turn off the expander button, since the user needs to contract the expanded
                       //  widget before they try to expand the new one. It would be nice to click that
                       //  button for them, but D three does not support that sort of activation is you are
                       //  using bound data. I should probably connect to those data dynamically to get around
                       //  this problem.

                       d3.select('#expbutton' +backgroundIndex1).style('pointer-events', 'none').style('opacity', 0.5);
                       d3.select('#expbutton' +backgroundIndex2).style('pointer-events', 'none').style('opacity', 0.5);
                       d3.select('#expbutton' +backgroundIndex3).style('pointer-events', 'none').style('opacity', 0.5);


//                       d3.select('#a' +backgroundIndex1).selectAll('.expandButton').style('pointer-events', 'none').style('opacity', 0.5);
//                       d3.select('#a' +backgroundIndex2).selectAll('.expandButton').style('pointer-events', 'none').style('opacity', 0.5);
//                       d3.select('#a' +backgroundIndex3).selectAll('.expandButton').style('pointer-events', 'none').style('opacity', 0.5);

                       d3.select('#sunburstContractor')
                               .style('opacity', 1);
//                       if (!contractingButtonDiv.empty ()) {
//                           contractingButtonDiv.style('opacity', 1);
//                       } else {
//                           contractingButtonDiv.append('div')
//                                   .attr('class', 'contractButton')
//                                   .attr('id', 'hierarchyContractor')
//                                   .transition()
//                                   .delay(1000)
//                                   .duration(500)
//                                   .style('opacity', 1);
//                       }
//                       origButton
//                               .text(textForContractingButton)
//                               .attr('class', 'contractButton')
//                               .transition()
//                               .delay(1000)
//                               .duration(500)
//                               .style('opacity', 1);
                   },

                   resetOneAndResettleThree = function (index, spotlight, backgroundIndex1, backgroundIndex2, backgroundIndex3, origButton, expandedPos) {

                       var widgetsGoHere = sharedStructures.widgetsGoHere();

                       //shrink
                       spotlight.transition()
                               .duration(400)
                               .style('height', widgetsGoHere[index].orig.size.height + "px")
                               .style('width', widgetsGoHere[index].orig.size.width + "%")
                               .style('padding-left', '5px');

                       //move back to your original X position
                       spotlight.transition()
                               .delay(400)
                               .duration(200)
                               .style("left", widgetsGoHere[index].orig.coords.x + "%");

                       //move back to your original Y position
                       spotlight.transition()
                               .delay(600)
                               .duration(400)
                               .style("top", widgetsGoHere[index].orig.coords.y + "px");


                       shiftBackgroundWidgets(d3.select('#a'+backgroundIndex1), widgetsGoHere[backgroundIndex1].orig.coords.x);
                       shiftBackgroundWidgets(d3.select('#a'+backgroundIndex2), widgetsGoHere[backgroundIndex2].orig.coords.x);
                       shiftBackgroundWidgets(d3.select('#a'+backgroundIndex3), widgetsGoHere[backgroundIndex3].orig.coords.x);
                       d3.select('#a'+backgroundIndex1).selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'auto');
                       d3.select('#a'+backgroundIndex2).selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'auto');
                       d3.select('#a'+backgroundIndex3).selectAll('.pieChart>svg>g>.pie-slice').style('pointer-events', 'auto');
                       //  Turn back on the expander buttons
                       //  widget before they try to expand the new one. It would be nice to click that
                       //  button for them, but D three does not support that sort of activation is you are
                       //  using bound data. I should probably connect to those data dynamically to get around
                       //  this problem.
                       if (!(linkedVizData.extendedHierarchyDataExists(backgroundIndex1))) {
                           d3.select('#expbutton' + backgroundIndex1).style('pointer-events', 'none').style('opacity', 0.5);
                       } else {
                           d3.select('#expbutton' + backgroundIndex1).style('pointer-events', 'auto').style('opacity', 1);
                       }
                       if (!(linkedVizData.extendedHierarchyDataExists(backgroundIndex2))) {
                           d3.select('#expbutton' + backgroundIndex2).style('pointer-events', 'none').style('opacity', 0.5);
                       } else {
                           d3.select('#expbutton' + backgroundIndex2).style('pointer-events', 'auto').style('opacity', 1);
                       }
                       if (!(linkedVizData.extendedHierarchyDataExists(backgroundIndex3))) {
                           d3.select('#expbutton' + backgroundIndex3).style('pointer-events', 'none').style('opacity', 0.5);
                       } else {
                           d3.select('#expbutton' + backgroundIndex3).style('pointer-events', 'auto').style('opacity', 1);
                       }


                       var x = origButton
                               .text(textForExpandingButton)
                               .attr('class', 'expandButton')
                               .transition()
                               .delay(1000)
                               .duration(500)
                               .style('opacity', 1);

                       // turn back on this reset buttons
                       activateDrillDownResetButtons();

                       // Set some style attributes that must be adjusted dynamically
                       tidyUpDisplay();
                   },

                   expandGraphicsArea = function (graphicsTarget, graphicsTitle) {

                       var bigarc = d3.svg.arc()
                               .innerRadius(innerRadiusWhenExpanded)
                               .outerRadius(bigPie);

                       var nullarc = d3.svg.arc()
                               .innerRadius(innerRadiusWhenExpanded)
                               .outerRadius(innerRadiusWhenExpanded + 1);

                       graphicsTarget
                               .attr('width', displayWidgetWidth)
                               .attr('height', displayWidgetHeight + 50); // Extra room for the 'click to contract' button

                       graphicsTarget
                               .select('g')
                               .selectAll('text')
                               .remove();

                       graphicsTarget
                               .selectAll('g')
                               .select('path')
                               .transition()
                               .duration(1500)
                               .attr("d", bigarc)  // pie size easily adjusted here
                               .attr("transform", "translate(368,375)");    // We need use explicit numbers here, not variables. This would be something to fix

                       graphicsTitle.attr('class', 'expandedGraphTitle');
                   },

                   contractGraphicsArea = function (graphicsTarget, graphicsTitle) {

                       var arc = d3.svg.arc()
                               .innerRadius(innerRadius)
                               .outerRadius(pieChartRadius);

                       graphicsTarget
                               .transition()
                               .duration(1500)
                               .attr('width', pieChartWidth)
                               .attr('height', pieChartWidth);

                       graphicsTarget
                               .select('g')
                               .selectAll('text')
                               .remove();

                       graphicsTarget
                               .selectAll('g')
                               .select('path')
                               .transition()
                               .duration(500)
                               .attr("d", arc)
                               .attr("transform", "translate(0,0)");

                       graphicsTitle.attr('class', 'graphTitle');

                   },
                   removeTheSun = function () {
                       d3.selectAll('#suburst_container').style('pointer-events', 'none')
                               .transition()
                               .delay(0)
                               .duration(500)
                               .style('opacity', '0')
                   },

           // We have to make a few changes to the display dynamically since we don't have complete control over the DC code
                   tidyUpDisplay = function () {
                       dc.renderAll();
                   },


                   swapAPieForTheSun = function (pieDiv, sunburstContainer, expandedButtonNum, callbackToExpandOrContractOnButtonClick) {
                       pieDiv.style('pointer-events', 'none')
                               .transition()
                               .delay(1000)
                               .duration(500)
                               .style('opacity', '0');
                       sunburstContainer.style('pointer-events', null)
                               .transition()
                               .delay(1000)
                               .duration(500)
                               .style('opacity', '1');
                       if (linkedVizData.retrieveCurrentHierarchicalData(expandedButtonNum).children !== undefined) {
                           createASunburst(1000, 1000, 5, 1000, continuousColorScale, 'div#sunburstdiv', linkedVizData.cid(), expandedButtonNum);
                           var minMaxHolder = linkedVizData.findMinimumAndMaximumRatiosForColoring(linkedVizData.filteredHierarchyData(expandedButtonNum));
                           createALegend(120, 200, 100, continuousColorScale, 'div#legendGoesHere', minMaxHolder.minimum, minMaxHolder.maximum);
//                    createALegend(120, 200, 100, continuousColorScale, 'div#legendGoesHere', 0, 1);
                           d3.selectAll('#suburst_container').style('pointer-events', null);
                       } else {
                           d3.select('div#sunburstdiv')
                                   .append('div')
                                   .attr("width", 1000)
                                   .attr("height", 1000)
                                   .style("padding-top", '200px')
                                   .style("text-align", 'center')
                                   .append("h1")
                                   .html("No off-embargo assay data are  available for this compound." +
                                           "Please either choose a different compound, or else come" +
                                           " back later when more assay data may have accumulated.");
                       }
                       d3.select('#sunburstContractor')
                               .on('click', function (d) {
                                   sunburstContainer.style('pointer-events', 'none')
                                           .style('opacity', '0');
                                   pieDiv.style('pointer-events', null)
                                           .style('opacity', '1');
                                   d3.selectAll('.molstruct')
                                           .style('opacity', '0');
                                    callbackToExpandOrContractOnButtonClick({    index: expandedButtonNum }, expandedButtonNum);
                               });
                       var molecularStructure = d3.selectAll('.molstruct')
                               .transition()
                               .delay(1000)
                               .duration(500)
                               .style('opacity', '1');

                   };

           // end var

           // Public API for this module
           return {
               disableAllPieClickEffectors: disableAllPieClickEffectors,
               reenableAllPieClickEffectors: reenableAllPieClickEffectors,
               eraseAnyOrphanedTooltips: eraseAnyOrphanedTooltips,
               cleanUpAnyGraphicsWeAreDoneWith: cleanUpAnyGraphicsWeAreDoneWith,
               contractGraphicsArea: contractGraphicsArea,
               expandGraphicsArea: expandGraphicsArea,
               resetOneAndResettleThree: resetOneAndResettleThree,
               spotlightOneAndBackgroundThree: spotlightOneAndBackgroundThree,
               expandDataAreaForAllPieCharts: expandDataAreaForAllPieCharts,
               moveDataTableOutOfTheWay: moveDataTableOutOfTheWay,
               moveDataTableBackToItsOriginalPosition: moveDataTableBackToItsOriginalPosition,
               addDcTable: addDcTable,
               addPieChart: addPieChart,
               swapAPieForTheSun: swapAPieForTheSun,
               tidyUpDisplay: tidyUpDisplay
           };
       }() );  //displayManipulator

       //
       //   Get the data and make the plots using dc.js.  Use this as an opportunity to encapsulate any methods that are
       //    used strictly locally
       //
       var generateLinkedPies = (function () {


           var buttondata = [
               { index: 0 },
               { index: 1 },
               { index: 2 },
               { index: 3 }]  ;


           // Private method used to pull the data in from the remote site
           var readInData = function () {

                       return    linkedVizData.retrieveLinkedData();

                   },


           // Our main button handler callback
                   handleExpandOrContractClick = function (d, x) {
                       // we better decide whether where you want to expand or contract
                       var origButton = d3.select('#expbutton' + d.index)
                                       .style('opacity', 0),
                               expandedWidget,
                               unexpandedWidget,
                               expandContractButton;

                       if (!widgetPosition.isAnyWidgetExpanded()) {
                           displayManipulator.disableAllPieClickEffectors();
                           displayManipulator.expandDataAreaForAllPieCharts(d3.select('.pieCharts'));
                           displayManipulator.moveDataTableOutOfTheWay(d3.select('#data-table'));
                           widgetPosition.expandThisWidget(d.index);
                           expandedWidget = widgetPosition.expandedWidget();
                           unexpandedWidget = widgetPosition.unexpandedWidgets();
                           displayManipulator.spotlightOneAndBackgroundThree(d.index, d3.select('#a' + expandedWidget),
                                   unexpandedWidget[0],
                                   unexpandedWidget[1],
                                    unexpandedWidget[2],
                                   origButton,
                                   expandedPos);
                           expandContractButton = d3.select('#a' + expandedWidget + '-chart>.graphTitle')
                           displayManipulator.expandGraphicsArea(d3.select('#a' + expandedWidget).select('.pieChart>svg'),
                                   expandContractButton);
                           if (linkedVizData.extendedHierarchyDataExists(expandedWidget)) {
                               displayManipulator.swapAPieForTheSun(d3.select('#a' + expandedWidget), d3.selectAll('#suburst_container'), expandedWidget, handleExpandOrContractClick);
                           }

                       }

                       else if (widgetPosition.expandedWidget() == d.index) {
                           expandedWidget = widgetPosition.expandedWidget();
                           unexpandedWidget = widgetPosition.unexpandedWidgets();
                           displayManipulator.contractGraphicsArea(d3.select('#a' + x).select('.pieChart>svg'),
                                   d3.select('#a' + expandedWidget + '-chart>.expandedGraphTitle'));
                           displayManipulator.resetOneAndResettleThree(d.index, d3.select('#a' + expandedWidget),
                                   unexpandedWidget[0],
                                   unexpandedWidget[1],
                                   unexpandedWidget[2],
                                   origButton,
                                   expandedPos);
                           widgetPosition.unexpandAllWidgets();
                           displayManipulator.moveDataTableBackToItsOriginalPosition(d3.select('#data-table'));
                           displayManipulator.reenableAllPieClickEffectors();
                           displayManipulator.eraseAnyOrphanedTooltips();
                           displayManipulator.cleanUpAnyGraphicsWeAreDoneWith();
                       }

                   },

                   attachButtonsToThePieContainers = function (classOfPieContainers, callbackToExpandOrContractOnButtonClick, buttondata, sunburstContainer) {
                       var placeButtonsHere = d3.selectAll(classOfPieContainers)
                               .data(buttondata);

                       placeButtonsHere.append("div")
                               .text(textForExpandingButton)
                               .attr('class', 'expandButton')
                               .attr('id', function (d) {
                                   return 'expbutton' + d.index;
                               })
                               .on('click', callbackToExpandOrContractOnButtonClick);

                       // deactivate button if we have no data
                       for (var i = 0; i < 4; i++) {
                           if (!(linkedVizData.extendedHierarchyDataExists(i))) {
                               var expandedButton = d3.select('#expbutton' + i);
                               if (!(expandedButton.empty())) {
                                   expandedButton.style('pointer-events', 'none').style('opacity', 0.5);
                               }

                           } else {
                               var expandedButton = d3.select('#expbutton' + i);
                               if (!(expandedButton.empty())) {
                                   expandedButton.style('pointer-events', 'auto').style('opacity', 1);
                               }

                           }
                       }

                       sunburstContainer.select('#sunburstContractor')
                               .text(textForContractingButton)
                               .style('opacity','0');
//                       // Add a button for causing an expanded hierarchy disappear
//                       sunburstContainer.insert("div")
//                               .text(textForContractingButton)
//                               .attr('class', 'contractButton')
//                               .attr('id', 'sunburstContractor') ;
//

                   },

                   verifyLinkedData = function (cid) {
                       console.log('beginning Linked Hierarchy with cid = '+cid+'.');

                       d3.json("http://localhost:8028/cow/veryCross/feedMeLinkedData", function (incomingData) {


//                       d3.json("/bardwebclient/bardWebInterface/linkedData/"+cid, function (incomingData) {
                           // create an empty list, Just in case we get null data
                           linkedVizData.parseData(incomingData);
                           if (!linkedVizData.validateLinkedData()) {
                               console.log(' we have trouble with incoming linked data');
                               throw new Exception('bad data');
                           } else {
                               linkedVizData.cid(cid);
                               linkedVizData.appendConditionalStatusFields();
                           }
                           presentLinkedData();
                           linkedVizData.cleanupOriginalHierarchyData(2);
                       });// d3.json

                   },


                   presentLinkedData = function () {
                       // create an empty list, Just in case we get null data
                       var assays = [];

                       // Clean up the data.  De-dup, and assign
                       assays = readInData();

                       // Create the crossfilter for the relevant dimensions and groups.
                       sharedStructures.setAssay( crossfilter(assays) );

                       // Build everything were going to display
                       sharedStructures.setAllDataDcTable(displayManipulator.addDcTable(assay, 'data-table', 'assayId'));
                       sharedStructures.setBiologicalProcessPieChart (displayManipulator.addPieChart(assay, 'a0-chart', 'GO_biological_process_term', colors, pieChartWidth, pieChartRadius, innerRadius));
                       sharedStructures.setAssayFormatPieChart (displayManipulator.addPieChart(assay, 'a1-chart', 'assay_format', colors, pieChartWidth, pieChartRadius, innerRadius));
                       sharedStructures.setAssayIdDimensionPieChart (displayManipulator.addPieChart(assay, 'a2-chart', 'protein_target', colors, pieChartWidth, pieChartRadius, innerRadius));
                       sharedStructures.setAssayTypePieChart (displayManipulator.addPieChart(assay, 'a3-chart', 'assay_type', colors, pieChartWidth, pieChartRadius, innerRadius));

                       sharedStructures.setAssayIndex( assay.dimension(function (d) {
                           return d['index'];
                       }));

                       // We should be ready, display it
                       dc.renderAll();

                       // Finally, attach some data along with buttons and callbacks to the pie charts we've built
                       attachButtonsToThePieContainers('.columnsAssociatedWithPies', handleExpandOrContractClick, buttondata, d3.selectAll('#suburst_container'));


                   };

           return {
               verifyLinkedData: verifyLinkedData,
               presentLinkedData: presentLinkedData
           }
       }()); // generateLinkedPies


       // **********************************************************
       // The highest level call.  Everything starts from here.
       // **********************************************************
       var buildLinkedHierarchiesVisualization = function (cid) {
           generateLinkedPies.verifyLinkedData(cid);  //
       }


       /***
        * We only want to return one thing from this top-level module to simplify the calling
        */
       return buildLinkedHierarchiesVisualization;

   }());  // linkedVisualizationModule
</script>

</head>
<body>

<div id = "graphs">
    %{--<div id="histogram">--}%
        %{--<span id = "histTitle" class="graphTitle">Histogram</span>--}%
        %{--<a class="reset" href="javascript:histogramChart.filterAll();dc.redrawAll();" style="display: none;">reset</a>--}%
        %{--<span class="reset" style="display: none;"></span>--}%
        %{--<div class = "clearfix"></div>--}%
    %{--</div>--}%

    <div id = "pieCharts" class="pieCharts">

        <div id = "a0"  class = "pieChartContainer" style="left: 0.5%; top: 10px; width: 21%;  height: 300px;">
            <div id="a0-chart" class="pieChart">
                <span class="graphTitle">Biological process</span>
                <a class="reset" href="javascript:sharedStructures.resetBiologicalProcessPieChart();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

        </div>

        <div id = "a1"  class = "pieChartContainer" style="left: 22.5%; top: 10px; width: 21%; height: 300px;">
            <div id="a1-chart" class="pieChart">
                <span class="graphTitle">Assay format</span>
                <a class="reset" href="javascript:sharedStructures.resetAssayFormatPieChart();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

        </div>

        <div id = "a2"  class = "pieChartContainer" style="left: 44.5%; top: 10px;  width: 21%; height: 300px;">
            <div id="a2-chart" class="pieChart">
                <span class="graphTitle">Protein class</span>
                <a class="reset" href="javascript:sharedStructures.resetAssayIdDimensionPieChart();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

        </div>

        <div id = "a3"  class = "pieChartContainer" style="left: 66.5%; top: 10px; width: 21%; height: 300px;">
            <div id="a3-chart" class="pieChart">
                <span class="graphTitle">Assay type</span>
                <a class="reset" href="javascript:sharedStructures.resetAssayTypePieChart();" style="display: none;">reset</a>
                <span class="reset" style="display: none;"></span>
                <div class = "clearfix"></div>
            </div>

        </div>
        <div id = "a4"  class = "resetDrillButtons" style="left: 88.5%; top: 10px; width: 11.5%; height: 300px;">
        </div>


</div>






</div>





%{--</script>--}%

<table id="data-table" class="dc-data-table bordered"  style="position:absolute; left: 0px; top: 300px;">
    <thead>
    <tr >
        <th style='left: 0%; width: 21.5%;' class="columnsAssociatedWithPies">Biological process</th>
        <th style='left: 22.5%; width: 21%;' class="columnsAssociatedWithPies">Assay format</th>
        <th style='left: 44.5%; width: 21%;' class="columnsAssociatedWithPies">Protein class</th>
        <th style='left: 66.5%; width: 21%;' class="columnsAssociatedWithPies">Assay type</th>
        <th style='left: 88.5%; width: 11.5%;' >ADID</th>
    </tr>
    </thead>
</table>

<div id="widthTest" class="legendLine"></div>

<div id="suburst_container" class="container-fluid" style="position:absolute; left: 10px; top: 1000px;">
    <div id="subcontainer" class="row-fluid">
        <div class="span6">





        </div>

        <div class="span6" style="text-align: center; vertical-align: bottom;">


        </div>

    </div>


    <script>
        var createALegend = function (legendWidth,
                                      legendHeight,
                                      numberOfDivisions,
                                      colorScale,
                                      domSelector,
                                      minimumValue,
                                      maximumValue) {

            var  numberOfTics = 10,
                    dynamicRange = maximumValue - minimumValue;

            //
            // First build the core the legend, which is used no matter what the dynamic range
            //

            var rootLegendHolder = d3.select(domSelector).append("div")
                    .attr("id", "sunburstlegend")
                    .attr("class", "legendHolder")
                    .html('<br />Color assignment:<br /> x = active / <br />(active + inactive)');

            rootLegendHolder.append('hr')
                    .attr("width", '100%')
                    .attr("color", '#000');

            //
            // Define a few private methods that we will use later
            //
            var zeroDynamicRange = function (rootLegendHolder,maximumValue) {
                var  valueAdjustedForPrecision =  0;
                if (!(maximumValue === undefined) &&
                        ((typeof maximumValue) ==='number')) {
                    valueAdjustedForPrecision =  maximumValue.toPrecision(3);
                }

                rootLegendHolder.append('div')
                        .attr('class', 'legendExplanation')
                        .html('Dynamic range is 0.   All arcs had value <strong>'+valueAdjustedForPrecision+'</strong> and the color scheme is therefore constant.');
            };


            var nonzeroDynamicRange = function (numberOfTics,rootLegendHolder,legendWidth,legendHeight,colorScale,numberOfDivisions) {
                var arr = Array.apply(null, {length:numberOfDivisions + 1}).map(Number.call, Number),
                        intervals = (legendHeight) / numberOfDivisions;

                var legendHolder = rootLegendHolder.append("svg")
                        .attr("width", legendWidth)
                        .attr("height", legendHeight + 10)
                        .attr("transform", "translate(" + legendWidth / 2 + "," + (legendHeight * 0.5 + 5) + ")");

                var theLegend = legendHolder.selectAll('g')
                        .data(arr)
                        .enter()
                        .append('g')
                        .attr('class', 'legend');
                theLegend.append('rect')
                        .attr('x', legendWidth - 80)
                        .attr('y', function (d, i) {
                            return (i * intervals) + 6;
                        })
                        .attr('width', 10)
                        .attr('height', intervals)
                        .style('fill', function (d, i) {
                            return colorScale(i / numberOfDivisions);//color(d.name);
                        });

                var textSpacing = (legendHeight) / (numberOfTics * 2);
                theLegend.append('text')
                        .attr('x', legendWidth - 60)
                        .attr('y', function (d, i) {
                            return (i * 2) + 11;
                        })
                        .text(function (d, i) {
                            if ((i % textSpacing) === 0) {
                                var valToWrite = (i / numberOfDivisions);
                                return valToWrite.toString();
                            }
                            else
                                return '';
                        });
            };

            // Finally build the rest of the legends depending on whether the dynamic range
            //  is 0 or nonzero
            if (dynamicRange === 0) {
                zeroDynamicRange(rootLegendHolder,
                        maximumValue);
            } else {
                nonzeroDynamicRange ( numberOfTics,
                        rootLegendHolder,
                        legendWidth,
                        legendHeight,
                        colorScale,
                        numberOfDivisions );
            }

            return rootLegendHolder;
        }


        var ColorManagementRoutines = function (colorScale) {

            // Safety trick for constructors
            if (!(this instanceof ColorManagementRoutines)) {
                return new ColorManagementRoutines();
            }

            // public methods
            this.colorArcFill = function (d) {
                var returnValue = new String();
                if (d.ac != undefined) {
                    var actives = parseInt(d.ac);
                    var inactives = parseInt(d.inac);
                    if ((actives + inactives) === 0) // this should never happen, but safety first!
                        return "#fff";
                    var prop = actives / (actives + inactives);
                    returnValue = colorScale(prop);
                } else {
                    returnValue = "#FF00FF";
                }
                return returnValue;
            };

            this.colorText = function (d) {
                return '#000';
            };
        };


        var TooltipHandler = function ()  {
            // Safety trick for constructors
            if (! (this instanceof TooltipHandler)){
                return new TooltipHandler ();
            }

            var tooltip = d3.select("body")
                    .append("div")
                    .style("opacity", "0")
                    .style("position", "absolute")
                    .style("z-index", "10")
                    .attr("class", "toolTextAppearance");

            this.mouseOver = function(d) {
                if (d.name != '/') {
                    tooltip.html(d.name + '<br/>' + 'active in ' + d.ac + '<br/>' + 'inactive in ' + d.inac)
                            .transition()
                            .duration(200)
                            .style("opacity", "1");
                    return;
                }
                else {
                    return tooltip.html(null).style("opacity", "0");
                }

            };
            this.mouseMove = function (d) {
                if (d.name === '/')  {
                    return tooltip.html(null).style("opacity", "0");
                }  else {
                    return tooltip .style("top", (d3.event.pageY - 10) + "px")
                            .style("left", (d3.event.pageX + 10) + "px");
                }

            };
            this.mouseOut =  function () {
                return tooltip.style("opacity", "0");
            };
        };





        function createASunburst(width, height, padding, duration, colorScale, domSelector, cid, widgetIndex) {

            var tooltipHandler  = new TooltipHandler (),
                    colorManagementRoutines = new ColorManagementRoutines(colorScale),
                    radius = Math.min(width, height) / 2;


            var SunburstAnimation = function ()  {
                        // Safety trick for constructors
                        if (! (this instanceof SunburstAnimation)){
                            return new SunburstAnimation ();
                        }

                        // Need to keep track of how Zoomed we are
                        var currentZoomLevel = 0;
                        this.zoomLevel = function (newZoomLevel){
                            if (newZoomLevel === undefined){
                                return  currentZoomLevel;
                            }  else {
                                currentZoomLevel =  newZoomLevel;
                            }
                        }


                        this.arcTween = function (d) {
                            var my = maxY(d),
                                    xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
                                    yd = d3.interpolate(y.domain(), [d.y, my]),
                                    yr = d3.interpolate(y.range(), [d.y ? 100 : 0, radius]);
                            return function (d) {
                                return function (t) {
                                    x.domain(xd(t));
                                    y.domain(yd(t)).range(yr(t));
                                    return arc(d);
                                };
                            };
                        };

                        var maxY = function (d) {
                            return d.children ? Math.max.apply(Math, d.children.map(maxY)) : d.y + d.dy;
                        }

                        var isParentOf = function (p, c) {
                            if (p === c) return true;
                            if (p.children) {
                                return p.children.some(function (d) {
                                    return isParentOf(d, c);
                                });
                            }
                            return false;
                        };

                        this.isParentOf = isParentOf;

                    },
                    sunburstAnimation = SunburstAnimation();

            var pict = d3.select("body")
                    .append("div")
                    .style("position", "absolute")
                    .style("top", "565px")
                    .style("border", "1")
                    .style("left", "445px")
                    .attr("height", "150")
                    .attr("width", "150")
                    .style("z-index", "100")
                    .attr("class", "molstruct")
                    .style("pointer-events","none")
                    .append("img")
                    .attr("src", "/bardwebclient/chemAxon/generateStructureImageFromCID?cid="+cid+"&width=150&height=150");

            var svg = d3.select(domSelector).append("svg")
                    .attr("width", width)
                    .attr("height", height )
                    .attr("id", 'sunburst_graphics_holder')
                    .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + (height /2 ) + ")");


            var x = d3.scale.linear()
                    .range([0, 2 * Math.PI]);

            var y = d3.scale.linear()
                    .range([0, radius]);


            var partition = d3.layout.partition()
                            .value(function (d) {
                                return linkedVizData.adjustedPartitionSize(d);
                            }).sort(function(a,b){
                                return d3.descending(a.name, b.name);
                            })
                    ;
            var outerRadius = function (d) {
                return Math.max(0, y(d.y + d.dy));
            } ;
            var innerRadius = function (d) {
                return Math.max(0, y(d.y));
            };

            var arc = d3.svg.arc()
                    .startAngle(function (d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x)));
                    })
                    .endAngle(function (d) {
                        return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx)));
                    })
                    .innerRadius(innerRadius)
                    .outerRadius(outerRadius);

            // Method local to createASunburst to keep track of our depth
            var createIdForNode = function (incomingName) {
                var returnValue = 'null';
                var preliminaryGeneratedId = String(incomingName).replace(/\s/g,'_');
                if (preliminaryGeneratedId === '/') {
                    returnValue = 'root';
                } else {
                    returnValue = preliminaryGeneratedId;
                }
                return returnValue;
            }

            //
            // Change the cursor to zoom-in or zoom-out or nothing, all depending on the current expansion
            //  level of the sunburst.
            //
            var adjustSunburstCursor = function (d) {
                //
                // first deal with all non-root arcs
                //
                if ( !(d.parent  === undefined) &&
                        !(d.parent.name  === undefined) )  {
                    sunburstAnimation.zoomLevel(d.depth);
                    var parentName =  d.parent.name;
                    var nodeName =  d.name;
                    // reset the cursor for the last center of the sunburst, since it is no longer
                    // ready to support a zoom out.  Note that this select statement will also grab
                    // nny other stray classes indicating zoom out.
                    var previousCenterpiece = d3.select('.indicateZoomOut');
                    if (!(previousCenterpiece === undefined)){
                        previousCenterpiece.classed('indicateZoomIn', true)
                                .classed('indicateZoomOut', false)
                                .classed('indicateNoZoomingPossible', false);
                    }
                    var arcThatWasLastZoomed = d3.selectAll('.indicateNoZoomingPossible');
                    if (!(arcThatWasLastZoomed === undefined)){
                        arcThatWasLastZoomed.classed('indicateNoZoomingPossible', function(d){
                            return (d.name === "/");
                        });
                        arcThatWasLastZoomed.classed('indicateZoomIn',  function(d){
                            return (!(d.name === "/"));
                        });
                    }
                    // Now deal with the parent node, which DOES need to adopt
                    // a cursor indicating that a zoom out is possible.
                    var parentNode =  d3.select('#'+createIdForNode(parentName));
                    if (sunburstAnimation.zoomLevel()>0)   {
                        parentNode.classed('indicateZoomOut', true)
                                .classed('indicateZoomIn', false)
                                .classed('indicateNoZoomingPossible', false);
                    }
                    // Take the current arc ( the one that was clicked ) and
                    // turn off any mouse handling at all, since After clicking an arc
                    // it becomes fully expanded, and there is no purpose to clicking it again.
                    var currentNode =  d3.select('#'+createIdForNode(nodeName));
                    currentNode.classed('indicateZoomOut', false)
                            .classed('indicateZoomIn', false)
                            .classed('indicateNoZoomingPossible', true);

                }  // next deal with the root arc, in case the user clicked it.
                else if ( !(d  === undefined) &&
                        !(d.name  === undefined) ) {  // Root node clicked -- reset mouse ptr
                    sunburstAnimation.zoomLevel(d.depth);
                    var nodeName =  d.name;
                    // whatever had no cursor needs to be turned on
                    var arcThatWasLastZoomed = d3.selectAll('.indicateNoZoomingPossible');
                    if (!(arcThatWasLastZoomed === undefined)){
                        arcThatWasLastZoomed.classed('indicateNoZoomingPossible', function(d){
                            return (d.name === "/");
                        });
                        arcThatWasLastZoomed.classed('indicateZoomIn',  function(d){
                            return (!(d.name === "/"));
                        });
                    }
                    // take the current arc and turn the cursor off
                    var currentNode =  d3.select('#'+createIdForNode(nodeName));
                    currentNode.classed('indicateZoomOut', false)
                            .classed('indicateZoomIn', false)
                            .classed('indicateNoZoomingPossible', true);
                }
            }

            /***
             * When a user clicks on a segment of the expanded sunburst (thus 'zooming in' on a portion of the underlying data hierarchy)
             *  we need to provide a reset button so that they can later zoom back out. They won't need this button right away, since
             *  they could zoom back out by clicking on the Sunburst as long as it is expanded. After their current Sunburst is
             *  contracted, however, then they will need this button.
             *
             * @param drillDownName
             * @param d
             * @param treeNumber
             */
            var markDrillDown = function (drillDownName,d,treeNumber){
                var currentContainer = d3.select('#a4');// where to put the buttons
                var drillDownId =  'drilldownBut'+treeNumber;
                var drillDownLabel =  currentContainer.select ('#'+drillDownId);
                if (!(drillDownLabel.empty())) { // there is already a button to contract this node
                    if (drillDownName === '/') {   // we are in the root remove the name
                        drillDownLabel.remove ();
                    } else {
                        drillDownLabel.text(drillDownName);
                    }
                } else {
                    if (!(drillDownName === '/')) {   // we only need a node if we are outside of the root
                        //  We have at least one drill down in place. Make sure that people can reset it.
                        var resetDrillDownName = '/';
                        var originalD = d;
                        var originalTreeId =  d.treeid;
                        // Add some explanation, as long as it doesn't exist already
                        var drillLabel = d3.select('.drillLabel');
                        if (drillLabel.empty ()) {
                            currentContainer.append('div')
                                    .text('Click below to reset drilldown')
                                    .attr('id','drillLabel')
                                    .attr('class','drillLabel')
                                    .style('opacity', 0.5);
                        }
                        currentContainer.append('div')
                                .text(drillDownName)
                                .attr('id',drillDownId)
                                .attr('class','drill')
                                .style('pointer-events', 'none')
                                .style('opacity', 0.5)
                                .on('click',function(d){
                                    // the code below is executed when the user clicks the button ( thus requesting that
                                    //  the system undo the zoom in performed by the code above).
                                    var drillDownLabel =  currentContainer.select ('#'+drillDownId);
                                    linkedVizData.adjustMembershipBasedOnSunburstClick (resetDrillDownName, originalD,originalTreeId);
                                    linkedVizData.resetDerivedHierarchyRouteToOriginalRoot (originalTreeId) ;
                                    drillDownLabel.remove ();
                                    // Did we remove the last drill down? If so then remove the label as well
                                    var anyRemainingDrillDownLabels =  currentContainer.selectAll ('.drill');
                                    if(anyRemainingDrillDownLabels.empty()) {
                                        var drillLabelExplanation = d3.select('.drillLabel');
                                        if (!(drillLabelExplanation.empty ())) {
                                            drillLabelExplanation.remove () ;
                                        }
                                    }
                                });
                    }

                }
            }



            var hierarchyData = linkedVizData.filteredHierarchyData(widgetIndex);

            var path = svg.datum(hierarchyData).selectAll("path")
                    .data(partition.nodes)
                    .enter().append("path")
                    .attr("d", arc)
                    .attr("id", function (d) {
                        return createIdForNode(d.name);
                    })
                    .classed('indicateZoomIn', function(d) { return (d.depth || d.name!='/');} )
                    .classed('indicateNoZoomingPossible', function(d) { return (!(d.depth || d.name!='/'));} )
                    .style("stroke", "#fff")
                    .style("fill", function (d) {
                        return colorManagementRoutines.colorArcFill(d);
                    })
                    .on("click", click)
                    .on("mouseover", tooltipHandler.mouseOver)
                    .on("mousemove", tooltipHandler.mouseMove)
                    .on("mouseout",tooltipHandler.mouseOut );


            var text = svg.datum(hierarchyData)
                    .selectAll("text")
                    .data(partition.nodes);

            // Interpolate the scales!
            function click(d) {
                adjustSunburstCursor(d);
                markDrillDown (d.name,d, d.treeid);
                linkedVizData.adjustMembershipBasedOnSunburstClick (d.name, d, d.treeid);
                linkedVizData.resetRootForHierarchy (d, d.treeid) ;
                path.transition()
                        .duration(duration)
                        .attrTween("d", sunburstAnimation.arcTween(d));

                // Somewhat of a hack as we rely on arcTween updating the scales.
                text.style("visibility", function (e) {
                    return sunburstAnimation.isParentOf(d, e) ? null : d3.select(this).style("visibility");
                })
                        .transition()
                        .duration(duration)
                        .attrTween("text-anchor", function (d) {
                            return function () {
                                return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
                            };
                        })
                        .attrTween("transform", function (d) {
                            var multiline = (d.name || "").split(" ").length > 1;
                            return function () {
                                var angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                                        rotate = angle + (multiline ? -.5 : 0);
                                return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
                            };
                        })
                        .style("fill-opacity", function (e) {
                            return sunburstAnimation.isParentOf(d, e) ? 1 : 1e-6;
                        })
                        .each("end", function (e) {
                            d3.select(this).style("visibility", sunburstAnimation.isParentOf(d, e) ? null : "hidden");
                        });
            }


            var textEnter = text.enter().append("svg:text")
                    .style("fill-opacity", 1)
                    .style("pointer-events", "none")
                    .style("fill", function (d) {
                        return  colorManagementRoutines.colorText(d);
                    })
                    .attr("text-anchor", function (d) {
                        return x(d.x + d.dx / 2) > Math.PI ? "end" : "start";
                    })
                    .attr("dy", ".2em")
                    .attr("transform", function (d) {
                        var multiline = (d.name || "").split(" ").length > 1,
                                angle = x(d.x + d.dx / 2) * 180 / Math.PI - 90,
                                rotate = angle + (multiline ? -.5 : 0);
                        return "rotate(" + rotate + ")translate(" + (y(d.y) + padding) + ")rotate(" + (angle > 90 ? -180 : 0) + ")";
                    })
                    .on("click", click);


            textEnter.append("tspan")
                    .attr("x", 0)
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[0] : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[1] || "" : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[2] || "" : "";
                    });
            textEnter.append("tspan")
                    .attr("x", 0)
                    .attr("dy", "1em")
                    .text(function (d) {
                        return d.depth ? d.name.split(" ")[3] || "" : "";
                    });

            // Need to make some adjustments to fit the Sunburst in with the linked pies
            var adjustSunburstToFitInWithThePies = (function () {
                var sunburstContainer = d3.selectAll('#suburst_container')
                        .style('left', '-10px')
                        .style('top', '320px')
                        .style('pointer-events', 'none')
                        .style('opacity', '0');
                var molecularStructure = d3.selectAll('.molstruct')
                        .style('top', '765px')
                        .style('opacity', '0');
            })();
        }


    </script>


    <script>
//        var $data = [{"name":"/", "ac":"0", "inac":"0", "children": [
//                     ...
    var minimumValue=0;
    var maximumValue=1;

    var continuousColorScale = d3.scale.linear()
            .domain([0, 1])
            .interpolate(d3.interpolateRgb)
            .range(["#deffd9", "#74c476"]);

    </script>


    <div class="row-fluid">
        <div class="span9 pull-left">

            <div id="sunburstdiv">

            </div>

        </div>

        <div class="span3" style="height: 600px;">

            <div style="vertical-align: top;">
                <div  style="opacity: 0" id="sunburstContractor" class ='contractButton' ></div>
            </div>



            <div style="float:right;padding-top:200px;">
                <div id="legendGoesHere"></div>

            </div>

            <div style="text-align: center; vertical-align: bottom;">

                <select id="coloringOptions" style="visibility: hidden">
                    <option value="1"
                    >Color by activity</option>
                    <option value="2"
                    >Split classes by activity</option>
                    <option value="3" >Color by class</option>
                </select>
                <div  style="padding-top: 320px;"></div>
                <select id="activity" style="visibility: hidden">
                    <option value="1" >Active only</option>
                    <option value="2" >Inactive only</option>
                    <option value="3"
                            selected>Active and Inactive</option>
                </select>

            </div>

        </div>

    </div>
</div>
<script>

    $(document).ready(function () {
        linkedVisualizationModule(2722);
    });


</script>


</body>
</html>