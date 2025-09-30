pipeline {
    agent any

    environment {
        IMAGE_NAME = "victoriaagro-site"
        CONTAINER_NAME = "victoriaagro_container"
        REPO_URL = "https://github.com/sksree/VICTORIA-AGROSERVE-.git"
        WORK_DIR = "${WORKSPACE}/victoriaagro"
    }

    stages {
        stage('Checkout Code') {
            steps {
                sh """
                    if [ ! -d "$WORK_DIR" ]; then
                        git clone $REPO_URL $WORK_DIR
                    else
                        cd $WORK_DIR && git pull
                    fi
                """
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dir(WORK_DIR) {
                        app = docker.build("${IMAGE_NAME}")
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop and remove old container if exists
                    sh """
                        if [ \$(docker ps -q -f name=$CONTAINER_NAME) ]; then
                            docker stop $CONTAINER_NAME
                            docker rm $CONTAINER_NAME
                        fi
                    """

                    // Run the new container
                    app.run("--name ${CONTAINER_NAME} -p 80:80")
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment completed successfully!"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}
