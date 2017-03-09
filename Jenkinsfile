/**
 * Created by odupre on 09/03/17.
 * 
 * IMPORTANT :
 * Le nom des agents auto-provisionnés est défini dans la configuration du plugin digitalOcean.
 */
pipeline {
    agent any

    stages {
        stage('Build & Unit Test'){
            agent{
                label 'build'
            }

            steps{
                pwd(tmp: false)
                sleep(time: 150, unit: 'NANOSECONDS')
                echo "Building & Unit testing"
                withMaven(
                    maven: 'M3' // Maven installation declared in the Jenkins "Global Tool Configuration"
                    // ,mavenSettingsConfig: 'my-maven-settings' // Maven settings.xml file defined with the Jenkins Config File Provider Plugin
                    // ,mavenLocalRepo: '.repository'
                    ) {
                        // Run the maven build
                    sh "mvn clean install"

                } // withMaven will discover the generated Maven artifacts, JUnit reports and FindBugs reports
            }
        }
    }
}