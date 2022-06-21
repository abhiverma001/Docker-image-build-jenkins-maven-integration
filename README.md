Build and push docker image to docker hub by Jenkins

Process:- Plcae the Dockerfile in a gitgub repo --> Integrate the repo with jenkins --> Jenkins will build the docker image by Maven --> Jenkins will push the built docker image to Docke Hub

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
                                   