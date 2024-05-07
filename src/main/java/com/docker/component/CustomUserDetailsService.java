package com.docker.component;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.docker.entity.CustomUserDetails;
import com.docker.entity.UserModel;
import com.docker.repository.UserRepository;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Transactional
    public CustomUserDetails loadUserByUsername(String username) {
        UserModel user=new UserModel();
		try {
			user = userRepository.findById(username).get();
			 return new CustomUserDetails(user);
		} catch (Exception e) {
			 return new CustomUserDetails();
		}

    }
}