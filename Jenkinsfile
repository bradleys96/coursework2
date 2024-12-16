pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'bradleys96/cw2-server:1.0'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', credentialsId: 'github-ssh', url: 'https://github.com/bradleys96/coursework2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    docker build -t ${DOCKER_IMAGE} .
                    '''
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Run the container for testing
                    sh '''
                    docker run --rm -d -p 8082:8080 --name test-container ${DOCKER_IMAGE}
                    sleep 5
                    curl -I http://localhost:8082
                    docker stop test-container
                    '''
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'dockerhub-credentials', url: '']) {
                        sh '''
                        docker push ${DOCKER_IMAGE}
                        '''
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
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
            script {
                sh '''
                docker system prune -f
                '''
            }
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for more details.'
        }
    }
}

