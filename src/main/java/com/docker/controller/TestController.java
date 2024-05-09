package com.docker.controller;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
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
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import com.docker.entity.UserModel;
import com.docker.repository.UserRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
//		redirect.setUrl("http://localhost:3000/personal-info/home");
		return redirect;
	}
	
	@GetMapping("/home")
	public ModelAndView home() {
		return new ModelAndView("home");
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

	@RequestMapping({ "/register/form" })
	public ModelAndView register() {
		ModelAndView modelAndView = new ModelAndView("register");
		return modelAndView;
	}

	@RequestMapping({ "/forget/form" })
	public ModelAndView forget() {
		ModelAndView modelAndView = new ModelAndView("forget");
		return modelAndView;
	}
	
	@RequestMapping({ "/forget/resetPassword" })
	public ModelAndView resetPassword(Model m,HttpServletRequest request) {
		m.addAttribute("username", request.getParameter("username"));
		ModelAndView modelAndView = new ModelAndView("resetPassword");
		return modelAndView;
	}

	@PostMapping("/m/checkUserName")
	public ResponseEntity<Map<String,String>> checkUserName(@RequestBody UserModel userModel){
	    Map<String,String> response = new HashMap<String, String>();
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

	@PostMapping("/m/checkPassword")
	public ResponseEntity<Map<String,String>> checkPassword(@RequestBody UserModel userModel){
	    Map<String,String> response = new HashMap<String, String>();
	    try {
	        UserModel user = userRepository.findById(userModel.getUsername()).orElse(null);
	        if (user != null) {
		        if (new BCryptPasswordEncoder().matches(userModel.getPassword(),user.getPassword())) {
		        	response.put("status", "success");
		        } else {
		        	response.put("status", "error");
		        }
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

	@RequestMapping({"/register/submit","/forget/submit"})
	public ResponseEntity<Map<String,Object>>  registerUser(@RequestBody UserModel user,HttpServletRequest request) {
		String currentUrl = request.getRequestURL().toString();
		if(currentUrl.indexOf("forget")!=-1) {
			user.setEmail(userRepository.findById(user.getUsername()).orElse(null).getEmail());
		}
		Map<String,Object> response = new HashMap<String,Object>();
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = bCryptPasswordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);
		user.setRoles("ROLE_USER");
		try {
			userRepository.save(user);
			response.put("status", "success");
			response.put("message", "User Registered Successfully.");
		}catch(Exception e) {
			response.put("status", "error");
			response.put("message", e.getStackTrace().toString());
		}
		return new ResponseEntity<Map<String,Object>>(response,HttpStatus.OK);
	}
	
	@RequestMapping({"/register/generateOtp","/forget/generateOtp"})
	public ModelAndView verifyOtp(@ModelAttribute UserModel user,HttpServletRequest request) throws JsonProcessingException {
		String currentUrl = request.getRequestURL().toString();
		if(currentUrl.indexOf("forget")!=-1) {
			user = userRepository.findById(user.getUsername()).orElse(null);
		}
		RestTemplate restTemplate = new RestTemplate();
		Random random = new Random();
		int otp = 1000 + random.nextInt(9000);
		Map<String, Object> requestmap = new HashMap<String, Object>();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Accept", "application/json, application/xml");
		headers.add("Content-Type", "application/json");
		requestmap.put("emailId", user.getEmail());
		requestmap.put("subject", "Otp Verification");
		requestmap.put("body", "Otp for email verification : "+otp);
		HttpEntity<Map<String, Object>> entity = new HttpEntity<Map<String, Object>>(requestmap, headers);
        ResponseEntity<Map<String, Object>> responseEntity=null;
		try {
			responseEntity = restTemplate.exchange(
			        "http://localhost:8050/mailer/m/sendEmail",
			        HttpMethod.POST,
			        entity,
			        new ParameterizedTypeReference<Map<String,Object>>() {}
			);
		} catch (RestClientException e) {
			e.printStackTrace();
		}
        Map<String, Object> response = responseEntity.getBody();
        if(response.get("status").equals("success")) {
        	ObjectMapper objectMapper = new ObjectMapper();
            String userString = objectMapper.writeValueAsString(user);
        	ModelAndView modelAndView = new ModelAndView("otpVerify");
        	modelAndView.addObject("otp", otp);
        	modelAndView.addObject("userString", userString);
        	modelAndView.addObject("user", user);
        	return modelAndView;
        }else {
    		if(currentUrl.indexOf("forget")!=-1) {
    			return new ModelAndView("redirect:/docker-app/forget/form");
    		}else {
    			return new ModelAndView("redirect:/docker-app/register/form");
    		}
        }
	}
}