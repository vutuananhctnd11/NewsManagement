package com.laptrinhjavaweb.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.laptrinhjavaweb.dto.UserDTO;

public interface IUserService {
	
	List<UserDTO> findAll (Pageable pageable);
	int totalUser ();
	UserDTO updateProfile (UserDTO dto);
}
