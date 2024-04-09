package com.docker.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import com.docker.component.CustomAuthenticatorProvider;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebSecurity
public class WebConfig extends WebSecurityConfigurerAdapter{
@Autowired
CustomAuthenticatorProvider authenticatorProvider;

protected void configure(AuthenticationManagerBuilder build) {
	build.authenticationProvider(authenticatorProvider);
}
@Override
protected void configure(HttpSecurity http) throws Exception {
    http
        .csrf().disable()
        .authorizeRequests()
//            .antMatchers("/admin/**").hasRole("ADMIN")
//            .antMatchers("/manager/**").hasRole("MANAGER")
//            .antMatchers("/user/**").hasRole("USER")
            .antMatchers("/m/**").permitAll()
            .antMatchers("/register/**").permitAll()
            .antMatchers("/forget/**").permitAll()
            .antMatchers("/static/**").permitAll()
            .anyRequest().authenticated()
            .and()
        .formLogin()
            .loginPage("/login")
            .permitAll()
            .successForwardUrl("/loginSuccess")
            .and()
        .logout()
            .permitAll();
}

}
