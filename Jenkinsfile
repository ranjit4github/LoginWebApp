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
                sh 'scp ${WORKSPACE}/target/LoginWebApp.war root@3.108.41.82:/etc/ansible/App'
            }
        }   
		
		stage ('Execute Ansible Playbook - CD'){
            agent {
                label 'ansible'
            }
            steps{
                script {
                    git branch: 'master', url: 'https://github.com/ranjit4github/FullStack_Deployment_Ansible.git';
                }
                sh '''
                 ansible-playbook roles/site.yml
                '''
            }
        }
    }
}
