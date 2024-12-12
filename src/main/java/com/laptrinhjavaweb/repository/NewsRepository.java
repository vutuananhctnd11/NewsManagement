package com.laptrinhjavaweb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.laptrinhjavaweb.entity.NewsEntity;

public interface NewsRepository extends JpaRepository<NewsEntity, Long> {
	
	List<NewsEntity> findByCategoryCode(String code);
	
}
