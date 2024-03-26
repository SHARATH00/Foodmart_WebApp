package com.project.freshpicks.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.freshpicks.Repository.adminRepository;
import com.project.freshpicks.model.AdminLogin;
import com.project.freshpicks.service.AdminService;
@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	adminRepository admin;
	@Override
	public AdminLogin findByEmail(String email) throws Exception {
		return admin.findByEmail(email).orElseThrow(()->new Exception("Admin user Not found.."));
	}

}
