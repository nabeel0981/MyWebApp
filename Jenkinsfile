pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/nabeel0981/MyWebApp.git'
            }
        }

        stage('Restore Dependencies') {
            steps {
                bat 'dotnet restore'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t mywebapp:latest .'
            }
        }

        stage('Test') {
            steps {
                bat 'dotnet test'
            }
        }

        stage('Publish') {
            steps {
                bat 'dotnet publish -c Release -o out'
                archiveArtifacts artifacts: 'out/**', fingerprint: true
            }
        }
    }
}
