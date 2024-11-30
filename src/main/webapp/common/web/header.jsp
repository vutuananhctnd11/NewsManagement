<%@ page import="com.laptrinhjavaweb.util.SecurityUtils" %> <%-- Import lớp chứa hàm lấy thông tin user --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="#">Start Bootstrap</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link" href="<c:url value='/trangchu'/>">Trang chủ
						<span class="sr-only">(current)</span>
				</a></li>
				<security:authorize access = "isAnonymous()"> <%-- hàm có sẵn --%>
					<li class="nav-item"><a class="nav-link" href="<c:url value='/dangnhap'/>">Đăng nhập</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Đăng ký</a></li>
				</security:authorize>
				<security:authorize access = "isAuthenticated()"> <%-- hàm có sẵn --%>
					<li class="nav-item"><a class="nav-link" href="#">Xin chào <%=SecurityUtils.getPrincipal().getFullName()%></a></li>
					<li class="nav-item"><a class="nav-link" href="<c:url value='/thoat'/>">Đăng xuất</a></li>
				</security:authorize>
			</ul>
		</div>
	</div>
</nav>