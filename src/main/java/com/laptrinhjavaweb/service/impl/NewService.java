package com.laptrinhjavaweb.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hpsf.Array;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.w3c.dom.stylesheets.LinkStyle;

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
	public NewsDTO save(NewsDTO dto, HttpServletRequest request) {
		NewsEntity newsEntity = new NewsEntity();
		
		CategoryEntity category = categoryRepository.findOneByCode(dto.getCategoryCode());
		
		if (dto.getId() !=null ) {
			NewsEntity oldNews = newsRepository.findOne(dto.getId());
			String filePath = request.getServletContext().getRealPath(oldNews.getThumbnail());
			File file = new File(filePath);
			file.delete();
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
			List<CommentEntity> listComment = commentRepository.findByNewsId(id);
			for (CommentEntity item : listComment) {
				commentRepository.delete(item);
			}
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
			totalComment= 0;
		}

		return result;
	}

	@Override
	public ResponseEntity<?> uploadFile(MultipartFile file, HttpServletRequest request) {
		String timestamp="";
		String filePath = "";
		
		if (file == null || file.isEmpty()) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("File không được để trống!");
	    }
		String fileName = file.getOriginalFilename();
	    if (fileName == null || (!fileName.endsWith(".jpg") && !fileName.endsWith(".png") && !fileName.endsWith(".jpeg"))) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
	        					 .header("Content-Type", "text/plain; charset=UTF-8")
	        					 .body("Chỉ chấp nhận file định dạng .jpg .jpeg hoặc .png!");
	    }
		if(file!=null) {
			try {
			String uploadRootPath = request.getServletContext().getRealPath("template/images");
			timestamp = String.valueOf(System.currentTimeMillis());
			File destination = new File(uploadRootPath+"/"+timestamp+ file.getOriginalFilename());
			filePath =  "template/images/"+timestamp+file.getOriginalFilename();
			file.transferTo(destination);
			} catch (Exception e) {
		        e.printStackTrace();
		    }
	    }
		return ResponseEntity.ok(filePath);
	}

	@Override
	public ResponseEntity<?> inputFileWord(MultipartFile file, HttpServletRequest request) {
		String timestamp="";
		String filePath = "";
		
		if (file == null || file.isEmpty()) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("File không được để trống!");
	    }
		String fileName = file.getOriginalFilename();
	    if (fileName == null || (!fileName.endsWith(".doc") && !fileName.endsWith(".docx"))) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
	        					 .header("Content-Type", "text/plain; charset=UTF-8")
	        					 .body("Chỉ được nhập file Word có định dạng .doc hoặc .docx !");
	    }
		if(file!=null) {
			try {
			String uploadRootPath = request.getServletContext().getRealPath("template/fileWord");
			timestamp = String.valueOf(System.currentTimeMillis());
			File destination = new File(uploadRootPath+"/"+timestamp+ file.getOriginalFilename());
			filePath =  request.getServletContext().getRealPath("template/fileWord/")+timestamp+file.getOriginalFilename();
			file.transferTo(destination);
			} catch (Exception e) {
		        e.printStackTrace();
		    }
	    }
		
		
		//xử lý file word
		StringBuilder content = new StringBuilder();
		NewsDTO result = new NewsDTO();
		
		try {
			FileInputStream fileIn = new FileInputStream(filePath);
			XWPFDocument document = new XWPFDocument(fileIn);
			
			List<XWPFParagraph> paragraphs = new ArrayList<>(document.getParagraphs());
			
			//lấy title
			XWPFParagraph getText = paragraphs.get(0);
			String title ="";
			for (XWPFRun run : getText.getRuns()) {
				title += run.getText(0);
			}
			result.setTitle(title);
			paragraphs.remove(0);
			//lấy shortDescription
			getText = paragraphs.get(0);
			String shortDescription ="";
			for (XWPFRun run : getText.getRuns()) {
				shortDescription += run.getText(0);
			}
			result.setShortDescription(shortDescription);
			paragraphs.remove(0);
			
			//lấy content
			for (XWPFParagraph paragraph : paragraphs) {
				content.append("<p>");
				for(XWPFRun run : paragraph.getRuns()) {
					String text = run.getText(0);
					String fontFamily = run.getFontFamily();
					int fontSize = run.getFontSize();
					String color = run.getColor();
                    boolean isBold = run.isBold();
                    boolean isItalic = run.isItalic();
                    
                    if (text != null) {
                    	content.append("<span style=\"");
                    	if (fontFamily != null) content.append("font-family: ").append(fontFamily).append("; ");
                    	if (fontSize > 0) content.append("font-size: ").append(fontSize).append("pt; ");
                    	if (color != null) content.append("color: #").append(color).append("; ");
                    	if (isBold) content.append("font-weight: bold; ");
                    	if (isItalic) content.append("font-style: italic; ");
                    }
					content.append("\">").append(text).append("</span>");
				}
				content.append("</p>");
			}
			document.close();
			File deleteFile = new File(filePath);
			deleteFile.delete();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		result.setContent(content.toString());
			
		return ResponseEntity.ok(result);
	}

	@Override
	public List<NewsDTO> filterNews(String filterName, Pageable pageable) {
		List<NewsDTO> result = new ArrayList<>();
		List<NewsEntity> entities = newsRepository.findByCategoryCode(filterName, pageable);
		for (NewsEntity entity : entities) {
			NewsDTO newsDTO = newsConverter.toDTO(entity);
			result.add(newsDTO);
		}
		return result;
	}

	@Override
	public int getTotalItem(String filterName) {
		List<NewsEntity> entities = newsRepository.findByCategoryCode(filterName);
		
		return entities.size();
	}

	@Override
	public List<NewsDTO> searchNews(String search) {
		List<NewsEntity> entities = newsRepository.findAll();
		List<NewsDTO> result = new ArrayList<>();
		for (NewsEntity entity: entities) {
			search = search.toLowerCase();
			String title = entity.getTitle().toLowerCase();
			String shortDescription = entity.getShortDescription().toLowerCase();
			if (title.contains(search) || shortDescription.contains(search)) {
				NewsDTO dto = newsConverter.toDTO(entity);
				result.add(dto);
			}
		}
		return result;
	}

	@Override
	public List<NewsDTO> searchAnFilterNews(String filterName, String search) {
		List<NewsEntity> entities = newsRepository.findByCategoryCode(filterName);
		List<NewsDTO> result = new ArrayList<>();
		for (NewsEntity entity: entities) {
			search = search.toLowerCase();
			String title = entity.getTitle().toLowerCase();
			String shortDescription = entity.getShortDescription().toLowerCase();
			if (title.contains(search) || shortDescription.contains(search)) {
				NewsDTO dto = newsConverter.toDTO(entity);
				result.add(dto);
			}
		}
		return result;
	}

}
