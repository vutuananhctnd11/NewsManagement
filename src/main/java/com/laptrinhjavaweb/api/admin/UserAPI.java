package com.laptrinhjavaweb.api.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.service.IUserService;

@RestController(value="UserAPIofAdmin")
public class UserAPI {
	
	@Autowired
	private IUserService userService;

	@PutMapping("/api/profile")
	public UserDTO editUserProfile (@RequestBody UserDTO dto) {
		return userService.updateProfile(dto);
	}
}
