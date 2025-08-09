pipeline {
    agent any
    parameters {
        string(name: 'RELEASE_VERSION', defaultValue: '', description: 'Release version to build')
    }
    stages {
        stage('Login to Docker') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-backent-cred',
                                                     usernameVariable: 'DOCKER_USER',
                                                     passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    }
                }
            }
        }
        stage('Build') {
            when {
                expression { params.RELEASE_VERSION != '' }
            }
            steps {
                echo 'build with version ${params.RELEASE_VERSION}'
                sh("docker build -t backent/pempek-makmantu:${params.RELEASE_VERSION} .")
            }
        }
    }
}