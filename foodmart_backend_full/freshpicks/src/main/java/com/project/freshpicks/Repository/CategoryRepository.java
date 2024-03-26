package com.project.freshpicks.Repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.project.freshpicks.model.Category;


public interface CategoryRepository  extends JpaRepository<Category, Long> {

}