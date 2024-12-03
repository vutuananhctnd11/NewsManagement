package com.laptrinhjavaweb.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.laptrinhjavaweb.dto.CommentDTO;

public interface ICommentService {
	
	List<CommentDTO>  findByNewsId(Pageable pageable, long newsId);
	int getTotalItemByNewsId(long newsId);
	void deleteComment (long[] ids);
	CommentDTO insert (CommentDTO dto);
	
}

