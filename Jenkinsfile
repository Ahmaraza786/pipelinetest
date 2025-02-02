pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app:latest"
        CONTAINER_NAME = "my-container"
    }

    stages {
        stage('Cleanup') {
            steps {
                script {
                    // Remove old containers and images safely
                    sh '''
                        # Stop and remove old container if exists
                        docker stop ${CONTAINER_NAME} || true
                        docker rm ${CONTAINER_NAME} || true
                        
                        # Remove dangling images (untagged images)
                        docker image prune -f
                        
                        # Remove old versions of our app image
                        docker images my-app -q | xargs docker rmi -f || true
                        
                        # Clean build cache
                        docker builder prune -f
                    '''
                }
            }
        }

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    credentialsId: '14f496e8-1cfd-495e-b33c-f3471fe3a118', 
                    url: 'https://github.com/Ahmaraza786/pipelinetest.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build --no-cache --memory=512m -t ${IMAGE_NAME} ."
            }
        }

        stage('Run New Container') {
            steps {
                sh "docker run -d --name ${CONTAINER_NAME} --memory=256m --restart unless-stopped -p 8080:8080 ${IMAGE_NAME}"
            }
        }
    }

    post {
        always {
            // Show disk usage after pipeline
            sh '''
                echo "Docker Disk Usage:"
                docker system df
                echo "System Disk Usage:"
                df -h
            '''
        }
        failure {
            sh '''
                docker logs ${CONTAINER_NAME} || true
                free -h || true
            '''
        }
    }
}