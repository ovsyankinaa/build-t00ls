node('build-in') {
  tools { 
    maven 'maven_3.8.4' 
  }
  stage('GIT'){
    cleanWs()
    git branch: 'aausiankin-pipeline', url: 'https://github.com/ovsyankinaa/build-t00ls.git'
  }
  stage('SONARQUBE'){
  }
  stage('BUILD WAR') { 
    dir('helloworld-project/helloworld-ws/') {
    sh 'mvn clean install' 
    }
  }
}
