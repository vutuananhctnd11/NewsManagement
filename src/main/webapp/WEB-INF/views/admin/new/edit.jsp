<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="newsURL" value="/quantri/baiviet/danhsach"/>
<c:url var="newsAPI" value="/api/news"/>
<c:url var="editNewsURL" value="/quantri/baiviet/chinhsua"/>
<html>
<head>
<title>Chỉnh sửa bài viết</title>
<!-- CKeditor -->
	<script src="<c:url value='/template/ckeditor/ckeditor.js'/>"></script>
</head>
<body>
	<div class="main-content">
		<div class="main-content-inner">
			<div class="breadcrumbs" id="breadcrumbs">
				<script type="text/javascript">
					try {
						ace.settings.check('breadcrumbs', 'fixed')
					} catch (e) {
					}
				</script>
	
				<ul class="breadcrumb">
					<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Trang chủ</a>
					</li>
	
					<li><a href="#">Quản lý bài viết</a></li>
					<li class="active">Thêm bài viết mới</li>
				</ul>
				<!-- /.breadcrumb -->
			</div>
			
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
						<c:if test="${not empty message }">
							<div class="alert alert-${alert}">	
								${message}
							</div>
						</c:if>
						
						
						<form:form class="form-horizontal" role="form" id="formSubmit" modelAttribute="model">
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="categoryCode">Thể loại:</label>
								<div class="col-sm-9">
									<%--  <select class="form-control" id="categoryCode" name="categoryCode">
								    <option value="">chọn thể loại bài viết</option>
								    <c:forEach var="" items="${categories}">
								    	<option value="${item.code}">${item.name}</option>
								    </c:forEach>
									</select>  --%> 
									<form:select path="categoryCode" id="categoryCode">
										<form:option value="" label="-- Chọn thể loại --"></form:option>
										<form:options items="${categories}"/>
									</form:select>
								</div>
								
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Tên bài viết </label>
								<div class="col-sm-9">
									<%-- <input type="text" placeholder="Nhập tên bài viết" class="col-xs-10 col-sm-5" id="title" name="title" value="${model.title}"/> --%>
									<form:input path="title" cssClass="col-xs-10 col-sm-5"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> Ảnh đại diện </label>
								<div class="col-sm-9">
									<input type="file" class="col-xs-10 col-sm-5" id="thumbnail" name="thumbnail" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="shortDescription" >Mô tả ngắn:</label>
								<div class="col-sm-9">
									<!-- HTML thuần -->
									<%-- <textarea class="form-control" rows="5" cols="10" id="shortDescription" name="shortDescription" value="${model.shortDescription}"></textarea> --%>
									<!-- Sử dụng spring form -->
									<form:textarea path="shortDescription" rows="5" cols="10" id="shortDescription" cssClass="form-control"/>
								</div>
								
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right" for="content">Nội dung:</label>
								<div class="col-sm-9">
									<%-- <textarea class="form-control" rows="5" cols="10" id="content" name="content" value="${model.content}"></textarea> --%>
									<form:textarea path="content" rows="5" cols="10" id="content" cssClass="form-control"/>
								</div>
								
							</div>
							<form:hidden path="id" id="newsId"/>
							<div class="clearfix form-actions">
								<div class="col-md-offset-3 col-md-9">
									<c:if test="${not empty model.id}">
										<button class="btn btn-info" type="button" id="btnAddOrUpdateNews">
											<i class="ace-icon fa fa-check bigger-110"></i>
											Cập nhật bài viết
										</button>
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										<button class="btn" type="reset">
											<i class="ace-icon fa fa-undo bigger-110"></i>
											Hủy chỉnh sửa
										</button>
									</c:if>
									<c:if test="${empty model.id}">
										<button class="btn btn-info" type="button" id="btnAddOrUpdateNews">
											<i class="ace-icon fa fa-check bigger-110"></i>
											Thêm bài viết
										</button>
										&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										<button class="btn" type="reset">
											<i class="ace-icon fa fa-undo bigger-110"></i>
											Hủy
										</button>
									</c:if>

									
								</div>
							</div>
							
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	$(document).ready(function(){
		CKEDITOR.replace('content');
	});
		
		$('#btnAddOrUpdateNews').click(function (e) {
		    e.preventDefault();
		    
		    //synchronous data from ckeditor to text area
		    for (let instance in CKEDITOR.instances) {
		        CKEDITOR.instances[instance].updateElement();
		    }
			
			var editorContent = CKEDITOR.instances['content'].getData();
		    

			// validate data
		    if ($('#categoryCode').val() == "") {
		    	alert("Chưa chọn thể loại bài viết");
		    	return;
		    }
		    if ($('#title').val() == "") {
		    	alert("Chưa điền tiêu đề bài viết");
		    	return;
		    }
		    if ($('#shortDescription').val() == "") {
		    	alert("Chưa điền mô tả ngắn của bài viết");
		    	return;
		    }
		    if ($('#content').val() == "") {
		    	alert("Chưa điền nội dung bài viết");
		    	return;
		    }
			
			//put data to excute
		    var data = {};
		    var formData = $('#formSubmit').serializeArray();
		    $.each(formData, function(i,v) {
		    	data[""+v.name+""] = v.value;
		    });
		    var id = $('#newsId').val();
		    if(id == ""){
		    	addNews(data);
		    } else {
		    	updateNews(data);
		    }
		    
		    
		});
		
		function addNews(data){
			$.ajax({
	            url: '${newsAPI}',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            dataType: 'json',
	            success: function (result) {
	            	window.location.href = "${editNewsURL}?id="+result.id+"&message=insert_success";
	            },
	            error: function (error) {
	            	window.location.href = "${newsURL}?page=1&limit=5&message=error_system";
	            }
	        });
		}
		function updateNews(data){
			$.ajax({
	            url: '${newsAPI}',
	            type: 'PUT',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            dataType: 'json',
	            success: function (result) {
	            	window.location.href = "${editNewsURL}?id="+result.id+"&message=update_success";
	            },
	            error: function (error) {
	            	window.location.href = "${editNewsURL}?id="+result.id+"&message=error_system";
	            }
	        });		
		}
	</script>
</body>
</html>
