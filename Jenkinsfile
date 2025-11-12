pipeline {
    agent any

    environment {
        IMAGE_NAME = 'django-simple:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/bigshabs13/django-simple-project1'
            }
        }

        stage('Build Docker Image (inside Minikube)') {
            steps {
                bat '''
                    echo ============================================
                    echo Setting Docker environment to Minikube...
                    echo ============================================
                    minikube -p minikube docker-env --shell cmd > docker_env.bat
                    call docker_env.bat

                    echo ============================================
                    echo Building Docker image inside Minikube...
                    echo ============================================
                    docker build -t %IMAGE_NAME% .

                    echo ============================================
                    echo Docker images inside Minikube:
                    docker images | findstr django
                    echo ============================================
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat '''
                    echo ============================================
                    echo Setting Docker environment to Minikube...
                    echo ============================================
                    minikube -p minikube docker-env --shell cmd > docker_env.bat
                    call docker_env.bat

                    echo ============================================
                    echo Deploying Django app to Minikube...
                    echo ============================================
                    kubectl apply -f deployment.yaml
                    kubectl rollout restart deployment django-deployment
                    kubectl rollout status deployment django-deployment

                    echo ============================================
                    echo Deployment complete!
                    echo ============================================
                '''
            }
        }
    }
}
