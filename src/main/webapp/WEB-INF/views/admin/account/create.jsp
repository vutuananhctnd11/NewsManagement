<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="createAccountAPI" value="/api/account"/>
<c:url var="accountURL" value="/quantri/taikhoan/danhsach/chitiet"/>
<html>
	<head>
	<title>Thông tin tài khoản</title>
	</head>
	
	
	<body class="no-skin">
		<div class="main-content">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb" style="font-size: 14px;">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="<c:url value = '/quantri/trangchu'/>">Trang chủ</a></li>
						<li><a href="#">Quản lý tài khoản</a></li>
						<li><a href="#">Thêm tài khoản mới</a></li>
					</ul>
					<!-- /.breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div id="user-profile-3" class="user-profile row">
							<div>
								<form:form class="form-horizontal" role="form" id="formSubmit" modelAttribute="model">
									<div class="tabbable">
										<ul class="nav nav-tabs padding-16">
											<li class="active">
												<a data-toggle="tab" href="#edit-basic">
													<i class="fa-solid fa-user"></i>
													Tạo tài khoản
												</a>
											</li>
										</ul>
	
										<div class="tab-content profile-edit-tab-content">
											<div id="edit-basic" class="tab-pane in active">
												<div class="row">
												<br/>
	
													<div class="col-xs-12 col-sm-8" style="margin-left: 30px;">
														<div class="form-group">
															<label class="col-sm-4 control-label no-padding-right" for="userName">Tên đăng nhập:</label>
	
															<div class="col-sm-8">
																<form:input style="width: 200px; font-size: 15px;" path="userName" id="userName"/>
															</div>
														</div>
	
														<div class="space-4"></div>
	
														<div class="form-group">
															<label class="col-sm-4 control-label no-padding-right" for="fullName">Họ và tên:</label>
	
															<div class="col-sm-8">
																<form:input style="width: 200px; font-size: 15px;" path="fullName" id="fullName"/>
															</div>
														</div>
													</div>
												</div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="email">Email: </label>
	
													<div class="col-sm-9">
														<span>
															<form:input style="width: 200px; font-size: 15px;" path="email" id="email"/>
														</span>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="roleCode">Vai trò: </label>
	
													<div class="col-sm-9" >
														<form:select path="roleCode" id="roleCode" style="width: 200px; font-size: 15px; height: 35px;">
															<form:option value="" label="-- Chọn vai trò tài khoản --"></form:option>
															<form:options items="${roles}"/>
														</form:select>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="password">Mật khẩu:</label>
	
													<div class="col-sm-9">
														<span>
															<form:input path="password" type="password" style="width: 200px; font-size: 15px;" id="password"  />
														</span>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="email">Xác nhận mật khẩu:</label>
	
													<div class="col-sm-9">
														<span>
															<input style="width: 200px; font-size: 15px;" type="password" id="confirmPassword"  />
														</span>
													</div>
												</div>
	
												<div class="space-4"></div>
											</div>
										</div>
										<div class="clearfix form-actions">
											<div class="col-md-offset-2 button-container">
												<button class="btn btn-success" type="button" id="createAccount">
													<i class="ace-icon fa fa-check bigger-110"></i>
													Tạo tài khoản
												</button>
												<button style="margin-left: 100px;" class="btn btn-danger" type="reset" id="">
													<i class="ace-icon fa fa-undo bigger-110"></i>
													Hủy
												</button>
											</div>
											
										</div>
									</div>
								</form:form>
							</div>
							</div>
						</div>
					</div>
				</div>	
				
			</div>
		</div>
		
		<script>
		$('#createAccount').click(function(e){
			//validate data
			if ($('#userName').val()==""){
				alert("Chưa nhập Tên đăng nhập!"); return;
			}
			if ($('#fullName').val()==""){
				alert("Chưa nhập Họ và tên!"); return;
			}
			if ($('#email').val()==""){
				alert("Chưa nhập Email!"); return;
			}
			if ($('#roleCode').val()==""){
				alert("Chưa nhập vai trò của tài khoản!"); return;
			}
			if ($('#password').val()!=$('#confirmPassword').val()){
				alert("Mật khẩu và Xác nhận mật khẩu không khớp!"); return;
			}
			var data = {};
 		    var formData = $('#formSubmit').serializeArray();
 		    $.each(formData, function(i,v) {
 		    	data[""+v.name+""] = v.value;
 		    });
 		    createAccount(data);
 		    
		});
		
		function createAccount(data){
			$.ajax({
	            url: '${createAccountAPI}',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            success: function (result) {
	            	var userid = result.id;
	            	Swal.fire("","Thao tác thành công!","success").then(function(result){
	            		window.location.href = "${accountURL}?userid="+userid;
	            	});
	            },
	            error: function (error) {
	            	Swal.fire("Lỗi hệ thống!", error.responseText, "error");
	            }
	        });
		}
			
		
		
		</script>
	</body>
</html>
