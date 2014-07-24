<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 12/6/13
  Time: 10:35 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>


    <title>jqgrid</title>
    <script src="../js/bardHomepage/jquery-1.8.3.min.js"></script>
    <script src="../js/jqgrid/jquery.jqGrid.src.js"></script>
    <script src="../js/jqgrid/grid.locale-en.js"></script>
    <script src="../js/jqgrid/jquery-ui-1.10.3.custom.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'ui.jqgrid.css')}" />
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'jquery-ui.css')}" />

    <style>
        /*this override doesn't work'*/
    /*input .ui-jqgrid {*/
        /*height: 20px;*/
    /*}*/

    </style>
    <script>

        function  cellFormatter (cellvalue, options, rowObject) {
            var rowIdInt = parseInt(options.rowId);
            var rowIdModulus = (rowIdInt% 8)+1;
            var imageReference = '../images/moles' +rowIdModulus +'.png';
            return "<img src='" +imageReference + "' alt='" + cellvalue + "' title='" + cellvalue + "' />";
        };

        function reloadGrid(){
            $("#list2").trigger("reloadGrid");
        };



//                function AA(){
//            $("#list2").jqGrid({
//                url:'feedMeJson',
//                datatype: "json",
//                height: 255,
//                width: 600,
//                colNames:['ID','Date', 'Client','note', 'Amount','Tax','Total'],
//                colModel:[
//                    {name:'id',index:'id', width:55, sorttype:"int"},
//                    {name:'invdate',index:'invdate', width:130, sorttype:"date"},
//                    {name:'name',index:'name asc', width:100, sorttype:"string"},
//                    {name:'note',index:'note', width:150, sortable:false, formatter: cellFormatter },
//                    {name:'amount',index:'amount', width:80, align:"right", sorttype:"float"},
//                    {name:'tax',index:'tax', width:80, align:"right", sorttype:"float"},
//                    {name:'total',index:'total', width:80,align:"right", sorttype:"float"}
//                ],
//                rowNum: 21,
//                scroll:1,
//                //rowTotal:2000,
//                jsonReader: {
//                    repeatitems : true,
//                    cell:"",
//                    id: "0"
//                },
//                scroll: 1,
//                loadonce:true,
//                mtype: "GET",
//                rownumbers: true,
//                rownumWidth: 40,
//                 pager: '#pager2',
//                sortname: 'id',
//                viewrecords: true,
//                sortorder: "asc",
//                virtualscroll:"true",
//                caption:""
//            });
//            //$("#list2").jqGrid('navGrid','#pager2',{del:false,add:false,edit:false},{},{},{},{multipleSearch:true});
//            $("#list2").jqGrid('navGrid','#pager2',  // Turn on the icons
//                    {edit:true,
//                        add:true,
//                        del:true,
//                        search:true,
//                        refresh:true,
//                        refreshstate:'current',
//                        view:true
//                    },
//                    // Edit dialog parameters
//                    {reloadAfterSubmit: false,
//                        closeAfterEdit: true
//                    },
//                    // Add dialog parameters
//                    {reloadAfterSubmit: true,
//                        closeAfterAdd: true
//                    },
//                    // Delete dialog parameters
//                    {reloadAfterSubmit: false},
//                    // Search dialog parameters
//                    {},
//                    // View dialog parameters
//                    {});
//        }
//

                function AAA(){
                    $("#list2").jqGrid({

                        // size
                        width: "100%",
                        height: "900",

                        // communication with the backend
                        url:'feedMeJson', // callback URL to retrieve data
                        datatype: "json", // type of data from server

                        // data model
                        sortname: 'id', // default sorting name
                        colNames:['id',/*'Date',*/ 'Promiscuity','Structure', 'AC 50','EC 50','Percent inhibition'], // appears in the header row
                        colModel:[ // all data in grid defined here
                            {name:'id',index:'id',  sortable:false, width:100},
                            /*{name:'invdate',index:'invdate',  sortable:false, width:130, frozen: true}, */
                            {name:'name',index:'name asc, invdate', width:100},
                            {name:'note',index:'note', width:150, sortable:false, formatter: cellFormatter},
                            {name:'amount',index:'amount', width:180, align:"center"},
                            {name:'tax',index:'tax', width:180, align:"center"},
                            {name:'AC50',index:'AC50', width:180,align:"center"}
                        ],


                        // dynamic behavior
                        hoverrows: true, //  respond to mouse hover

                        // this next section is unnec since we adhere to th default(?)
//                        "jsonReader":{  //
//                            "repeatitems":false,
//                            "subgrid":{"repeatitems":false}
//                        },
                        gridview: true,   // true==faster, BUT cannot use tree, subGrid, or the afterInsertRow event

                        //critical control over scrolling
                        scroll: 1,  // 1 :  IMPORTANT: comment out this line and we go to ordinary paging. Leave this line in for virtual paging.
                        rowNum:100, // how many records do we want to download at once

                        // paging control
                        viewrecords: true,  // view information about paging
                        rowList:[10,50,100],  //options for paging
                        recordpos: "right",  // location of the text indicating our position
                        pgbuttons: true,   //  allow control over paging with buttons
                        pginput: true,     //  allow 'go to page' option
                        pgtext: "page {0} out of {1}", // text for page controller
                        recordtext: "records [{0} - {1}] of {2}",  // text for record indicator
                        emptyrecords: "No records to view",
                        loadtext: "Loading...",


                        //                       "prmNames":{"page":"page","rows":"rows","sort":"sidx","order":"sord","search":"_search","nd":"nd","id":"id","filter":"filters","searchField":"searchField","searchOper":"searchOper","searchString":"searchString","oper":"oper","query":"grid","addoper":"add","editoper":"edit","deloper":"del","excel":"excel","subgrid":"subgrid","totalrows":"totalrows","autocomplete":"autocmpl"},
                        "loadError":function(xhr,status, err){
                            try {
                                alert('foo');
                                jQuery.jgrid.info_dialog(
                                     jQuery.jgrid.errors.errcap,'<div class="ui-state-error">'+ xhr.responseText +'</div>',
                                     jQuery.jgrid.edit.bClose,{buttonalign:'right'}
                            );}
                            catch(e) { alert(xhr.responseText);}
                        },
                        "pager":"#pager2",  // where does the pager user interface set
                        shrinkToFit: true,
//                        height: 'auto',
                        caption:"s"
                    });
                    jQuery("#list2").jqGrid('setGroupHeaders', {
                        useColSpanStyle: true,
                        groupHeaders:[
                            {startColumnName: 'amount', numberOfColumns: 3, titleText: '<a href=\'/\'><em>ADID=232</em></a>'}
                        ]
                    });
                    $("#list2").jqGrid('navGrid','#pager2',{del:false,add:false,edit:false},{},{},{},{multipleSearch:true});

                }


    </script>
</head>

<body>
<h1>Molecular spreadsheet premium!</h1>

<table id="list2"></table>
<div id="pager2"></div>
<script>
    $(document).ready(function() {
AAA();
    });
</script>
<form>
    <input type=button value='Reload' onclick="reloadGrid();" />
</form>


</body>
</html>