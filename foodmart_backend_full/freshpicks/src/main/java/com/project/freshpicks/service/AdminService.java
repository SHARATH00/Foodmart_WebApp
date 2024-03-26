package com.project.freshpicks.service;

import org.springframework.stereotype.Service;

import com.project.freshpicks.model.AdminLogin;
@Service
public interface AdminService {
	AdminLogin findByEmail(String email) throws Exception;

}
