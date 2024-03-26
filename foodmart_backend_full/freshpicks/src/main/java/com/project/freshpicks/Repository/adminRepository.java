package com.project.freshpicks.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.freshpicks.model.AdminLogin;

public interface adminRepository extends JpaRepository<AdminLogin,Long> {
	Optional<AdminLogin> findByEmail(String email);


}
