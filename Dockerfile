# Use an official OpenJDK 8 runtime as a base image
FROM openjdk:8-jre-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the packaged JAR file into the container
COPY target/docker-app.jar /app/docker-app.jar

# Expose the port that your application runs on
EXPOSE 8090

# Specify the command to run your application
CMD ["java", "-jar", "docker-app.jar"]
