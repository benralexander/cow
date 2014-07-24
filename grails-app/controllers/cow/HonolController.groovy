package cow

class HonolController {

    def index() {
        render(view: 'honol')
    }
    def honol() { }
    def citysource(){
        File f = new File("")
        InputStream crimeData = this.class.classLoader.getResourceAsStream('citysourced.csv')
        OutputStream out = response.getOutputStream()
        //set up byte array
        byte[] content = crimeData.getBytes()


        response.setContentLength(content.size())
        response.addHeader("Content-disposition", "attachment; filename='citysourced.csv'")
        response.addHeader("Content-type", "txt")
        out.write(content)
        out.close()
    }
}
