<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="profileAPI" value="/api/profile"/>
<c:url var="profileURL" value="/quantri/taikhoan/thongtin"/>
	
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
							<div id="user-profile-3" class="user-profile row"><div>
								<form:form class="form-horizontal" role="form" id="formSubmit" modelAttribute="model">
									<div class="tabbable">
										<ul class="nav nav-tabs padding-16">
											<li class="active">
												<a data-toggle="tab" href="#edit-basic">
													<i class="fa-solid fa-user"></i>
													Thông tin cá nhân
												</a>
											</li>
	
											<li>
												<a data-toggle="tab" href="#edit-password">
													<i class="blue ace-icon fa fa-key bigger-125"></i>
													Đổi mật khẩu
												</a>
											</li>
										</ul>
	
										<div class="tab-content profile-edit-tab-content">
										

											<div id="edit-basic" class="tab-pane in active">
												<h4 class="header blue bolder smaller">Thông tin cơ bản</h4>
	
												<div class="row">
	
													<div class="col-xs-12 col-sm-8" style="margin-left: 30px;">
														<div class="form-group">
															<label class="col-sm-4 control-label no-padding-right" for="userName">Tên đăng nhập:</label>
	
															<div class="col-sm-8">
																<form:input style="width: 250px;" id="userName" path="userName" class="lock"/>
															</div>
														</div>
	
														<div class="space-4"></div>
	
														<div class="form-group">
															<label class="col-sm-4 control-label no-padding-right" for="fullName">Họ và tên:</label>
	
															<div class="col-sm-8">
																<form:input style="width: 250px;" class="profile" path="fullName" id="fullName"/>
															</div>
														</div>
													</div>
												</div>
												
												<hr />
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="ngaySinh">Ngày sinh:</label>
													<div class="col-sm-9">
														<div class="input-medium">
															<div class="input-group">
																<form:input class="input-medium date-picker profile" path="birthday" id="birthday" data-date-format="dd/mm/yyyy" 
																 	  placeholder="dd/mm/yyyy" readonly="readonly"/>
																<span class="input-group-addon">
																	<i class="ace-icon fa fa-calendar"></i>
																</span>
															</div>
														</div>
													</div>
												</div>
	
												<div class="space-4"></div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right">Giới tính</label>
													<div class="col-sm-9" style="align-content: center;">
														<label class="inline">
															<input name="gender" type="radio" value="Nam" class="gender profile">
															<span class="lbl middle"> Nam</span>
														</label>
	
														&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
														<label class="inline">
															<input name="gender" type="radio" value="Nữ" class="gender profile"/>
															<span class="lbl middle"> Nữ</span>
														</label>
													</div>
												</div>
	
												<div class="space-4"></div>
	
												<div class="space"></div>
												<h4 class="header blue bolder smaller">Liên hệ</h4>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="form-field-website">Vai trò: </label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<form:input path="roleName" id="roleName" class="lock"/>
														</span>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="email">Email</label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<form:input style="width:250px;" class="profile" path="email" id="email"/>
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
															<form:input type="text" class="profile" path="phoneNumber" id="phoneNumber"/>
															<i class="ace-icon fa fa-phone fa-flip-horizontal"></i>
														</span>
													</div>
												</div>
	
												<div class="space"></div>
												<h4 class="header blue bolder smaller">Xã hội</h4>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="facebook"><i class="fa-brands fa-facebook" style="font-size: 20px;color:#3B5998;"></i></label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<form:input class="profile" path="facebook" id="facebook" />
														</span>
													</div>
												</div>
	
												<div class="space-4"></div>
	
												<div class="form-group">
													<label class="col-sm-3 control-label no-padding-right" for="instagram"><i class="fa-brands fa-instagram" style="font-size: 20px; color:#BC2A8D;"></i></label>
	
													<div class="col-sm-9">
														<span class="input-icon input-icon-right">
															<form:input class="profile" path="phoneNumber" id="zalo" />
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
	
									<div class="clearfix form-actions">
										<div class="col-md-offset-3 col-md-9 button-container">
											<button class="btn btn-info" type="button" id="editProfile">
												<i class="ace-icon fa fa-check bigger-110"></i>
												Sửa thông tin
											</button>
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
		var radios = document.querySelectorAll('.gender');
		radios.forEach(function(radio) {
		    var labelText = radio.nextElementSibling.textContent.trim();
		    if (labelText.toLowerCase() === gender.toLowerCase()) {
		        radio.checked = true;
		    }
		});

		//khóa không cho sửa
		$(document).ready(function () {
            //$('.profile').prop('disabled', true);
            $('.profile').prop('disabled', true);
            $('.lock').attr('readonly', 'readonly');
			
            //thay đổi nút
            $('.button-container').on('click', '#editProfile', function () {
            	$('.profile').prop('disabled', false);
                
                $('.button-container').html(`
                		<button class="btn btn-success" type="button" id="saveButton">
						<i class="ace-icon fa fa-check bigger-110"></i>
						Lưu
						</button>

						&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
						<button class="btn" type="reset" id="cancelButton">
						<i class="ace-icon fa fa-undo bigger-110"></i>
						Hủy
						</button>
                `);
                $('.button-container').on('click', '#cancelButton',function () {
                    Swal.fire("","Đã hủy thay đổi!","success");
                    
                    resetToEditState();
                });
                
                $('.button-container').on('click', '#saveButton',function () {
                	var data = {};
            	    var formData = $('#formSubmit').serializeArray();
            	    $.each(formData, function (i, v) {
                        data[""+v.name+""] = v.value;
            	    });
            	    updateProfile(data);
                });
            });
            
            
            
            function resetToEditState() {
                $('.profile').prop('disabled', true);
                $('.button-container').html(`
                		<button class="btn btn-info" type="button" id="editProfile">
						<i class="ace-icon fa fa-check bigger-110"></i>
						Sửa thông tin
						</button>
                `);
                $('#fullName').val("${model.fullName}");
                $('#birthday').val("${model.birthday}");
                $('#email').val("${model.email}");
                $('#phoneNumber').val("${model.phoneNumber}");
                $('#facebook').val("${model.facebook}");
                $('#zalo').val("${model.phoneNumber}");
            }
            
        });
		
		function updateProfile(data){
			$.ajax({
	            url: '${profileAPI}',
	            type: 'PUT',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            dataType: 'json',
	            success: function (result) {
	            	Swal.fire("", "Sửa thông tin thành công", "success").then(function(apply){
	            		window.location.href = "${profileURL}";
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
