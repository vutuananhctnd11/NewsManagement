package com.laptrinhjavaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.laptrinhjavaweb.entity.NewsEntity;

public interface NewsRepository extends JpaRepository<NewsEntity, Long> {
	
}
