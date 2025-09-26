pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "mywebapp:latest"
        CONTAINER_NAME = "mywebappcontainer"
        HOST_PORT = "6060"
        CONTAINER_PORT = "80"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clean workspace to prevent Git lock issues
                deleteDir()
                git branch: 'main',
                    url: 'https://github.com/nabeel0981/MyWebApp.git'
            }
        }

        stage('Restore & Build') {
            steps {
                sh 'dotnet restore'
                sh 'dotnet build -c Release'
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
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Deploy Container') {
            steps {
                // Stop & remove previous container if exists
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"

                // Run new container with correct port
                sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} -e ASPNETCORE_URLS=http://+:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful! Access your app at http://localhost:${HOST_PORT}"
        }
        failure {
            echo "❌ Something went wrong, check the logs."
        }
    }
}
