pipeline {
  agent any
  environment {
    REGISTRY   = 'docker.io'
    IMAGE_NAME = 'serj12/django-simple'
    SHORT_SHA  = "${env.GIT_COMMIT?.take(7) ?: 'dev'}"
    TAG        = "${SHORT_SHA}"
  }
  triggers {
    githubPush()    // 🔥 auto-builds whenever you push to GitHub
  }
  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/bigshabs13/django-simple-project1'
      }
    }

    stage('Build Image') {
      steps {
        bat "docker build -t %REGISTRY%/%IMAGE_NAME%:%TAG% ."
      }
    }

    stage('Push Image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          bat """
            echo %PASS% | docker login %REGISTRY% -u %USER% --password-stdin
            docker push %REGISTRY%/%IMAGE_NAME%:%TAG%
            docker logout %REGISTRY%
          """
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        bat """
          kubectl set image deployment/django-deployment django=%REGISTRY%/%IMAGE_NAME%:%TAG%
          kubectl rollout status deployment/django-deployment
        """
      }
    }
  }
}
