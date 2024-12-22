package com.laptrinhjavaweb.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		String uri = request.getRequestURI();

		String contextPath = request.getContextPath();

        String pathWithoutContext = uri.substring(contextPath.length());
        if (pathWithoutContext.startsWith("/quantri/taikhoan/taomoi")) {
            response.sendRedirect(contextPath+"/editorAccessDenied");
        } else if (pathWithoutContext.startsWith("/quantri")) {
            response.sendRedirect(contextPath+"/accessDenied");
        } else {
            response.sendRedirect(contextPath+"/accessDenied");
        }
	}

}
