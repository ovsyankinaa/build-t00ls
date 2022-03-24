pipeline {
  agent { label 'build-in' }
  tools { 
    maven 'maven_3.8.4' 
  }
  stages {
    stage('GIT'){
      steps {
        cleanWs()
        git branch: 'aausiankin-pipeline', url: 'https://github.com/ovsyankinaa/build-t00ls.git'
      }
      stage('SONARQUBE'){
      }
      stage('BUILD WAR') {
        steps {
          dir('helloworld-project/helloworld-ws/') {
            sh 'mvn clean install'
          }
        }
      }
    }
  }
}
