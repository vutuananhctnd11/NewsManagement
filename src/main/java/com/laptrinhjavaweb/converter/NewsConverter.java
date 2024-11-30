package com.laptrinhjavaweb.converter;

import org.springframework.stereotype.Component;

import com.laptrinhjavaweb.dto.NewsDTO;
import com.laptrinhjavaweb.entity.NewsEntity;

@Component
public class NewsConverter {

	public NewsDTO toDTO (NewsEntity newsEntity) {
		NewsDTO result = new NewsDTO();
		result.setId(newsEntity.getId());
		result.setTitle(newsEntity.getTitle());
		result.setThumbnail(newsEntity.getThumbnail());
		result.setShortDescription(newsEntity.getShortDescription());
		result.setContent(newsEntity.getContent());
		result.setCategoryCode(newsEntity.getCategory().getCode());
		
		return result;
	}
	
	public NewsEntity toEntity(NewsDTO dto) {
		NewsEntity result =  new NewsEntity();
		result.setTitle(dto.getTitle());
		result.setThumbnail(dto.getThumbnail());
		result.setShortDescription(dto.getShortDescription());
		result.setContent(dto.getContent());
		return result;
	}
	
	public NewsEntity toEntity(NewsEntity result, NewsDTO dto) {
		result.setTitle(dto.getTitle());
		result.setThumbnail(dto.getThumbnail());
		result.setShortDescription(dto.getShortDescription());
		result.setContent(dto.getContent());
		return result;
	}
}
