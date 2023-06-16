// node {
//   docker.image('maven:3.9.0').inside('-v /root/.m2:/root/.m2') {
//     stage('Build') {
//       sh 'mvn -B -DskipTests clean package'
//     }
//     stage('Test') {
//       sh 'mvn test' 
//     }
//   }
// }

pipeline {
  agent {
    docker {
      image 'maven:3.9.0'
      args '-v /root/.m2:/root/.m2'
    }
  }
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }
  }
}
