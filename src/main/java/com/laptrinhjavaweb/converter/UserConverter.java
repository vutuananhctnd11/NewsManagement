package com.laptrinhjavaweb.converter;

import org.springframework.stereotype.Component;

import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.entity.UserEntity;

@Component
public class UserConverter {
	
	public UserDTO toDTO (UserEntity entity) {
		UserDTO result =  new UserDTO();
		result.setUserName(entity.getUserName());
		result.setPassword(entity.getPassword());
		result.setFullName(entity.getFullName());
		result.setRoleName(entity.getRoles().get(0).getName());
		result.setBirthday(entity.getBirthday());
		result.setGender(entity.getGender());
		result.setEmail(entity.getEmail());
		result.setPhoneNumber(entity.getPhoneNumber());
		result.setFacebook(entity.getFacebook());
		return result;
	}

}
