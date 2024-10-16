#!groovy

node {
    try {
        stage('Checkout') {
            checkout scm

            sh 'git log HEAD^..HEAD --pretty="%h %an - %s" > GIT_CHANGES'
            def lastChanges = readFile('GIT_CHANGES')
            slackSend color: "warning", message: "Started `${env.JOB_NAME}#${env.BUILD_NUMBER}`\n\n_The changes:_\n${lastChanges}"
        }

        stage('Test') {
            sh 'virtualenv env -p python3.10'
            
            // Check if the virtual environment was created
            sh 'ls -l env/bin/'  // List contents of the virtual environment's bin directory

            // Activate the virtual environment and run the command in one line
            dir('website') {
                sh '''
                . ../env/bin/activate  # Navigate back to the parent directory
                env/bin/python manage.py test --testrunner=blog.tests.test_runners.NoDbTestRunner
                '''
            }
        }

        stage('Deploy') {
            sh './deployment/deploy_prod.sh'
        }

        stage('Publish results') {
            slackSend color: "good", message: "Build successful: `${env.JOB_NAME}#${env.BUILD_NUMBER}` <${env.BUILD_URL}|Open in Jenkins>"
        }

    } catch (err) {
        slackSend color: "danger", message: "Build failed :face_with_head_bandage: \n`${env.JOB_NAME}#${env.BUILD_NUMBER}` <${env.BUILD_URL}|Open in Jenkins>"
        throw err
    }
}

