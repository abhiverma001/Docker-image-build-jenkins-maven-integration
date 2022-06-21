Build and push docker image to docker hub by Jenkins

Process:- Place the Dockerfile in a gitgub repo --> Integrate the repo with jenkins --> Jenkins will build the docker image by Maven --> Jenkins will push the built docker image to Docke Hub

Above process intructions are written in Jenkinsfile, Jenkins will read the jenkinsfile and proceed with the mentioned intructions.

Go GitHub Repo :-  https://github.com/abhiverma001/Docker-image-build-jenkins-maven-integration 
and Read the readme file and explor the pom.xml file & jenkinsfile

Depedencies:- Below tools should be installed and integrated with Jenkins Global Tools Configuration on Jenkins Machine (For the refer to  CI/CD Notes)
              Git
			  Java Jdk
			  Maven
			  Docker   (First install the Docker plugin for this then it will show in jenkins's global tool configuration)
			  
Go jenkins dashboard and make a new project with pipline
Go to config of project
General -  Github repojiroty URL
Build Trigger - 
       Select below both options
       Build whenever a snapshot dependecy is built
	   Github hook trigger for gitScm polling

Pipeline - Here basically we define by script what exactly need to be done
           we can directly write the script here or we can write the script in Jenkinsfile and upload here (Pipeline Scipt form SCM)
		   
		   Scripted jenkins file is placed in Github repo, go there and modify the required changes as per your configuration
		   
		   Proceed with stage by stage  (Comment (#) rest stages)
		                           First proceed with first stage 
								   then with first and second stage 
								   then first, second and third all stage
								   
								   You can see all the stages process in jenkins project stages dashboard.


Belwo Jenkinsfiles Script Understanding:-  First of all need to remove all # comments while putting this code in JenkinsFile script

pipeline {
    agent any
    tools{
        maven 'maven_3_5_0'   #Check you maven version same version need be specify here or replace this 'maven_3_5_0' with "MAVEN"
    }
    
#Define what steps (stages) need to be performed    
    stages{                   
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Java-Techie-jt/devops-automation']]])

#To get the above checkout syntax go to your jenkins project --> config --> Pipeline --> Pipeline syntax --> Select the Sample Step --> checkout: checkout from version control --> Provide your repo URL --> verify the branch name (main or master) --> Generate the pipeline script --> Copy the content and paste here

                sh 'mvn clean install'  #If jenkins is running on windows machine, change 'sh' to 'bat' and if jenkins running on linux machine, change 'bat' to 'sh'
            }
        }
               
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t abhiverma001/devops-integration .'    #If jenkins is running on windows machine, change 'sh' to 'bat' and if jenkins running on linux machine, change 'bat' to 'sh'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {

# To need to put above script so that you jenkins can get the you dockerhub credentail --> Go to you jenkins dashboard --> Project --> pipeline syntax --> sample step --> with credentials: Bind credentails to variables --> binding -->add (secret text) --> variable (dockerhubpwd) --> add -->jenkins --> kind--> secret text --> secret (password of you docker hub) --> ID (any name like abhi) -->add --> credential --drop down and select you id name abhi --> generate pipeline script and copy the content                 
             
                   sh 'docker login -u javatechie -p ${dockerhubpwd}'    #Replace the javatechie with your docker hub login id. 

}
                   sh 'docker push javatechie/devops-integration'      #If jenkins is running on windows machine, change 'sh' to 'bat' and if jenkins running on linux machine, change 'bat' to 'sh'
                }
            }
        }
    }
}