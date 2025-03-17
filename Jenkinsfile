pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub_id' // Matches the Jenkins credentials ID
        DOCKER_IMAGE_NAME = 'gabrielbeharry/maven-webapp' // Your Docker Hub repository
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
                    bat 'mvn clean package'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo "Running unit tests..."
                    bat 'mvn test'
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    echo "Logging into Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo "Building Docker Image..."
                    bat 'docker build -t %DOCKER_IMAGE_NAME% .'
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    echo "Pushing Docker Image to Docker Hub..."
                    bat 'docker push %DOCKER_IMAGE_NAME%'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo "Running Docker Container..."
                    bat 'docker run -d -p 8080:8080 --name maven-webapp %DOCKER_IMAGE_NAME%'
                }
            }
        }
    }

    triggers {
        pollSCM('H/5 * * * *') // Check for new commits every 5 minutes
    }
}
