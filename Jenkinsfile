pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'carlie06'
        IMAGE_NAME = "carlie06/flask_hello"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

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
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                sh "docker run --rm ${IMAGE_NAME}:${IMAGE_TAG} python test.py -v"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Push sur Docker Hub...'
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Déploiement sur Kubernetes...'
                sh """
                    CONTAINER_NAME=\$(kubectl get deployment flask-app -o jsonpath='{.spec.template.spec.containers[0].name}')
                    echo "Container name: \$CONTAINER_NAME"
                    kubectl set image deployment/flask-app \${CONTAINER_NAME}=${IMAGE_NAME}:${IMAGE_TAG}
                    kubectl rollout status deployment/flask-app --timeout=3m
                """
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