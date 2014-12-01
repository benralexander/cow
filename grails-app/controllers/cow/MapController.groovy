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

}
