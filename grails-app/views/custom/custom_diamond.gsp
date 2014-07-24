
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>ui tests</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'cow.css')}" />
    <script type="text/javascript">
        function canvasLayer(location, id) {
            var canvas1 = document.getElementById('canvas');
            return canvas1.getContext("2d");
        }
        function drawLine(ctx,x1,y1,x2,y2) {
            ctx.beginPath();
            ctx.moveTo(x1,y1);
            ctx.lineTo(x2,y2);
            ctx.strokeStyle = '#000000';
            ctx.lineWidth = 2;
            ctx.stroke();
        }
        function drawThickLine(ctx,x1,y1,x2,y2) {
            ctx.beginPath();
            ctx.moveTo(x1,y1);
            ctx.lineTo(x2,y2);
            ctx.strokeStyle = '#000000';
            ctx.lineWidth = 3;
            ctx.stroke();
        }
        function setAppearance(ctx) {
            ctx.strokeStyle = '#000000';
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
<header class="pagehead" name="intro">
    <br/>
    <span>
        <div style="vertical-align:middle;float: left; padding-left: 10px;padding-top: 40px; ">
            <span>
                <input size=90 type="text" />
                <input type="submit" value="search" class="prettybutton"/>
            </span>
            <br/>
            <span style="float: right;  padding-right: 90px; font-family: Helvetica,Arial,sans-serif; color: #0000ff; font-size: 16px;">
                Draw or paste the structure or list of IDs for search
            </span>

            %{--<input size=90 type="text" />--}%
            %{--<input type="submit" value="search"/><br />--}%
            %{--Draw or paste the structure or list of IDs for search--}%
        </div>
        %{--<div style="vertical-align:middle;float: left;">--}%
        %{--Draw or paste the structure or list of IDs for search--}%
        %{--</div>--}%
        <div style="vertical-align:middle;float: right; padding-right: 30px;">
            <g:img dir="images" file="bard_logo_small.png" width="300" height="100"/>
        </div>
    </span>
</header>
<canvas id="canvas" width="1024" height="768" style="border:1px solid #c3c3c3; z-index: -1">
    Your browser does not support the canvas element.
</canvas>
<section>

    <div class="crossproduct_angle" id="diamond_holder">
        <table class="cprod" width="100%" border=1>
            <script type="text/javascript">
                var layer = {};
                layer['background'] = new canvasLayer('body', 'canvas');
                console.log(layer);
                //                setAppearance(ctx);
                drawLine(layer['background'],612,267,859,514);
                drawLine(layer['background'],395,267,148,514);
                drawLine(layer['background'],280,267,33,514);
                drawThickLine(layer['background'],00,267,1020,267);
                drawThickLine(layer['background'],00,329,1020,329);
                drawThickLine(layer['background'],00,391,1020,391);
                drawThickLine(layer['background'],00,453,1020,453);
                drawLine(layer['background'],00,515,1020,515);
                drawLine(layer['background'],00,518,1020,518);
                //vertical lines
                drawLine(layer['background'],280,267,280,217);
                drawLine(layer['background'],395,267,395,217);
                drawLine(layer['background'],612,267,612,217);
                // center line top
                drawThickLine(layer['background'],500,287,500,210);
                drawThickLine(layer['background'],506,287,506,210);
                // center line bottom
                drawThickLine(layer['background'],499,637,499,768);
                drawThickLine(layer['background'],505,637,505,768);

                // below the diamond
                drawLine(layer['background'],00,580,1020,580);
                drawLine(layer['background'],00,642,1020,642);
                drawLine(layer['background'],00,704,1020,704);
                drawLine(layer['background'],00,768,1020,768);
                //vertical lines
                drawLine(layer['background'],65,518,65,768);
                drawLine(layer['background'],150,518,150,768);
                drawLine(layer['background'],810,518,810,768);
                // down diagonals
                drawThickLine(layer['background'],257,518,499,760);
                drawThickLine(layer['background'],748,518,506,760);
                // supplement table diagonals

                //                drawLine(layer['background'],395,267,395,217);
//                drawLine(layer['background'],612,267,612,217);

                //drawSomeText(50, 50, '', 50, layer['background']) ;
                var canvas = document.getElementsByTagName('canvas')[0],
                        c = canvas.getContext('2d');

                c.font = "15px Arial,sans-serif";
                c.textAlign = "center";
                // c.fillText("I am a canvas",90,36);
            </script>
            <tr class="diamond_elements">
                <td class="cprodlt"><div class="revspin"><font color="#f62217">3.94uM</font></div></td>
                <td class="cprodt"><div class="revspin"><font color="#157dec">65.2%</font></div></td>
                <td class="cprodt"><div class="revspin"><font color="#157dec">12.0%</font></div></td>
                <td class="cprodt"><div class="revspin"><font color="#157dec">11.2uM</font></div></td>
            </tr>
            <tr class="diamond_elements">
                <td class="cprodl"><div class="revspin"><font color="#157dec">&gt;90uM</font></div></td>
                <td class="cprod"><div class="revspin">--</div></td>
                <td class="cprod"><div class="revspin"><font color="#157dec">12.9%</font></div></td>
                <td class="cprod"><div class="revspin"><font color="#157dec">19.2uM</font></div></td>
            </tr>
            <tr class="diamond_elements">
                <td class="cprodl"><div class="revspin"><font color="#f62217">2.43uM</font></div></td>
                <td class="cprod"><div class="revspin"><font color="#157dec">25.0%</font></div></td>
                <td class="cprod"><div class="revspin"><font color="#f62217">78.9%</font></div></td>
                <td class="cprod"><div class="revspin">--</div></td>
            </tr>
            <tr class="diamond_elements">
                <td class="cprodlb"><div class="revspin"><font color="#f62217">1.07uM</font></div></td>
                <td class="cprod"><div class="revspin"><font color="#157dec">45.6%</font></div></td>
                <td class="cprod"><div class="revspin"><font color="#157dec">9.82%</font></div></td>
                <td class="cprod"><div class="revspin"><font color="#157dec">27.3uM</font></div></td>
            </tr>
        </table>
    </div>
</section>
<section class="tableHeaders"  id="leftcol_angle">
    <div  class="tableHeaderRow"  style="top: 36px;">
        <div class="tableElems" style="left: 100px;">
            Molecule IDs
        </div>
        <div class="tableElems" style="top: -25px; left: 315px;">
            Active<br/>  / Tested
        </div>
        <div class="tableElems" style="left: 420px;">
            Structure
        </div>
    </div>
    <div class="tableRow"  style="top: 90px; left: 30px;">
        <div class="tableElems" style="top: -4px; left: 55px;">
            345234
        </div>
        <div class="tableElems" style="left: 250px;">
            <span class="badge">11 / 55</span>
        </div>
        <div class="tableElems" style="top:-25px; left: 372px;">
            <g:img dir="images" file="moles1.png" width="72" height="55"/>
        </div>
    </div>
    <div class="tableRow"  style="top: 150px; left: 10px;">
        <div class="tableElems" style="top: -4px; left: 55px;">
            345967
        </div>
        <div class="tableElems" style="left: 210px;">
            <span class="badge">12 / 99</span>
        </div>
        <div class="tableElems" style="top:-22px; left: 332px;">
            <g:img dir="images" file="moles2.png" width="72" height="55"/>
        </div>
    </div>
    <div class="tableRow"  style="top: 210px; left: -10px;">
        <div class="tableElems" style="top: -4px; left: 55px;">
            245461
        </div>
        <div class="tableElems" style="left: 170px;">
            <span class="badge">3 / 33</span>
        </div>
        <div class="tableElems" style="top:-22px; left: 292px;">
            <g:img dir="images" file="moles3.png" width="72" height="55"/>
        </div>
    </div>
    <div class="tableRow"  style="top: 270px; left: -30px;">
        <div class="tableElems" style="top: -4px; left: 50px;">
            34523
        </div>
        <div class="tableElems" style="left: 140px;">
            <span class="badge">4 / 53</span>
        </div>
        <div class="tableElems" style="top:-22px; left: 252px;">
            <g:img dir="images" file="moles4.png" width="72" height="55"/>
        </div>
    </div>
    %{--below the diamond--}%
    <div class="tableRow"  style="top: 335px; left: -30px;">
        <div class="tableElems" style="top: -2px; left: 50px;">
            24276
        </div>
        <div class="tableElems" style="top: -2px; left: 118px;">
            <span class="badge">12 / 63</span>
        </div>
        <div class="tableElems" style="top:-22px; left: 216px;">
            <g:img dir="images" file="moles5.png" width="80" height="60"/>
        </div>
    </div>
    <div class="tableRow"  style="top: 395px; left: -30px;">
        <div class="tableElems" style="top: 0px; left: 50px;">
            1024
        </div>
        <div class="tableElems" style="top: 0px; left: 118px;">
            <span class="badge">00 / 120</span>
        </div>
        <div class="tableElems" style="top:-20px; left: 248px;">
            <g:img dir="images" file="moles6.png" width="80" height="60"/>
        </div>
    </div>
    <div class="tableRow"  style="top: 457px; left: -30px;">
        <div class="tableElems" style="top: 0px; left: 46px;">
            206192
        </div>
        <div class="tableElems" style="top: 0px; left: 118px;">
            <span class="badge">89 / 94</span>
        </div>
        <div class="tableElems" style="top:-20px; left: 248px;">
            <g:img dir="images" file="moles7.png" width="80" height="60"/>
        </div>
    </div>
    <div class="tableRow"  style="top: 519px; left: -30px;">
        <div class="tableElems" style="top: 0px; left: 46px;">
            766201
        </div>
        <div class="tableElems" style="top: 0px; left: 118px;">
            <span class="badge">14 / 112</span>
        </div>
        <div class="tableElems" style="top:-20px; left: 248px;">
            <g:img dir="images" file="moles8.png" width="80" height="60"/>
        </div>
    </div>
</section>
<section  class="tableHeaders" id="rightcol_angle">
        <div  class="tableHeaderRow"  style="top: 36px;">
            <div class="tableElems" style="left: 12px;">
                Measure
            </div>
            <div class="tableElems" style="left: 230px;">
                Assay name
            </div>
        </div>
    <div class="tableRow"  style="top: 90px; left: 30px;">
        <div class="tableElems" style="top: -4px; left: 45px;">
            EC50
        </div>
         <div class="tableElems" style="top:-20px; left: 122px;">
             Fluorescence-based dose response cell-based high-throughput screening assay for agonists of NPY-Y1
        </div>
    </div>
    <div class="tableRow"  style="top: 150px; left: 60px;">
        <div class="tableElems" style="top: -14px; left: 45px;">
            Screening<br /> Conc.
        </div>
        <div class="tableElems" style="top:-20px; left: 150px;">
            Luminescence-based cell-based assay for<br/> activators of the GAA850 frataxin (FXN)
        </div>
    </div>
    <div class="tableRow"  style="top: 210px; left: 125px;">
        <div class="tableElems" style="top: -14px; left: 50px;">
            Percent<br /> Activation
        </div>
        <div class="tableElems" style="top:-20px; left: 140px;">
            Luminescence cell-based assay for<br/> activators of the frataxin (FXN)
        </div>
    </div>
    <div class="tableRow"  style="top: 270px; left: 180px;">
        <div class="tableElems" style="top: -4px; left: 50px;">
            AC50
        </div>
        <div class="tableElems" style="top:-20px; left: 150px;">
            A qHTS for Inhibitors of <br/>Shiga Toxin
        </div>
    </div>
%{--below the diamond--}%
    <div class="tableRow"  style="top: 335px; left: 180px;">
        <div class="tableElems" style="top: -4px; left: 45px;">
            B-score
        </div>
        <div class="tableElems" style="top:-20px; left: 130px; text-align: left;">
            Primary cell-based HTS<br/> assay for compounds that<br/> inhibit KCNQ1 channels
        </div>
    </div>
    <div class="tableRow"  style="top: 400px; left: 180px;">
        <div class="tableElems" style="top: -14px; left: 40px;">
            Percent<br /> Activation
        </div>
        <div class="tableElems" style="top:-20px; left: 130px; text-align: left;">
            Primary cell-based HTS assay<br/> for potentiators of NPY-Y1
        </div>
    </div>
    <div class="tableRow"  style="top: 462px; left: 180px;">
        <div class="tableElems" style="top: -4px; left: 40px;">
            AC50
        </div>
        <div class="tableElems" style="top:-20px; left: 130px; text-align: left;">
             Mycobacterium tuberculosis<br/> (H37Rv) Inhibitors
        </div>
    </div>
    <div class="tableRow"  style="top: 520px; left: 180px;">
        <div class="tableElems" style="top: -4px; left: 40px;">
            EC50
        </div>
        <div class="tableElems" style="top:-20px; left: 130px; text-align: left;">
            Identify Compounds Cytotoxic<br/> to Streptococcus
        </div>
    </div>

    %{--</table>--}%
</section>

</body>
</html>