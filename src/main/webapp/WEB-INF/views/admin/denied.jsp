<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <title>Trang chủ</title> -->
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs ace-save-state" id="breadcrumbs">
            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Trang chủ</a>
                </li>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row" >
                <div class="col-xs-12" style="color: red; text-align: center;">
					<h3>Bạn không có quyền sử dụng chức năng này</h3>
					<h3>Vui lòng đăng nhập bằng tài khoản <b>ADMIN</b> để sử dụng !</h3>
					<img src="<%= request.getContextPath() %>/template/images/denied.jpg" height="300">
                </div>
            </div>
        </div>
    </div>
</div><!-- /.main-content -->
</body>
</html>