# docker-app 

## Steps To Dockerie Spring Boot Application : 
mvn clean <br/>
mvn install<br/>
docker build --no-cache -t your-app-name .<br/>
docker run -p 8080:8080 docker-app


## Steps to tag and push image in docker hub
docker tag local-image-name:tag hub-repo-name:tag
docker push hub-repo-name:tag
