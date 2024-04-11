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

# Specify the command to run your application
CMD ["java", "-Dspring.datasource.url=jdbc:mysql://monorail.proxy.rlwy.net:33620/user", "-Dspring.datasource.username=root", "-Dspring.datasource.password=FJksRduoAwdSrcVBdMneteLMDrakHEAS", "-Dspring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver", "-Dserver.servlet.context-path=/docker-app", "-Dspring.mvc.view.prefix=/WEB-INF/jsp/", "-Dspring.mvc.view.suffix=.jsp", "-Dspring.jpa.hibernate.ddl-auto=update", "-Dspring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL5InnoDBDialect", "-Dspring.jpa.show-sql=true", "-Dspring.mvc.static-path-pattern=/static/**", "-Dspring.resources.static-locations=classpath:/static/", "-jar", "docker-app.jar"]
