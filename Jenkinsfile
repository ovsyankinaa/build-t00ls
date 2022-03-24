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
          withSonarQubeEnv('sonar_9.3') {
            sh '''mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.1.2184:sonar
-Dsonar.projectKey = "pipeline:maven"
-Dsonar.projectName = pipeline_docker_maven
-Dsonar.projectVersion = 1.0
-Dsonar.sources = "helloworld-project/helloworld-ws/src/main/java/org/jboss/as/quickstarts/wshelloworld"
-Dsonar.java.binaries = "helloworld-project/helloworld-ws/src/main/java/org/jboss/as/quickstarts/wshelloworld"
'''
          }
          sh 'mvn clean install'
        }
      }
    }

    stage('BUILD IMAGE') {
      steps{
        script{
          docker_img = docker.build "172.22.0.5:8085/repository/docker_repo:rc-${env.BUILD_NUMBER}"
        }
      }
    }

    stage('Uploading to Nexus') {
      steps{  
        script {
          docker.withRegistry( 'http://172.22.0.5:8085', 'jenkins_nexus' ) {
          docker_img.push("rc-${env.BUILD_NUMBER}")
          }
        }
      }
    }
  }
}


/*sonar_scaner_4
sonar_9.3
http://192.168.49.1:9000
sonar*/
