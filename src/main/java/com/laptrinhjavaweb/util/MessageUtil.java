package com.laptrinhjavaweb.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class MessageUtil {

	public Map<String, String> getMessage (String message){
		Map<String, String> result = new HashMap<>();
		if (message.equals("error_system")) {
			result.put("message", "Đã xảy ra lỗi hệ thống, không thực hiện được");
			result.put("alert", "danger");
		}
		return result;
	}
}
