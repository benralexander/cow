package cow

class CookinController {

    def index() {
        render (view: 'cookin')
    }
    def nick() {
        render (view: 'nick')
    }
    def multi() {
        render (view: 'multi')
    }
    def arrayData() {
        render (view: 'arrayData')
    }

    def arrayNest() {
        render (view: 'arrayNest')
    }
    def simpleTest() {
        render (view: 'simpleTest')
    }
    def simpleTest2() {
        render (view: 'simpleTest2')
    }
    def layoutTest() {
        render (view: 'layoutTest')
    }
    def arrayFilter() {
        render (view: 'arrayFilter')
    }
    def colorinterp() {
        render (view: 'colorinterp')
    }
    def basicAxes() {
        render (view: 'basic-axes')
    }
    def gridLines() {
        render (view: 'grid-line')
    }
    def rescaling() {
        render (view: 'rescaling')
    }
    def multiElementTransition() {
        render (view: 'multi-element-transition')
    }
    def easing() {
        render (view: 'easing')
    }
    def tweening() {
        render (view: 'tweening')
    }
    def lineInt() {
        render (view: 'lineInt')
    }
    def areaChart() {
        render (view: 'area-chart')
    }
    def scatterplotChart() {
        render (view: 'scatterplot-chart')
    }
    def bubbleChart() {
        render (view: 'bubble-chart')
    }
    def pieChart() {
        render (view: 'pie-chart')
    }
    def poly() {
        render (view: 'poly')
    }
    def simpleHtml() {
        render (view: 'simpleHtml')
    }
    def simpleCss() {
        render (view: 'simpleCss')
    }
    def simpleJs() {
        render (view: 'simpleJs')
    }
    def mandelbrot() {
        render (view: 'mandelbrot')
    }
    def d3expts() {
        render (view: 'd3expts')
    }
    def histocruise() {
        render (view: 'histocruise')
    }
    def sierpinski() {
        render (view: 'sierpinski')
    }
    def runSTests() {
        render (view: 'runSTests')
    }
    def fundamental() {
        render (view: 'fundamental')
    }
    def simp() {
        render (view: 'simp')
    }
    def simp2() {
        render (view: 'simp2')
    }
    def simp3() {
        render (view: 'simp3')
    }
    def simp4() {
        render (view: 'simp4')
    }



    def histogramData = """
[
    { "key": 0, "value": 5 },
    { "key": 1, "value": 10 },
    { "key": 2, "value": 13 },
    { "key": 3, "value": 20 },
    { "key": 4, "value": 22 },
    { "key": 5, "value": 26 },
    { "key": 6, "value": 22 },
    { "key": 7, "value": 19 },
    { "key": 8, "value": 18 },
    { "key": 9, "value": 13 },
    { "key": 10, "value": 11 },
    { "key": 11, "value": 12 },
    { "key": 12, "value": 15 },
    { "key": 13, "value": 16 },
    { "key": 14, "value": 17 }]"""

    def retrieveJson(){
        render(histogramData.toString()) ;
    }
    def cookin(){}
}
