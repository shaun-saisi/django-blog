pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup Virtual Environment') {
            steps {
                sh 'virtualenv env -p python3.10'
                sh '. env/bin/activate'
                sh 'env/bin/pip install -r requirements.txt'
            }
        }
        
        stage('Run Tests') {
            steps {
                dir('website') { // Change to the 'website' directory
                    sh '. ../env/bin/activate' // Activate the virtual environment
                    sh 'python manage.py test --testrunner=blog.tests.test_runners.NoDbTestRunner'
                }
            }
        }
        
        stage('Notify Slack') {
            steps {
                slackSend channel: '#deployment', color: 'danger', message: 'Build failed'
            }
        }
    }
}

