pipeline {
    agent any  // Koi bhi free Jenkins agent use kar lega

    stages {
        // PEHLA KAAM: Code Github se le aao
        stage('Code Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Roshanyadav18/my-docker-app2.git'
                // Apna repository URL daal dena
            }
        }

        // DOOSRA KAAM: Automated Tests Chalado
        stage('Run Tests') {
            steps {
                sh 'npm install'    // Pehle dependencies install karo
                sh 'npm test'       // Phir tests chalado
                // Agar Python hai toh: `pytest`
                // Agar Java hai toh: `mvn test`
            }
        }

        // TEESRA KAAM: Docker Image Banao
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("my-app:${env.BUILD_ID}")
                    // BUILD_ID har build ka unique number hota hai, usse tag kar denge
                }
            }
        }

        // CHAUTHA KAAM: Container Test Karo (Optional but recommended)
        stage('Test Container') {
            steps {
                script {
                    // Temporary container chalake dekhlo sab theek hai ya nahi
                    dockerImage.inside {
                        sh 'echo "Container is running successfully!"'
                        // Yahan aur health checks bhi kar sakte ho
                    }
                }
            }
        }

        // PAACHAVA KAAM: Docker Image Ko DockerHub Pe Push Karo
        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }
    }

    // Agar kuch fail hua toh kya karna hai
    post {
        failure {
            echo 'Pipeline failed! Kuch toh gadbad hai!'
            // Yahan email ya Slack notification bhi bhej sakte ho
        }
        success {
            echo 'Hurray! Sab kuch successful hua!'
        }
    }
}