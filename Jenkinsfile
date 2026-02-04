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

        stage('Verify Environment') {
            steps {
                echo "Checking installed tools..."

                sh 'python3 --version'
                sh 'robot --version'
                sh 'chromium --version || google-chrome --version'
                sh 'chromedriver --version'

                // Debug workspace structure
                sh '''
                echo "Workspace:"
                pwd
                ls -R
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                echo "Running Robot Framework tests..."

                sh """
                robot \
                    --outputdir ${RESULTS_DIR} \
                    --loglevel TRACE \
                    tests/
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
