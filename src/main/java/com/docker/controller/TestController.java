package com.docker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class TestController {
	@Autowired
	private JdbcTemplate jdbcTemplate;
@GetMapping("/test")
public String test() {
	return "test";
}

@GetMapping("/dbstatus")
public String getDatabaseStatus() {
    try {
        jdbcTemplate.execute("SELECT 1");
        return "Database connection is successful";
    } catch (Exception e) {
        return "Failed to connect to the database: " + e.getMessage();
    }
}
}
