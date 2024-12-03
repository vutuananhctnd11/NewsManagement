package com.laptrinhjavaweb.converter;

import org.springframework.stereotype.Component;

import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.entity.CommentEntity;
import com.mysql.cj.jdbc.util.ResultSetUtil;

@Component
public class CommentConverter {

	
	public CommentDTO toDTO (CommentEntity entity) {
		CommentDTO result = new CommentDTO();
		result.setId(entity.getId());
		result.setContent(entity.getContent());
		result.setLikeComment(entity.getLikeComment());
		result.setNewsId(entity.getNewsId());
		result.setNewsTitle(entity.getNews().getTitle());
		result.setUserId(entity.getUserId());
		result.setUserName(entity.getUser().getFullName());
		result.setCreatedDate(entity.getCreatedDate());
		return result;
	}
	
	public CommentEntity toEntity (CommentDTO dto) {
		CommentEntity result = new CommentEntity();
		result.setContent(dto.getContent());
		result.setLikeComment(dto.getLikeComment());
		result.setNewsId(dto.getNewsId());
		result.setUserId(dto.getUserId());
		return result;
	}
}
