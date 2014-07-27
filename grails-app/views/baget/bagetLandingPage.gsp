<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>QQ plot</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css"/>
    <script type="text/javascript" src="../js/d3.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="ba">
    <link rel="icon" href="../../baget.ico">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<link media="all" rel="stylesheet" href="../css/baget/baget.css">
<link media="all" rel="stylesheet" href="../css/baget/bootstrap.min.css">
<link media="all" rel="stylesheet" href="../css/baget/ie-emulation-modes-warning.js">
<link media="all" rel="stylesheet" href="../css/baget/ie10-viewport-bug-workaround.js">
<script src="../js/d3.js"></script>
<script src="../js/baget/qqplot.js"></script>
<script src="../js/baget/d3tooltip.js"></script>
<script src="../js/baget/slider.js"></script>
<script>
   var displaySignificanceIndicator  =  function ()  {
       console.log ('gg='+d3.select('.qqcontrols').style('display'));
       if (d3.select('.qqcontrols').style('display')==='block') {
           d3.select('.qqcontrols').style('display','none');
           qqPlot.displaySignificanceLine(false).render();
       }  else {
           d3.select('.qqcontrols').style('display','block');
           qqPlot.displaySignificanceLine(true).render();
           var significanceLineValue = qqPlot.significanceLineValue();
           slider.sliderLocation(significanceLineValue);
       }

   };
</script>

<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<div class="container">

    <div class="starter-template">
        <h1>QQ Plot</h1>
        <p class="lead">Initial product of the Broad Accumulated Graphical Elements Team <it>(BAGET)</it><br></p>
    </div>

</div><!-- /.container -->

<div class="jumbotron">
    <div class="container">

        <div class="row">
            <div class="col-md-8"><div id="scatterPlot1"></div></div>
            <div class="col-md-1"></div>
            <div class="col-md-1">
                <div class='buttonHolder' height="100%">
                <div id="btnmgr" class="btn-group-vertical" style="vertical-align: bottom">
                    <button type="button" class="btn btn-default btn-sm" onclick="displaySignificanceIndicator ()">significance indicator
                    </button>
                    %{--<button type="button" class="btn btn-default btn-sm">--}%
                        %{--<span class="glyphicon glyphicon-star"></span>--}%
                    %{--</button>--}%
                </div>
                </div>
            </div>
            <div class="col-md-2"><div class='qqcontrols'><div id='slider'></div></div></div>
        </div>



    </div>
</div>
<script>

    var margin = {top: 30, right: 20, bottom: 50, left: 70},
            width = 700 - margin.left - margin.right,
            height = 400 - margin.top - margin.bottom;

    data = [
        {x:3.5,
            y:3.5,
            popup:'rs79716074'
        },
        {x:4.9,
            y:4.99,
            popup:'more useful information'
        },
        {x:7,
            y:8,
            popup:'more information'
        }
    ];
    var significanceValue = 100;
    var qqPlot ;
    d3.json("http://localhost:8028/cow/box/qqPlotData", function (error, json) {

        qqPlot=baget.qqPlot()
                .selectionIdentifier("#scatterPlot1")
                .width(width)
                .height(height)
                .margin(margin)
//                 .xAxisLabel('expected')
//                 .yAxisLabel('observed')
//                 .xAxisAccessor(function (d) {
//                     return d.x;
//                 })
//                 .yAxisAccessor(function (d) {
//                     return d.y;
//                 })
//                 .tooltipAccessor(function (d) {
//                     return d.popup
//                 })
                .displayIdentityLine (true)
                .displaySignificanceLine(false)
               // .significanceLineValue (significanceValue)
                .assignData(json);
        qqPlot.render();




    } );


    var defaultInterquartileMultiplier = function(d){
        console.log('a'+ d.toString());
    };
    var onBrushMoveDoThis = function(d){
        if (typeof(qqPlot) !=="undefined") {
            qqPlot.significanceLineValue(d);
        }
    };
    var onBrushEndDoThis = function(){
        if (typeof(qqPlot) !=="undefined") {
            qqPlot.render();
        }
    };
    var minimumInterquartileMultiplier = 180,
            maximumInterquartileMultiplier = 0,
            onScreenStart = 10,
            onScreenEnd = 200;

    var slider = baget.slider(minimumInterquartileMultiplier,
            maximumInterquartileMultiplier,
            onScreenStart,
            onScreenEnd,
            'vertical',3300,onBrushMoveDoThis,onBrushEndDoThis) ;






</script>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/baget/bootstrap.min.js"></script>
</body>
</html>