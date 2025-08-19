package com.barsch.petison;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class PetisonApplication {

	@GetMapping("/api")
	public String sampleEndpoint() throws InterruptedException {
		Thread.sleep(1000); // Sleep for 1 seconds
		return """
        	Get busy living
        	or
        	get busy dying.
        	--Stephen King""";
	}

	public static void main(String[] args) {
		SpringApplication.run(PetisonApplication.class, args);
	}

}
