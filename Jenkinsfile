pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('da98f6a8-8ea8-4d38-88b1-4fa84c846ad0')
        KUBE_CONFIG = credentials('kubeconfig')
        DOCKER_IMAGE = 'anselmschaefer/petison'
        DOCKER_IMAGE_TAG = "1.5.0"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/AnselmSchaefer/petison.git', branch: 'main'
            }
        }

        stage('Set Environment') {
            steps {
                script {
                    // Set JAVA_HOME and GRAALVM_HOME to the GraalVM installation directory
                    env.JAVA_HOME = '/var/jvm/graalvm-jdk-21.0.8+12.1'
                    env.GRAALVM_HOME = '/var/jvm/graalvm-jdk-21.0.8+12.1'
                    env.PATH = "${env.JAVA_HOME}/bin:${env.PATH}"
                }
            }
        }

        stage('Build & Package Native Image with Buildpacks') {
            steps {
                script {
                    // Configure Docker image name via Maven
                    sh """
                        mvn -Pnative \
                        -Dspring-boot.build-image.imageName=${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG} \
                        spring-boot:build-image
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'da98f6a8-8ea8-4d38-88b1-4fa84c846ad0') {
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
                        sh "kubectl apply -f ingress.yaml"
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
