pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app:latest"
        CONTAINER_NAME = "my-container"
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git branch: 'main',
                    credentialsId: '14f496e8-1cfd-495e-b33c-f3471fe3a118', 
                    url: 'https://github.com/Ahmaraza786/pipelinetest.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile in the repository
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Stop & Remove Old Container') {
            steps {
                // Stop the old container if it exists
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                // Optionally remove the old image (not necessary if you don't want to)
                sh "docker rmi ${IMAGE_NAME} || true"
            }
        }

        stage('Run New Container') {
            steps {
                // Run the new Docker container
                sh "docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}"
            }
        }
    }
}
