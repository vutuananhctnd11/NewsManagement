package com.laptrinhjavaweb.api.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public ResponseEntity<?> editUserProfile (@RequestBody UserDTO dto) {
		return userService.updateProfile(dto);
	}
	
	@PutMapping("/api/password")
	public ResponseEntity<?> changePassword (@RequestBody UserDTO dto) {
		return userService.changePassword(dto);
	}
	
	@PutMapping("/api/account")
	public void lockedOrUnlockAccount (@RequestBody long[] ids) {
		userService.lockedOrUnlockedAccount(ids);
	}
	
	@PostMapping("/api/account")
	public ResponseEntity<?> createAccount (@RequestBody UserDTO dto) {
		return userService.createAccount(dto);
	}
	
	@DeleteMapping("api/account")
	public void deleteAccount (@RequestBody long[] ids) {
		userService.deleteAccount(ids);
	}
}
