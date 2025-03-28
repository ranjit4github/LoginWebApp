pipeline {
    agent any
    tools {
        maven "MAVEN"
        jdk "JDK"
    }

    environment {
        // This can be nexus3 or nexus2
        NEXUS_VERSION = "nexus3"
        // This can be http or https
        NEXUS_PROTOCOL = "http"
        // Where your Nexus is running
        NEXUS_URL = "13.126.159.57:8081"
        // Repository where we will upload the artifact
        NEXUS_REPOSITORY = "logicwebapp"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "Nexus"
        ARTIFACT_VERSION = "${BUILD_NUMBER}"
    }

    stages {
        stage("Check out") {
            steps {
                script {
                    git branch: 'feature/nexusUpload', url: 'https://github.com/PSRINVAS-729/LoginWebApp.git';
                }
            }
        }

        stage("mvn build") {
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

    post {
        success {
            echo "✅ Build and Artifact Upload Successful!"
        }
        failure {
            echo "❌ Build or Artifact Upload Failed. Check Logs!"
        }
    }
}
}
