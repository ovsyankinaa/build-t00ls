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

    stage('SONAR') {
      steps {
        dir('helloworld-project/helloworld-ws/') {
          withSonarQubeEnv('sonar_9.3') {
            sh '''mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.1.2184:sonar \
-Dsonar.projectKey=pipeline:maven \
-Dsonar.projectName=pipeline_docker_maven \
-Dsonar.projectVersion=1.0 \
-Dsonar.sources=src/main/java/org/jboss/as/quickstarts/wshelloworld \
-Dsonar.java.binaries=src/main/java/org/jboss/as/quickstarts/wshelloworld'''
          }
        }
      }
    }

    stage('BUILD WAR') {
      steps {
        dir('helloworld-project/helloworld-ws/') {
          sh 'mvn clean install'
        }
      }
    }

    stage('BUILD DOCKER IMAGE') {
      steps{
        script{
          docker_img = docker.build "172.22.0.5:8085/repository/docker_repo:rc-${env.BUILD_NUMBER}"
        }
      }
    }

    stage('UPLOAD NEXUS') {
      steps{  
        script {
          docker.withRegistry( 'http://172.22.0.5:8085', 'jenkins_nexus' ) {
          docker_img.push("rc-${env.BUILD_NUMBER}")
          }
        }
      }
    }
    
    stage('ARCHIVE ARTIFACT') {
      steps{
        archiveArtifacts artifacts: 'helloworld-project/helloworld-ws/target/*.war'
      }
    }
    
    stage('START DEPLOY JOB') {
      steps{
        build job: 'deploy_job', 
          parameters: [
            string(name: 'PARENT_BUILD', value: String.valueOf(BUILD_NUMBER))
          ]
      }
    }
  }
}

