package cow

import org.springframework.web.context.request.RequestContextHolder

class HtmlTagLib {

    static namespace = 'html'

    def render = {attrs ->

        def filePath = attrs.file

        if (!filePath) {
            throwTagError("'file' attribute must be provided")
        }
        InputStream crimeData = this.class.classLoader.getResourceAsStream(filePath)
        //set up byte array
        out << crimeData.getText()
    }
}