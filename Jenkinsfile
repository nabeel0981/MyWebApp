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
                sh 'dotnet restore'
            }
        }

        stage('Test') {
            steps {
                sh 'dotnet test'
            }
        }

        stage('Publish') {
            steps {
                sh 'dotnet publish -c Release -o out'
                archiveArtifacts artifacts: 'out/**', fingerprint: true
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t mywebapp:latest .'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker stop mywebapp || true
                docker rm mywebapp || true
                docker run -d -p 5000:80 --name mywebapp mywebapp:latest
                '''
            }
        }
    }
}
