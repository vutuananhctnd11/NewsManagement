package com.laptrinhjavaweb.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.laptrinhjavaweb.dto.NewsDTO;

public interface INewService {
	List<NewsDTO> findAll(Pageable pageable);
	int getTotalItem();
	NewsDTO findById(long id);
	NewsDTO  save(NewsDTO dto, HttpServletRequest request);
	void delete (long[] ids);
	Map<Long, Long> getTotalCommentOfNews (NewsDTO newsdto);
	ResponseEntity<?> uploadFile (MultipartFile file, HttpServletRequest request);
	ResponseEntity<?> inputFileWord (MultipartFile file, HttpServletRequest request);
	List<NewsDTO> filterNews (String filterName, Pageable pageable);
	int getTotalItem(String filterName);
	List<NewsDTO> searchNews (String search);
	List<NewsDTO> searchAnFilterNews (String filterName, String search);
}
