pipeline {
    agent any

    parameters {
        string(name: 'RP_ENDPOINT', defaultValue: '', description: 'Report Portal URL (e.g. https://reportportal.example.com). Leave empty to skip Report Portal.')
        string(name: 'RP_PROJECT', defaultValue: 'default_project', description: 'Report Portal project name')
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '15'))
        timeout(time: 20, unit: 'MINUTES')
        gitConnectionTimeout(60)
    }

    environment {
        PIP_CACHE = "${WORKSPACE}/.pip_cache"
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                checkout scm
            }
        }

        stage('Setup Python & Dependencies') {
            steps {
                bat '''
                    if not exist .pip_cache mkdir .pip_cache
                    python -m pip install --cache-dir .pip_cache -r requirements.txt --quiet
                '''
            }
        }

        stage('Run Robot Framework Tests') {
            steps {
                script {
                    def rpVars = ''
                    if (params.RP_ENDPOINT?.trim()) {
                        withCredentials([string(credentialsId: 'reportportal-api-key', variable: 'RP_API_KEY')]) {
                            rpVars = """
                                --listener robotframework_reportportal.listener
                                --variable RP_ENDPOINT:"${params.RP_ENDPOINT}"
                                --variable RP_LAUNCH:"Robot_${env.JOB_NAME}_${env.BUILD_NUMBER}"
                                --variable RP_PROJECT:"${params.RP_PROJECT}"
                                --variable RP_API_KEY:${env.RP_API_KEY}
                                --variable RP_ATTACH_LOG:True
                                --variable RP_ATTACH_REPORT:True
                            """.replaceAll(/\s+/, ' ').trim()
                            def robotCmd = "robot --outputdir results --loglevel INFO ${rpVars} tests/"
                            bat robotCmd
                        }
                    } else {
                        bat 'robot --outputdir results --loglevel INFO tests/'
                    }
                }
            }
            post {
                always {
                    robot outputPath: 'results',
                         reportFileName: 'report.html',
                         logFileName: 'log.html',
                         passThreshold: 0,
                         unstableThreshold: 0
                    )
                    publishHTML(target: [
                        allowMissing: false,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'results',
                        reportFiles: 'report.html',
                        reportName: 'Robot Framework Report',
                        reportTitles: ''
                    ])
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
        }
        success {
            echo 'Pipeline completed successfully. Results sent to Report Portal.'
        }
        failure {
            echo 'Pipeline failed. Check test results and logs.'
        }
        unstable {
            echo 'Build unstable due to test failures.'
        }
    }
}
