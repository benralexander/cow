
<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->

<head>
<title>Probe targets</title>

%{--<script src="/bardwebclient/static/plugins/jquery-1.7.1/js/jquery/jquery-1.7.1.min.js" type="text/javascript" ></script>--}%

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="/bardwebclient/static/images/favicon.ico" type="image/x-icon">

<g:javascript src="d3.js"/>
<g:javascript src="sunburst/createASunburst.js"/>
<g:javascript src="sunburst/createALegend.js"/>




</head>
<body>


<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6">

        </div>

        <div class="span6" style="text-align: center; vertical-align: bottom;">
            <br/>
            <h2>Class hierarchy</h2>
            <br/>
        </div>

    </div>



    <div class="row-fluid">
        <div class="span9 pull-left">

            <g:uploadForm action="upload1">
                <input type="file"  class="btn btn-default btn-sm" name="myFile1" />
                <input type="submit"   class="btn btn-default btn-sm" />
            </g:uploadForm>

            <g:uploadForm action="upload2">
                <input type="file"  class="btn btn-default btn-sm" name="myFile2" />
                <input type="submit"   class="btn btn-default btn-sm" />
            </g:uploadForm>

        </div>

        <div class="span3" style="padding-top: 50px;  height: 600px;">
            <div style="float:right;">

            </div>


        </div>
    </div>

    <div class="row-fluid">
        <div class="span9 pull-left">
        </div>

        <div class="span3 pull-left">
            <button id="toggler" onclick="sunburst.toggleColorDisplay()">toggle color</button>
        </div>
    </div>
    <hr>
</div>


</body>
</html>