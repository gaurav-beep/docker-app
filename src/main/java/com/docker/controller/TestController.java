package com.docker.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class TestController {
	
	@GetMapping("/test")
	public String test() {
		return "test";
	}
	@GetMapping("/home")
	public ModelAndView home() {
		return new ModelAndView("home");
	}
}
