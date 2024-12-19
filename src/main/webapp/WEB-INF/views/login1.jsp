<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<body class="bg-dark">
	<div class="container">
		<div class="card card-login mx-auto mt-5">
			<div class="card-header">Đăng nhập</div>
			<div class="card-body">
				<form action="j_spring_security_check" id="formLogin" method="post">
				<c:if test="${param.incorrectAccount != null}">
					<div class="alert alert-danger">	
							User name hoặc mật khẩu không đúng !
					</div>
				</c:if>
				<c:if test="${param.nopermission != null}">
					<div class="alert alert-danger">	
							Bạn không có quyền truy cập vào trang quản trị ! <br/> Hãy đăng nhập bằng <b>tài khoản admin</b> !
					</div>
				</c:if>
				<c:if test="${param.registerSuccess != null}">
					<div class="alert alert-success">	
							Đăng ký thành công, hãy đăng nhập !
					</div>
				</c:if>
					<div class="form-group">
						<div class="form-label-group">
							<input type="text" id="userName" name="j_username" class="form-control" placeholder="Tên đăng nhập" required="required" autofocus="autofocus"> 
							<label for="userName">Tên đăng nhập </label>
						</div>
					</div>
					<div class="form-group">
						<div class="form-label-group">
							<input type="password" id="password" name="j_password" class="form-control" placeholder="Mật khẩu" required="required"> 
							<label for="password">Mật khẩu</label>
						</div>
					</div>
					<div class="form-group">
						<div class="checkbox">
							<label> <input type="checkbox" value="remember-me"> Lưu mật khẩu </label>
						</div>
					</div>
					<button type="submit" class="btn btn-primary btn-block">Đăng nhập </button>
				</form>
				<div class="text-center">
					<a class="d-block small mt-3" href="<c:url value = '/dangky'/>">Đăng ký tài khoản người dùng</a> 
				</div>
			</div>
		</div>
	</div>
</body>
</html>