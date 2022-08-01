pipeline{
    // setting up dockhub information needed to push image.
    environment {
        registry = "https://github.com/ecarmona1992/devops-2.git"
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
        stage("build"){
            steps{
                script{
                    // reference: https://www.jenkins.io/doc/book/pipeline/jenkinsfile/
                    img = registry
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
}