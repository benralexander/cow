<%--
  Created by IntelliJ IDEA.
  User: balexand
  Date: 2/26/13
  Time: 7:35 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>ui tests</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'cow.css')}" />
    <script type="text/javascript">
        function canvasLayer(location, id) {
            var canvas1 = document.getElementById('canvas');
            return canvas1.getContext("2d");
        }



        function drawSomeText(x, y, text, maxWidth, ctx) {
    //metric will receive the measures of the text
    var metric = ctx.measureText(text);
    console.log(metric.width);

    ctx.save(); // this will "save" the normal canvas to return to
    if(maxWidth != null && metric.width > maxWidth) {
    // These two methods will change EVERYTHING
    // drawn on the canvas from this point forward
    // Since we only want them to apply to this one fillText,
    // we use save and restore before and after

    // We want to find the center of the text (or whatever point you want) and rotate about it
    var tx = x + (metric.width/2);
    var ty = y + 5;

    // Translate to near the center to rotate about the center
    ctx.translate(tx,ty);
    // Then rotate...
    ctx.rotate(Math.PI / 2);
    // Then translate back to draw in the right place!
    ctx.translate(-tx,-ty);
    }
    ctx.fillText(text, x, y);
    ctx.restore(); // This will un-translate and un-rotate the canvas
    }
    </script>
</head>
<body>
   <h1>hi</h1>
<header>This is where a search box might go</header>
<canvas id="canvas" width>HEY</canvas>
<section>
    <div class="crossproduct">
        <table class="cprod" width="100%" border=1>
            <script type="text/javascript">
                var layer = {};
                layer['background'] = new canvasLayer('body', 'canvas');
                console.log(layer);

                drawSomeText(50, 50, 'hey', 50, layer['background']) ;
                var canvas = document.getElementsByTagName('canvas')[0],
                        c = canvas.getContext('2d');

                c.font = "15px Arial,sans-serif";
                c.textAlign = "center";
                c.fillText("I am a canvas",90,36);
            </script>
            <tr>
                <td class="cprodlt"><div class="revspin">3.94uM</div></td>
                <td class="cprodt"><div class="revspin">65.2%</div></td>
                <td class="cprodt"><div class="revspin">12.0%</div></td>
                <td class="cprodrt"><div class="revspin">11.2uM</div></td>
        </tr>
            <tr>
                <td class="cprodl"><div class="revspin">&gt;90uM</div></td>
                <td class="cprod"><div class="revspin">--</div></td>
                <td class="cprod"><div class="revspin">789</div></td>
                <td class="cprodr"><div class="revspin">19.2uM</div></td>
            </tr>
            <tr>
                <td class="cprodl"><div class="revspin">2.43uM</div></td>
                <td class="cprod"><div class="revspin">25.0%</div></td>
                <td class="cprod"><div class="revspin">78.9%</div></td>
                <td class="cprodr"><div class="revspin">--</div></td>
            </tr>
            <tr>
                <td class="cprodlb"><div class="revspin">1.07uM</div></td>
                <td class="cprodb"><div class="revspin">45.6%</div></td>
                <td class="cprodb"><div class="revspin">9.82%</div></td>
                <td class="cprodrb"><div class="revspin">27.3uM</div></td>
            </tr>
        </table>
    </div>
</section>
<section id="leftcol">
    <table>
        <tr>
            <th class="cmptbl">Structure</th>
            <th class="cmptbl">Active vs.<br /> tested</th>
            <th class="cmptbl">CID</th>
            <th class="cmptbl">Promiscuity</th>
        </tr>
        <tr>
            <td class="cmptbl">
                <g:img dir="images" file="mol1.png" width="100" height="45"/>
            </td>
            <td class="cmptbl">
                <g:img dir="images" file="pil1.png" width="100" height="45"/>
            </td>
            <td class="cmptbl">
                <g:img dir="images" file="cid1.png" width="75" height="45"/>
            </td>
            <td class="cmptbl"></td>
        </tr>
        <tr>
            <td class="cmptbl">
                <g:img dir="images" file="mol2.png" width="100" height="45"/>
            </td>
            <td class="cmptbl">
                <g:img dir="images" file="pil2.png" width="100" height="45"/>
            </td>
            <td class="cmptbl">
                <g:img dir="images" file="cid2.png" width="75" height="45"/>
            </td>
            <td class="cmptbl"></td>
        </tr>
        <tr>
            <td class="cmptbl">
                <g:img dir="images" file="mol3.png" width="100" height="45"/>
            </td>
            <td class="cmptbl">
                <g:img dir="images" file="pil3.png" width="100" height="45"/>
            </td>
            <td class="cmptbl">
                <g:img dir="images" file="cid3.png" width="75" height="45"/>
            </td>
            <td class="cmptbl"></td>
        </tr>
        <tr>
            <td class="cmptbl">
                <g:img dir="images" file="mol4.png" width="100" height="45"/>
            </td>
            <td class="cmptbl">
                <g:img dir="images" file="pil4.png" width="100" height="45"/>
            </td>
            <td class="cmptbl">
                <g:img dir="images" file="cid4.png" width="75" height="45"/>
            </td>
            <td class="cmptbl"></td>
        </tr>

    </table>
</section>
<section id="rightcol">
    <table width=100%>
        <tr>
            <th class="cmprtbl">Assay name</th>
            <th class="cmprtbl">Measure</th>
        </tr>
        <tr>
            <td class="cmprtbl">
                Fluorescence-based dose response cell-based high-throughput screening assay for agonists of NPY-Y1.
            </td>
            <td class="cmprtbl">
                EC50
            </td>
        </tr>
        <tr>
            <td class="cmprtbl">
                Luminescence-based cell-based high throughput confirmation assay for activators of the GAA850 frataxin (FXN) promoter
            </td>
            <td class="cmprtbl">
                screening concentration
            </td>
        </tr>
        <tr>
            <td class="cmprtbl">
                Anti-Malarial Hsp90 Inhibitors Measured in Microorganism System Using Plate Reader - 2121-01_Inhibitor_Dose_CherryPick_Activity
            </td>
            <td class="cmprtbl">
                percent activity
            </td>
        </tr>
        <tr>
            <td class="cmprtbl">
                A qHTS for Small Molecule Inhibitors of Shiga Toxin
            </td>
            <td class="cmprtbl">
                AC50
            </td>
        </tr>

    </table>
</section>

</body>
</html>