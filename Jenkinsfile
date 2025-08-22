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
                sh '''
                pip3 install pytest
                pytest tests/ --maxfail=1 --disable-warnings -q
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-docker-app:latest .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker tag my-docker-app:latest $DOCKER_USER/my-docker-app:latest
                    docker push $DOCKER_USER/my-docker-app:latest
                    '''
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker stop my-docker-container || true
                docker rm my-docker-container || true
                docker run -d --name my-docker-container -p 8081:80 my-docker-app:latest
                '''
            }
        }
    }
}
