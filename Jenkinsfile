pipeline {
    agent any

    environment {
        RESULTS_DIR = "results"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Python + Selenium') {
            steps {
                sh '''
                echo "Installing Python dependencies..."

                python3 -m pip install --upgrade pip

                pip3 install robotframework
                pip3 install robotframework-seleniumlibrary
                pip3 install selenium
                '''
            }
        }

        stage('Install Firefox + Geckodriver') {
            steps {
                sh '''
                echo "Installing Firefox and Geckodriver..."

                apt-get update
                apt-get install -y firefox-esr wget tar

                GECKO_VERSION=0.34.0
                wget https://github.com/mozilla/geckodriver/releases/download/v$GECKO_VERSION/geckodriver-v$GECKO_VERSION-linux64.tar.gz
                tar -xvzf geckodriver-v$GECKO_VERSION-linux64.tar.gz
                mv geckodriver /usr/local/bin/
                chmod +x /usr/local/bin/geckodriver
                '''
            }
        }

        stage('Verify Environment') {
            steps {
                sh '''
                echo "Verifying installations..."

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
