package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.converter.UserConverter;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.entity.RoleEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.IUserService;

@Service
public class UserService implements IUserService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserConverter userConverter;

	@Override
	public List<UserDTO> findAll(Pageable pageable) {
		
		List<UserDTO> result = new ArrayList<>();
		List<UserEntity> entities = userRepository.findAll(pageable).getContent();
		for (UserEntity entity : entities) {
			UserDTO dto = userConverter.toDTO(entity);
			result.add(dto);
		}
		return result;
	}

	@Override
	public int totalUser() {
		return (int) userRepository.count();
	}

	@Override
	public UserDTO updateProfile(UserDTO dto) {
		UserEntity entity = userRepository.findOneByUserNameAndStatus(dto.getUserName(), SystemConstant.ACTIVE_STATUS);
		List<RoleEntity> roles = entity.getRoles();
		entity = userConverter.toEntity(entity, dto);
		entity.setRoles(roles);
		entity = userRepository.save(entity);
		
		return userConverter.toDTO(entity);
	}

}
