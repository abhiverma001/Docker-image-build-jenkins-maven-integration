#FROM ubuntu
#EXPOSE 8080
#ADD target/devops-integration.jar devops-integration.jar
#ENTRYPOINT ["java","-jar","/devops-integration.jar"]




FROM alpine:latest

#install the nodejs (apk is package Manager rool for apline os, --no-cache is used to reduce the size of nodejs application)
RUN apk add --no-cache nodejs npm

#Create a work dir in contianer
WORKDIR /app