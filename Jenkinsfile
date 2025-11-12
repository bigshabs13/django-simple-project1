pipeline {
  agent any

  environment {
    PATH = "C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313;C:\\Users\\user\\AppData\\Local\\Programs\\Python\\Python313\\Scripts;${env.PATH}"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/bigshabs13/django-simple-project1'
      }
    }

    stage('Verify Python') {
      steps {
        bat 'python --version'
        bat 'pip --version'
      }
    }

    stage('Install Dependencies') {
      steps {
        bat 'python -m pip install --upgrade pip'
        bat 'python -m pip install -r requirements.txt'
      }
    }

    stage('Run App') {
      steps {
        bat 'python manage.py runserver'
      }
    }
  }
}
