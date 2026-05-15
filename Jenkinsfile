pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Récupération du code depuis GitHub...'
                git credentialsId: 'github-credentials',
                    url: 'https://github.com/fenocarlie609/flask_hello_jenkins.git',
                    branch: 'main'
            }
        }

        stage('Test') {
            steps {
                echo 'Lancement des tests...'
                sh 'pip install -r requirements.txt'
                sh 'python test.py -v'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Construction de l image Docker...'
                sh 'docker build -t flask_hello:latest .'
            }
        }

    }

    post {
        success {
            echo '✅ Pipeline terminé avec SUCCÈS !'
        }
        failure {
            echo '❌ Pipeline ÉCHOUÉ !'
        }
    }
}