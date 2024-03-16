# Use an official OpenJDK 8 runtime as a base image
FROM openjdk:8-jre-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file into the container
COPY target/docker-app-0.0.1-SNAPSHOT.jar /app/docker-app-0.0.1-SNAPSHOT.jar

# Expose the port that your application runs on
EXPOSE 8080

# Specify the command to run your application
CMD ["java", "-jar", "docker-app-0.0.1-SNAPSHOT.jar"]
