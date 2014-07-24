<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>BARD</title>
    <link href="../css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="../css/bootstrap-responsive.css" rel="stylesheet" media="screen">


    <script src="../js/crossfilter.js"></script>
    <script src="../js/d3.js"></script>
    <script src="../js/dc.js"></script>
    <style>
    #img0{
        position: relative;
        font-family: Arial;
        top: 50px;
    }
    .img0_text_shared
    {
        position: absolute;
        width: 66%;
        top: 50px;
    }
    .img0_text .subtext_shared
    {
        padding-left: 5%;
        text-align: left;
    }

    @media only screen and (min-width: 1100px) {
        .img0_text
        {
            font-size: 20pt;
            max-width: 800px;
        }
        .img0_text .subtext
        {
            margin-top: 50px;
            font-size: 14pt;
        }

    }
    @media only screen and (max-width: 1100px) {
        .img0_text
        {
            font-size: 18pt;
            max-width: 800px;
        }
        .img0_text .subtext
        {
            margin-top: 40px;
            font-size: 12pt;
        }

    }
    @media only screen and (max-width: 800px) {
        .img0_text
        {
            font-size: 16pt;
            max-width: 600px;
            top: 40px;
        }
        .img0_text .subtext
        {
            margin-top: 20px;
            font-size: 10pt;
        }

    }

    @media only screen and (max-width: 600px) {
        .img0_text
        {
            font-size: 12pt;
            max-width: 400px;
            top: 20px;
        }
        .img0_text .subtext
        {
            margin-top: 10px;
            font-size: 8pt;
        }

    }
    @media only screen and (max-width: 400px) {
        .img0_text
        {
            font-size: 10pt;
            max-width: 300px;
            top: 5px;
        }
        .img0_text .subtext
        {
            margin-top: 2px;
            font-size: 8pt;
        }
    }
    .searchBar
    {
        height: 150px;
        max-width: 1240px;
        background: rgb(4,84,119); /* Old browsers */
        background: -moz-linear-gradient(-45deg,  rgba(4,84,119,1) 0%, rgba(6,42,59,1) 36%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, right bottom, color-stop(0%,rgba(4,84,119,1)), color-stop(36%,rgba(6,42,59,1))); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(-45deg,  rgba(4,84,119,1) 0%,rgba(6,42,59,1) 36%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(-45deg,  rgba(4,84,119,1) 0%,rgba(6,42,59,1) 36%); /* Opera 11.10+ */
        background: -ms-linear-gradient(-45deg,  rgba(4,84,119,1) 0%,rgba(6,42,59,1) 36%); /* IE10+ */
        background: linear-gradient(135deg,  rgba(4,84,119,1) 0%,rgba(6,42,59,1) 36%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#045477', endColorstr='#062a3b',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */
    }
    .searchBar  .inputArea {
        border: 2px red solid;
        vertical-align: middle;
    }
    </style>
</head>

<body>
<script src="../js/jquery-2.0.3.min.js"></script>
<script src="../js/bootstrap.js"></script>

<div class="container-fluid">
    <header class="row-fluid" id="bard_header">
        <div class="span5">
            <img src="../images/bard_logo_small.png" class="img-responsive" alt="Search and analyze your own way">
        </div>

        <div class="span7">
            <nav id="navbar-example" class="navbar" role="navigation">
                <div class="navbar-inner">
                    <ul class="nav">
                        <li class="dropdown">
                            <a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">About us <b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Details about Bard</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a id="drop2" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">How to <b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop2">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">How to search</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Work with results</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Submit data</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Use securely</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Create and use plug-ins</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" id="drop3" role="button" class="dropdown-toggle" data-toggle="dropdown">Support<b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop3">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Community</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Report a bug</a></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Contact us</a></li>
                                <li role="presentation" class="divider"></li>
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Separated link</a></li>
                            </ul>
                        </li>

                        <li class="dropdown">
                            <a href="#" id="drop4" role="button" class="dropdown-toggle" data-toggle="dropdown">Submissions<b class="caret"></b></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="drop4">
                                <li role="presentation"><a role="menuitem" tabindex="-1" href="http://twitter.com/fat">Details about Submissions</a></li>
                            </ul>

                        </li>

                    </ul>
                </div><!-- /.nav-collapse -->
            </nav>

        </div>
    </header>

    <section class="row-fluid" id="img0">
        <div class="span12">
            <img src="../images/imag0_01.jpg" class="img-responsive" alt="Search and analyze your own way">
            <div   class="row-fluid">
                <div class="span8">
                    %{--<span  class="img0_text_shared img0_text">--}%
                        %{--Enhanced data and advanced tools <span class="hidden-phone">to accelerate drug discovery</span>--}%
                        %{--<div   class="subtext_shared subtext">--}%
                            %{--<span class=" hidden-phone">Introducing BARD, the powerful new bioassay database from the NIH Molecular Libraries Program.--}%
                            %{--<span class="visible-desktop">Now with unprecedented  efficiency, scientists can develop and test hypotheses on the influence of--}%
                            %{--different chemical probes on biological functions</span></span>--}%
                        %{--</div>--}%
                    %{--</span>--}%


                </div>
                <div class="span4">
                </div>
            </div>
        </div>

    </section>

    <article class="row-fluid searchBar" id="searchBar">
        <div class="span12" >
            <div class="form-group span4 offset4">
            <form role="form">
                    <label for="searchInput">SEARCH BARD</label>
                    <input type="text" class="form-control inputArea" id="searchInput" placeholder="Search by Chemistry, Biology, Structure and More">
            </form>
            </div>
            <div class="span4"></div>
        </div>
    </article>


    <section class="row-fluid" id="news">
        <div class="span12">
            Here is the news

        </div>
    </section>







    <aside class="row-fluid" id="bard_carousel">

        <div id="carousel-example-generic" class="carousel slide hidden-phone" data-interval="false">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                <li data-target="#f" data-slide-to="1"></li>
                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner">
                <div class="item active">
                    <img src="../images/Slide01_01.jpg" class="img-responsive" alt="Public bioassay data">

                    <div class="carousel-caption">
                        Public bioassay data
                    </div>
                </div>

                <div class="item" id="#f">
                    <img src="../images/Slide02_01.jpg" class="img-responsive" alt="The power of a common language">

                    <div class="carousel-caption">
                        The power of a common language -- hurrah
                    </div>
                </div>

                <div class="item">
                    <img src="../images/Slide03_01.jpg" class="img-responsive" alt="Search and analyze your own way">

                    <div class="carousel-caption">
                        Search and analyze your own way-hurrah
                    </div>
                </div>

            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                <span class="icon-prev"></span>
            </a>
            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                <span class="icon-next"></span>
            </a>
        </div>
    </aside>


    <article class="row-fluid" id="bardIsGrowing">
        <div class="span12">
        </div>
    </article>



    <nav class="row-fluid" id="bardLinks">
        <div class="span12">
        </div>
    </nav>


    <footer class="row-fluid" id="bardFooter">
        <div class="span12">
        </div>
    </footer>



</div>
</body>
</html>
