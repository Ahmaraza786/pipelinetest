pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app:latest"
        CONTAINER_NAME = "my-container"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    credentialsId: '14f496e8-1cfd-495e-b33c-f3471fe3a118', 
                    url: 'https://github.com/Ahmaraza786/pipelinetest.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Stop & Remove Old Container') {
            steps {
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                sh "docker rmi ${IMAGE_NAME} || true"
            }
        }

        stage('Run New Container') {
            steps {
                sh "docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}"
            }
        }
    }
}
