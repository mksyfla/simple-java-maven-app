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

  // stage('Build Image') {
  //   withCredentials([usernamePassword(
  //     credentialsId: 'docker-hub-mksyfla',
  //     usernameVariable: 'USER',
  //     passwordVariable: 'PASSWORD'
  //   )]) {
  //     sh 'docker login -u $USER -p $PASSWORD'
  //     sh 'ls && ls target'
  //     sh 'java -jar target/my-app-1.0-SNAPSHOT.jar'
  //     sh 'docker build -t maven-app -f Dockerfile target/my-app-1.0-SNAPSHOT.jar'
  //     sh 'docker tag maven-app:latest $USER/maven-app'
  //     sh 'docker push $USER/maven-app'
  //   }
  // }

  stage('Deploy') {
    input message: 'Lanjutkan ke tahap Deploy?'
    withCredentials([sshUserPrivateKey(
      credentialsId: 'ec2-server-key',
      keyFileVariable: 'KEYFILE',
    )]) {
      sh "scp -i $KEYFILE target/my-app-1.0-SNAPSHOT.jar ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com:~/app.jar"
      sh "ssh -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'ls'"
      sh "ssh -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'sudo docker build -t maven-java app.jar'"
      sh "ssh -i $KEYFILE ubuntu@ec2-13-215-248-81.ap-southeast-1.compute.amazonaws.com 'sudo docker run -d -p 8080:8080 -n maven-app mksyfla/maven-app:latest'"
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
