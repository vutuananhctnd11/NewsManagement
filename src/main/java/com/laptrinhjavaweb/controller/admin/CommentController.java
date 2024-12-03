package com.laptrinhjavaweb.controller.admin;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.dto.CommentDTO;
import com.laptrinhjavaweb.dto.NewsDTO;
import com.laptrinhjavaweb.service.ICategoryService;
import com.laptrinhjavaweb.service.ICommentService;
import com.laptrinhjavaweb.service.INewService;


@Controller(value="commentControllerOfAdmin")
public class CommentController {
	
	@Autowired
	private INewService newsService;
	@Autowired
	private ICategoryService categoryService;
	@Autowired
	private ICommentService commentService;

	@RequestMapping(value="/quantri/binhluan/baiviet", method= RequestMethod.GET)
	public ModelAndView showList(@RequestParam("page") int page, @RequestParam("limit") int limit) {
		NewsDTO model = new NewsDTO();
		model.setPage(page);
		model.setLimit(limit);
		ModelAndView mav = new ModelAndView("admin/comment/list");
		Pageable pageable = new PageRequest(page-1, limit);		//thư viện Pageable phân trang
		model.setListResult(newsService.findAll(pageable));
		model.setTotalItem(newsService.getTotalItem());
		model.setTotalPage((int) Math.ceil((double)model.getTotalItem() / model.getLimit()));
		
		Map<Long, Long> listTotalCommentOfNews = newsService.getTotalCommentOfNews(model);
		mav.addObject("totalComment", listTotalCommentOfNews);
		mav.addObject("model", model);
		mav.addObject("categories", categoryService.findAll());	//truyền vào thể loại bài viết
		return mav;
	}
	
	@RequestMapping(value="/quantri/binhluan/chitiet", method = RequestMethod.GET)
	public ModelAndView showListComment (@RequestParam("newsid") long newsId, @RequestParam("page") int page, @RequestParam("limit") int limit) {
		CommentDTO model = new CommentDTO();
		model.setNewsId(newsId);
		model.setPage(page);
		model.setLimit(limit);
		ModelAndView mav = new ModelAndView("admin/comment/detail");
		Pageable pageable = new PageRequest(page-1, limit);
		model.setListResult(commentService.findByNewsId(pageable, newsId));
		model.setTotalItem(commentService.getTotalItemByNewsId(newsId));
		int totalPage = (int) Math.ceil((double) model.getTotalItem()/ model.getLimit());
		model.setTotalPage(totalPage);
		mav.addObject("model", model);
		
		return mav;
	}
}
