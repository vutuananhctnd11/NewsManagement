package com.laptrinhjavaweb.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.converter.UserConverter;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.entity.RoleEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.RoleRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.IRoleService;
import com.laptrinhjavaweb.service.IUserService;
import com.laptrinhjavaweb.util.SecurityUtils;

@Controller(value = "accountControllerOfAdmin")
public class AccountController {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserConverter userConverter;
	
	@Autowired
	private IUserService userService;
	
	@Autowired
	private IRoleService roleService;
	
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
	public ModelAndView listAccount (@RequestParam("page") int page, @RequestParam("limit") int limit, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/admin/account/list");
		UserDTO model = new UserDTO();
		model.setPage(page);
		model.setLimit(limit);
		Pageable pageable = new PageRequest(page-1, limit);
		model.setListResult(userService.findAll(pageable));
		model.setTotalItem(userService.totalAccount());
		int totalPage = (int) Math.ceil((double) model.getTotalItem() / model.getLimit());
		model.setTotalPage(totalPage);
		
		UserEntity user = userRepository.findOneByUserName(SecurityUtils.getPrincipal().getUsername());
		model.setRoleCode(user.getRoles().get(0).getCode());
		mav.addObject("model", model);
		return mav;
	}
	
	@RequestMapping(value="/quantri/taikhoan/danhsach/chitiet")
	public ModelAndView AccountDetail (@RequestParam("userid") long userId) {
		ModelAndView mav = new ModelAndView("/admin/account/detail");
		UserEntity entity = userRepository.findOne(userId);
		UserDTO model = userConverter.toDTO(entity);
		mav.addObject("model", model);
		return mav;
	}
	
	@RequestMapping(value="/quantri/taikhoan/taomoi")
	public ModelAndView addAccount () {
		ModelAndView mav = new ModelAndView("/admin/account/create");
		UserDTO model = new UserDTO();
		mav.addObject("model", model);
		mav.addObject("roles", roleService.findAll());
		return mav;
	}

}
