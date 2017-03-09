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
                    sh "mvn -B clean install"

                } // withMaven will discover the generated Maven artifacts, JUnit reports and FindBugs reports

                stash includes: 'target/*.jar', name: 'binary'
            }
        }

        stage ('Static Analyis'){
            agent{
                label 'build'
            }

            steps{
                sleep(time: 300, unit: 'MICROSECONDS')
                echo "Static analysing"
                sleep(time: 15, unit: 'MILLISECONDS')
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

        // Clearing workspace....
        stage ('Clearing'){
            agent{
                label 'deploy'
            }

            steps{
                dir("target"){
                    deleteDir();
                }

                sh "ls -alh"
            }
        }

        // Unstash'....
        stage ('Staging'){
            agent{
                label 'deploy'
            }

            steps{
                unstash 'binary'
                sh 'ls -alh target/'
            }
        }

        // Mark the code build 'stage'....
        stage ('Manual-approval'){
            steps{
                input message: 'Go to production?', ok: 'Deploy'
            }
        }

        // Create docker image....
        stage ('Docker build'){
            agent{
                label 'docker'
            }

            steps{
                dir("target"){
                    deleteDir();
                }

                sh "ls -alh" 
                unstash 'binary'
                sh 'ls -alh target/'

                sh ("docker build -t toulouseJam/spring-petclinic:${env.BUILD_NUMBER} .")
                // docker.build("toulouseJam/spring-petclinic:${env.BUILD_NUMBER}")
            }
        }

        // Display tests results
        stage ('Deploy'){
            agent{
                label 'deploy'
            }

            steps {
                echo "Deploying..."
                sleep(time: 2, unit: 'SECONDS')
            }
        }
    }
}