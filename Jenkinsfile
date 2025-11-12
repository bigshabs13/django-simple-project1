pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/bigshabs13/django-simple-project1'
      }
    }

    stage('Build') {
      steps {
        bat 'python --version'
      }
    }

    stage('Run App') {
      steps {
        bat 'python manage.py runserver'
      }
    }
  }
}
