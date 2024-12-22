package com.laptrinhjavaweb.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;

import com.laptrinhjavaweb.dto.UserDTO;

public interface IUserService {
	
	List<UserDTO> findAll (Pageable pageable);
	int totalAccount ();
	ResponseEntity<?> updateProfile (UserDTO dto);
	void lockedOrUnlockedAccount (long[] ids);
	void deleteAccount (long[] ids);
	ResponseEntity<?> createAccount (UserDTO dto);
	ResponseEntity<?> changePassword (UserDTO dto);
	int totalUser ();
	int totalEditor ();
}
