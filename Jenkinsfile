pipeline {
    agent any
    parameters {
        string(name: 'RELEASE_VERSION', 'default': 'none', description: 'Release version to build')
    }
    stages {
        stage('Login to Docker') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials',
                                                     usernameVariable: 'DOCKER_USER',
                                                     passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin $DOCKER_REGISTRY"
                    }
                }
            }
        }
        stage('Build') {
            when {
                expression { params.RELEASE_VERSION != 'none' }
            }
            steps {
                sh('docker build -t backent/pempek-makmantu:${params.RELEASE_VERSION} .')                
            }
        }
    }
}