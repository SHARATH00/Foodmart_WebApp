package com.project.freshpicks.Controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.freshpicks.Controller.pojo.ApiResponse;
import com.project.freshpicks.model.Survey;
import com.project.freshpicks.model.User;
import com.project.freshpicks.service.impl.SurveyService;

@RestController
@RequestMapping("api")
public class SurveyController {
	@Autowired
	SurveyService surveyservice;
	@RequestMapping("survey")
	@CrossOrigin
	public ResponseEntity<?> addSurveyData(@RequestBody HashMap<String,String> surveyRequest) {
		try {
			//TODO validation has to add for client request
		     surveyservice.addSurvey(surveyRequest);
			return  ResponseEntity.ok("Thanks for your Response");
		}catch(Exception e ) {
			return ResponseEntity.badRequest().body(new ApiResponse(e.getMessage(), ""));
		}
	}
	

}
