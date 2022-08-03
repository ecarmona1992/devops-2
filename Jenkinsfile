pipeline{
    // setting up dockhub information needed to push image.
    environment {
        registry = "ecarmona1992/devops-challenge"
        registrycredential = 'docker-hub'
        dockerimage = ''
            }
    agent any

    stages{
        stage("init"){
            steps{
                echo "Cloning git"
                // git 'https://github.com/ecarmona1992/devops-challenge.git' 
                // sh "docker system prune -af"
            }
        }
        stage("testing"){
            steps{
                echo "passed test"
            }
        }
        stage("build package"){
            steps{
                sh "mvn clean package"
            }
        }
        stage('SonarQube Analysis') {
            steps{
                script{
                sh "mvn -X verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=devops-2"
                }
            }
        }
        stage("build"){
            steps{
                script{
                    // reference: https://www.jenkins.io/doc/book/pipeline/jenkinsfile/
                    img = registry + ":${env.BUILD_ID}"
                    // reference: https://docs.cloudbees.com/docs/admin-resources/latest/plugins/docker-workflow
                    dockerImage = docker.build("${img}")
                }
            }
        }
        stage("Deploy"){
            steps{
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com ', registryCredential ) {
                        // push image to registry
                        dockerImage.push()
                    }
                }
            }
        }
        
    }
    // send email notification once everything completes
        post {
            always {
                
                emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n",
                    recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                    subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
                
            }
        }
}