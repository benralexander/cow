grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.dependency.resolver = "maven"
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherit(false) // don't repositories from plugins
        grailsPlugins()
        grailsHome()

//        if (useBroadRepo) {
//            mavenRepo "http://bard-repo.broadinstitute.org:8081/artifactory/bard-virtual-repo"
//            grailsRepo("http://bard-repo.broadinstitute.org:8081/artifactory/bard-virtual-repo", "grailsCentral")
//        } else {
            grailsCentral()
            mavenLocal()
            mavenCentral()
 //       }
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
        test "org.spockframework:spock-grails-support:0.7-groovy-2.0"
        // runtime 'mysql:mysql-connector-java:5.1.20'
    }

    plugins {
        build (":tomcat:7.0.54",
                ":rest-client-builder:2.0.3") {
            export = false
        }

        // plugins for the compile step
        compile ":scaffolding:2.1.2"
        compile ':cache:1.1.7'
        compile ":asset-pipeline:1.8.11"
        compile ':resources:1.2.8'
        compile ':rest-client-builder:2.0.3'
        compile ":cache:1.0.1"

        // plugins needed at runtime but not for compilation
        runtime ":hibernate4:4.3.5.4" // or ":hibernate:3.6.10.16"
        runtime ":database-migration:1.4.0"
        runtime ":jquery:1.11.1"
        runtime ':resources:1.2.8'

        test ":codenarc:0.18.1"

    }
}
