package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.converter.CommentConverter;
import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.entity.CommentEntity;
import com.laptrinhjavaweb.entity.NewsEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.CommentRepository;
import com.laptrinhjavaweb.repository.NewsRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.ICommentService;
import com.laptrinhjavaweb.util.SecurityUtils;

@Service
public class CommentService implements ICommentService {
	
	@Autowired
	private CommentRepository commentRepository;
	@Autowired
	private CommentConverter commentConverter;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private NewsRepository newsRepository;

	@Override
	public List<CommentDTO> findByNewsId(Pageable pageable, long newsId) {
		// TODO Auto-generated method stub
		List<CommentDTO> result = new ArrayList<>();
		List<CommentEntity> entities = commentRepository.findByNewsId(newsId, pageable).getContent();
		for (CommentEntity item : entities) {
			if (item.getNewsId() == newsId ) {
				item.setUser(userRepository.findOne(item.getUserId()));
				item.setNews(newsRepository.findOne(item.getNewsId()));
				CommentDTO dto = commentConverter.toDTO(item);
				result.add(dto);
			}
		}
		return result;
	}

	@Override
	public int getTotalItemByNewsId(long newsId) {
		int totalItem =0;
		List<CommentEntity> entities = commentRepository.findAll();
		for (CommentEntity item : entities) {
			if (item.getNewsId() == newsId ) {
				totalItem++;
			}
		}
		return totalItem;
	}

	@Override
	@Transactional
	public void deleteComment(long[] ids) {
		// TODO Auto-generated method stub
		for (long commentId : ids) {
			commentRepository.delete(commentId);
		}
	}

	@Override
	@Transactional
	public CommentDTO insert(CommentDTO dto) {
		String username = SecurityUtils.getPrincipal().getUsername();		//lấy username từ user đang đăng nhập trong spring security
		UserEntity user = userRepository.findOneByUserNameAndStatus(username, SystemConstant.ACTIVE_STATUS);
		dto.setUserId(user.getId());
		NewsEntity news = newsRepository.findOne(dto.getNewsId());
		CommentEntity entity = commentConverter.toEntity(dto);
		entity.setUser(user);
		entity.setNews(news);
		entity.setLikeComment(0);
		entity = commentRepository.save(entity);
		return  commentConverter.toDTO(entity);
	}

}
