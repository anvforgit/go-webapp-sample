pipeline {
  agent any
  stages {
    // agent any
    stage('Build') {
      steps {
         script { 
          echo '=======================Build Code Start======================='
          sh 'go build -o go-test main.go'
          echo '=======================Build Code End========================='
         }
      }
    }

    

    stage('Build Image') {
      // agent {dockerfile true}
      steps {
        echo '=======================Build Docker Image Start==============='
        sh "docker build -t anatolev/go-test:latest . "
        echo '=======================Build Docker Image End================='
      }
    }

    stage("Docker login") {
            steps {
                echo " ============== docker login =================="
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
                    docker login -u $USERNAME -p $PASSWORD
                    """
                }
            }
    }
    stage('Upload Artifact') {
      steps {
        echo '===============Upload Artifact Start==========================='
        sh "docker push anatolev/go-test:latest "
        echo '===============Upload Artifact End============================='
        }
    }
    stage('Deploy to stage') {
      // agent any
      steps {
        echo '===============Deploy to stage Start==========================='
        sh "ssh -i /var/lib/jenkins/.ssh/project_key.pem ubuntu@172.31.92.124 'docker pull anatolev/go-test:latest' "
        sh "ssh -i /var/lib/jenkins/.ssh/project_key.pem ubuntu@172.31.92.124 'docker stop go-test' "
        sh "ssh -i /var/lib/jenkins/.ssh/project_key.pem ubuntu@172.31.92.124 'docker run --name go-test --rm -d --privileged   --publish 8000:8080 anatolev/go-test:latest' "
        sh "ssh -i /var/lib/jenkins/.ssh/project_key.pem ubuntu@172.31.92.124 'docker ps' "
        echo '===============Deploy to stage End============================='
        }
    }
  }
  post {
        always {
            
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
            
        }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    timestamps()
  }
  triggers {
    pollSCM('H/2 * * * *')
  }
}
properties([disableConcurrentBuilds()])



