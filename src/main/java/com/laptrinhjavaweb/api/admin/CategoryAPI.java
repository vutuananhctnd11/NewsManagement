package com.laptrinhjavaweb.api.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.laptrinhjavaweb.dto.CategoryDTO;
import com.laptrinhjavaweb.service.ICategoryService;

@RestController(value="CategoryAPIofAdmin")
public class CategoryAPI {
	
	@Autowired
	private ICategoryService categoryService;

	@PostMapping("/api/category")
	public ResponseEntity<?> createCategory (@RequestBody CategoryDTO dto) {
		return categoryService.createCayegory(dto);
	}
	
	@PutMapping("/api/category")
	public ResponseEntity<?> updateCategory (@RequestBody CategoryDTO dto) {
		return categoryService.updateCayegory(dto);
	}
	
	@DeleteMapping("/api/category")
	public void deleteCategory (@RequestBody long[] ids) {
		categoryService.deleteCategory(ids);
	}
	
}
