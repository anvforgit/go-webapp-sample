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

    stage('Unit Test') {
      // agent any
      steps {
        echo '=======================Some Tests Start======================='
        sh "go test ./... -coverprofile=coverage.out"
        echo '=======================Some Tests End========================='
      }
    }

    // stage('SonarQube analysis') {
    //     steps {
    //      def scannerHome = tool 'SonarScanner 4.6.2.2472';
    //      withSonarQubeEnv('http://sonarqube:9000') { 
    //        sh "${scannerHome}/bin/sonar-scanner"
    //      }
    //     }
    // }
    stage('sonar-scanner') {
      steps {
        // def sonarqubeScannerHome = tool name: 'SonarScanner 4.6.2.2472', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        withCredentials([string(credentialsId: 'sonar', variable: 'sonarLogin')]) {
          // sh "/opt/sonar-scanner/bin/sonar-scanner -e -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=${sonarLogin} -Dsonar.projectName=go-test -Dsonar.projectVersion=${env.BUILD_NUMBER} -Dsonar.projectKey=GT -Dsonar.sources=. -Dsonar.tests=test/ -Dsonar.language=go"
          sh "/opt/sonar-scanner/bin/sonar-scanner \
            -Dsonar.go.coverageReportPaths=coverage.out \
            -Dsonar.host.url=http://sonarqube:9000 \
            -Dsonar.login=${sonarLogin} \
            -Dsonar.projectName=go-test \
            -Dsonar.coverage.dtdVerification=false \
            -Dsonar.test.inclusions=/**_test.go \
            -Dsonar.projectVersion=${env.BUILD_NUMBER} \
            -Dsonar.projectKey=GT \
            -Dsonar.sources=. \
            -Dsonar.tests=test/ \
            -Dsonar.language=go"
          // sh "/opt/sonar-scanner/bin/sonar-scanner -e -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=2e9fd15216a9d5f2fff4789458233c58fbcb93d0 -Dsonar.projectName=go-test -Dsonar.projectVersion=${env.BUILD_NUMBER} -Dsonar.projectKey=GT -Dsonar.sources=. -Dsonar.tests=test/ -Dsonar.language=go"
        }
      }
    }

    stage('Build Image') {
      // agent {dockerfile true}
      steps {
        echo '=======================Build Docker Image Start==============='
        sh "docker build -t sem4docker/go-test:latest . "
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
        sh "docker push sem4docker/go-test:latest "
        echo '===============Upload Artifact End============================='
        }
    }
    stage('Deploy to stage') {
      // agent any
      steps {
        echo '===============Deploy to stage Start==========================='
        sh "ssh stage 'docker pull sem4docker/go-test:latest' "
        sh "ssh stage 'docker stop go-test' "
        sh "ssh stage 'docker run --name go-test --rm -d --privileged   --publish 8000:8080 sem4docker/go-test:latest' "
        sh "ssh stage 'docker ps' "
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



