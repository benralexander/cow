
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <g:javascript src="ctrp/d3.js"/>
    <link rel="stylesheet" href="${resource(dir: 'css/map', file: 'map.css')}" type="text/css">
    <g:javascript src="map/topojson.js" />



</head>

<body>

<h1 class="section-title">Mapping topology</h1>


<div id='map03'></div>

<div>
    <style>
    .bolivia {
        fill: #666;
    }
    </style>
</div>


<script type="text/javascript">
    var url = "${createLink(controller: 'map', action:'retrieveCountriesTopoJson')}",
            width = 500,
            height = 500;

    var globeFeature = {
        type: 'Feature',
        geometry: {
            type: 'Polygon',
            coordinates: [
                [
                    [-179.999,  89.999],
                    [ 179.999,  89.999],
                    [ 179.999, -89.999],
                    [-179.999, -89.999],
                    [-179.999,  89.999]
                ]
            ]
        }
    };

    d3.json(url, function(error, data) {

        if (error) { return error; }

        // Create the SVG container
        var div = d3.select('#map03'),
                svg = div.selectAll('svg').data([data]);

        // Create the SVG container on enter
        svg.enter().append('svg')
                .attr('width', width)
                .attr('height', height);

        // Use the TopoJSON library to construct the feature collection
        var geodata = topojson.feature(data, data.objects.countries);

        // Filter the countries in South America
//        var scandinavia = geodata.features.filter(function(d) {
//            return d.properties.continent === 'Europe';
//        });
        var scandinavia = geodata.features.filter(function(d) {
            return ((d.properties.admin === 'Iceland') ||
                    (d.properties.admin === 'Denmark') ||
                    (d.properties.admin === 'Sweden') ||
                    (d.properties.admin === 'Finland') ||
                    (d.properties.admin === 'Norway') ||
                    (d.properties.admin === 'Germany') ||
                    (d.properties.admin === 'Lithuania') ||
                    (d.properties.admin === 'Latvia') ||
                    (d.properties.admin === 'Poland'))
        });

        // Create a feature collection for south america
        var scandinaviaFeature = {
            type: 'FeatureCollection',
            features: scandinavia
        };

        // Projection
        // ----------

        // Compute the bounds, centroid and angle extent of South America
        // to configure the projection
        var bounds = d3.geo.bounds(scandinaviaFeature),
                //center = d3.geo.centroid(scandinaviaFeature),
                center = [2.0,65.0],
                //distance = d3.geo.distance(bounds[0], bounds[1]);
        distance = d3.geo.distance([58,-28], [71,31]);

        // The width will cover the complete circumference
        var scale = 1 * width / distance;

        // Create the projection to match the centroid of the feature
        var projection = d3.geo.mercator()
                .scale(scale)
                .translate([width / 2, 0.35 * height])
                .center(center);

        // Create the path generator
        var pathGenerator = d3.geo.path()
                .projection(projection);

        // Globe
        // -----

        // Create a selection for the graticule path and bint the data
        var globe = svg.selectAll('path.globe')
                .data([globeFeature])
                .enter()
                .append('path')
                .attr('class', 'globe')
                .attr('d', pathGenerator);

        // Features
        // --------

        // Create a selection for the countries and bind the feature data
        var featurePath = svg.selectAll('path.feature')
                .data([scandinaviaFeature])
                .enter()
                .append('path')
                .attr('class', 'feature')
                .attr('d', pathGenerator);

        var colorRange = [
            '#f7fcfd',
//            '#e0ecf4',
//            '#bfd3e6',
//            '#9ebcda',
//            '#8c96c6',
//            '#8c6bb1',
//            '#88419d',
            '#6e016b'];

        // Create the color scale for the area of the features
        var colorScale = d3.scale.linear()
                .domain([0,0.28])
                .range(colorRange);

        // Create a selection for the countries and bind the feature data
        var features = svg.selectAll('path.feature-color').data(scandinaviaFeature.features);

        // Append the paths on enter
        features.enter().append('path')
                .attr('class', 'feature-color');

        // Set the path of the countries
        features.attr('d', pathGenerator)
                .attr('fill', function(d) {
                    switch (d.properties.admin) {
                        case 'Iceland':   return   colorScale(0.0);
                        case 'Sweden':   return   colorScale(0.04);
                        case 'Denmark':   return   colorScale(0.03);
                        case 'Finland':   return   colorScale(0.28);
                        case 'Norway':   return   colorScale(0.0);
                        case 'Germany':   return   colorScale(0.0);
                        case 'Lithuania':   return   colorScale(0.0);
                        case 'Latvia':   return   colorScale(0.0);
                        case 'Poland':   return   colorScale(0.03);
                        default:  return  colorScale(0.0);

                    }

                } );




    });
</script>


</body>
</html>