package cow

import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import groovy.json.JsonSlurper
import spock.lang.Specification
import spock.lang.Unroll

@TestMixin(GrailsUnitTestMixin)
@Unroll
class LinkedVisHierDataUnitSpec  extends Specification {

    void setup() {
    }

    void tearDown() {
        // Tear down logic here
    }


    void "test writeCategorySection"() {
        when:
        cow.LinkedVisHierData linkedVisHierData = new cow.LinkedVisHierData()
        String categorySectionJson =  linkedVisHierData.createCategorySection()
//        println  categorySectionJson

        then:
        def userJson = new JsonSlurper().parseText(categorySectionJson )
        assert  userJson.getClass().name == 'java.util.ArrayList'
    }



    void "test writeHierSection"() {
        when:
        cow.LinkedVisHierData linkedVisHierData = new cow.LinkedVisHierData()
        String hierarchySectionJson =  linkedVisHierData.createHierarchySection()
//        println  hierarchySectionJson

        then:
        def userJson = new JsonSlurper().parseText(hierarchySectionJson )
        assert  userJson.getClass().name == 'java.util.ArrayList'
    }


    void "test writeAssaysSection"() {
        when:
        cow.LinkedVisHierData linkedVisHierData = new cow.LinkedVisHierData()
        String assaysSectionJson =  linkedVisHierData.createAssaysSection()
//        println  assaysSectionJson

        then:
        def userJson = new JsonSlurper().parseText(assaysSectionJson )
        assert  userJson.getClass().name == 'java.util.ArrayList'
    }


    void "test createAssayCrossSection"() {
        when:
        cow.LinkedVisHierData linkedVisHierData = new cow.LinkedVisHierData()
        String assaysSectionJson =  linkedVisHierData.createAssayCrossSection()
//        println  assaysSectionJson

        then:
        def userJson = new JsonSlurper().parseText(assaysSectionJson )
        assert  userJson.getClass().name == 'java.util.ArrayList'
    }




    void "test createCombinedListing"() {
        when:
        cow.LinkedVisHierData linkedVisHierData = new cow.LinkedVisHierData()
        String assaysSectionJson =  linkedVisHierData.createCombinedListing()
        println  assaysSectionJson

        then:
        def userJson = new JsonSlurper().parseText(assaysSectionJson )
        assert  userJson.getClass().name == 'java.util.HashMap'
    }






}
