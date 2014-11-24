package cow

import grails.transaction.Transactional
import org.codehaus.groovy.grails.commons.GrailsApplication

@Transactional
class GeneralPurposeService {

    GrailsApplication grailsApplication

    String retrieveDataFromDisk(String fileName) {

         String fileLocation = grailsApplication.mainContext.getResource("/WEB-INF/resources/${fileName}").file.toString()
        println "Loading data from file = ${fileLocation}"
        File file = new File(fileLocation)
        int counter = 1
        boolean headerLine = false
        StringBuilder sb = new StringBuilder()
        file.eachLine {
            sb << it
            if (headerLine) {
                headerLine = false
            }
        }

        return sb.toString()
    }


}
