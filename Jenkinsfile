pipeline {
    agent any

    environment {
        IMAGE_NAME = "victoriaagro-site"
        CONTAINER_NAME = "victoriaagro_container"
        REPO_URL = "https://github.com/sksree/VICTORIA-AGROSERVE-.git"
        WORK_DIR = "/opt/victoriaagro"
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
                sh """
                    cd $WORK_DIR
                    docker build -t $IMAGE_NAME .
                """
            }
        }

        stage('Deploy Container') {
            steps {
                sh """
                    # Stop old container if running
                    if [ \$(docker ps -q -f name=$CONTAINER_NAME) ]; then
                        docker stop $CONTAINER_NAME
                        docker rm $CONTAINER_NAME
                    fi
                    
                    # Start new container
                    docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME
                """
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
