<%--
  about history of the Bard project
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
    <link media="all" rel="stylesheet" href="../css/bootstrapHomepage/BardText.css">
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
            <strong class="logo"><a href="../scaledDownHomePage/index">BARD BioAssay Research Database</a></strong>
            <ul class="social-networks">
                <li><a href="#" title="Share">Share</a></li>
                <li><a href="#" title="Google" class="google">Google</a></li>
            </ul>
            <nav class="nav-panel">
            </nav>
        </div>
    </header>


    %{--Block to hold the main search textblock--}%
    <div class="search-panel">
        <div class="container-fluid">
            <div class="row-fluid">
                <aside class="span2"></aside>
                <article class="span8 head-holder"><h2>About History:</h2></article>
                <aside class="span2"></aside>
            </div>

        </div>
    </div>


    %{--Enhanced data and advanced tools block--}%
    <article class="hero-block">
        <div class="container-fluid">
            <div class="hero-area">
                <div class="row-fluid">
                    <aside class="span2"></aside>
                    <article class="span8">

                        <h3>
                            The Explosion and Evolution of Chemical Biology Data
                        </h3>

                        <p>
                            BARD’s challenge is complex, but its goal is quite simple: To unlock the full potential and value of years of research to empower scientists and benefit all mankind.
                        </p>
                        <p>
                            Consider how far technology has come in the eight years since the founding of the National Institute of Health’s Molecular Libraries Program (MLP): Computers with amazing power, datacenters with staggering capacity, all connected by a robust and mature Internet. Just as technology continuously transforms itself, so it transforms the work of researchers.
                        </p>

                        <p>
                            Since 2005, the MLP has endeavored to harness technology to expand and catalog the relationships between individual chemical entities and biological functions. Through a network of High Throughput Screening (HTS) centers, the MLP has generated reams of bioassay data over the course of thousands of screening campaigns, many of which producing promising probes. However, this data, published with little standardization to PubChem, tends to be limited by the moment, place and technology in which it was created.                        </p>

                        <p>
                            Over the same eight years, numerous other public and private online databases have appeared, each with their own ontologies and blend of various data: chemical structures, patent information, compound activity, affinity data, biological activity, and others. Also, pharmaceutical companies have begun developing their own proprietary systems to integrate various types of data to meet their specific needs.     </p>

                        <p>
                            For the biomedical research community, all this promising technology has resulted in a labyrinth of resources and overly complex tools. Also, publically shared data too often lacks the proper contextual information for interpretation. Worse still, it lacks adequate quality controls (e.g., five established databases disagree on the structure of 150 top-selling drugs.) Lastly, pharmaceuticals is a tight-lipped business where even trace evidence of multimillion dollar IP left in the public domain can compromise a company and end careers. The result is an environment that is inhospitable for empirical science, informed business strategy or unfettered exploration.
                        </p>

                        <p>
                            So while technology enables us to gather exponentially more data, at the same time it can obscure valuable information and true knowledge in a haze of noise that makes it difficult to know what is known and discern what is significant. But not anymore, thanks to BARD.
                        </p>


                    </article>
                    <aside class="span2"></aside>
                </div>
            </div>
        </div>
    </article>


    %{--This is the main carousel, with three big pictures and associated buttons--}%
    <div>
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