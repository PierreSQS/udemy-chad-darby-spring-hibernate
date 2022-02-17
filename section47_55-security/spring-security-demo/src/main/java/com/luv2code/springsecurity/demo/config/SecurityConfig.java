package com.luv2code.springsecurity.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    private static final String EMPLOYEE = "EMPLOYEE";
    private static final String MANAGER = "MANAGER";
    private static final String ADMIN = "ADMIN";

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        // 5.1.0.Release implementation!!! Actually deprecated!!!!
        User.UserBuilder users = User.withDefaultPasswordEncoder();

        auth.inMemoryAuthentication()
                .withUser(users.username("John")
                        .password("John")
                        .roles(EMPLOYEE))
                .withUser(users.username("Mary")
                        .password("Mary")
                        .roles( MANAGER, EMPLOYEE))
                .withUser(users.username("Susan")
                        .password("Susan")
                        .roles( ADMIN, EMPLOYEE));
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                    .antMatchers("/").hasRole(EMPLOYEE)
                    .antMatchers("/leaders/**").hasRole(MANAGER)
                    .antMatchers("/systems/**").hasRole(ADMIN)
                .and()
                .formLogin()
                    .loginPage("/showLoginPage")
                    .loginProcessingUrl("/authenticateUser")
                .permitAll()
                .and()
                    .logout().permitAll();
    }
}
