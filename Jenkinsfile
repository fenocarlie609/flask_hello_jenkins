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
                echo 'Lancement des tests dans Docker...'
                sh 'docker build -t flask_hello:latest .'
                sh 'docker run --rm flask_hello python test.py -v'
            }
        }

        stage('Run App') {
            steps {
                echo 'Vérification que l app démarre...'
                sh 'docker run --rm -d --name flask_test -p 5000:5000 flask_hello'
                sh 'sleep 3'
                sh 'docker stop flask_test'
                echo 'Application démarrée et arrêtée avec succès !'
            }
        }

    }

    post {
        success {
            echo '✅ Pipeline terminé avec SUCCÈS !'
        }
        failure {
            echo '❌ Pipeline ÉCHOUÉ !'
            sh 'docker stop flask_test || true'
        }
    }
}