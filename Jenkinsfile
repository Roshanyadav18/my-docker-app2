pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app"
    }

    stages {
        // Stage 1: Code Checkout
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                     url: 'https://github.com/Roshanyadav18/my-docker-app2.git'
            }
        }

        // Stage 2: Run Tests
        stage('Run Tests') {
            steps {
                sh 'npm install'
                sh 'npm test'
            }
        }

        // Stage 3: Build Docker Image (YEH WAALA STAGE FAIL HO RAHA HAI)
        stage('Build Docker Image') {
            steps {
                script {
                    // Simple command se try karo pehle
                    sh "docker build -t ${IMAGE_NAME}:${env.BUILD_ID} ."
                }
            }
        }

        // Stage 4: Test Container
        stage('Test Container') {
            steps {
                script {
                    sh "docker run --rm ${IMAGE_NAME}:${env.BUILD_ID} echo 'Container test successful'"
                }
            }
        }

        // Stage 5: Push to DockerHub
        stage('Push to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                        sh "docker push ${IMAGE_NAME}:${env.BUILD_ID}"
                    }
                }
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed! Kuch toh gadbad hai!'
        }
        success {
            echo 'Hurray! Sab kuch successful hua!'
        }
    }
}