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
                sh 'scp ${WORKSPACE}/target/LoginWebApp.war root@65.1.85.11:/etc/ansible/App'
            }
        }   
		
	stage ('Execute Ansible Playbook - CD'){
            agent {
                label 'ansibleDemo'
            }
            steps{
                sh '''
                 	#ansible-playbook /etc/ansible/roles/site.yml
				  echo "Testing....."
                '''
            }
        }
    }
}
