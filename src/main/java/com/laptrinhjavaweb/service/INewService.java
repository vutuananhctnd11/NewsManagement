package com.laptrinhjavaweb.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;

import com.laptrinhjavaweb.dto.NewsDTO;

public interface INewService {
	List<NewsDTO> findAll(Pageable pageable);
	int getTotalItem();
	NewsDTO findById(long id);
	NewsDTO insert (NewsDTO dto);
	NewsDTO update (NewsDTO updateNews);
	NewsDTO  save(NewsDTO dto);
	void delete (long[] ids);
	Map<Long, Long> getTotalCommentOfNews (NewsDTO newsdto);
	
}
