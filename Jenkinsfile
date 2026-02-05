pipeline {
    agent any

    environment {
        RESULTS_DIR = "results"
    }

    stages {

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Verify Environment') {
            steps {
                sh '''
                echo "Checking installed tools..."
                python3 --version
                robot --version
                firefox --version
                geckodriver --version
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                sh """
                mkdir -p ${RESULTS_DIR}
                robot --outputdir ${RESULTS_DIR} tests/Lab8.robot
                """
            }
        }
    }

    post {
        always {
            step([$class: 'RobotPublisher',
                outputPath: "${RESULTS_DIR}",
                outputFileName: 'output.xml',
                reportFileName: 'report.html',
                logFileName: 'log.html'
            ])
        }
    }
}
