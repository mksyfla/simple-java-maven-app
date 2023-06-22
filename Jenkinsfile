node {
  docker.image('maven:3.9.0-eclipse-temurin-11').inside('-v /root/.m2:/root/.m2') {
    stage('Build') {
      sh 'mvn -B -DskipTests clean package -DfinalName=maven-java'
      sh 'ls'
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
      // sh "docker cp -i $KEYFILE target/maven-java.jar ubuntu@13.215.248.81:~/app.jar"
      // sh "docker cp -i $KEYFILE Dockerfile ubuntu@13.215.248.81:~/Dockerfile"
      // sh "ssh ssh -i $KEYFILE ubuntu@13.215.248.81 'sudo docker build -t maven-java . -f ~/Dockerfile'"
      // sh "ssh -i $KEYFILE ubuntu@13.215.248.81 'docker run -d -p 8080:8080 --n maven-java maven-java'"
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
