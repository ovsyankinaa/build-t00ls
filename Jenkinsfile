pipeline {
  agent { label 'build-in' }

  tools { 
    maven 'maven_3.8.4' 
  }
  
  stages {

    stage('GIT') {
      steps {
        cleanWs()
        git branch: 'aausiankin-pipeline', url: 'https://github.com/ovsyankinaa/build-t00ls.git'
      }
    } 

    stage('BUILD WAR') {
      steps {
        dir('helloworld-project/helloworld-ws/') {
          sh 'mvn clean install'
        }
      }
    }

    stage('BUILD IMAGE') {
      steps{
        script{
          docker.build "172.22.0.5:8085/repository/docker_repo:rc-${env.BUILD_NUMBER}"
        }
      }
    }

    stage('Uploading to Nexus') {
      steps{  
        script {
          docker.withRegistry( 'http://172.22.0.5:8085', 'jenkins_nexus' ) {
          dockerImage.push("rc-${env.BUILD_NUMBER}")
          }
        }
      }
    }
  }
}

