package com.laptrinhjavaweb.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.entity.NewsEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.CategoryRepository;
import com.laptrinhjavaweb.repository.CommentRepository;
import com.laptrinhjavaweb.repository.NewsRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.IUserService;

@Controller(value = "homeControllerOfAdmin")
public class HomeController {
	
	@Autowired
	private NewsRepository newsRepository;
	
	@Autowired
	private CommentRepository commentRepository;
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private IUserService userService;

	@RequestMapping(value = "/quantri/trangchu", method = RequestMethod.GET)
	public ModelAndView homePage() {
		ModelAndView mav = new ModelAndView("admin/home");
		NewsEntity news = newsRepository.findFirstByOrderByIdDesc();
		mav.addObject("news", news);
		int totalCmt = (int) commentRepository.count();
		mav.addObject("totalCmt", totalCmt);
		int totalNews = (int) newsRepository.count();
		mav.addObject("totalNews", totalNews);
		int totalCategory = (int) categoryRepository.count();
		mav.addObject("totalCategory", totalCategory);
		int totalUser = userService.totalUser();
		int totalEditor = userService.totalEditor();
		mav.addObject("totalUser", totalUser);
		mav.addObject("totalEditor", totalEditor);
		return mav;
	}
}
