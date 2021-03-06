package com.course.business.config;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.env.Environment;

@SpringBootApplication
@EnableEurekaClient
@MapperScan("com.course.server.mapper")
@ComponentScan("com.course")
public class BusinessApplication {

	private static final Logger log = LoggerFactory.getLogger(BusinessApplication.class);

	public static void main(String[] args) {

		//SpringApplication.run(EurekaApplication.class, args);
		SpringApplication app = new SpringApplication(BusinessApplication.class);
		Environment env = app.run(args).getEnvironment();
		log.info("启动成功！Business地址：\thttp://127.0.0.1:{}",env.getProperty("server.port"));
	}

}
