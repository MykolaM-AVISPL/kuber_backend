package com.example.kuber.backend.api;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.availability.AvailabilityChangeEvent;
import org.springframework.boot.availability.LivenessState;
import org.springframework.boot.availability.ReadinessState;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;


/**
 * Class TestRestController is responsible for
 *
 * @author Mykola.Matsishin <br> created on 24 June 2022
 * @since 5.6
 */
@RestController
public class TestRestController {
	@Autowired
	ApplicationEventPublisher eventPublisher;


	@PostMapping("/state/{version}")
	public void youAreNotPrepared(@PathVariable String version) {
		switch (version) {
			case "broken" -> AvailabilityChangeEvent.publish(this.eventPublisher, new RuntimeException("was broken"), LivenessState.BROKEN);
			case "correct" -> AvailabilityChangeEvent.publish(this.eventPublisher,new Object(), LivenessState.CORRECT);
			case "refusing" -> AvailabilityChangeEvent.publish(this.eventPublisher, new RuntimeException("now refusing traffic"), ReadinessState.REFUSING_TRAFFIC);
			case "accepting" -> AvailabilityChangeEvent.publish(this.eventPublisher, "well... it works", ReadinessState.ACCEPTING_TRAFFIC);
		}
	}
}
