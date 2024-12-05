package com.laptrinhjavaweb.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.laptrinhjavaweb.entity.CommentEntity;

public interface CommentRepository extends JpaRepository<CommentEntity, Long> {

	Page<CommentEntity> findByNewsId (long newsId, Pageable pageable);
	List<CommentEntity> findByNewsId (long newsId);
}
