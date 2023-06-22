node {
  docker.image('maven:3.9.0-eclipse-temurin-11').inside('-v /root/.m2:/root/.m2') {
    stage('Build') {
      sh 'mvn -B -DskipTests clean package'
      sh 'ls && ls target'
    }
    stage('Test') {
      try {
        sh 'mvn test'
      } finally {
        junit 'target/surefire-reports/*.xml'
      }
    }
  }

  stage('Checkout') {
    checkout scm
  }

  stage('Deploy') {
    input message: 'Lanjutkan ke tahap Deploy?'
    withCredentials([sshUserPrivateKey(
      credentialsId: 'ec2-server-key',
      keyFileVariable: 'KEYFILE',
    )]) {
      sh "scp -i $KEYFILE target/my-app-1.0-SNAPSHOT.jar ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com:maven-app/app.jar"
      sh "ssh -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'ls'"
      sh "ssh -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'sudo docker build -t maven-app -f Dockerfile maven-app/.'"
      sh "ssh -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'sudo docker run -d -p 8080:8080 -n maven-app maven-app:latest'"
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
