package com.bluebooks;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@EnableAsync
@SpringBootApplication
public class BlueBooksApplication {

	public static void main(String[] args) {
		SpringApplication.run(BlueBooksApplication.class, args);
	}

}
