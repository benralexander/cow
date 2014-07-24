describe('Seirpinski triangle tests', function() {

    var sierpinskiChart, dataset, fixture;

    beforeEach(function () {
        dataset = [10, 20, 30, 40];
        sierpinskiChart = cbbo.sierpinskiTriangle();
        fixture = d3.select('body')
            .append('div')
            .attr('id', 'triangleGoesHere');
    });

    afterEach(function () {
        fixture.remove();
    });

    it('should render a chart with minimal requirements', function() {
        sierpinskiChart.selectionIdentifier("#triangleGoesHere").render();
        expect(fixture.select('svg')).toBeDefined();
    });


    it('should provide getters and setters', function() {
        var defaultLevelsOfDescent = sierpinskiChart.levelsOfDescent();

        sierpinskiChart.levelsOfDescent(7);

        var newLevelsOfDescent = sierpinskiChart.levelsOfDescent();

        expect(defaultLevelsOfDescent).not.toBe(1234);
        expect(newLevelsOfDescent).toBe(7);
    });


    it('should scope some private and some public fields and methods', function() {
        // private methods
        expect(sierpinskiChart.geometryOfATriangle).toBeUndefined();
        expect(sierpinskiChart.renderASingleTriangle).toBeUndefined();
        expect(sierpinskiChart.sierpinskiRecursiveDescent).toBeUndefined();

        expect(sierpinskiChart.render).toBeDefined();
        expect(typeof sierpinskiChart.render).toBe('function');
        expect(sierpinskiChart.clear).toBeDefined();
        expect(typeof sierpinskiChart.clear).toBe('function');
    });


    it('should generate the correct number of triangles', function() {
        sierpinskiChart.selectionIdentifier("#triangleGoesHere").levelsOfDescent(1).render();
        expect(fixture.selectAll('polygon')[0].length).toBe(3);

        sierpinskiChart.selectionIdentifier("#triangleGoesHere").clear().levelsOfDescent(2).render();
        expect(fixture.selectAll('polygon')[0].length).toBe(12);

        sierpinskiChart.selectionIdentifier("#triangleGoesHere").clear().levelsOfDescent(3).render();
        expect(fixture.selectAll('polygon')[0].length).toBe(39);

        sierpinskiChart.selectionIdentifier("#triangleGoesHere").clear().levelsOfDescent(4).render();
        expect(fixture.selectAll('polygon')[0].length).toBe(120);

        sierpinskiChart.selectionIdentifier("#triangleGoesHere").clear().levelsOfDescent(5).render();
        expect(fixture.selectAll('polygon')[0].length).toBe(363);

        sierpinskiChart.selectionIdentifier("#triangleGoesHere").clear().levelsOfDescent(6).render();
        expect(fixture.selectAll('polygon')[0].length).toBe(1092);

    });

});