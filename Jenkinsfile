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

        stage('Build Docker Image') {
            steps {
                echo 'Construction de l image Docker...'
                sh 'docker build -t flask_hello:latest .'
            }
        }

        stage('Deploy to Kubernetes') {
    steps {
        echo 'Déploiement sur Kubernetes...'
        sh 'kubectl apply -f kubernetes/deployment.yaml --validate=false'
        sh 'kubectl apply -f kubernetes/service.yaml --validate=false'
        timeout(time: 3, unit: 'MINUTES') {
            sh 'kubectl rollout status deployment/flask-app'
        }
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