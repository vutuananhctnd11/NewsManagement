package com.laptrinhjavaweb.api.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.service.ICommentService;

@RestController(value="CommentAPIOfAdmin")
public class CommentAPI {
	
	@Autowired
	private ICommentService commentService;
	
	@PostMapping("/api/comment")
	public CommentDTO addComment (@RequestBody CommentDTO dto) {
		return commentService.insert(dto);
	}
	
	@DeleteMapping("/api/comment")
	public void deteleComment (@RequestBody long[] ids) {
		commentService.deleteComment(ids);
	}
}
