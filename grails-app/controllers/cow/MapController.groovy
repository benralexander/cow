package cow

class MapController {
    GeneralPurposeService generalPurposeService

    def index() {}

    def geoJson() {
        render(view: 'geoJson')
    }

    def topoJson() {
        render(view: 'topoJson')
    }

    def chloropleth() {
        render(view: 'chloropleth')
    }

    def topology() {
        render(view: 'topology')
    }

    def slc30a8() {
        render(view: 'slc30a8')
    }

    def mapbox() {
        render(view: 'mapbox')
    }

    def retrieveCountriesGeoJson ()  {
        String dataFilename  = "countries.geojson"
        String dataFileContents  = generalPurposeService.retrieveDataFromDisk(dataFilename)
        render  dataFileContents
    }
    def retrieveCountriesTopoJson ()  {
        String dataFilename  = "countries.topojson"
        String dataFileContents  = generalPurposeService.retrieveDataFromDisk(dataFilename)
        render  dataFileContents
    }
    def retrieveArubaCities()  {
        String dataFilename  = "aruba-cities.json"
        String dataFileContents  = generalPurposeService.retrieveDataFromDisk(dataFilename)
        render  dataFileContents
    }
    def retrieveHyg()  {
        String dataFilename  = "hyg.json"
        String dataFileContents  = generalPurposeService.retrieveDataFromDisk(dataFilename)
        render  dataFileContents
    }
    def retrieveLand()  {
        String dataFilename  = "land.json"
        String dataFileContents  = generalPurposeService.retrieveDataFromDisk(dataFilename)
        render  dataFileContents
    }

    def projection(){
        render(view:'projection') ;
    }
    def rotating(){
        render(view:'rotating') ;
    }
    def celestialSphere(){
        render(view:'celestialSphere') ;
    }
    def fullScreen(){
        render(view:'fullScreen') ;
    }
    def raster(){
        render(view:'raster') ;
    }

    def mapboxTest1(){
        render(view:'mapboxTest1') ;
    }

    def mapboxTest2(){
        render(view:'mapboxTest2') ;
    }

    def localThoughts(){
        render(view:'localThoughts') ;
    }


}
