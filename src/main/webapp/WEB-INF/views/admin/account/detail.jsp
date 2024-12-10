<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<html>
	<head>
	<title>Thông tin tài khoản</title>
	</head>
	
	
	<body class="no-skin">
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="page-header">
						<h1>
							Thông tin tài khoản
						</h1>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<div id="user-profile-3" class="user-profile row">
							<div>
								<form class="form-horizontal">
									<div class="tabbable">
										<ul class="nav nav-tabs padding-16">
											<li class="active">
												<a data-toggle="tab" href="#edit-basic">
													<i class="fa-solid fa-user"></i>
													Thông tin cá nhân
												</a>
											</li>
										</ul>
	
										<div class="tab-content profile-edit-tab-content">
											<div id="edit-basic" class="tab-pane in active">
												<div class="row">
												<br/>
	
													<div class="col-xs-12 col-sm-8" style="margin-left: 25px;">
														<div class="form-group">
															<label class="col-sm-4 control-label no-padding-right" for="username">Tên đăng nhập:</label>
	
															<div class="col-sm-8">
																<input style="width: 200px;" type="text" id="username" disabled value="${model.userName}" />
															</div>
														</div>
	
														<div class="space-4"></div>
	
														<div class="form-group">
															<label class="col-sm-4 control-label no-padding-right" for="form-field-first">Họ và tên:</label>
	
															<div class="col-sm-8">
																<input style="width: 250px;" type="text" id="fullName" class="profile" disabled value="${model.fullName}" />
															</div>
														</div>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="ngaySinh">Ngày sinh:</label>
													<div class="col-sm-9">
														<div class="input-medium">
															<div class="input-group">
																<input class="input-medium date-picker profile" id="birthday" type="text" data-date-format="dd/mm/yyyy" 
																 	   disabled placeholder="dd/mm/yyyy" value="${model.birthday}"/>
																<span class="input-group-addon">
																	<i class="ace-icon fa fa-calendar"></i>
																</span>
															</div>
														</div>
													</div>
												</div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right">Giới tính</label>
													<div class="col-sm-9" style="align-content: center;">
														<label class="inline">
															<input name="form-field-radio" type="radio" class="gioiTinh profile" disabled/>
															<span class="lbl middle"> Nam</span>
														</label>
	
														&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
														<label class="inline">
															<input name="form-field-radio" type="radio" class="gioiTinh profile"disabled/>
															<span class="lbl middle"> Nữ</span>
														</label>
													</div>
												</div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="form-field-website">Vai trò: </label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<input type="text" disabled id="position" value="${model.roleName}" />
														</span>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="email">Email</label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<input style="width: 250px;" type="email" class="profile" disabled id="email" value="${model.email}" />
															<i class="ace-icon fa fa-envelope"></i>
														</span>
													</div>
												</div>
	
												<div class="space-4"></div>
	
												
	
												<div class="space-4"></div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="form-field-phone">Số điện thoại</label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<input type="text" class="profile" disabled id="phoneNumber" value="${model.phoneNumber}" />
															<i class="ace-icon fa fa-phone fa-flip-horizontal"></i>
														</span>
													</div>
												</div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="facebook"><i class="fa-brands fa-facebook" style="font-size: 20px;color:#3B5998;"></i></label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<input type="text" class="profile" disabled value="${model.facebook}" id="facebook" />
														</span>
													</div>
												</div>
	
												<div class="space-4"></div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="instagram"><i class="fa-brands fa-instagram" style="font-size: 20px; color:#BC2A8D;"></i></label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<input type="text" class="profile" disabled value="${model.phoneNumber}" id="zalo" />
														</span>
													</div>
												</div>
	
											</div>
											<div id="edit-password" class="tab-pane">
												<div class="space-10"></div>
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="password">Mât khẩu hiện tại</label>
	
													<div class="col-sm-9">
														<input style="width: 300px;" type="password" id="password" />
													</div>
												</div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="newPassword">Mật khẩu mới</label>
	
													<div class="col-sm-9">
														<input style="width: 300px;" type="password" id="newPassword" />
													</div>
												</div>
	
												<div class="space-4"></div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="confirmNewPassword">Xác nhận mật khẩu</label>
	
													<div class="col-sm-9">
														<input style="width: 300px;" type="password" id="confirmNewPassword" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
							</div>
						</div>
					</div>
				</div>	
				
			</div>
		</div>
		
		<script>
		$('.date-picker').datepicker({
		    autoclose: true,
		    format: 'dd/mm/yyyy',
		    todayHighlight: true
		});
		$('.input-group-addon').on('click', function() {
		    $(this).prev('.date-picker').datepicker('show');
		});
		
		//giới tính
		var gender = "${model.gender}";
		var radios = document.querySelectorAll('.gioiTinh');
		radios.forEach(function(radio) {
		    var labelText = radio.nextElementSibling.textContent.trim();
		    
		    console.log(gender +" - "+labelText);
		    if (labelText.toLowerCase() === gender.toLowerCase()) {
		        radio.checked = true;
		    }
		});
		
		//khóa không cho sửa
		$(document).ready(function () {
            $('.profile').prop('disabled', true);
        });
		
		
		
		</script>
	</body>
</html>
