<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>layout example</title>
    <meta name="layout" content="core"/>
    <g:javascript src="jquery-2.0.3.min.js"/>
    %{--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>--}%
    <g:javascript src="ctrp/d3.js"/>
    <g:javascript src="masteringd3js/barcode.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css/map', file: 'map.css')}" type="text/css">

</head>
<body>

<h1 class="section-title">celestial sphere</h1>


<h2 class="section-subtitle">Equirectangular Projection</h2>

<div id="equirectangular"></div>

<script>
    var url = "${createLink(controller: 'map', action:'retrieveHyg')}";
    d3.json(url, function(error, data) {

        if (error) { console.error(error); }

        var width = 600,
                height = 300;

        // Select the container div and creates the SVG container
        var div = d3.select('#equirectangular'),
                svg = div.append('svg')
                        .attr('width', width)
                        .attr('height', height);

        // Creates an instance of the equirectangular projection
        var projection = d3.geo.equirectangular()
                .scale(width / (2 * Math.PI))
                .translate([width / 2, height / 2]);


        // Compute the radius for the point features
        var rScale = d3.scale.linear()
                .domain(d3.extent(data.features, function(d) { return d.properties.mag; }))
                .range([3, 1]);

        // Create and configure the geographic path generator
        var path = d3.geo.path()
                .projection(projection)
                .pointRadius(function(d) {
                    return d.properties ? rScale(d.properties.mag) : 1;
                });

        // Add graticule lines
        var graticule = d3.geo.graticule();

        // Draw graticule lines
        svg.selectAll('path.graticule-black').data([graticule()])
                .enter().append('path')
                .attr('class', 'graticule-black')
                .attr('d', path);

        // Draw the stars in the chart
        svg.selectAll('path.star-black').data(data.features)
                .enter().append('path')
                .attr('class', 'star-black')
                .attr('d', path);
    });
</script>


<h2 class="section-subtitle">Equirectangular Projection (with Style)</h2>

<div id="equirectangular-style"></div>

<script>
    d3.json(url, function(error, data) {

        if (error) { console.error(error); }

        var width = 600,
                height = 300;

        var div = d3.select('#equirectangular-style'),
                svg = div.append('svg')
                        .attr('width', width)
                        .attr('height', height);

        var projection = d3.geo.equirectangular()
                .scale(width / (2 * Math.PI))
                .translate([width / 2, height / 2]);

        // Create and configure the geographic path generator
        var path = d3.geo.path().projection(projection);

        var graticule = d3.geo.graticule();

        svg.append('path').datum({type: 'Sphere'})
                .attr('class', 'cellestial-globe')
                .attr('d', path);

        // Draw graticule lines
        svg.selectAll('path.graticule').data([graticule()])
                .enter().append('path')
                .attr('class', 'graticule')
                .attr('d', path);

        var rScale = d3.scale.linear()
                .domain(d3.extent(data.features, function(d) { return d.properties.mag; }))
                .range([3, 1]);

        // Compute the radius for the point features
        path.pointRadius(function(d) {
            return d.properties ? rScale(d.properties.mag) : 1;
        });

        svg.selectAll('path.star').data(data.features)
                .enter().append('path')
                .attr('class', 'star')
                .attr('d', path);
    });
</script>

<h2 class="section-subtitle">Orthographic Projection</h2>

<div id="orthographic"></div>

<script>
    d3.json(url, function(error, data) {

        if (error) { console.error(error); }

        var width = 600,
                height = 300;

        var rotate = {x: 0, y: 90};

        var div = d3.select('#orthographic'),
                svg = div.append('svg')
                        .attr('width', width)
                        .attr('height', height);

        var projection = d3.geo.orthographic()
                .scale(1.5 * height / Math.PI)
                .translate([width / 2, height / 2])
                .clipAngle(90)
                .rotate([rotate.x / 2, -rotate.y / 2]);

        // Create and configure the geographic path generator
        var path = d3.geo.path().projection(projection);

        svg.append('path').datum({type: 'Sphere'})
                .attr('class', 'cellestial-globe')
                .attr('d', path);

        var graticule = d3.geo.graticule();

        // Draw graticule lines
        var lines = svg.selectAll('path.graticule').data([graticule()])
                .enter().append('path')
                .attr('class', 'graticule')
                .attr('d', path);

        var rScale = d3.scale.linear()
                .domain(d3.extent(data.features, function(d) { return d.properties.mag; }))
                .range([3, 1]);

        // Compute the radius for the point features
        path.pointRadius(function(d) {
            return d.properties ? rScale(d.properties.mag) : 1;
        });

        var stars = svg.selectAll('path.star').data(data.features)
                .enter().append('path')
                .attr('class', 'star')
                .attr('d', path);

        var overlay = svg.selectAll('circle').data([rotate])
                .enter().append('circle');

        overlay
                .attr('r', height / 2)
                .attr('transform', 'translate(' + [width / 2, height / 2] + ')')
                .attr('fill-opacity', 0);

        var dragBehavior = d3.behavior.drag()
                .origin(Object)
                .on('drag', drag);

        function drag(d) {
            projection.rotate([(d.x = d3.event.x) / 2, -(d.y = d3.event.y) / 2]);
            stars.attr('d', function(u) {
                var p = path(u);
                return p ? p : 'M 10 10';
            });
            lines.attr('d', path);
        }

        overlay.call(dragBehavior);
    });
</script>


<h2 class="section-subtitle">Stereographic Projection</h2>

<div id="stereographic"></div>

<script>
    d3.json(url, function(error, data) {

        if (error) { console.error(error); }

        var width = 600,
                height = 300;

        var rotate = {x: 0, y: 45};

        var div = d3.select('#stereographic'),
                svg = div.append('svg')
                        .attr('width', width)
                        .attr('height', height);

        var projection = d3.geo.stereographic()
                .scale(1.5 * height / Math.PI)
                .translate([width / 2, height / 2])
                .clipAngle(120)
                .rotate([rotate.x, -rotate.y]);

        // Create and configure the geographic path generator
        var path = d3.geo.path().projection(projection);

        svg.append('path').datum({type: 'Sphere'})
                .attr('class', 'cellestial-globe')
                .attr('d', path);

        var graticule = d3.geo.graticule();

        // Draw graticule lines
        var lines = svg.selectAll('path.graticule').data([graticule()])
                .enter().append('path')
                .attr('class', 'graticule')
                .attr('d', path);

        var rScale = d3.scale.linear()
                .domain(d3.extent(data.features, function(d) { return d.properties.mag; }))
                .range([3, 1]);

        // Compute the radius for the point features
        path.pointRadius(function(d) {
            return d.properties ? rScale(d.properties.mag) : 1;
        });

        var stars = svg.selectAll('path.star').data(data.features)
                .enter().append('path')
                .attr('class', 'star')
                .attr('d', path);

        var overlay = svg.selectAll('circle').data([rotate])
                .enter().append('circle');

        overlay
                .attr('r', height / 2)
                .attr('transform', 'translate(' + [width / 2, height / 2] + ')')
                .attr('fill-opacity', 0);

        // Create and configure the drag behavior
        var dragBehavior = d3.behavior.drag()
                .on('drag', drag);

        // Add event listeners for drag gestures to the overlay
        overlay.call(dragBehavior);

        function drag(d) {

            // Compute the projection's rotation
            d.x = 180 * d3.event.x / width;
            d.y = -180 * d3.event.y / height;

            projection.rotate([d.x, d.y]);

            stars.attr('d', function(u) {
                var p = path(u);
                return p ? p : 'M 10 10';
            });
            lines.attr('d', path);
        }


    });
</script>

</body>
</html>
