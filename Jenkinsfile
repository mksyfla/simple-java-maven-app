node {
  docker.image('maven:3.9.0-eclipse-temurin-11').inside('-v /root/.m2:/root/.m2') {
    stage('Build') {
      sh 'mvn clean package'
    }
  }

  stage('Checkout') {
    checkout scm
  }

  stage('Build Image') {
    withCredentials([usernamePassword(
      credentialsId: 'docker-hub-mksyfla',
      usernameVariable: 'USER',
      passwordVariable: 'PASSWORD'
    )]) {
      sh 'docker login -u $USER -p $PASSWORD'
      sh 'docker build -t simple-java-maven -f Dockerfile .'
      sh 'docker tag simple-java-maven:latest $USER/simple-java-maven'
      sh 'docker push simple-java-maven'
    }
  }

  stage('Deploy') {
    input message: 'Lanjutkan ke tahap Deploy?'
    withCredentials([sshUserPrivateKey(
      credentialsId: 'ec2-server-key',
      keyFileVariable: 'KEYFILE',
    )]) {
      sh "ssh -o StrictHostKeyChecking=no -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'sudo docker pull mksyfla/react-app:latest'"
      sh "ssh -o StrictHostKeyChecking=no -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'sudo docker run -p 3000:3000 -d mksyfla/react-app:latest -n maven'"
      sh "ssh -o StrictHostKeyChecking=no -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'sudo docker exec -it maven /bin/bash ./jenkins/scripts/deliver.sh'"
    }
    sleep(time: 1, unit: 'MINUTES')
  }
}

// pipeline {
//   agent {
//     docker {
//       image 'maven:3.9.0-eclipse-temurin-11'
//       args '-v /root/.m2:/root/.m2'
//     }
//   }
//   stages {
//     stage('Build') {
//       steps {
//         sh 'mvn -B -DskipTests clean package'
//       }
//     }
//     stage('Test') {
//       steps {
//         sh 'mvn test'
//       }
//       post {
//         always {
//           junit 'target/surefire-reports/*.xml'
//         }
//       }
//     }
//     stage('Deploy') {
//       steps {
//         input message: 'Lanjutkan ke tahap Deploy?'
//         sh './jenkins/scripts/deliver.sh'
//         sleep(time: 1, unit: 'MINUTES')
//       }
//     }
//   }
// }
