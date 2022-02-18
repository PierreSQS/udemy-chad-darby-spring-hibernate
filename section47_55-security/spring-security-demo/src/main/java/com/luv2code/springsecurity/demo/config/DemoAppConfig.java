package com.luv2code.springsecurity.demo.config;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;
import java.util.Objects;

@Slf4j
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"com.luv2code.springsecurity.demo"})
@PropertySource("classpath:mysql.properties")
public class DemoAppConfig {

    @Autowired
    Environment env;

    // define a bean for ViewResolver
    @Bean
    public ViewResolver viewResolver() {

        var viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/view/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;

    }

    // Define a bean for our Security DataSource
    @Bean
    public DataSource securityDataSource() {
        // create connection pool
        ComboPooledDataSource securityDataSource = new ComboPooledDataSource();

        // set jdbc driver class
        try {
            securityDataSource.setDriverClass(env.getProperty("jdbc.driver"));
        } catch (PropertyVetoException exc) {
            throw new RuntimeException(exc);
        }

        String jdbcUrlProp = env.getProperty("jdbc.url");
        String userProp = env.getProperty("jdbc.user");

        // log the connection
        log.info("jdbc.url={}",jdbcUrlProp);
        log.info("jdbc.user={}",userProp);

        // set the database connection
        securityDataSource.setJdbcUrl(jdbcUrlProp);
        securityDataSource.setUser(userProp);
        securityDataSource.setPassword(env.getProperty("jdbc.password"));

        // set connection props
        securityDataSource.setInitialPoolSize(Integer.parseInt(Objects.requireNonNull(env.getProperty("connection.pool.initialPoolSize"))));
        securityDataSource.setMinPoolSize(Integer.parseInt(Objects.requireNonNull(env.getProperty("connection.pool.minPoolSize"))));
        securityDataSource.setMaxPoolSize(Integer.parseInt(Objects.requireNonNull(env.getProperty("connection.pool.maxPoolSize"))));
        securityDataSource.setMaxIdleTime(Integer.parseInt(Objects.requireNonNull(env.getProperty("connection.pool.maxIdleTime"))));

        return securityDataSource;
    }
}
