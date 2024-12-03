package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.laptrinhjavaweb.converter.NewsConverter;
import com.laptrinhjavaweb.dto.NewsDTO;
import com.laptrinhjavaweb.entity.CategoryEntity;
import com.laptrinhjavaweb.entity.CommentEntity;
import com.laptrinhjavaweb.entity.NewsEntity;
import com.laptrinhjavaweb.repository.CategoryRepository;
import com.laptrinhjavaweb.repository.CommentRepository;
import com.laptrinhjavaweb.repository.NewsRepository;
import com.laptrinhjavaweb.service.INewService;

@Service
public class NewService implements INewService {
	
	@Autowired
	private NewsRepository newsRepository;
	@Autowired
	private CategoryRepository categoryRepository;
	@Autowired
	private NewsConverter newsConverter;
	@Autowired
	private CommentRepository commentRepository;
	

	
	@Override
	public List<NewsDTO> findAll(Pageable pageable) {
		List<NewsDTO> models = new ArrayList<>();
		List<NewsEntity> entities = newsRepository.findAll(pageable).getContent();
		for (NewsEntity item : entities) {
			NewsDTO dto = newsConverter.toDTO(item);
			models.add(dto);
		}
		return models;
	}

	@Override
	public int getTotalItem() {
		return (int) newsRepository.count();
	}

	@Override
	public NewsDTO findById(long id) {
		NewsEntity entity = newsRepository.findOne(id);
		return newsConverter.toDTO(entity);
	}

	@Override
	@Transactional
	public NewsDTO insert(NewsDTO dto) {
		// TODO Auto-generated method stub
		CategoryEntity category = categoryRepository.findOneByCode(dto.getCategoryCode());
		NewsEntity newsEntity = newsConverter.toEntity(dto);
		newsEntity.setCategory(category);
		newsEntity = newsRepository.save(newsEntity);
		return newsConverter.toDTO(newsEntity);
	}

	@Override
	@Transactional
	public NewsDTO update(NewsDTO dto) {
		// TODO Auto-generated method stub
		NewsEntity oldNews = newsRepository.findOne(dto.getId());
		CategoryEntity category = categoryRepository.findOneByCode(dto.getCategoryCode());
		oldNews.setCategory(category);
		NewsEntity updateNews = newsConverter.toEntity(oldNews, dto);
		updateNews = newsRepository.save(updateNews);
		return newsConverter.toDTO(updateNews);
	}

	@Override
	@Transactional
	public NewsDTO save(NewsDTO dto) {
		NewsEntity newsEntity = new NewsEntity();
		CategoryEntity category = categoryRepository.findOneByCode(dto.getCategoryCode());
		
		if (dto.getId() !=null ) {
			NewsEntity oldNews = newsRepository.findOne(dto.getId());
			oldNews.setCategory(category);
			newsEntity = newsConverter.toEntity(oldNews, dto);
		} else {
			newsEntity = newsConverter.toEntity(dto);
			newsEntity.setCategory(category);
		}
//		newsEntity = newsRepository.save(newsEntity);
		return newsConverter.toDTO(newsRepository.save(newsEntity));
	}

	@Override
	public void delete(long[] ids) {
		// TODO Auto-generated method stub
		for (long id : ids) {
			newsRepository.delete(id);
		}
	}

	@Override
	public Map<Long, Long> getTotalCommentOfNews(NewsDTO newsdto) {
		Map<Long, Long> result = new HashMap<>();
		List<CommentEntity> listComment = commentRepository.findAll();
		
		for (NewsDTO news : newsdto.getListResult()) {
			long totalComment = 0;
			for (CommentEntity comment : listComment) {
				if (news.getId().equals(comment.getNewsId())){
					totalComment++;
				}
			}
			result.put(news.getId(), totalComment);
			totalComment=0;
		}

		return result;
	}

	
}
