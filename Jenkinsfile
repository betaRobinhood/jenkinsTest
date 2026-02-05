pipeline {
    agent any

    environment {
        RESULTS_DIR = "results"
    }

    stages {

        stage('Checkout Source') {
            steps {
                echo "Cloning repository..."
                checkout scm
            }
        }

        stage('Install System Dependencies') {
            steps {
                echo "Installing Firefox + Geckodriver..."

                sh '''
                apt-get update

                # Install Firefox
                apt-get install -y firefox-esr wget tar

                # Install Geckodriver
                GECKO_VERSION=0.34.0
                wget https://github.com/mozilla/geckodriver/releases/download/v$GECKO_VERSION/geckodriver-v$GECKO_VERSION-linux64.tar.gz
                tar -xvzf geckodriver-v$GECKO_VERSION-linux64.tar.gz
                mv geckodriver /usr/local/bin/
                chmod +x /usr/local/bin/geckodriver
                '''
            }
        }

        stage('Install Python Dependencies') {
            steps {
                echo "Installing Robot Framework + Selenium..."

                sh '''
                python3 -m pip install --upgrade pip
                pip3 install robotframework
                pip3 install robotframework-seleniumlibrary
                pip3 install selenium
                '''
            }
        }

        stage('Verify Environment') {
            steps {
                sh '''
                echo "Verifying installed tools..."

                firefox --version
                geckodriver --version
                robot --version
                python3 --version
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
            echo "Publishing Robot results..."

            step([$class: 'RobotPublisher',
                outputPath: "${RESULTS_DIR}",
                outputFileName: 'output.xml',
                reportFileName: 'report.html',
                logFileName: 'log.html'
            ])
        }
    }
}
