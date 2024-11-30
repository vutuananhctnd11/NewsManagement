package com.laptrinhjavaweb.converter;

import com.laptrinhjavaweb.dto.CategoryDTO;
import com.laptrinhjavaweb.entity.CategoryEntity;

public class CategoryConverter {

	public CategoryDTO toDTO (CategoryEntity entity) {
		CategoryDTO result= new CategoryDTO();
		result.setId(entity.getId());
		result.setCode(entity.getCode());
		result.setName(entity.getName());
		return result;
	}
	
	public CategoryEntity toEntity (CategoryDTO dto) {
		CategoryEntity result= new CategoryEntity();
		result.setCode(dto.getCode());
		result.setName(dto.getName());
		return result;
	}
}
