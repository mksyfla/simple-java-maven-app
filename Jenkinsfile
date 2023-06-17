node {
  docker.image('maven:3.9.0-eclipse-temurin-11').inside('-v /root/.m2:/root/.m2') {
    stage('Build') {
      sh 'mvn -B -DskipTests clean package'
    }
    stage('Test') {
      try {
        sh 'mvn test'
      } finally {
        junit 'target/surefire-reports/*.xml'
      }
    }
    stage('Deploy') {
      input message: 'Lanjutkan ke tahap Deploy?'
      sh './jenkins/scripts/deliver.sh'
      sleep(time: 1, unit: 'MINUTES')
    }
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
