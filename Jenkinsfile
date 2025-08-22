pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Roshanyadav18/my-docker-app2.git'
            }
        }

        stage('Install Dependencies & Run Tests') {
            steps {
                sh 'pip install pytest'
                sh 'pytest tests/ --maxfail=1 --disable-warnings -q'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-docker-app:latest .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASS')]) {
                    sh """
                    echo $DOCKER_PASS | docker login -u <roshanyadav18> --password-stdin
                    docker tag my-docker-app:latest <roshanyadav18>/my-docker-app:latest
                    docker push <roshanyadav18>/my-docker-app:latest
                    """
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh 'docker run -d -p 8081:80 my-docker-app:latest'
            }
        }
    }
}
