pipeline {
  agent any

  environment {
    // Add Python 3.13 paths for Jenkins service
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

    stage('Run Migrations') {
      steps {
        dir('website') { // ✅ change directory to where manage.py actually is
          bat 'python manage.py makemigrations'
          bat 'python manage.py migrate'
        }
      }
    }

    stage('Run Django App (optional)') {
      when { expression { return false } } // prevents Jenkins from hanging forever
      steps {
        dir('website') {
          bat 'python manage.py runserver 0.0.0.0:8000'
        }
      }
    }
  }
}
