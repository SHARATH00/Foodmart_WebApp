package com.project.freshpicks.Controller;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.freshpicks.Controller.pojo.ApiResponse;
import com.project.freshpicks.model.User;
import com.project.freshpicks.service.UserService;

@RestController
@RequestMapping("api/signup")
public class SignUpController {
	@Autowired
	  UserService userservice;
	@CrossOrigin
	@RequestMapping("user")
	public ResponseEntity<?> userLogin(@RequestBody HashMap<String,String> signupRequest) {
		try {
			//TODO validation has to add for client request
			User user = userservice.signUpUser(signupRequest);
			return  ResponseEntity.ok(user);
		}catch(Exception e ) {
			return ResponseEntity.badRequest().body(new ApiResponse(e.getMessage(), ""));
		}
	}
}


