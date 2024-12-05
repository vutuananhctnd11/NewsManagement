package com.laptrinhjavaweb.api.admin;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
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
	public NewsDTO createNews(@RequestBody NewsDTO newsDTO) {
		return newsService.save(newsDTO);
	}
	
	@PutMapping("/api/news")
	public NewsDTO updateNews(@RequestBody NewsDTO updateNews) {
		return newsService.save(updateNews);
	}
	
	@DeleteMapping("/api/news")
	public void deleteNews(@RequestBody long[] ids) {
		newsService.delete(ids);
	}
	
	@PostMapping("/api/uploadfile")
	public String uploadfile (@RequestParam("file") MultipartFile file, HttpServletRequest request){
		//xử lý ảnh
		String timestamp="";
		
		if(file!=null) {
			String uploadRootPath = request.getServletContext().getRealPath("template/images");
			timestamp = String.valueOf(System.currentTimeMillis());
			File destination = new File(uploadRootPath+"/"+timestamp+ file.getOriginalFilename());
			
			try {
			file.transferTo(destination);
			} catch (Exception e) {
		        e.printStackTrace();
		    }
	    }
		
		String filePath =  "template/images/"+timestamp+file.getOriginalFilename();

		return filePath;
	}
	
}
