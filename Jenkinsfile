pipeline {
    agent any
    tools {
        maven "Maven" // Use the correct Maven tool name
        jdk "Java8" // Use the correct JDK tool name
    }

    environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "167.71.235.85:8081"
        NEXUS_REPOSITORY = "LoginWebApp"
        NEXUS_CREDENTIAL_ID = "nexusCredentials"
        ARTIFACT_VERSION = "${BUILD_NUMBER}"
    }

    stages {
        stage("Check out") {
            steps {
                script {
                    git branch: 'feature/nexusUpload', url: 'https://github.com/ranjit4github/LoginWebApp.git'
                }
            }
        }

        stage("mvn build") {
            steps {
                script {
                    sh "mvn clean package"
                }
            }
        }

        stage("publish to nexus") {
            steps {
                script {
                    pom = readMavenPom file: "pom.xml"
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}")
                    artifactPath = filesByGlob[0].path

                    if (fileExists(artifactPath)) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}"

                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: ARTIFACT_VERSION,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging]
                            ]
                        )
                    } else {
                        error "*** File: ${artifactPath}, could not be found"
                    }
                }
            }
        }

        stage('Execute Ansible Play - CD') {
            agent {
                label 'ansible'
            }
            steps {
                script {
                    git branch: 'feature/ansibleNexus', url: 'https://github.com/ranjit4github/Ansible_Demo_Project.git'
                }
                sh '''
                    ansible-playbook -e vers=${BUILD_NUMBER} roles/site.yml
                '''
            }
        }
    }
}
