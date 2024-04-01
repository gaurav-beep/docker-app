package com.docker.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.docker.entity.UserModel;
import com.docker.repository.UserRepository;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class TestController {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	UserRepository userRepository;
	
	@GetMapping("/m/test")
	
	public String test() {
		return "test";
	}
	
	@PostMapping("/loginSuccess")
	public RedirectView login(Model m) {
		RedirectView redirect = new RedirectView();
		redirect.setUrl("/docker-app/home");
		return redirect;
	}
	
	@GetMapping("/home")
	public String home(Model m) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		return auth.getAuthorities().toString();
	}
	
	@GetMapping("/m/dbstatus")
	public String getDatabaseStatus() {
	    try {
	        jdbcTemplate.execute("SELECT 1");
	        return "Database connection is successful";
	    } catch (Exception e) {
	        return "Failed to connect to the database: " + e.getMessage();
	    }
	}
	
	@RequestMapping({ "/", "/login" })
	public ModelAndView login(@RequestParam(name = "error", required = false) String error) {
		ModelAndView modelAndView = new ModelAndView("login");
	    if (error != null) {
	    	modelAndView.addObject("error", "Authentication failed. Please check your credentials.");
	    }
	    return modelAndView;
	}
	
	@RequestMapping({ "/m/registerUserForm" })
	public ModelAndView register() {
		ModelAndView modelAndView = new ModelAndView("register");
		return modelAndView;
	}
	
	@RequestMapping({ "/m/forgetPasswordForm" })
	public ModelAndView forget() {
		ModelAndView modelAndView = new ModelAndView("forget");
		return modelAndView;
	}
	
	@PostMapping("/m/checkUserName")
	public ResponseEntity<Map<String,String>> checkUserName(@RequestBody UserModel userModel){
	    Map<String,String> response = new HashMap<>();
	    try {
	        UserModel user = userRepository.findById(userModel.getUsername()).orElse(null);
	        if (user != null) {
	            response.put("status", "success");
	        } else {
	            response.put("status", "error");
	        }
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        response.put("status", "error");
	        response.put("message", "An error occurred: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
	@RequestMapping({"/m/registerUser","/m/forgetPassword"})
	public RedirectView  registerUser(@ModelAttribute UserModel user) {
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = bCryptPasswordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);
		user.setRoles("ROLE_USER");
		userRepository.save(user);
		RedirectView view = new RedirectView();
		view.setUrl("/docker-app/");
		return view;
	}
}
