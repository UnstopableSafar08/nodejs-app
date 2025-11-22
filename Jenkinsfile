// Stages
// 1. Checkout
// 2. Build and Run Tests & Generate Coverage
// 3. SonarQube Scan
// 4. Sonar Quality Gate
// 5. OWASP Dependency-Check
// 6. Build Docker Image
// 7. Trivy Image Scan
// 8. Trivy FileSystem Scan

pipeline {
    agent any
  tools {
      jdk 'java21'
      gradle 'gradle90'
  }
    environment {
        DOCKER_IMAGE = "sagarmalla08/nodejs-app:$BUILD_NUMBER"
    }

    stages {
        stage('Init') {
            steps {
                sh '''
                    git -v
                    docker -v
                '''
            }
        }

        stage('Checkout') {
            steps {
                deleteDir() // clean workspace before checkout
                git branch: 'main',
                    url: 'https://github.com/UnstopableSafar08/nodejs-app.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t $DOCKER_IMAGE .
                '''
            }
        }

        stage('Push to Registry') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker rm -f node-app || true
                    docker pull $DOCKER_IMAGE
                    docker run -d --name node-app -p 3000:3000 $DOCKER_IMAGE
                '''
            }
        }
    }
}
