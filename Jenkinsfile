pipeline {
    agent any
    
    tools {
        maven 'localMaven'
        jdk 'Java8'
    }

stages{
        stage('Build'){
            steps {
                sh 'mvn clean package'
            }
            post {
                success {
                    echo 'Archiving the artifacts'
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }
        stage ('Deliver to Ansible') {
            steps{
                sh 'scp ${WORKSPACE}/target/LoginWebApp.war root@13.235.243.103:/etc/ansible/App'
            }
        }
    }
}
