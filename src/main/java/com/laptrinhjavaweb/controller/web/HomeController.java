package com.laptrinhjavaweb.controller.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.dto.UserDTO;

@Controller(value = "homeControllerOfWeb")
public class HomeController {

	@RequestMapping(value = "/trangchu", method = RequestMethod.GET)
	public ModelAndView homePage() {
		ModelAndView mav = new ModelAndView("web/home");
		return mav;
	}
	
	@RequestMapping(value = "/dangnhap", method = RequestMethod.GET)
	public ModelAndView loginPage() {
		ModelAndView mav = new ModelAndView("login1");
		return mav;
	}
	
	@RequestMapping(value = "/dangky")
	public ModelAndView register() {
	    ModelAndView mav = new ModelAndView("register");
	    UserDTO model = new UserDTO();
	    mav.addObject("model", model);
	    return mav;
	}
	
	@RequestMapping(value = "/accessDenied", method = RequestMethod.GET)
	public ModelAndView accessDenied() {
		return new ModelAndView("redirect:/dangnhap?nopermission");
	}
	
	@RequestMapping(value = "/editorAccessDenied", method = RequestMethod.GET)
	public ModelAndView editorAccessDenied() {
		return new ModelAndView("/admin/denied");
	}
	
	@RequestMapping(value = "/thoat", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();		//lấy thông tin đăng nhập
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}

		return new ModelAndView("redirect:/trangchu?logOut");
	}
}
