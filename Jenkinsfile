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
            agent "build"

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

        stage ('Static Analyis'){
            steps{
                node(label: 'build') {
                    sleep(time: 300, unit: 'MICROSECONDS')
                    echo "Static analysing"
                    sleep(time: 15, unit: 'MILLISECONDS')
                }
            }
        }

        stage ('Acceptance Tests'){
            steps{
                parallel(
                    "Chrome": {
                        node(label: 'agent0') {
                            echo "Chrome running" 
                            sleep(time: 300, unit: 'MILLISECONDS')
                            echo "Chrome ran" 
                        }
                    },
                    "Firefox": {
                        node(label: 'agent1') {
                            echo "Firefox poney roxing" 
                            sleep(time: 400, unit: 'NANOSECONDS')
                            echo "Firefox poney roxed" 
                        }
                    },
                    "Edge": {
                        node(label: 'agent2') {
                            echo "Edge slowing down the process" 
                            sleep(time: 3, unit: 'SECONDS')
                            echo "Chrome slowed down the process" 
                        }
                    }
                )
            }
        }

        // Mark the code build 'stage'....
        stage ('Manual-approval'){
            steps{
                input message: 'Go to production?', ok: 'Deploy'
            }
        }

        // Display tests results
        stage ('Deploy'){
            steps {
                node(label: 'deploy') {
                    echo "Deploying..."
                    sleep(time: 2, unit: 'SECONDS')
                }
            }
        }
    }
}