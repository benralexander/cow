package cow

class AuthController {

    def index() {}

    def googleAuthentication(){
        render (view: 'googleAuth')
    }
    def twitterAuthentication(){

        render (view: 'twitterAuth')
    }

}
