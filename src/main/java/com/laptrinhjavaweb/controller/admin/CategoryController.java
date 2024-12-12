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

import com.laptrinhjavaweb.dto.CategoryDTO;
import com.laptrinhjavaweb.service.ICategoryService;

@Controller(value="categoryControllerOfAdmin")
public class CategoryController {

	@Autowired
	private ICategoryService categoryService;
	
	@RequestMapping(value="/quantri/danhmuc/danhsach", method = RequestMethod.GET)
	public ModelAndView showlist (@RequestParam("page") int page, @RequestParam("limit") int limit) {
		ModelAndView mav = new ModelAndView("/admin/category/list");
		CategoryDTO model = new CategoryDTO();
		model.setLimit(limit);
		model.setPage(page);
		Pageable pageable = new PageRequest(page-1, limit);
		model.setListResult(categoryService.findAll(pageable));
		model.setTotalItem(categoryService.getTotalItem());
		model.setTotalPage((int) Math.ceil((double)model.getTotalItem() / model.getLimit()));
		mav.addObject("model", model);
		
		Map<String, Long> totalNewsOfCategory = categoryService.totalNewsOfCategory(model);
		mav.addObject("totalNews", totalNewsOfCategory);
		return mav;
	}
}
