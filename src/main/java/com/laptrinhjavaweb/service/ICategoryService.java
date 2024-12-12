package com.laptrinhjavaweb.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;

import com.laptrinhjavaweb.dto.CategoryDTO;

public interface ICategoryService {

	Map<String, String> findAll();
	List<CategoryDTO> findAll (Pageable pageable);
	int getTotalItem();
	Map<String, Long> totalNewsOfCategory (CategoryDTO dto);
	ResponseEntity<?> createCayegory (CategoryDTO dto);
	ResponseEntity<?> updateCayegory (CategoryDTO dto);
	void deleteCategory (long[] ids);
	
}
