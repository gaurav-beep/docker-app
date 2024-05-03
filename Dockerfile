# Use an official OpenJDK 8 runtime as a base image
FROM openjdk:8-jre-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file into the container
COPY target/docker-app.jar /app/docker-app.jar

# Copy the JSP files into the container
COPY src/main/webapp/WEB-INF/jsp/ /app/src/main/webapp/WEB-INF/jsp/

# Expose the port that your application runs on
EXPOSE 8090

# Command to run the application
CMD ["java", "-jar", "docker-app.jar"]
