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
                    sh "mvn clean package -DskipTests"
            }
        }

         stage("Upload Artifact to Nexus") {
            steps {
                script {
                    def artifactPath = "target/nexus-1.0.jar" // Update artifact name
                    def artifactName = "nexus-1.0.jar"

                    sh """
                    curl -v -u ${NEXUS_CREDENTIALS_USR}:${NEXUS_CREDENTIALS_PSW} --upload-file ${artifactPath} ${NEXUS_URL}${artifactName}
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
