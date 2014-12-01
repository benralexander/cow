package cow

class HomeController {

    def index() {
        println "home"
        render view:"index"
    }
}
