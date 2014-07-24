<%--
  Broad home page
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BARD</title>
    <link href='http://fonts.googleapis.com/css?family=Lato:400,400italic,700,700italic,900,900italic,300,300italic'
          rel='stylesheet' type='text/css'>
    <link media="all" rel="stylesheet" href="../css/bootstrapHomepage/bootstrap.css">
    <link media="all" rel="stylesheet" href="../css/bootstrapHomepage/bootstrap-responsive.css">
    <link media="all" rel="stylesheet" href="../css/bootstrapHomepage/BardHomepage.css">
    <script src="../js/bardHomepage/jquery-1.8.3.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/jquery-1.8.3.min.js"><\/script>')</script>
    <script src="../js/bardHomepage/bootstrap.js"></script>
    <script src="../js/bardHomepage/jquery.main.js"></script>
    <!--[if lt IE 9]><link rel="stylesheet" href="../css/bootstrapHomepage/ieBardHomepage.css" media="screen" /><![endif]-->
    <!--[if IE]><script src="../js/bardHomepage/ie.js"></script><![endif]-->
</head>

<body>
<div id="wrapper">

%{--The control area at the top of the page is all contained within this header--}%
<header class="navbar navbar-static-top" id="header">
    <div class="container-fluid">
        <strong class="logo"><a href="#">BARD BioAssay Research Database</a></strong>
        <ul class="social-networks">
            <li><a href="#" title="Share">Share</a></li>
            <li><a href="#" title="Google" class="google">Google</a></li>
        </ul>
        <nav class="nav-panel">
         </nav>
    </div>
</header>

%{--Enhanced data and advanced tools block--}%
<article class="hero-block">
    <div class="container-fluid">
        <div class="hero-area">
            <div class="row-fluid">
                <article class="span8">
                    <h1>Enhanced data and advanced tools to accelerate drug discovery.</h1>

                    <p>Introducing BARD, the powerful new bioassay database from the NIH Molecular Libraries Program. Now with unprecedented efficiency, scientists can develop and test hypotheses on the influence of different chemical probes on biological functions.</p>
                    <a href="../scaledDownHomePage/bardtext_aboutBard" class="btn btn-primary">LEARN MORE</a>
                </article>
                <aside class="span4"></aside>
            </div>
        </div>
    </div>
</article>

%{--Block to hold the main search textblock--}%
<div class="search-panel">
    <div class="container-fluid">

        <div class="head-holder">
        <h2>BARD is nearing its initial public release</h2>
        </div>

        <div class="search-block" style="padding-right: 0px">
        Join our
        <a href="mailto:bard@broadinstitute.org?Subject=Bard%20mailing%20list">mailing list</a>  to find out more







        </div>
    </div>
</div>


%{--This is the main carousel, with three big pictures and associated buttons--}%
<div class="articles-gallery slide" id="articles-gallery" data-interval="false">
    <a href="#articles-gallery" class="btn-prev" data-slide="prev">Previous</a>
    <a href="#articles-gallery" class="btn-next" data-slide="next">Next</a>

    <div class="carousel-inner">
        <article class="item active">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span6 img-box">
                        <img src="../images/bardHomepage/img-01.png" alt="image description">
                    </div>

                    <div class="span6 pull-right article">
                        <div class="article-holder">
                            <h1>Search and analyze your own way.</h1>

                            <p>Keeping the promise of the MLP, BARD gives you nimble access to most all the program’s data through an array of query, analysis and visualization tools.</p>
                            <a href="../scaledDownHomePage/bardtext_aboutBard" class="btn btn-primary">LEARN MORE ABOUT BARD</a>
                        </div>
                    </div>
                </div>
            </div>
        </article>
        <article class="item">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span6 img-box">
                        <img src="../images/bardHomepage/img-02.png" alt="image description">
                    </div>

                    <div class="span6 pull-right article">
                        <div class="article-holder">
                            <h1>The power of a common language.</h1>

                            <p>A focused but flexible ontology designed to capture fully annotated preclinical data from multiple scientific disciplines for comprehensive search results.</p>
                            <a href="../scaledDownHomePage/bardtext_rdm" class="btn btn-primary">RESEARCH DATA MANAGEMENT</a>
                        </div>
                    </div>
                </div>
            </div>
        </article>
        <article class="item">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span6 img-box">
                        <img src="../images/bardHomepage/img-03.png" alt="image description">
                    </div>

                    <div class="span6 pull-right article">
                        <div class="article-holder">
                            <h1>Public bioassay data – organized, standardized and put into context.</h1>

                            <p>Public data sets cleaned up, organized and enhanced with assay, experiment and project contextual information for reliable and productive searches.</p>
                            <a href="../scaledDownHomePage/bardtext_aboutBard" class="btn btn-primary">LEARN MORE ABOUT BARD</a>
                        </div>
                    </div>
                </div>
            </div>
        </article>
    </div>
</div>

%{--The BARD is  growing line sits on its own above the blocks--}%

%{--Now we have a footer section containing a bunch of links--}%
<footer id="footer">
    <div class="footer-columns">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span4">
                    <h3>About</h3>
                    <ul>
                        <li><a href="../scaledDownHomePage/bardtext_rdm">Research Data Mgt.</a></li>
                        <li><a href="../scaledDownHomePage/bardtext_history">History</a></li>
                        <li><a href="../scaledDownHomePage/bardtext_developmentTeam">Development Team</a></li>
                    </ul>
                </div>


                <div class="span4">
                    <h3>Technology</h3>
                    <ul>
                        <li><a href="../scaledDownHomePage/bardtext_architecture">Architecture &amp; Design</a></li>
                        <li><a href="#">REST API</a></li>
                        <li><a href="#"  style="text-decoration:line-through;">Source code on GitHub <img src="../images/bardHomepage/comingSoon2.png" alt="coming soon"></a></li>
                    </ul>
                </div>

                <div class="span4 by">
                    <strong class="logo-by"><a href="http://www.chemaxon.com/" title="Powered by ChemAxon">Powered by ChemAxon</a></strong>

                    <p>&copy; 2013 BARD</p>
                </div>
            </div>
        </div>
    </div>

    %{--The bottom line of the whole page--}%
    <div class="footer-info">
        <div class="container-fluid">
            <ul>
                <li><a href="http://www.nih.gov/">National Institutes of Health</a></li>
                <li><a href="#">U.S. Department of Health and Human Services</a></li>
                <li><a href="http://www.usa.gov/">USA.gov – Government Made Easy</a></li>
            </ul>
        </div>
    </div>
</footer>
</div>
</body>
</html>