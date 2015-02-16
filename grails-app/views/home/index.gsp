<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 11/25/2014
  Time: 8:50 PM
--%>

<%@ page import="temporary.BuildInfo" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Cow graphics</title>
    <meta name="layout" content="core"/>
    <style>
    dl {
        font-size: 12pt;
    }
    dt {
        font-family: arial, helvetica, verdana, sans-serif;
        font-size: 14pt;
        padding-top: 20px;
        margin-left: 20px;
    }
    dd {
        font-family: arial, helvetica, verdana, sans-serif;
        font-weight: bold;
        margin-left: 30px;
    }
    body {
        padding: 25px;
    }
    .titleDox  {
        margin:50px;
        padding: 50px;
        border: 1px solid black;
        width: 600px;
        align-content: center;
    }
    hr {
        width: 6%;
        height: 2px;
        margin-left: auto;
        margin-right: auto;
        background-color:#81F7F3;
        color:#FF0066;
        border: 0 none;
        margin-bottom:5px;
    }
    </style>

</head>

<body>
<div class="titleDox">
    <h1> Assorted graphics examples</h1>
    <p>
    <h5>I figured I'd put all my old test harnesses in one place in case they have utility for someone else</h5>
    </p>

    <h1 style="display:none">Ben R Alexander</h1>
    <h1 style="display:none">D3</h1>
</div>
<dl>
    <dt><a href="<g:createLink controller='angle' action='angled_diamond'/>">early Sunburst</a></dt>
    <dd>One of my first experiments with the Sunburst.  Mono color, and containing a representation of the Panther protein category hierarchy for a single drug candidate</dd>

    <dt><a href="<g:createLink controller='BardHomepage' action='index'/>">Bard homepage</a></dt>
    <dd>This was my test harness  as I figured out how to implement the HTML that would eventually become  the bootstrap-based Bard homepage</dd>

    <dt><a href="<g:createLink controller='box' action='index'/>">Box whisker</a></dt>
    <dd>Example of a box whisker plot. You can adjust the  size of the whiskers using a slider, and you can also adjust the size of the outlier dots themselves.  For reference sake
    the whisker sizes are calculated by taking a variable <em>m</em> (where 0 &lt; <em>m</em> &lt; 3) multiplied by the distance between the third and the first quartile. This graphic
    was developed for the Cancer Therapeutics Response Portal (CTRP), where I think it is still in use</dd>

    <dt><a href="<g:createLink controller='box' action='scatter'/>">Scatter plot</a></dt>
    <dd>A basic example of a scatter plot, also developed for the CTRP. In this test harness clicking on the points doesn't do anything,  though in the live software you can
    click on the box whisker outliers to get a scatter plot, and then you could click on the scatter plot points to get a dose response curve (see below). It was a handy
    drill down for the data set we were cconsidering at the time.</dd>

    <dt><a href="<g:createLink controller='box' action='doseResponse'/>">Dose Response graphic</a></dt>
    <dd>A dose response curve with error bars, also developed for the CTRP.  In this case  the incoming data  were dots with error bars along with the four parameters
    necessary to specify a hill slope curve. If you look in the code you can see how those parameters are translated into the curve you see on-screen.</dd>


    <dt><a href="<g:createLink controller='cookin' action='easing'/>">easing</a></dt>
    <dd>Example taken from the book 'Data Visualization with D3.js Cookbook' by Nick Qi Zhu (who also did the awesome dc.js package.  Check out his work  <a href="https://github.com/NickQiZhu">here</a>)</dd>

    <dt><a href="<g:createLink controller='cookin' action='gridLines'/>">gridLines</a></dt>
    <dd>taken from the book 'Data Visualization with D3.js Cookbook' by Nick Qi Zhu (who also did the awesome dc.js package.  Check out his work  <a href="https://github.com/NickQiZhu">here</a>)</dd>

    <dt><a href="<g:createLink controller='cookin' action='rescaling'/>">rescaling</a></dt>
    <dd>taken from the book 'Data Visualization with D3.js Cookbook' by Nick Qi Zhu (who also did the awesome dc.js package.  Check out his work  <a href="https://github.com/NickQiZhu">here</a>)</dd>

    <dt><a href="<g:createLink controller='cookin' action='areaChart'/>">areaChart</a></dt>
    <dd>taken from the book 'Data Visualization with D3.js Cookbook' by Nick Qi Zhu (who also did the awesome dc.js package.  Check out his work  <a href="https://github.com/NickQiZhu">here</a>)</dd>

    <dt><a href="<g:createLink controller='cookin' action='scatterplotChart'/>">scatterplotChart</a></dt>
    <dd>taken from the book 'Data Visualization with D3.js Cookbook' by Nick Qi Zhu (who also did the awesome dc.js package.  Check out his work  <a href="https://github.com/NickQiZhu">here</a>)</dd>

    <dt><a href="<g:createLink controller='cookin' action='bubbleChart'/>">bubbleChart</a></dt>
    <dd>taken from the book 'Data Visualization with D3.js Cookbook' by Nick Qi Zhu (who also did the awesome dc.js package.  Check out his work  <a href="https://github.com/NickQiZhu">here</a>)</dd>

    <dt><a href="<g:createLink controller='cookin' action='mandelbrot'/>">Mandelbrot set</a></dt>
    <dd>A re-creation of a portion of the Mandelbrot set using the familiar graphic. This one  performs a bunch of recursive JavaScript calls so it takes a while to complete (roughly 10 - 12
    seconds on my machine).  This is surely a misuse of SVG-- the output should probably be handled with something inherently raster like an HTML canvas.</dd>

    <dt><a href="<g:createLink controller='cookin' action='histocruise'/>">the phantom pattern</a></dt>
    <dd>The idea behind this graphic is that you can hit the randomize button (which really is a regular, pseudo-randomizer) and the bars often seem to form patterns. Is this
    only a mistake?  A function of the overzealous pattern matching behavior of our brains?  Or are the patterns real -- the only thing they lack is a driving function.
    Which brings up a larger question, I suppose, about whether the intentionality of the engineer is necessary for a pattern to exist.  Too deep for me right now,
    but there are certainly  some metaphysics that I would work through if I felt a little more energetic.</dd>

    <dt><a href="<g:createLink controller='cookin' action='sierpinski'/>">Sierpinski triangles</a></dt>
    <dd>The deeply cool fractal  originally conceived by the Polish mathematician Wacław Sierpiński.  I put a box on the page which will allow you to
    redraw the triangles to whatever depth you like (at least in principle -- in practice my browser explodes when I try and go past 10)</dd>


    <dt><a href="<g:createLink controller='curvedForce' action='curvedForce'/>">force plot</a></dt>
    <dd>This is an example of a D3 force layout with curved arrows. I had intended to use this as a way of representing a network with distinct layers of elements, but unfortunately
    the boxes start to overlay one another if any single layer has more than just a few elements.  I keep thinking there something  that I need to do for which
    a force layout would be perfect, but I have yet to find the right real world driving imperative</dd>

    <dt><a href="<g:createLink controller='custom' action='custom_diamond'/>">diamond cross compare</a></dt>
    <dd>I built this  as a mockup to illustrate how a diamond shape could be used as an alternative to the standard rows and columns of a data grid.  I still think it's a reasonable idea (the
    motivating reasoning is that columns don't give you much room for labels) but the concept would have to be  played out in a real application before we could find out for sure
    if there's the germ of a useful idea in there somewhere.</dd>

    <dt><a href="<g:createLink controller='histogram' action='histogram'/>">histogram</a></dt>
    <dd>Here's the core of a histogram I built for the Bard project (go to the  <a class="standardLinks" href="https://bard.nih.gov/BARD/bardWebInterface/index">actual software</a> to see the graphic in action)</dd>

    <dt><a href="<g:createLink controller='jqgrid' action='jqgrid'/>">jqgrid</a></dt>
    <dd>Infinite scrolling in action.  This was intended for a high-end revision of the Bard, but this project proposal unfortunately never got off the ground.</dd>

    <dt><a href="<g:createLink controller='map' action='geoJson'/>">geoJson</a></dt>
    <dd>What does  a sample of geoJson look like as text?  Here's an example, adapted from 'Mastering d3.js', by Pablo Castillo (which seems like a great book so far -- here's
    a link in case you're interested <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a>)</dd>

    <dt><a href="<g:createLink controller='map' action='topoJson'/>">topoJson</a></dt>
    <dd>What does  a sample of topoJson look like as text?  Here's an example, adapted from 'Mastering d3.js', by Pablo Castillo (which seems like a great book so far -- here's
    a link in case you're interested <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a>)</dd>


    <dt><a href="<g:createLink controller='map' action='chloropleth'/>">choropleth</a></dt>
    <dd>Here is an example of a choropleth, adapted from 'Mastering d3.js', by Pablo Castillo (which seems like a great book so far -- here's
    a link in case you're interested <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a>)</dd>


    <dt><a href="<g:createLink controller='map' action='topology'/>">topology</a></dt>
    <dd>Some further examples taken from 'Mastering d3.js', by Pablo Castillo (which seems like a great book so far -- here's
    a link in case you're interested <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a>)</dd>

    <dt><a href="<g:createLink controller='map' action='slc30a8'/>">slc30a8</a></dt>
    <dd>slc30a8</dd>

    <dt><a href="<g:createLink controller='map' action='mapbox'/>">mapbox</a></dt>
    <dd>This was a really neat example built around mapbox.js.  Hopefully this JavaScript library will come back to life, though it seems dead as I put this page together right now</dd>

    <dt><a href="<g:createLink controller='probe' action='probe_targets'/>">MLP probe</a></dt>
    <dd>Sunburst representation of the Panther protein categories impacted by a particular molecular probe during a large collection of High Throughput Assays undertaken as part of the Molecular Libraries Program(2009-2013)</dd>

    <dt><a href="<g:createLink controller='probe' action='HierDisplay'/>">Cancer Cell Libraries</a></dt>
    <dd>Sunburst representation of a hierarchy of 860 known human Cancer Cell Lines, performed as part of the CTD2 project at the Broad Institute</dd>

    <dt><a href="<g:createLink controller='probe' action='uploadPrep'/>">Custom files</a></dt>
    <dd>Roll your own sunburst</dd>



    <dt><a href="<g:createLink controller='ScaledDownHomePage' action='ScaledDownHomePage'/>">Bard homepage</a></dt>
    <dd>Test harness for the Bard Homepage with mostly functional links.  This was the first time I really worked with responsive design (that is, trying to get the
    damned interface to look okay on a smart phone-sized screen</dd>

    <dt><a href="<g:createLink controller='slick' action='slick'/>">Slick grid</a></dt>
    <dd>And experiment with infinite scrolling on a Molecular spreadsheet.  Slick grid is a nice JavaScript project -- check it out <a href="https://github.com/mleibman/SlickGrid"> here</a></dd>

    <dt><a href="<g:createLink controller='probe' action='uploadPrep'/>">Build a sunburst</a></dt>
    <dd>Build a sunburst visualization to represent your own data.. You need only convert your data into the JSON format prescribed in this page and then upload the files through the interface</dd>

    <dt><a href="<g:createLink controller='baget' action='boxwhisk'/>">Revised bw</a></dt>
    <dd>Build a new bw</dd>


    <dt><a href="<g:createLink controller='baget' action='boxwhisk2'/>">Revision of my revised bw</a></dt>
    <dd>Build a new bw</dd>

    <dt><a href="<g:createLink controller='cookin' action='simpleTest'/>">launch example</a></dt>
    <dd>example from mastering d3.js by pablo castillo</dd>


    <dt><a href="<g:createLink controller='cookin' action='simpleTest2'/>">launch example2</a></dt>
    <dd>bar code example from mastering d3.js by pablo castillo</dd>

    <dt><a href="<g:createLink controller='cookin' action='layoutTest'/>">layoutTest</a></dt>
    <dd>layout example from mastering d3.js by pablo castillo</dd>

    <dt><a href="<g:createLink controller='cookin' action='sliderTest'/>">sliderTest</a></dt>
    <dd>slider example from mastering d3.js by pablo castillo</dd>

    <dt><a href="<g:createLink controller='cookin' action='colorPicker'/>">colorPicker</a></dt>
    <dd>colorPicker example from mastering d3.js by pablo castillo</dd>

    <dt><a href="<g:createLink controller='cookin' action='highlight'/>">highlight</a></dt>
    <dd>highlight example from mastering d3.js by pablo castillo</dd>

    <dt><a href="<g:createLink controller='cookin' action='brush'/>">brush</a></dt>
    <dd>brush example from mastering d3.js by pablo castillo</dd>

    <dt><a href="<g:createLink controller='map' action='projection'/>">projection</a></dt>
    <dd>Some further examples taken from 'Mastering d3.js', by Pablo Castillo (which is a great book, though perhaps
    I would recommend something else if you are a D3 beginner).  Here's the link:   <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a></dd>


    <dt><a href="<g:createLink controller='map' action='rotating'/>">rotating</a></dt>
    <dd>Some further examples taken from 'Mastering d3.js', by Pablo Castillo (which is a great book, though perhaps
    I would recommend something else if you are a D3 beginner).  Here's the link:   <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a></dd>


    <dt><a href="<g:createLink controller='map' action='celestialSphere'/>">celestialSphere</a></dt>
    <dd>Some further examples taken from 'Mastering d3.js', by Pablo Castillo (which is a great book, though perhaps
    I would recommend something else if you are a D3 beginner).  Here's the link:   <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a></dd>


    <dt><a href="<g:createLink controller='map' action='fullScreen'/>">fullScreen</a></dt>
    <dd>Some further examples taken from 'Mastering d3.js', by Pablo Castillo (which is a great book, though perhaps
    I would recommend something else if you are a D3 beginner).  Here's the link:   <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a></dd>


    <dt><a href="<g:createLink controller='map' action='raster'/>">raster</a></dt>
    <dd>Some further examples taken from 'Mastering d3.js', by Pablo Castillo (which is a great book, though perhaps
    I would recommend something else if you are a D3 beginner).  Here's the link:   <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a></dd>

    <dt><a href="<g:createLink controller='cookin' action='heatmap'/>">heatmap</a></dt>
    <dd>Some further examples taken from 'Mastering d3.js', by Pablo Castillo (which is a great book, though perhaps
    I would recommend something else if you are a D3 beginner).  Here's the link:   <a href="https://www.packtpub.com/web-development/mastering-d3js"> mastering D3.js</a></dd>

    <dt><a href="<g:createLink controller='veryCross' action='index'/>">Linked Hierarchies</a></dt>
    <dd>This was my original test harness as I built the Linked Hierarchies Visualization which eventually ended up in the <a class="standardLinks" href="https://bard.nih.gov/BARD/bardWebInterface/index">Bard</a>  project.</dd>

    <dt><a href="<g:createLink controller='cookin' action='serveVideo'/>">serve video</a></dt>
    <dd>How hard is it to embed a video in a webpage? Let's try</dd>

    <dt><a href="<g:createLink controller='map' action='mapboxTest1'/>">map box test 1</a></dt>
    <dd>First <a href="https://www.mapbox.com">map box</a>  test.  Requires no JavaScript library, sso how they get such a thing to embed in a page I'm not quite sure.</dd>


<dt><a href="<g:createLink controller='map' action='mapboxTest2'/>">map box test 2</a></dt>
<dd>Another test of <a href="https://www.mapbox.com">map box</a>, this time using their library (  so the result is  customizable, at least in principle)</dd>

<dt><a href="<g:createLink controller='auth' action='googleAuthentication'/>">Google auth</a></dt>
<dd>Attempt to use  Google authentication</dd>


<dt><a href="<g:createLink controller='auth' action='twitterAuthentication'/>">Twitter auth</a></dt>
<dd>Attempt to use  Twitter authentication</dd>


<hr style="margin-top: 25px">
    <hr>

    <P>Compilations:</P>

    <dt><a href="http://bagetsoftware.org">baget</a></dt>
    <dd>The place where my generalized D3/Javascript-based graphics go when the code has grown up a little.  Currently I'm providing only a few graphics on BAGET, but my goal would be to improve some of the graphics that start here on graphicscow but then migrate to BAGET.</dd>

    <dt><a href="http://bovinecontemplation.org">bovine contemplation</a></dt>
    <dd>My homepage, <a href="http://bovinecontemplation.org">Bovine Contemplation</a>.  While that homepage does link back to many of the graphics linked on this page, it also
    has some other links as well, in addition to amusing pictures for cows and their friends to ponder.</dd>


    <dt><a href="https://github.com/benralexander">github</a></dt>
    <dd>The code for this page and all my others.</dd>


</dl>



</body>
</html>