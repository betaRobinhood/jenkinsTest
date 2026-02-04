pipeline {
    agent any

    environment {
        RESULTS_DIR = "results"
    }

    stages {

        stage('Cleanup') {
            steps {
                echo "Cleaning old results..."
                sh "rm -rf ${RESULTS_DIR}"
                sh "mkdir -p ${RESULTS_DIR}"
            }
        }

        stage('Install System Dependencies') {
            steps {
                echo "Installing Chromium + ChromeDriver (if missing)..."

                sh '''
                if ! command -v chromium >/dev/null 2>&1; then
                    apt-get update
                    apt-get install -y chromium-browser chromium-chromedriver
                fi
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
                echo "Verifying installed tools..."

                sh '''
                python3 --version
                robot --version
                chromium --version || google-chrome --version
                chromedriver --version
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                echo "Running Robot tests..."

                sh """
                robot \
                    --outputdir ${RESULTS_DIR} \
                    tests/Lab8.robot
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
                logFileName: 'log.html',
                disableReports: false,
                passThreshold: 100.0,
                unstableThreshold: 80.0
            ])

            archiveArtifacts artifacts: "${RESULTS_DIR}/*.*", allowEmptyArchive: true
        }
    }
}
