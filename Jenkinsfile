pipeline {
    agent any

    environment {
        VIRTUAL_ENV = 'env' // Name of your virtual environment directory
        PYTHON_VERSION = 'python3.10' // Adjust if you need a specific Python version
        REPO_URL = 'https://github.com/shaun-saisi/django-blog.git'
        SLACK_CREDENTIALS = 'a2f872c3-1e35-4e51-8c90-5bacf458a49a' // Adjust this with your actual credential ID
        CHANNEL = '#deployment' // Slack channel for notifications
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                git url: "${REPO_URL}", branch: 'master'
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                // Create and activate virtual environment
                sh "virtualenv ${VIRTUAL_ENV} -p ${PYTHON_VERSION}"
                sh ". ${VIRTUAL_ENV}/bin/activate"
                // Install dependencies
                sh "${VIRTUAL_ENV}/bin/pip install -r requirements.txt"
            }
        }

        // Removed the 'Run Tests' stage since you requested not to run tests.

        stage('Notify Slack') {
            steps {
                script {
                    // Notify Slack of build status
                    slackSend(channel: "${CHANNEL}", color: 'good', message: "Build completed successfully!")
                }
            }
        }
    }

    post {
        failure {
            script {
                // Notify Slack on failure
                slackSend(channel: "${CHANNEL}", color: 'danger', message: "Build failed!")
            }
        }
    }
}

