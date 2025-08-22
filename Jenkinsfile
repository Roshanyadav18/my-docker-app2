pipeline {
    agent any

    stages {
        // Stage 1: Check Docker Status
        stage('Check Docker') {
            steps {
                sh 'docker --version'
                sh 'docker info'
            }
        }

        // Stage 2: Checkout Code
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                     url: 'https://github.com/Roshanyadav18/my-docker-app2.git',
                     credentialsId: 'github-credentials'
            }
        }

        // Stage 3: List Files (Debugging ke liye)
        stage('List Files') {
            steps {
                sh 'ls -la'
                sh 'cat Dockerfile || echo "Dockerfile not found"'
            }
        }

        // Stage 4: Simple Docker Build
        stage('Simple Docker Build') {
            steps {
                sh 'docker build -t test-image .'
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed - checking results'
        }
    }
}