package com.project.freshpicks.Controller;

import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.freshpicks.Controller.pojo.ApiResponse;
import com.project.freshpicks.Controller.pojo.LoginPojo;
import com.project.freshpicks.JWTToken.AuthLogin;
import com.project.freshpicks.JWTToken.JWTTokenProvider;
import com.project.freshpicks.JWTToken.UserPrincipal;
import com.project.freshpicks.Repository.userRepository;
import com.project.freshpicks.model.User;
import com.project.freshpicks.service.UserService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("api")
public class LoginController {
	
	@Autowired
	  UserService userservice;
	@Autowired
	AuthLogin authLogin;
	@Autowired
	JWTTokenProvider tokenProvider;
	@Autowired
	userRepository userRepo;
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@RequestMapping("login/user")//post and get
	@CrossOrigin
	public ResponseEntity<?> userLogin(@RequestBody LoginPojo loginRequest) {
		
		try {
			
        	Authentication authentication =  authLogin.authenticate(new UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword()) ,loginRequest);
        	SecurityContextHolder.getContext().setAuthentication(authentication);
        	String token = tokenProvider.generateToken(authentication);
    		JSONObject obj =  this.getUserResponse(token);
    		if(obj == null) {
    			throw new Exception("Error while generating Reponse");
    		}
    		saveUserToken(token);
	        return new ResponseEntity<String>(obj.toString(), HttpStatus.OK);
	        
    	}catch(Exception e ) {
    		logger.info("Error in authenticateUser ",e);
    		return ResponseEntity.badRequest().body(new ApiResponse(e.getMessage(), ""));
    		
    	}
		
	}
	private void saveUserToken(String token) throws Exception {
		try {
			User user = userservice.getUserDetailById(_getUserId());
			user.setLoginToken(token);
			userRepo.save(user);
		}
		catch (Exception e) {
			throw new Exception(e.getMessage()+" Error while Saving Token");
		}
    	
		
		
	}
	private JSONObject getUserResponse(String token) {
    	
    	try {
			User user = userservice.getUserDetailById(_getUserId());
			HashMap<String,String> response = new HashMap<String,String>();
			response.put("user_id", ""+_getUserId());
			response.put("email", user.getEmail());
			response.put("name", user.getUsername());	
			JSONObject obj = new JSONObject();
			
			obj.put("user_profile_details",response);
			obj.put("token", token);
			logger.info(obj.toString());
			return obj;
		} catch (Exception e) {
			logger.info("Error in getUserResponse ",e);
		}
    	
    	return null;
    }
 
 	private long _getUserId() {
    	logger.info("user id vaildating. "+ SecurityContextHolder.getContext().getAuthentication());
		UserPrincipal userPrincipal = (UserPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		logger.info("(LoginController)user id is "+userPrincipal.getId());
		return userPrincipal.getId();
	}
}
