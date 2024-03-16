"# docker-app" 

Steps To Dockerie Spring Boot Application : 
mvn clean 
mvn install
docker build --no-cache -t your-app-name .
docker run -p 8080:8080 docker-app
