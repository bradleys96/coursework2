pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'bradleys96/cw2-server:1.0'  // DockerHub image path
    }
    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git branch: 'main', credentialsId: 'github-ssh', url: 'https://github.com/bradleys96/coursework2.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }
        stage('Test Docker Image') {
            steps {
                script {
                    // Run the container for testing
                    sh '''
                    docker run --rm -d -p 8080:8080 --name test-container $DOCKER_IMAGE
                    sleep 5
                    curl -I http://localhost:8080
                    docker stop test-container
                    '''
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        // Log in to DockerHub and push the image
                        sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push $DOCKER_IMAGE
                        '''
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Apply Kubernetes deployment and service configurations
                    sh '''
                    kubectl apply -f deployment.yml
                    kubectl apply -f service.yml
                    '''
                }
            }
        }
    }
    post {
        always {
            // Clean up Docker resources
            sh 'docker system prune -f'
        }
    }
}

