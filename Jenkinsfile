pipeline {
    agent any
    
    tools {
        maven 'localMaven'
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
                sh 'scp ${WORKSPACE}/target/LoginWebApp.war root@13.126.11.27:/etc/ansible/App'
            }
        }   
		
		stage ('Execute Ansible Playbook - CD'){
            agent {
                label 'ansible'
            }
            steps{
                sh '''
		 cd /etc/ansible
                 ansible-playbook roles/site.yml
                '''
            }
        }
    }
}
