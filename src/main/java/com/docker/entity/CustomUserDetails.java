package com.docker.entity;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@SuppressWarnings("serial")
public class CustomUserDetails implements UserDetails {

	private String userName,password;
	private List<GrantedAuthority> roles=new ArrayList<GrantedAuthority>();
	public CustomUserDetails(UserModel user){
		if (user == null) {
            throw new IllegalArgumentException("UserModel cannot be null");
        }
		this.userName=user.getUsername();
		this.password=user.getPassword();
        if (user.getRoles() != null) {
            List<String> roles = Arrays.asList(user.getRoles().split(","));
            for (String role : roles) {
                this.roles.add(new SimpleGrantedAuthority(role));
            }
        } else {
            System.err.println("User roles are null");
        }
	}
	public CustomUserDetails() {	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.roles;
	}

	public String getPassword() {
		return this.password;
	}

	public String getUsername() {
		return this.userName;
	}

	public boolean isAccountNonExpired() {
		return true;
	}

	public boolean isAccountNonLocked() {
		return true;
	}

	public boolean isCredentialsNonExpired() {
		return true;
	}

	public boolean isEnabled() {
		return true;
	}

}
	