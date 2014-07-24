package cow

class CrimeController {
    def index() {
        render(view: 'crime')
    }
    def crime() { }
    def data(){
        File f = new File("")
        InputStream crimeData = this.class.classLoader.getResourceAsStream('2010-10.csv')
        OutputStream out = response.getOutputStream()
        //set up byte array
        byte[] content = crimeData.getBytes()


        response.setContentLength(content.size())
        response.addHeader("Content-disposition", "attachment; filename='2010-10.csv'")
        response.addHeader("Content-type", "txt")
        out.write(content)
        out.close()
//        render(crimeData)
    }


}
