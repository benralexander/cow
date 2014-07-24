<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 12/31/13
  Time: 9:27 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>SlickGrid example 1: Basic grid</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css/slick', file: 'slick.grid.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css/slick/smoothness', file: 'jquery-ui-1.8.16.custom.css')}" />
    %{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'css/slick', file: 'examples.css')}" />--}%


%{--Now write over some of the values in slick.grid.CSS    --}%
 <style>
.slick-header-column.ui-state-default {
    position: relative;
    display: inline-block;
    overflow: visible;
    -o-text-overflow: ellipsis;
    text-overflow: ellipsis;
    height: 32px;
    line-height: 16px;
    margin: 0;
    padding: 4px;
    border-right: 1px solid silver;
    border-left: 0px;
    border-top: 0px;
    border-bottom: 0px;
    float: left;
}
.slick-header.ui-state-default, .slick-headerrow.ui-state-default {
    width: 100%;
    overflow: hidden;
    border-left: 0px;
}

.slick-header-columns, .slick-headerrow-columns {
    position: relative;
    /*white-space: nowrap;*/
    cursor: default;
    overflow: visible;
}
.ui-sortable {
    white-space: normal;
}
 </style>

%{--We can put some custom classes here, such as those referenced by headerCssClass, to see if we can--}%
%{--manipulate the appearance of the grid that way--}%
<style>
    .trialHeaderAppearance {
        word-break: keep-all;
        position: relative;
        background: #add8e6;
    }

</style>



    %{--Previously everything in the following block was held in ../slick-default-theme.css--}%
%{--Note that the only thing that needs to change if you want to copy it back there is to remove the characters "/css"--}%
%{--from the URL references--}%
<style>
.slick-header-columns {
    /*background: url('../css/images/header-columns-bg.gif') repeat-x center bottom;*/
    border-bottom: 1px solid silver;
}

.slick-header-column {
    /*background: url('../css/images/header-columns-bg.gif') repeat-x center bottom;*/
    border-right: 1px solid silver;
}

.slick-header-column:hover, .slick-header-column-active {
    background: white url('../css/images/header-columns-over-bg.gif') repeat-x center bottom;
}

.slick-headerrow {
    background: #fafafa;
}

.slick-headerrow-column {
    background: #fafafa;
    border-bottom: 0;
    height: 100%;
}

.slick-row.ui-state-active {
    background: #F5F7D7;
}

.slick-row {
    position: absolute;
    background: white;
    border: 0px;
    line-height: 20px;
}

.slick-row.selected {
    z-index: 10;
    background: #DFE8F6;
}

.slick-cell {
    padding-left: 4px;
    padding-right: 4px;
}

.slick-group {
    border-bottom: 2px solid silver;
}

.slick-group-toggle {
    width: 9px;
    height: 9px;
    margin-right: 5px;
}

.slick-group-toggle.expanded {
    background: url(../css/images/collapse.gif) no-repeat center center;
}

.slick-group-toggle.collapsed {
    background: url(../css/images/expand.gif) no-repeat center center;
}

.slick-group-totals {
    color: gray;
    background: white;
}

.slick-cell.selected {
    background-color: beige;
}

.slick-cell.active {
    border-color: gray;
    border-style: solid;
}

.slick-sortable-placeholder {
    background: silver !important;
}

.slick-row.odd {
    background: #fafafa;
}

.slick-row.ui-state-active {
    background: #F5F7D7;
}

.slick-row.loading {
    opacity: 0.5;
    filter: alpha(opacity = 50);
}

.slick-cell.invalid {
    border-color: red;
    -moz-animation-duration: 0.2s;
    -webkit-animation-duration: 0.2s;
    -moz-animation-name: slickgrid-invalid-hilite;
    -webkit-animation-name: slickgrid-invalid-hilite;
}

@-moz-keyframes slickgrid-invalid-hilite {
    from { box-shadow: 0 0 6px red; }
    to { box-shadow: none; }
}

@-webkit-keyframes slickgrid-invalid-hilite {
    from { box-shadow: 0 0 6px red; }
    to { box-shadow: none; }
}
</style>



%{--Note that the only thing that needs to change if you want to copy it back there is to remove the characters "/css"--}%
%{--from the URL references--}%
    %{--Everything in the following style block used to go and examples.CSS. Presumably it will go in --}%
    %{--another CSS block when the experimentation phase is done.--}%
<style>
    /*@import url('../slick-default-theme.css');*/

    * {
        font-family: arial;
        font-size: 8pt;
    }

    body {
        background: beige;
        padding: 0;
        margin: 8px;
    }

    h2 {
        font-size: 10pt;
        border-bottom: 1px dotted gray;
    }

    ul {
        margin-left: 0;
        padding: 0;
        cursor: default;
    }

    li {
        background: url("../css/images/arrow_right_spearmint.png") no-repeat center left;
        padding: 0 0 0 14px;

        list-style: none;
        margin: 0;
    }

    #myGrid {
        background: white;
        outline: 0;
        border: 1px solid gray;
    }

    .grid-header {
        border: 1px solid gray;
        border-bottom: 0;
        border-top: 0;
        background: url('../css/images/header-bg.gif') repeat-x center top;
        color: black;
        height: 32px;
        line-height: 32px;
    }

    .grid-header label {
        display: inline-block;
        font-weight: bold;
        margin: auto auto auto 6px;
    }

    .grid-header .ui-icon {
        margin: 4px 4px auto 6px;
        background-color: transparent;
        border-color: transparent;
    }

    .grid-header .ui-icon.ui-state-hover {
        background-color: white;
    }

    .grid-header #txtSearch {
        margin: 0 4px 0 4px;
        padding: 2px 2px;
        -moz-border-radius: 2px;
        -webkit-border-radius: 2px;
        border: 1px solid silver;
    }

    .options-panel {
        -moz-border-radius: 6px;
        -webkit-border-radius: 6px;
        border: 1px solid silver;
        background: #f0f0f0;
        padding: 4px;
        margin-bottom: 20px;
        width: 320px;
        position: absolute;
        top: 0px;
        left: 650px;
    }

        /* Individual cell styles */
    .slick-cell.task-name {
        font-weight: bold;
        text-align: right;
    }

    .slick-cell.task-percent {
        text-align: right;
    }

    .slick-cell.cell-move-handle {
        font-weight: bold;
        text-align: right;
        border-right: solid gray;

        background: #efefef;
        cursor: move;
    }

    .cell-move-handle:hover {
        background: #b6b9bd;
    }

    .slick-row.selected .cell-move-handle {
        background: #D5DC8D;
    }

    .slick-row .cell-actions {
        text-align: left;
    }

    .slick-row.complete {
        background-color: #DFD;
        color: #555;
    }

    .percent-complete-bar {
        display: inline-block;
        height: 6px;
        -moz-border-radius: 3px;
        -webkit-border-radius: 3px;
    }

        /* Slick.Editors.Text, Slick.Editors.Date */
    input.editor-text {
        width: 100%;
        height: 100%;
        border: 0;
        margin: 0;
        background: transparent;
        outline: 0;
        padding: 0;

    }

    .ui-datepicker-trigger {
        margin-top: 2px;
        padding: 0;
        vertical-align: top;
    }

        /* Slick.Editors.PercentComplete */
    input.editor-percentcomplete {
        width: 100%;
        height: 100%;
        border: 0;
        margin: 0;
        background: transparent;
        outline: 0;
        padding: 0;

        float: left;
    }

    .editor-percentcomplete-picker {
        position: relative;
        display: inline-block;
        width: 16px;
        height: 100%;
        background: url("../css/images/pencil.gif") no-repeat center center;
        overflow: visible;
        z-index: 1000;
        float: right;
    }

    .editor-percentcomplete-helper {
        border: 0 solid gray;
        position: absolute;
        top: -2px;
        left: -9px;
        background: url("../css/images/editor-helper-bg.gif") no-repeat top left;
        padding-left: 9px;

        width: 120px;
        height: 140px;
        display: none;
        overflow: visible;
    }

    .editor-percentcomplete-wrapper {
        background: beige;
        padding: 20px 8px;

        width: 100%;
        height: 98px;
        border: 1px solid gray;
        border-left: 0;
    }

    .editor-percentcomplete-buttons {
        float: right;
    }

    .editor-percentcomplete-buttons button {
        width: 80px;
    }

    .editor-percentcomplete-slider {
        float: left;
    }

    .editor-percentcomplete-picker:hover .editor-percentcomplete-helper {
        display: block;
    }

    .editor-percentcomplete-helper:hover {
        display: block;
    }

        /* Slick.Editors.YesNoSelect */
    select.editor-yesno {
        width: 100%;
        margin: 0;
        vertical-align: middle;
    }

        /* Slick.Editors.Checkbox */
    input.editor-checkbox {
        margin: 0;
        height: 100%;
        padding: 0;
        border: 0;
    }
    </style>

    <style>
    .cell-story {
        white-space: normal !important;
        line-height: 19px !important;
    }

    .loading-indicator {
        display: inline-block;
        padding: 12px;
        background: white;
        opacity: 0.5;
        color: black;
        font-weight: bold;
        z-index: 9999;
        border: 1px solid red;
        -moz-border-radius: 10px;
        -webkit-border-radius: 10px;
        -moz-box-shadow: 0 0 5px red;
        -webkit-box-shadow: 0px 0px 5px red;
    }

    .loading-indicator label {
        padding-left: 20px;
        background: url('../images/ajax-loader-small.gif') no-repeat center left;
    }

    .grid-header {
        border: 1px solid gray;
        border-bottom: 0;
        border-top: 0;
        /*background: url('../images/header-bg.gif') repeat-x center top;*/
        color: black;
        height: 36px;
        line-height: 36px;
    }

    .slick-header-columns {
        height: 32px;
        line-height: 32px;
    }

    </style>
</head>
<body>

<div style="width:700px;float:left;">
    <div class="grid-header" style="width:100%">
        <label>Molecular spreadsheet</label>
        <span style="float:right;display:inline-block;">
            <input type="button" id="PidGroup" value="Group by AID">
        </span>
    </div>
    <div id="myGrid" style="width:100%;height:600px;"></div>
    <div id="pager" style="width:100%;height:20px;"></div>
</div>
<div style="margin-left:750px;margin-top:40px;;">
</div>


<script src="../js/slick/lib/firebugx.js"></script>

<script src="../js/slick/lib/jquery-1.7.min.js"></script>
<script src="../js/slick/lib/jquery-ui-1.8.16.custom.min.js"></script>
<script src="../js/slick/lib/jquery.event.drag-2.2.js"></script>
<script src="../js/slick/lib/jquery.jsonp-2.4.min.js"></script>


<script src="../js/slick/slick.core.js"></script>
%{--<script src="../js/slick/slick.remotemodel.js"></script>--}%
<script src="../js/slick/slick.grid.js"></script>

<script>
    // describe the data model we maintain on the browser
    (function ($) {

        function RemoteModel() {
            // private
            var PAGESIZE = 50;
            var STATIC_COLUMNS = 4;
            var data = {length: 0};
            var searchstr = "";
            var sortcol = null;
            var sortdir = 1;
            var h_request = null;
            var req = null; // ajax request
            var headers = null;
            var columnHeaders = null;

            // events
            var onDataLoading = new Slick.Event();
            var onDataLoaded = new Slick.Event();


            function init() {
            }

            function columnExtractor(  rawHeaderInfo )   {
                var developingColumns = [];
                if ((typeof rawHeaderInfo === 'undefined') ||
                    (typeof rawHeaderInfo.headers === 'undefined') ||
                    (typeof rawHeaderInfo.headers.exptHeaders === 'undefined') ||
                        ( rawHeaderInfo.headers.exptHeaders.length <STATIC_COLUMNS )){
                    console.log('Variable intended for header extraction is flawed');
                } else {
                    developingColumns.push ({id: "a0", name: "Structure", field: "f1", width: 120, formatter: molecularStructureFormatter, sortable: false});
                    developingColumns.push ({id: "a1", name: "CID", field: "f2", width: 80, formatter: numericalDataFormatter, cssClass: "cell-story", sortable: true});
                    developingColumns.push ({id: "a2", name: "Promiscuity", field: "f3", width: 80, formatter: numericalDataFormatter, cssClass: "cell-story", sortable: true});
                    developingColumns.push ({id: "a3", name: "Active Inactive", field: "f4", width: 60, formatter: numericalDataFormatter, headerCssClass: "trialHeaderAppearance", sortable: false});
                    for ( var i=STATIC_COLUMNS ; i<(STATIC_COLUMNS+rawHeaderInfo.headers.exptHeaders.length) ; i++ ) {
                        developingColumns.push ({id: "a"+(i), name: rawHeaderInfo.headers.exptHeaders[i-STATIC_COLUMNS].resultType, field: "f"+(i), width: 90, formatter: numericalDataFormatter, cssClass: "cell-story", sortable: true});
                    }
                }
                columnHeaders = developingColumns;
            } ;


            function isDataLoaded(from, to) {
                for (var i = from; i <= to; i++) {
                    if (data[i] == undefined || data[i] == null) {
                        return false;
                    }
                }

                return true;
            }


            function retriveColumnHeaders(){
                var retrieveHeadersUrl = "retrieveHeaders";
                var returnValue;
//                returnValue = $.getJSON(retrieveHeadersUrl,function(response){
//                    onHeaderSuccess(response)
//                });
                returnValue = $.ajax({
                    dataType: "json",
                    url:retrieveHeadersUrl,
                    data: "",
                    success:onHeaderSuccess,
                    async: false
                 });
                return columnHeaders;
            }


            function onHeaderSuccess(response) {
                console.log(' made it In to onHeaderSuccess subroutine') ;
                columnExtractor(  response ) ;
                console.log(' made it Out of onHeaderSuccess.') ;
            }


            function clear() {
                for (var key in data) {
                    delete data[key];
                }
                data.length = 0;
            }

            /**
            *  This method is called every time the grid needs more data.  This method has the responsibility
            *  of deciding whether we already have those data in hand or whether we need to ask for something
            *  new from the server If were going to go to the server then we need to put together a suitable
            *   set of parameters to make sure we get back what we want.
            */
            function ensureData(from, to) {

                // If a call is already in progress then interrupt it -- we need to make a new one
                if (req) {
                    req.abort();
                    // this next for loop makes no sense at all to me. I will commented out and see what happens
                    for (var i = req.fromPage; i <= req.toPage; i++)
                        data[i * PAGESIZE] = undefined;
                }

                // We request data one page at a time.  Figure out the 'from' and 'to' For the page we're about to request,
                // and then as the very last step we will convert that into rows.
                if (from < 0) {
                    from = 0;
                }

                if (data.length > 0) {
                    to = Math.min(to, data.length - 1);
                }

                var fromPage = Math.floor(from / PAGESIZE);
                var toPage = Math.floor(to / PAGESIZE);

                while (data[fromPage * PAGESIZE] !== undefined && fromPage < toPage)
                    fromPage++;

                while (data[toPage * PAGESIZE] !== undefined && fromPage < toPage)
                    toPage--;

                if (fromPage > toPage || ((fromPage == toPage) && (data[fromPage * PAGESIZE] !== undefined &&
                        data[fromPage * PAGESIZE] !== null))) {
                    // TODO:  This would be a good place to implement a look ahead
                    onDataLoaded.notify({from: from, to: to});
                    return;
                }

                // Having decided on the page, we now convert those page numbers into specific rows
                var rowsRequested= 50;
                var requestedStart =  (fromPage*rowsRequested);
                var requestedEnd = requestedStart +  rowsRequested;

                // Have we been launched as part of a header click? If so then specify the row and the direction of the sort
                var columnAndDirection = "";
                if (sortcol != null) {
                    columnAndDirection = ("&sortby=" + sortcol +"&sord=" + ((sortdir > 0) ? "asc" : "desc"));
                }
                var url = "feedMeJson?start=" + requestedStart + "&end=" + requestedEnd+columnAndDirection;

                // Ready to initiate a new timeout
                if (h_request != null) {
                    clearTimeout(h_request);
                }

                h_request = setTimeout(function () {
                    for (var i = fromPage; i <= toPage; i++)
                        data[i * PAGESIZE] = null; // null indicates a 'requested but not available yet'

                    onDataLoading.notify({from: from, to: to});

                    console.log (' server request prepared: URL ='+url +'.');
                    req = $.getJSON(url,function(resp){
                                onSuccess(resp);
                            }
                    );
                    req.fromPage = fromPage;
                    req.toPage = toPage;
                }, 50);
            }


            function onError(fromPage, toPage) {
                alert("error loading pages " + fromPage + " to " + toPage);
            }

            // pull the information out of our Ajax return call and push it into 'data', which is our
            //  the externally visible variable we use for transfer.
            function onSuccess(resp) {
                var from = parseInt( resp.start);
                var to = parseInt( resp.end);
                // if you want to limit the number of records we handle, this is the place to do it
                // As an example:
                // data.length = Math.min(parseInt(resp.records),1000); // limitation of the API
                data.length = parseInt(resp.records);
//                console.log ('received->start ='+ from +', end ='+ to+', records ='+ data.length +'.');

                headers = resp.headers;

                //  first element of array is  null . How can we fix this problem?
                for (var i = 0; i < resp.rows.length; i++) {
                    // Here are the pieces of information we will pass to the grid.
//                    data[from+i] = { num:resp.rows[i].id,
//                                     story:resp.rows[i].name,
//                                     points:resp.rows[i].amount,
//                        ac50:resp.rows[i].tax,
//                        ec50:resp.rows[i].note};
                    data[from+i] = { id:resp.rows[i].id,
                        promisc:resp.rows[i].name,
                        inhib:resp.rows[i].amount,
                        ec50:resp.rows[i].tax,
                        ac50:resp.rows[i].AC50};
                    data[from+i].index = from+i;

                 }
                 req = null;

                onDataLoaded.notify({from: from, to: to});
            }


            function reloadData(from, to) {
                for (var i = from; i <= to; i++)
                    delete data[i];

                ensureData(from, to);
            }


            function setSort(column, dir) {
                sortcol = column;
                sortdir = dir;
                clear();
            }

            function setSearch(str) {
                searchstr = str;
                clear();
            }


            init();

            return {
                // properties
                "data": data,
                "columnHeaders": columnHeaders ,

                // methods
                "clear": clear,
                "isDataLoaded": isDataLoaded,
                "ensureData": ensureData,
                "reloadData": reloadData,
                "setSort": setSort,
                "setSearch": setSearch,
                "retriveColumnHeaders":retriveColumnHeaders,

                // events
                "onDataLoading": onDataLoading,
                "onDataLoaded": onDataLoaded
            };
        }

        // Slick.Data.RemoteModel
        $.extend(true, window, { Slick: { Data: { RemoteModel: RemoteModel }}});
    })(jQuery);

</script>



<script>
    // ********* control the data grid on the browser ************
    //  Handle the appearance, define the events and handlers, define
    //   all user facing widgets.
    //
    //  Everything in the section is of course dependent on the previously defined data model.
    var grid;
    var loader = new Slick.Data.RemoteModel();
    var runawayRecursionDetector = 0;


    var storyTitleFormatter = function ( row,// Integer value of r ow
                                         cell,  // Integer value of column
                                         value,  // Unformatted matched value
                                         columnDef, // Column header
                                         dataContext  // Map defining this row
            ) {
        return value;
    };

    var molecularStructureFormatter = function (row, cell, value, columnDef, dataContext) {
        var rowIdInt = parseInt(row);
        var rowIdModulus = (rowIdInt% 8)+1;
        var imageReference = '../images/moles' +rowIdModulus +'.png';
        return "<img src='" +imageReference + "' alt='" + value + "' title='" + value + "' />";
    };

    var numericalDataFormatter = function (row, cell, value, columnDef, dataContext) {
        var s ="<b>" +value + "</b><br/>";
        return s;
    };


    var dateFormatter = function (row, cell, value, columnDef, dataContext) {
        return (value.getMonth()+1) + "/" + value.getDate() + "/" + value.getFullYear();
    };

    // the names specified by the field named 'field'  must match  those provided in the
    //  variable 'data' in the remoteModel portion of the code (look for the onSuccess method)
    var columns = columnExtractor (loader.headers) ;
//    var columns = [
//        {id: "id", name: "ID", field: "id", width: 40, sortable: true},
//        {id: "promisc", name: "Promiscuity", field: "promisc", width: 80, formatter: storyTitleFormatter, cssClass: "cell-story", sortable: true},
//        {id: "structure", name: "Structure", field: "structure", width: 120, formatter: molecularStructureFormatter, cssClass: "cell-story", sortable: false},
//        {id: "ac50", name: "AC50", field: "ac50", width: 120, formatter: numericalDataFormatter, cssClass: "cell-story", sortable: true},
//        {id: "ec50", name: "EC50", field: "ec50", width: 120, formatter: numericalDataFormatter, cssClass: "cell-story", sortable: true},
//        {id: "inhib", name: "Percent inhibition", field: "inhib", width: 60, sortable: true,  headerCssClass: "trialHeaderAppearance"}
//    ];

    var subColumns  = [
        '',
        '<span></span>',
        '<span></span>',
        '<span>AC50</span>',
        '<span>EC50</span>',
        '<span>inhib.</span>'
    ];

    var options = {
        rowHeight: 100,
        editable: false,
        enableAddRow: false,
        enableCellNavigation: false,
        showHeaderRow: true,
        headerRowHeight: 40
    };

    var loadingIndicator = null;

 function columnExtractor(  rawHeaderInfo )   {
        if (rawHeaderInfo != null)  {
            console.log('Hooray!   We now have data for the column extract or');
        }
        var developingColumns = [];
        developingColumns.push ({id: "id", name: "ID", field: "id", width: 40, sortable: true});
        developingColumns.push ({id: "promisc", name: "Promiscuity", field: "promisc", width: 80, formatter: storyTitleFormatter, cssClass: "cell-story", sortable: true});
        developingColumns.push ({id: "structure", name: "Structure", field: "structure", width: 120, formatter: molecularStructureFormatter, cssClass: "cell-story", sortable: false});
        developingColumns.push ({id: "ac50", name: "AC50", field: "ac50", width: 120, formatter: numericalDataFormatter, cssClass: "cell-story", sortable: true});
        developingColumns.push ({id: "ec50", name: "EC50", field: "ec50", width: 120, formatter: numericalDataFormatter, cssClass: "cell-story", sortable: true});
        developingColumns.push ({id: "inhib", name: "Percent inhibition", field: "inhib", width: 60, sortable: true,  headerCssClass: "trialHeaderAppearance"});
        return  developingColumns;
    } ;



    $(function () {

        var columnHdrs = loader.retriveColumnHeaders();

        grid = new Slick.Grid("#myGrid", loader.data,columns , options);

        grid.onViewportChanged.subscribe(function (e, args) {
            var vp = grid.getViewport();
            loader.ensureData(vp.top, vp.bottom);
        });


        grid.onSort.subscribe(function (e, args) {
            console.log("Sort requested on field="+args.sortCol.field + ", direction ="+args.sortAsc + ".");
            loader.setSort(args.sortCol.field, args.sortAsc ? 1 : -1);
            var vp = grid.getViewport();
            loader.ensureData(vp.top, vp.bottom);
        });

        // Event handler -- we have initiated a data transfer with the server
        loader.onDataLoading.subscribe(function () {
            if (!loadingIndicator) {
                loadingIndicator = $("<span class='loading-indicator'><label>Buffering...</label></span>").appendTo(document.body);
                var $g = $("#myGrid");

                loadingIndicator
                        .css("position", "absolute")
                        .css("top", $g.position().top + $g.height() / 2 - loadingIndicator.height() / 2)
                        .css("left", $g.position().left + $g.width() / 2 - loadingIndicator.width() / 2);
            }

            loadingIndicator.show();
        });

        // Event handler -- we have received everything were going to get for this transmission from the server
        loader.onDataLoaded.subscribe(function (e, args) {
            console.log(' data received');
            for (var i = args.from; i <= args.to; i++) {
                grid.invalidateRow(i);
            }
         //   columns = columnExtractor (loader.headers) ;
            grid.updateRowCount();
            grid.render();

            //  Now we have to perform a check. Since the browser is reacting asynchronously to the data returned by the server,
            //  and since the user is allowed to scroll all over the table in whatever way they like, it is possible to end up
            //  with one or more lines in the data structure that aren't filled.  Therefore I am plum and hear the following kludgy
            //  workaround: run over the whole data structure and see if we ended up with any nulls (presumably when one incoming
            //  record interrupted another before he could be stored).  If so then interrogate the table to find out the viewport,
            //  and perform another round-trip to make sure at the least that we have data for every place the user can currently see.
            //  Note that this involves throwing a new event from inside the handler for the event we are throwing -- obviously
            //  a recipe for recursive ctack overflow if for some reason that particular row really SHOULD be null.  Therefore
            //  wwe also use a variable that is scoped outside of this routine as a runaway recursion detector, to make certain
            //  that the browser doesn't fall into an infinite loop.  A blank row is ugly, to be sure, but a crashing browser
            //  is far uglier.
            if (typeof loader.data.length !== undefined) {
                var numberOfNulls  = 0;
                for (var loop = 0;loop<loader.data.length;loop++){
                    if (loader.data[loop]=== null ){
                        numberOfNulls++;
                    }
                }
                if ((numberOfNulls>0)  && (runawayRecursionDetector < 1)) {
                    console.log ('... And nulls existed');
                    runawayRecursionDetector = 1;
                    var vp = grid.getViewport();
                    loader.ensureData(vp.top, vp.bottom);
                }
            }

            loadingIndicator.fadeOut();
            runawayRecursionDetector = 0;
        });

        $("#txtSearch").keyup(function (e) {
            if (e.which == 13) {
                loader.setSearch($(this).val());
                var vp = grid.getViewport();
                loader.ensureData(vp.top, vp.bottom);
            }
        });

        loader.setSearch($("#txtSearch").val());
        loader.setSort("create_ts", -1);
        grid.setSortColumn("date", false);

        var subheaderCounter = 0;
        var totalNumberOfSubHeaders = subColumns.length;
        $('.slick-headerrow-column').each(
                function() {
                    if (subheaderCounter < totalNumberOfSubHeaders) {
                        $(this).append(subColumns[subheaderCounter++]);
                    } else {
                        alert(' array overrun.  Reactor core meltdown imminent.')
                    }
                }
        );

        // load the first page
        grid.onViewportChanged.notify();
    })
</script>



</html>