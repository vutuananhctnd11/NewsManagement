package com.laptrinhjavaweb.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.converter.UserConverter;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.util.SecurityUtils;

@Controller(value = "accountControllerOfAdmin")
public class AccountController {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserConverter userConverter;
	
	@RequestMapping(value = "/quantri/taikhoan/thongtin", method = RequestMethod.GET)
	public ModelAndView AccountProfile () {
		ModelAndView mav = new ModelAndView("/admin/account/profile");
		String username = SecurityUtils.getPrincipal().getUsername();
		UserEntity entity = userRepository.findOneByUserNameAndStatus(username, SystemConstant.ACTIVE_STATUS);
		UserDTO model = userConverter.toDTO(entity);
		mav.addObject("model", model);
		return mav;
	}
	
	@RequestMapping(value = "/quantri/taikhoan/danhsach", method = RequestMethod.GET)
	public ModelAndView listAccount () {
		ModelAndView mav = new ModelAndView("/admin/account/list");
		return mav;
	}

}
