package com.laptrinhjavaweb.converter;

import org.springframework.stereotype.Component;

import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.entity.UserEntity;

@Component
public class UserConverter {
	
	public UserDTO toDTO (UserEntity entity) {
		UserDTO result =  new UserDTO();
		result.setId(entity.getId());
		result.setUserName(entity.getUserName());
		result.setPassword(entity.getPassword());
		result.setFullName(entity.getFullName());
		result.setRoleName(entity.getRoles().get(0).getName());
		result.setStatus(entity.getStatus());
		result.setBirthday(entity.getBirthday());
		result.setGender(entity.getGender());
		result.setEmail(entity.getEmail());
		result.setPhoneNumber(entity.getPhoneNumber());
		result.setFacebook(entity.getFacebook());
		return result;
	}
	
	public UserEntity toEntity (UserEntity result, UserDTO dto) {
		result.setUserName(dto.getUserName());
		result.setFullName(dto.getFullName());
		result.setBirthday(dto.getBirthday());
		result.setGender(dto.getGender());
		result.setEmail(dto.getEmail());
		result.setPhoneNumber(dto.getPhoneNumber());
		result.setFacebook(dto.getFacebook());
		return result;
	}

}
