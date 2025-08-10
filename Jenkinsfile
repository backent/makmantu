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
        stage('Image Push') {
            when {
                expression { params.RELEASE_VERSION != '' }
            }
            steps {
                echo 'push image with version ${params.RELEASE_VERSION}'
                sh("docker push backent/pempek-makmantu:${params.RELEASE_VERSION}")
            }
        }
        stage('Deployment') {
            when {
                expression { params.RELEASE_VERSION != '' }
            }
            steps {
                echo "deploying with version ${params.RELEASE_VERSION}"
                withCredentials([
                    file(credentialsId: 'makmantu-key', variable: 'SECRET_FILE_PATH'),
                    string(credentialsId: 'makmantu-location', variable: 'SECRET_VPS')
                ]) {
                    withEnv(["REL_VER=${params.RELEASE_VERSION}"]) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no -i "$SECRET_FILE_PATH" "$SECRET_VPS" \
                        "sudo docker pull backent/pempek-makmantu:$REL_VER && \
                        sudo docker rm -f makmantu-ui || true && \
                        sudo docker run -dp 8080:80 --name makmantu-ui backent/pempek-makmantu:$REL_VER"
                        '''
                    }
                }
            }
        }
    }
    post {
        cleanup {
            sh('docker logout')
            sh("docker image rm backent/pempek-makmantu:${params.RELEASE_VERSION}")
            sh('docker image prune -f')
        }
    }
}