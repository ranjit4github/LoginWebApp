// pipeline {
//     agent any
//     tools {
//         maven "MAVEN"
//         jdk "JDK"
//     }

//     environment {
//         NEXUS_VERSION = "nexus3"   // Nexus 3 or Nexus 2
//         NEXUS_PROTOCOL = "http"    // HTTP or HTTPS
//         NEXUS_URL = "13.126.159.57:8081"  // Nexus Server IP and Port
//         NEXUS_REPOSITORY = "logicwebapp"  // Nexus Repository Name
//         NEXUS_CREDENTIAL_ID = "Nexus"  // Jenkins Credential ID for Nexus
//         ARTIFACT_VERSION = "${BUILD_NUMBER}"  // Versioning
//         GROUP_ID = "com/psrinivas"
//         ARTIFACT_ID = "loginwebapp"
//     }

//     stages {
//         stage("Checkout Code") {
//             steps {
//                 script {
//                     git branch: 'feature/nexusUpload', url: 'https://github.com/PSRINVAS-729/LoginWebApp.git'
//                 }
//             }
//         }

//         stage("Maven Build") {
//             steps {
//                 sh "mvn clean install"
//             }
//         }

//         stage("Upload Artifact to Nexus") {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'Nexus', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
//                     sh """
//                     curl -v -u ${NEXUS_USER}:${NEXUS_PASS} --upload-file target/LoginWebApp.war ${NEXUS_URL}/repository/${NEXUS_REPOSITORY}/${GROUP_ID}/${ARTIFACT_ID}/${ARTIFACT_VERSION}/${ARTIFACT_ID}-${ARTIFACT_VERSION}.war
//                     """
//                 }
//             }
//         }
//     }
// }
// s3 upload
pipeline {
    agent any
    tools {
        maven "MAVEN"
        jdk "JDK"
    }

    environment {
        S3_BUCKET = "jenkinss322"
        AWS_REGION = "ap-south-1"  // Change based on your region
        AWS_CREDENTIALS_ID = "s3"
    }

    stages {
        stage("Checkout Code") {
            steps {
                git branch: 'feature/nexusUpload', url: 'https://github.com/PSRINVAS-729/LoginWebApp.git'
            }
        }

        stage("Maven Build") {
            steps {
                sh "mvn clean install"
            }
        }

        stage("Upload to S3") {
            steps {
                withAWS(credentials: 's3', region: "${AWS_REGION}") {
                    sh 'pwd'
                    sh """
                    aws s3 cp target/LoginWebApp.war s3://${S3_BUCKET}/LoginWebApp-${BUILD_NUMBER}.war
                    """
                }
            }
        }
    }
}
