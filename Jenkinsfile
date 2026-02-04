pipeline {
    agent any

    environment {
        RESULTS_DIR = "results"
    }

    stages {

        stage('Install System Dependencies') {
            steps {
                echo "Installing Firefox + Geckodriver..."

                sh '''
                apt-get update

                # Install Firefox
                apt-get install -y firefox-esr

                # Install geckodriver
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
                echo "Installing Robot + Selenium..."

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
                firefox --version
                geckodriver --version
                robot --version
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                sh """
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
