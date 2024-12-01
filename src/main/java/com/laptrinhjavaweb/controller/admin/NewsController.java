package com.laptrinhjavaweb.controller.admin;

import java.util.Map;

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
import com.laptrinhjavaweb.util.MessageUtil;

@Controller(value = "newsControllerOfAdmin")
public class NewsController {
	
	@Autowired
	private INewService newService;
	@Autowired
	private ICategoryService categoryService;
	@Autowired
	private MessageUtil messageUtil;

	@RequestMapping(value = "/quantri/baiviet/danhsach", method = RequestMethod.GET)
	public ModelAndView showList(@RequestParam("page") int page, @RequestParam("limit") int limit, HttpServletRequest request) {
		NewsDTO model = new NewsDTO();
		model.setPage(page);
		model.setLimit(limit);
		ModelAndView mav = new ModelAndView("admin/new/list");
		Pageable pageable = new PageRequest(page-1, limit);		//thư viện Pageable phân trang
		model.setListResult(newService.findAll(pageable));
		model.setTotalItem(newService.getTotalItem());
		model.setTotalPage((int) Math.ceil((double)model.getTotalItem() / model.getLimit()));
		if (request.getParameter("message") !=null){
			Map<String, String> message = messageUtil.getMessage(request.getParameter("message"));
			mav.addObject("alert", message.get("alert"));
			mav.addObject("message", message.get("message"));
		}
		mav.addObject("model", model);
		mav.addObject("categories", categoryService.findAll());
		return mav;
	}
	
	@RequestMapping(value = "/quantri/baiviet/chinhsua", method = RequestMethod.GET)
	public ModelAndView editNew(@RequestParam(value="id", required = false) Long id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/new/edit");
		NewsDTO model = new NewsDTO();
		if (id != null ) {
			model =  newService.findById(id);
		}
		if (request.getParameter("message") !=null){
			Map<String, String> message = messageUtil.getMessage(request.getParameter("message"));
			mav.addObject("alert", message.get("alert"));
			mav.addObject("message", message.get("message"));
		}
		
		mav.addObject("model", model);
		mav.addObject("categories", categoryService.findAll());
		
		return mav;
	}
}
