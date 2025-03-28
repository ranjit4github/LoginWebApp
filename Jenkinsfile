pipeline {
    agent any
    tools {
        maven "MAVEN"
        jdk "JDK"
    }

    environment {
        NEXUS_VERSION = "nexus3"   // Nexus 3 or Nexus 2
        NEXUS_PROTOCOL = "http"    // HTTP or HTTPS
        NEXUS_URL = "13.126.159.57:8081"  // Nexus Server IP and Port
        NEXUS_REPOSITORY = "logicwebapp"  // Nexus Repository Name
        NEXUS_CREDENTIAL_ID = "Nexus"  // Jenkins Credential ID for Nexus
        ARTIFACT_VERSION = "${BUILD_NUMBER}"  // Versioning
    }

    stages {
        stage("Checkout Code") {
            steps {
                script {
                    git branch: 'feature/nexusUpload', url: 'https://github.com/PSRINVAS-729/LoginWebApp.git'
                }
            }
        }

        stage("Maven Build") {
            steps {
                sh "mvn clean install"
            }
        }

        stage("Upload Artifact to Nexus") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${NEXUS_CREDENTIAL_ID}", usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
                        def artifactPath = "target/LoginWebApp.war"
                        def artifactName = "LoginWebApp-${ARTIFACT_VERSION}.war"
                        def nexusUploadUrl = "${NEXUS_PROTOCOL}://${NEXUS_URL}/repository/${NEXUS_REPOSITORY}/${artifactName}"

                        sh """
                        echo "Uploading ${artifactName} to Nexus..."
                        curl -v -u ${NEXUS_USER}:${NEXUS_PASS} --upload-file ${artifactPath} ${nexusUploadUrl}
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and Artifact Upload Successful!"
        }
        failure {
            echo "❌ Build or Artifact Upload Failed. Check Logs!"
        }
    }
}
