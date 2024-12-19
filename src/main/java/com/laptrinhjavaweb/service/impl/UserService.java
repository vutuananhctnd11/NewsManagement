package com.laptrinhjavaweb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.laptrinhjavaweb.constant.SystemConstant;
import com.laptrinhjavaweb.converter.UserConverter;
import com.laptrinhjavaweb.dto.UserDTO;
import com.laptrinhjavaweb.entity.CommentEntity;
import com.laptrinhjavaweb.entity.RoleEntity;
import com.laptrinhjavaweb.entity.UserEntity;
import com.laptrinhjavaweb.repository.CommentRepository;
import com.laptrinhjavaweb.repository.RoleRepository;
import com.laptrinhjavaweb.repository.UserRepository;
import com.laptrinhjavaweb.service.IUserService;
import com.laptrinhjavaweb.util.PasswordUtil;
import com.laptrinhjavaweb.util.Validate;

@Service
public class UserService implements IUserService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private UserConverter userConverter;
	
	@Autowired
	private CommentRepository commentRepository;
	
	@Autowired
	private RoleRepository roleRepository;

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
	@Transactional
	public ResponseEntity<?> updateProfile(UserDTO dto) {
		//validate email
		if(!Validate.isValidEmail(dto.getEmail())) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Email không hợp lệ!");
		}
		//validate phone number
		if(!Validate.isValidPhoneNumber(dto.getPhoneNumber())) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Số điện thoại bắt đầu bằng số 0 và gồm 10 số!");
		}
		UserEntity entity = userRepository.findOneByUserNameAndStatus(dto.getUserName(), SystemConstant.ACTIVE_STATUS);
		List<RoleEntity> roles = entity.getRoles();
		entity = userConverter.toEntity(entity, dto);
		entity.setRoles(roles);
		entity = userRepository.save(entity);
		
		return ResponseEntity.ok(userConverter.toDTO(entity));
	}

	@Override
	@Transactional
	public void lockedOrUnlockedAccount(long[] ids ) {
		
		for (long id : ids) {
			UserEntity entity = userRepository.findOne(id);
			if (entity.getStatus()==1) {
				entity.setStatus(SystemConstant.INACTIVE_STATUS);
			} else if (entity.getStatus()==0) {
				entity.setStatus(SystemConstant.ACTIVE_STATUS);
			}
			entity = userRepository.save(entity);
		}
	}

	@Override
	@Transactional
	public void deleteAccount(long[] ids) {
		for (long id : ids) {
			List<CommentEntity> cmtEntities = commentRepository.findByUserId(id);
			for (CommentEntity item : cmtEntities) {
				commentRepository.delete(item);
			}
			UserEntity user = userRepository.findOne(id);
			for (RoleEntity role : user.getRoles()) {
				role.getUsers().remove(user);
			}
			user.getRoles().clear();
			userRepository.delete(user);
		}
		
	}

	@Override
	@Transactional
	public ResponseEntity<?> createAccount(UserDTO dto) {
		if (dto == null || dto.getRoleCode() == null) {
			ResponseEntity.status(HttpStatus.BAD_REQUEST)
			 .header("Content-Type", "text/plain; charset=UTF-8")
			 .body("Không có dữ liệu truyền vào");
		}
		UserEntity user = userRepository.findOneByUserName(dto.getUserName());
		if (user !=null) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Đã tồn tại tài khoản có tên đăng nhập: "+dto.getUserName());
		}
		if (dto.getUserName().length()<6 || dto.getUserName().length() > 12) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Tên đăng nhập phải có độ dài từ 6-12 ký tự!");
		}
		
		String password = dto.getPassword();
		if (password.length()<6 || password.length()>12) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Mật khẩu phải có độ dài từ 6-12 ký tự!");
		}
		UserEntity entity = userConverter.toEntity(dto);
		//validate email
		if(!Validate.isValidEmail(dto.getEmail())) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Email không hợp lệ!");
		}
		
		
		List<RoleEntity> roles = roleRepository.findByCode(dto.getRoleCode());
		if (roles == null || roles.isEmpty()) {
		    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Không tồn tại vai trò (role) này!");
		}
		entity.setRoles(roles);
		entity.setStatus(SystemConstant.ACTIVE_STATUS);
		entity.setPassword(PasswordUtil.encryptPassword(dto.getPassword()));
		entity = userRepository.save(entity);
		return ResponseEntity.ok(userConverter.toDTO(entity));
	}

	@Override
	public ResponseEntity<?> changePassword(UserDTO dto) {
		String password = dto.getPassword();
		String newPassword = dto.getNewPassword();
		if (newPassword.length()<6 || newPassword.length()>12) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Mật khẩu phải có độ dài từ 6-12 ký tự!");
		}
		UserEntity user = userRepository.findOneByUserName(dto.getUserName());
		if(!PasswordUtil.matchesPassword(password, user.getPassword())) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Mật khẩu hiện tại không đúng!");
		}
		if (PasswordUtil.matchesPassword(newPassword, user.getPassword())) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					 .header("Content-Type", "text/plain; charset=UTF-8")
					 .body("Mật khẩu mới không được trùng với mật khẩu hiện tại!");
		}
		newPassword = PasswordUtil.encryptPassword(newPassword);
		user.setPassword(newPassword);
		user = userRepository.save(user);
		return ResponseEntity.ok(userConverter.toDTO(user));
	}


}
