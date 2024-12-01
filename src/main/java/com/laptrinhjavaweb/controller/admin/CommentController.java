package com.laptrinhjavaweb.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.dto.NewsDTO;
import com.laptrinhjavaweb.service.ICategoryService;
import com.laptrinhjavaweb.service.INewService;


@Controller(value="commentControllerOfAdmin")
public class CommentController {
	
	@Autowired
	private INewService newsService;
	@Autowired
	private ICategoryService categoryService;

	@RequestMapping(value="/quantri/binhluan/danhsach", method= RequestMethod.GET)
	public ModelAndView showList(@RequestParam("page") int page, @RequestParam("limit") int limit, HttpServletRequest request) {
		NewsDTO model = new NewsDTO();
		model.setPage(page);
		model.setLimit(limit);
		ModelAndView mav = new ModelAndView("admin/comment/list");
		Pageable pageable = new PageRequest(page-1, limit);		//thư viện Pageable phân trang
		model.setListResult(newsService.findAll(pageable));
		model.setTotalItem(newsService.getTotalItem());
		model.setTotalPage((int) Math.ceil((double)model.getTotalItem() / model.getLimit()));
		mav.addObject("model", model);
		mav.addObject("categories", categoryService.findAll());
		return mav;
	}
}
