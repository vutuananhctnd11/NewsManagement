package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.laptrinhjavaweb.converter.CategoryConverter;
import com.laptrinhjavaweb.dto.CategoryDTO;
import com.laptrinhjavaweb.entity.CategoryEntity;
import com.laptrinhjavaweb.entity.NewsEntity;
import com.laptrinhjavaweb.repository.CategoryRepository;
import com.laptrinhjavaweb.repository.NewsRepository;
import com.laptrinhjavaweb.service.ICategoryService;
import com.laptrinhjavaweb.service.INewService;

@Service
public class CategoryService implements ICategoryService {

	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private CategoryConverter categoryConverter;
	
	@Autowired
	private NewsRepository newsRepository;
	
	@Autowired
	private INewService newService;
	
	@Override
	public Map<String, String> findAll() {
		Map<String, String> result = new HashMap<>();
		List<CategoryEntity> entities = categoryRepository.findAll();
		for (CategoryEntity item : entities) {
			result.put(item.getCode(), item.getName());
		}
		return result;
	}

	@Override
	public List<CategoryDTO> findAll(Pageable pageable) {
		List<CategoryDTO> result = new ArrayList<>();
		List<CategoryEntity> entities = categoryRepository.findAll(pageable).getContent();
		for (CategoryEntity entity : entities) {
			CategoryDTO dto = categoryConverter.toDTO(entity);
			result.add(dto);
		}
		
		return result;
	}

	@Override
	public int getTotalItem() {
		return (int) categoryRepository.count();
	}

	@Override
	public Map<String, Long> totalNewsOfCategory(CategoryDTO dto) {
		Map<String, Long> result = new HashMap<>();
		long totalNews = 0;
		for (CategoryDTO item : dto.getListResult()) {
			List<NewsEntity> newsEntities = newsRepository.findAll();
			for (NewsEntity entity : newsEntities) {
				if(entity.getCategory().getCode().equals(item.getCode())) {
					totalNews ++;
				}
			}
			result.put(item.getCode(), totalNews);
			totalNews=0;
		}
		return result;
	}

	@Override
	@Transactional
	public ResponseEntity<?> createCayegory(CategoryDTO dto) {
		CategoryEntity isExsit = categoryRepository.findOneByCode(dto.getCode());
		if (isExsit!=null) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Đã tồn tại mã danh mục này!");
		}
		CategoryEntity entity = categoryConverter.toEntity(dto);
		entity = categoryRepository.save(entity);
		return ResponseEntity.ok(categoryConverter.toDTO(entity));
	}

	@Override
	@Transactional
	public ResponseEntity<?> updateCayegory(CategoryDTO dto) {
		CategoryEntity entity = categoryRepository.findOneByCode(dto.getCode());
		entity = categoryConverter.toEntity(entity, dto);
		entity = categoryRepository.save(entity);
		return ResponseEntity.ok(categoryConverter.toDTO(entity));
	}

	@Override
	public void deleteCategory(long[] ids) {
		for ( long id : ids) {
			CategoryEntity categoryEntity = categoryRepository.findOne(id);
			List<NewsEntity> newsEntities = newsRepository.findByCategoryCode(categoryEntity.getCode());
			for (NewsEntity newsEntity : newsEntities) {
				long[] newsId = new long[] {newsEntity.getId()};
				newService.delete(newsId);
			}
			categoryRepository.delete(categoryEntity);;
		}
	}

}
