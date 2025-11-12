pipeline {
  agent any
  environment {
    IMAGE_NAME = 'django-simple'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/bigshabs13/django-simple-project1'
      }
    }

    stage('Build Image in Minikube') {
      steps {
        bat '''
          echo Setting Docker environment to Minikube
          minikube -p minikube docker-env --shell cmd > docker_env.bat
          call docker_env.bat

          echo Building Docker image inside Minikube...
          docker build -t django-simple:latest .
        '''
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        bat '''
          echo Updating Kubernetes deployment...
          kubectl set image deployment/django-deployment django=django-simple:latest
          kubectl rollout restart deployment/django-deployment
          kubectl rollout status deployment/django-deployment
        '''
      }
    }
  }
}
