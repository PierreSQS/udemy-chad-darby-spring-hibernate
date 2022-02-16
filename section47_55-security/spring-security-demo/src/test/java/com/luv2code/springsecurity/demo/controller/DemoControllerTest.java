package com.luv2code.springsecurity.demo.controller;

import com.luv2code.springsecurity.demo.config.DemoAppConfig;
import com.luv2code.springsecurity.demo.config.SecurityConfig;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.user;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.authenticated;
import static org.springframework.security.test.web.servlet.response.SecurityMockMvcResultMatchers.unauthenticated;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {SecurityConfig.class, DemoAppConfig.class})
@WebAppConfiguration()
class DemoControllerTest {

    @Autowired
    private WebApplicationContext context;

    private MockMvc mockMvc;

    @BeforeEach
    void setUp() {
        mockMvc = MockMvcBuilders
                .webAppContextSetup(context)
                .apply(springSecurity())
                .build();
    }

    @Test
    void showHomeUnauthenticated() throws Exception {
        mockMvc.perform(get("/"))
                .andExpect(unauthenticated())
                .andExpect(status().is3xxRedirection())
                .andDo(print());
    }

    @Test
    void showHomeAuthenticated() throws Exception {
        mockMvc.perform(get("/")
                            .with(user("John")
                            .password("John")
                            .roles("EMPLOYEE")))
                .andExpect(authenticated())
                .andExpect(forwardedUrl("/WEB-INF/view/home.jsp"))
                .andExpect(status().isOk())
                .andDo(print());
    }
}