<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>
<c:url var="createAccountAPI" value="/api/account"/>
<c:url var="loginURL" value="/dangnhap"/>
<html>
	<body class="bg-dark">
	  <div class="container">
	    <div class="card card-register mx-auto mt-5">
	      <div class="card-header">Đăng ký tài khoản mới</div>
	      <div class="card-body">
	        <form:form class="form-horizontal" role="form" id="formSubmit" modelAttribute="model">
	          <div class="form-group">
	            <div class="form-row">
	              <div class="col-md-6">
	                <div class="form-label-group">
	                  <form:input path="userName" id="userName" class="form-control" placeholder="Tên đăng nhập" autofocus="autofocus"/>
	                  <label for="userName">Tên đăng nhập</label>
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="form-label-group">
	                  <form:input path="fullName" id="fullName" class="form-control" placeholder="Họ và tên"/>
	                  <label for="fullName">Họ và tên</label>
	                </div>
	              </div>
	            </div>
	          </div>
	          <div class="form-group">
	            <div class="form-label-group">
	              <form:input path="email" id="email" class="form-control" placeholder="Địa chỉ email"/>
	              <label for="email">Địa chỉ email</label>
	            </div>
	          </div>
	          <div class="form-group">
	            <div class="form-row">
	              <div class="col-md-6">
	                <div class="form-label-group">
	                  <form:input path="password" type="password" id="password" class="form-control" placeholder="Mật khẩu"/>
	                  <label for="password">Mật khẩu</label>
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="form-label-group">
	                  <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm password"/>
	                  <label for="confirmPassword">Xác nhận mật khẩu</label>
	                </div>
	              </div>
	            </div>
	          </div>
	          <button class="btn btn-primary btn-block" id="register">Đăng ký</button>
	        </form:form>
	        <div class="text-center">
	          <a class="d-block small mt-3" href="<c:url value='/dangnhap' />">Bạn đã có tài khoản?</a>
	        </div>
	      </div>
	    </div>
	  </div>
	  
	  <script>
	  $('#register').click(function(e){
		  e.preventDefault();
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
		    data["roleCode"] = "USER";
		    console.log(data);
		    createAccount(data);
	  });
	  
	  function createAccount(data){
			$.ajax({
	            url: '${createAccountAPI}',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            success: function (result) {
	            	window.location.href = "${loginURL}?registerSuccess";
	            },
	            error: function (error) {
	            	alert("Đã có lỗi: "+error.responseText);
	            }
	        });
		}
	  

	  	
	  </script>
  </body>
</html>