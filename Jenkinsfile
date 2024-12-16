pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/cw2-server:1.0'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', credentialsId: 'github-ssh', url: 'git@github.com:your-username/DevOps-Coursework.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }
        stage('Test Docker Image') {
            steps {
                script {
                    sh 'docker run --rm -d -p 8080:8080 --name test-container $DOCKER_IMAGE'
                    sh 'sleep 5'
                    sh 'curl -I http://localhost:8080'
                    sh 'docker stop test-container'
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    sh 'docker login -u your-dockerhub-username -p your-dockerhub-password'
                    sh 'docker push $DOCKER_IMAGE'
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
            sh 'docker system prune -f'
        }
    }
}
pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/cw2-server:1.0'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', credentialsId: 'github-ssh', url: 'git@github.com:your-username/DevOps-Coursework.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }
        stage('Test Docker Image') {
            steps {
                script {
                    sh 'docker run --rm -d -p 8080:8080 --name test-container $DOCKER_IMAGE'
                    sh 'sleep 5'
                    sh 'curl -I http://localhost:8080'
                    sh 'docker stop test-container'
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    sh 'docker login -u your-dockerhub-username -p your-dockerhub-password'
                    sh 'docker push $DOCKER_IMAGE'
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
            sh 'docker system prune -f'
        }
    }
}

