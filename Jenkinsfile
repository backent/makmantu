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
                withCredentials([
                    string(credentialsId: 'makmantu-docker-user', variable: 'DOCKER_USER'),
                    string(credentialsId: 'makmantu-docker-image-name', variable: 'DOCKER_IMAGE_NAME')
                ]) {
                    withEnv(["REL_VER=${params.RELEASE_VERSION}"]) {
                        echo 'build with version $REL_VER'
                        sh('docker build -t $DOCKER_USER/$DOCKER_IMAGE_NAME:$REL_VER .')
                    }
                }
                
            }
        }
        stage('Image Push') {
            when {
                expression { params.RELEASE_VERSION != '' }
            }
            steps {
                withCredentials([
                    string(credentialsId: 'makmantu-docker-user', variable: 'DOCKER_USER'),
                    string(credentialsId: 'makmantu-docker-image-name', variable: 'DOCKER_IMAGE_NAME')
                ]) {
                    withEnv(["REL_VER=${params.RELEASE_VERSION}"]) {
                        echo 'push image with version $REL_VER'
                        sh("docker push $DOCKER_USER/$DOCKER_IMAGE_NAME:$REL_VER")
                    }
                }
                
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
                    string(credentialsId: 'makmantu-location', variable: 'SECRET_VPS'),
                    string(credentialsId: 'makmantu-docker-user', variable: 'DOCKER_USER'),
                    string(credentialsId: 'makmantu-docker-image-name', variable: 'DOCKER_IMAGE_NAME')
                ]) {
                    withEnv(["REL_VER=${params.RELEASE_VERSION}"]) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no -i "$SECRET_FILE_PATH" "$SECRET_VPS" \
                        "sudo docker pull $DOCKER_USER/$DOCKER_IMAGE_NAME:$REL_VER && \
                        sudo docker rm -f makmantu-ui || true && \
                        sudo docker run -dp 127.0.0.1.8080:80 --name makmantu-ui $DOCKER_USER/$DOCKER_IMAGE_NAME:$REL_VER"
                        '''
                    }
                }
            }
        }
    }
    post {
        cleanup {
            sh('docker logout')
            withCredentials([
                string(credentialsId: 'makmantu-docker-user', variable: 'DOCKER_USER'),
                string(credentialsId: 'makmantu-docker-image-name', variable: 'DOCKER_IMAGE_NAME')
            ]) {
                withEnv(["REL_VER=${params.RELEASE_VERSION}"]) {
                sh('docker image rm $DOCKER_USER/$DOCKER_IMAGE_NAME:$REL_VER')
                }
            }
            sh('docker image prune -f')
        }
    }
}