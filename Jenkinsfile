pipeline {
    agent any
    tools{
        maven 'maven_3_5_0'   #Check you maven version same version need be specify here
    }
    
#Define what steps (stages) need to be performed    
    stages{                   
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Java-Techie-jt/devops-automation']]])
                sh 'mvn clean install'
            }
        }
#To get the above checkout syntax go to your jenkins project --> config --> Pipeline --> Pipeline syntax --> Select the Sample Step --> checkout: checkout from version control --> Provide your repo URL --> verify the branch name -- Generate the pipeline script 
               
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t javatechie/devops-integration .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u javatechie -p ${dockerhubpwd}'

}
                   sh 'docker push javatechie/devops-integration'
                }
            }
        }
    }
}
