package com.laptrinhjavaweb.api.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.laptrinhjavaweb.dto.NewsDTO;
import com.laptrinhjavaweb.service.INewService;

@RestController(value = "newsAPIOfAdmin")
public class NewsAPI {
	
	@Autowired
	private INewService newsService;

	@PostMapping("/api/news")
	public NewsDTO createNews(@RequestBody NewsDTO newsDTO, HttpServletRequest request) {
		return newsService.save(newsDTO, request);
	}
	
	@PutMapping("/api/news")
	public NewsDTO updateNews(@RequestBody NewsDTO updateNews, HttpServletRequest request) {
		return newsService.save(updateNews, request);
	}
	
	@DeleteMapping("/api/news")
	public void deleteNews(@RequestBody long[] ids) {
		newsService.delete(ids);
	}
	
	@PostMapping("/api/uploadfile")
	public ResponseEntity<?> uploadfile (@RequestParam("file") MultipartFile file, HttpServletRequest request){
		return newsService.uploadFile(file, request);
	}
	@PostMapping("/api/inputfileword")
	public ResponseEntity<?> inputFileWord (@RequestParam("file") MultipartFile file, HttpServletRequest request){
		return newsService.inputFileWord(file, request);
	}
	
}
