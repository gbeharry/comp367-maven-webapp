pipeline {
    agent any

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

        stage('Deploy') {
            steps {
                echo "Deploying application..."
                
            }
        }
    }

    triggers {
        pollSCM('H/5 * * * *')
    }
}
