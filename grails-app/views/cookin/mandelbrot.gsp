<%--
  Created by IntelliJ IDEA.
  User: ben
  Date: 4/26/14
  Time: 1:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Mandelbrot set</title>
    <meta name="layout" content="core"/>
    <link rel="stylesheet" href="${resource(dir: 'css/ctrp', file: 'doseResponse.css')}" type="text/css">

    <g:javascript src="d3.js"/>
</head>
<body>


<script>
    myNamespace = {};

    myNamespace.mandelbrot = function module() {
        var complexRange = [-0.15,0.15],
                realRange = [-1.65,-1.35],
                screenXMax = 800,
                screenXMin = 0,
                screenYMax = 800,
                screenYMin = 0,
                numberDivisionsComplex = 500,
                numberDivisionsReal = 500,

        xScale = d3.scale.linear()
                .domain(realRange)
                .range([screenXMin, screenXMax]),
        yScale = d3.scale.linear()
                .domain(complexRange)
                .range([screenYMax, screenYMin]),
        color = d3.scale.category20b();


        function holder(selection) {

            var computeColor = function (outerProducts) {
                return outerProducts.map(function (x){
                    return ({r: x.r, c: x.c, e: complexLibrary.determineEscape(x,18)});
                });
            },



            assignData = function (outerProducts) {
                var svgContainer = d3.select("body").append("svg")
                                                   .attr("width", 800)
                                                    .attr("height", 800);


                // Enter
                var rects = svgContainer.selectAll("rect")
                        .data(outerProducts)
                        .enter()
                        .append("rect");

                // Update
                rects
                        .attr('x',function (d) {
                            return (xScale(d.r)) ;
                        })
                        .attr('y',function (d) {
                            return (yScale(d.c)) ;
                        })
                        .attr('width',800/(numberDivisionsComplex-5))
                        .attr('height',800/(numberDivisionsReal-5))
                        .style('fill',function (d) {
                            return d3.rgb(color(d.e+1)) ;
                        })
                        .style('stroke-width',0)
                ;

            },


            generateOuterProducts = function( complexRange,numberDivisionsComplex,
                                              realRange,numberDivisionsReal)  {

                // private method
                var generateVector = function( range,numberOfDivisions)  {
                    var minimum = range[0],
                            maximum = range[1],
                            numericalRange =  maximum - minimum,
                            sizeOfEachStep =  numericalRange /numberOfDivisions,
                            accumulatingArray = [];
                    for (  var i = 0 ; i < numberOfDivisions ; i++ )   {
                        accumulatingArray.push(minimum + (i*sizeOfEachStep))
                    }
                    return   accumulatingArray;
                },
                divisionsComplex = generateVector  (complexRange,numberDivisionsComplex),
                divisionsReal = generateVector  (realRange,numberDivisionsReal),
                outerProduct = [];

                // this is where the processing starts
                divisionsComplex.forEach(function (complexElement){
                    divisionsReal.forEach(function (realElement){
                        outerProduct.push ({r:realElement, c:complexElement})
                    })
                });
                return   outerProduct;
            };

            // this is where the processing starts
            selection.each(function(data) {
                // first regenerate the outer product of the range we will consider


                assignData(
                        computeColor (
                                generateOuterProducts( complexRange,numberDivisionsComplex,
                                        realRange, numberDivisionsReal ) ) );
            });


        }
        holder.complexRange = function(x) {
            if (!arguments.length) return complexRange;
            complexRange = x;
            return this;
        };
        holder.realRange = function(x) {
            if (!arguments.length) return realRange;
            realRange = x;
            return this;
        };

        return holder;
    };


    var complexLibrary=(function(){
        var _square=function(incoming){
                    var rSquared = Math.pow(incoming.r,2),
                        cSquared = Math.pow(incoming.c,2),
                        realComponent = rSquared- cSquared,
                        complexComponent = 2*incoming.r*incoming.c;
                    return {r:realComponent, c:complexComponent};
                },
                _add = function (incoming1,incoming2){
                    var realComponent =  incoming1.r + incoming2.r,
                         complexComponent = incoming1.c + incoming2.c;
                    return {r:realComponent, c:complexComponent};
                },
                determineEscape = function(incoming,maximumIterations) {
                    var loopNumber = 0,
                        returnValue = -1,
                        iteratingValue  = {r:incoming.r, c:incoming.c} ;
                    while ((loopNumber < maximumIterations)  &&
                            (iteratingValue.c < 2))  {
                        iteratingValue  = _add(_square (iteratingValue) ,incoming);
                        loopNumber++;
                    }
                    if (loopNumber < maximumIterations) {
                        returnValue =  loopNumber;
                    } else {
                       console.log('manbdle');
                    }
                    return returnValue;
                };
        return {
            determineEscape:determineEscape
        }
    }());

    // Setters can also be chained directly to the returned function
    var mandelbrot =myNamespace.mandelbrot();

    d3.select('body').call(mandelbrot);




</script>




</body>
</html>