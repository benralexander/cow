<%@ page import="temporary.BuildInfo" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Cow graphics</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="Graphics examples, d3, benralexander, scientific graphics, bovine contemplation, Styrofoam heads, left nostril">
    <meta name="description" content="Assorted graphics examples">
    <meta name="author" content="Ben R Alexander">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'baget.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <g:layoutHead/>
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-55553855-1', 'auto');
        ga('send', 'pageview');

    </script>
    <meta name="wot-verification" content="8d52e9e2f0f07175b213"/>
    <r:layoutResources />
</head>
<body>
%{--<div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div>--}%
<g:layoutBody/>
<div class="footer" role="contentinfo">
    Built on ${BuildInfo?.buildHost} at ${BuildInfo?.buildTime}.  Version=${BuildInfo?.appVersion}.${BuildInfo?.buildNumber}
</div>
<g:javascript library="application"/>
<r:layoutResources />
</body>
</html>
