
<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>boxwhisk</title>
    <meta name="layout" content="core"/>
    <script src="../js/jquery-2.0.3.min.js"></script>
    %{--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>--}%
    <g:javascript src="ctrp/d3.js"/>
    <g:javascript src="ctrp/d3tooltip.js"/>
    <g:javascript src="bootstrap3.js" />

    %{--<script src="/bardwebclient/static/plugins/jquery-1.7.1/js/jquery/jquery-1.7.1.min.js" type="text/javascript" ></script>--}%

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="/bardwebclient/static/images/favicon.ico" type="image/x-icon">

    <g:javascript src="d3.js"/>
    <g:javascript src="sunburst/createASunburst.js"/>
    <g:javascript src="sunburst/createALegend.js"/>

    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'bootstrap.css')}" />


    <style>
    p {
        margin-top:10px;
        padding:50px;
        border: 1px solid lightgrey;
    }
    #myDiv {
        margin-top: 10px;
    }
    </style>

    <script type="text/javascript">
        $(function () {
            $("[rel='tooltip']").tooltip();
        });
    </script>
</head>
<body>


<div>
    <style>
    .chart-example {
        margin: 20px;
        padding: 10px;
        border: solid 1px #babdb6;
    }

    /* Chapter 2 */
    .data-item {
        border: solid 1px black;
        margin: 4px;
        padding: 4px;
        background-color: #eeeeec;
    }
    </style>
    <style>
    .btn-custom {
        background-color: hsl(195, 100%, 21%) !important;
        background-repeat: repeat-x;
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#0fc3ff", endColorstr="#00506b");
        background-image: -khtml-gradient(linear, left top, left bottom, from(#0fc3ff), to(#00506b));
        background-image: -moz-linear-gradient(top, #0fc3ff, #00506b);
        background-image: -ms-linear-gradient(top, #0fc3ff, #00506b);
        background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #0fc3ff), color-stop(100%, #00506b));
        background-image: -webkit-linear-gradient(top, #0fc3ff, #00506b);
        background-image: -o-linear-gradient(top, #0fc3ff, #00506b);
        background-image: linear-gradient(#0fc3ff, #00506b);
        border-color: #00506b #00506b hsl(195, 100%, 13%);
        color: #fff !important;
        text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.52);
        -webkit-font-smoothing: antialiased;
    }
    .notableText {
        font-family: "Arial Black", Gadget, sans-serif;
        font-size: 14pt;
    }
    </style>
</div>


<div class="container-fluid">

    <div class="row-fluid">

        <div class="span4">

        </div>

        <div class="span4">
            <h1>Build a Sunburst</h1>
        </div>
        <div class="span4">

        </div>

    </div>


    <div class="row-fluid">

        <div class="span2">

        </div>

        <div class="span8">
            <h4>Supply your own hierarchy definition files in JSON format and the software will draw a sunburst</h4>
            You will need to supply  two separate files.  One defines the relationships between the different elements in the hierarchy ( that is, which nodes are the children of which other nodes).
            We will call this the <strong>elements</strong> file. The other file defines the names which will be presented for each arc in the Sunburst. We will call this file the <strong>categories</strong>  file.
        </div>
        <div class="span2">

        </div>

    </div>

    <div class="row-fluid">

        <br/>
    </div>



    <div class="row-fluid">
        <div class="span2">

            <h3>
                <span rel="tooltip"
                      data-toggle="tooltip"
                      data-trigger="hover"
                      data-placement="right"
                      data-html="true"
                      data-title='click to download a sample elements.json file'>
                    <a href="${createLink(controller:'probe', action:'clickToDownloadElementsFile')}">Elements file</a>
                </span>

            </h3>

        </div>
        <div class="span9 fileNamer">
            <span>
                <g:uploadForm action="upload1">
                    <g:if test="${firstFileName}">
                        <span class="notableText">Elements file successfully loaded</span>
                    </g:if>
                    <g:else>
                        <input type="file"  class="btn btn-default btn-sm" name="myFile1" />
                        <input type="submit"   class="btn-custom" />
                    </g:else>
                </g:uploadForm>

            </span>


        </div>

        <div class="span1 pull-left">
            %{--<span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span>--}%
            %{--<span rel="tooltip"--}%
                  %{--data-toggle="tooltip"--}%
                  %{--data-trigger="hover"--}%
                  %{--data-placement="bottom"--}%
                  %{--data-html="true"--}%
                  %{--data-title='<div><p>Example:<br/>[{"index":"1","name":"protein"},<br/>--}%
%{--{"index":"2","name":"chaperone"}]</p></div>'>--}%
                %{--<span style="font-size:32pt">?</span>--}%
            %{--</span>--}%
        </div>
    </div>
    <div class="row-fluid">

        <div class="span2   col-md-2" >
            <h3>
                <span rel="tooltip"
                      data-toggle="tooltip"
                      data-trigger="hover"
                      data-placement="right"
                      data-html="true"
                      data-title='click to download a sample categories.json file'>
                    <a href="${createLink(controller:'probe', action:'clickToDownloadCategoriesFile')}">Categories file</a>
                </span>
           </h3>

        </div>
        <div class="span9 col-md-9 fileNamer">

            <g:uploadForm action="upload2">
                <g:if test="${firstFileName}">
                    <input type="file"  class="btn btn-default btn-sm" name="myFile2" />
                    <input type="hidden" name="myFile1" value="${myFile1}"/>
                    <input type="submit"   class="btn-custom" />
                </g:if>
                <g:else>
                    <input type="file"  class="btn btn-default btn-sm" name="myFile2"  disabled/>
                    <input type="submit"   class="btn-custom"  readonly/>
                </g:else>
             </g:uploadForm>

        </div>
        <div class="span1  col-md-1">
            %{--<span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span>--}%
            %{--<span rel="tooltip"--}%
                  %{--data-toggle="tooltip"--}%
                  %{--data-trigger="hover"--}%
                  %{--data-placement="bottom"--}%
                  %{--data-html="true"--}%
                  %{--data-title='<div><p>Example:<br/>[{"hierarchy":"1.2.22"},<br/>--}%
                  %{--{"hierarchy":"1.2.23"}]</p></div>'>--}%
                %{--<span style="font-size:32pt">?</span>--}%
            %{--</span>--}%
        </div>

    </div>

    <hr>
</div>

</body>


<script>
</script>
</html>