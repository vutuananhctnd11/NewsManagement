package com.laptrinhjavaweb.util;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class PasswordUtil {
	private static final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    // Mã hóa mật khẩu
    public static String encryptPassword(String rawPassword) {
        return passwordEncoder.encode(rawPassword);
    }
    
    // Kiểm tra mật khẩu
    public static boolean matchesPassword(String rawPassword, String encryptedPassword) {
        return BCrypt.checkpw(rawPassword, encryptedPassword);
    }

}
