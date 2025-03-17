pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub_id' 
        DOCKER_IMAGE_NAME = 'gabrielbeharry/maven-webapp' 
    }

    tools {
        maven 'Maven 3' 
        jdk 'JDK 21' 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/gbeharry/comp367-maven-webapp.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Building the Maven Web App..."
                    sh 'mvn clean package'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo "Running unit tests..."
                    sh 'mvn test'
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    echo "Logging into Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo "Building Docker Image..."
                    sh 'docker build -t $DOCKER_IMAGE_NAME .'
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    echo "Pushing Docker Image to Docker Hub..."
                    sh 'docker push $DOCKER_IMAGE_NAME'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo "Running Docker Container..."
                    sh 'docker run -d -p 8080:8080 --name maven-webapp $DOCKER_IMAGE_NAME'
                }
            }
        }
    }

    triggers {
        pollSCM('H/5 * * * *')
    }
}
