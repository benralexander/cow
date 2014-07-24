<%--
  about the Bard approach to Research Data Management
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
                <article class="span8 head-holder"><h2>Research data management</h2></article>
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
                            BARD hierarchy top level concept definitions
                        </h3>


                        <h4>
                            Overview
                        </h4>

                        <p>
                            The definition of an assay (aka "assay definition") in BARD consists of two top-level concepts: the assay protocol, which defines the experimental conditions, and the biology, which defines the presumed biological subject of the assay, independent of the experimental conditions. Each of these concepts contains a set of terms that specify their details as the assay definition, which can be reused whenever depositing new data that were collected with all the same parameters defined in these two sets of terms.
                        </p>

                        <p>
                            The third top-level concept, project management, captures the information that is newly specified each time an assay protocol is executed, defined as an experiment (conceptually similar to a 'run' or an 'assay instance'). A project (e.g., a screening campaign) is a collection of experiments run to identify, validate, and optimize probe or tool compounds to interrogate specific biology . Individual experiments may or may not be associated to a project, although in the MLP they typically are associated with a project.
                        </p>

                        <p>
                            The fourth top-level concept, result, defines the types of measurements captured by the assay protocol, including both measured and derived values. This section also includes details such as parameters used in derivations, thresholds for "hit" calling and quality assessment parameters. Results are treated separately from the assay definition so that appending new result measurements to an existing assay definition, e.g., changing from single-point percent inhibition to IC50 curves, is allowed while maintaining the same assay protocol and biology target.
                        </p>

                        <p>
                            Each experiment (a.k.a. run, assay instance) in BARD combines an assay definition (assay protocol + biology ) with one or more result types. Each experiment is further annotated by the structure of its results, how the measured values were captured and reported (such as tested concentrations), and whether the experiment was executed to support an existing project.
                        </p>

                        <p>
                            Each experiment may vary in certain parameters, usually related to the perturbagens being tested, that do not change the underlying assay protocol or biology (together, the assay definition). For example, the same assay definition may be run at a single concentration or in dose-response format, against a different compound collection, or by a different laboratory - the exact same assay protocol run by different groups will be considered the same assay definition. In addition, a single assay definition may be used for different purposes in different overall screening projects or campaigns, perhaps as a primary screen in one case and as a counterscreen in another. Finally, in addition to the role of an experiment in a screening campaign, the project management concept captures the overall purpose (e.g., therapeutic discovery for disease X) of the project with which each experiment is associated.
                        </p>

                        <h4>
                            First-level term definitions from the BARD ontology
                        </h4>

                        <p>
                            <dl>
                        <dt>assay protocol</dt>
                        <dd>An experimental protocol designed to test the effect of a perturbagen on a biological entity, measuring one or more readouts facilitated by an assay design and assay type, and recording the results as one or more endpoints that quantify or qualify the extent of perturbation.</dd>

                        <dt>biology</dt>
                        <dd>A biological entity or process that is the presumed subject of the assay; may refer to a macromolecule whose activity is being regulated, or to a cell-biological process (e.g., neurite outgrowth). Refers specifically to the assay being defined without regard to the larger project context in which the assay may be executed; the larger project biological context is captured separately, in the 'project management' section.</dd>

                        <dt>result</dt>
                        <dd>A description of a set of data generated by executing an assay protocol and the context of those data, including defining what parameters the results are measuring and what calculation methods are used to derive the results. These parameters refer to the entire dataset, not to the specific results of any one perturbagen; the latter can be viewed individually only following data submission. </dd>

                        <dt>project management</dt>
                        <dd>Information specific to the project under which a deposited experiment was run; does not modify the experimental conditions of the defined assay protocol, but provides a larger context for interpreting the results. </dd>

                         </dl>

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