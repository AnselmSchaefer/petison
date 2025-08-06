pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('da98f6a8-8ea8-4d38-88b1-4fa84c846ad0')
        KUBE_CONFIG = credentials('kubeconfig')
        DOCKER_IMAGE = 'anselmschaefer/petison'
        DOCKER_IMAGE_TAG = "1.0.0"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/AnselmSchaefer/petison.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package' // or 'gradle build' depending on your build tool
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}", ".")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}").push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withEnv(["KUBECONFIG=${KUBE_CONFIG}"]) {
                        sh "kubectl apply -f kubernetes-deployment.yaml"
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
