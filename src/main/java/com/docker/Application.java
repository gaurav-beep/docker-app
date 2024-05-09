package com.docker;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;

@PropertySource("file:C:/Properties/application.properties")
@SpringBootApplication
public class Application {
public static void main(String[] args) {
	SpringApplication.run(Application.class,args);
}
}
