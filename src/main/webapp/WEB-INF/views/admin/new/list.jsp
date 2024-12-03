<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="newsAPI" value="/api/news"/>
<c:url var="newsURL" value="/quantri/baiviet/danhsach"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Danh sách bài viết</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value = '/quantri/baiviet/danhsach'/>" id="formSubmit" method="get">

			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Trang chủ</a></li>
						<li><a href="#">Danh sách bài viết</a></li>
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
							<div class="widget-box table-filter">
								<div class="table-btn-controls">
									<div class="pull-right tableTools-container" style="display: flex;">
									
										<div class="dt-buttons btn-overlap btn-group" style="display: flex;">
										<c:url var="createNewsURL" value="/quantri/baiviet/chinhsua"/>
											<a flag="info" class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Thêm bài viết' href='${createNewsURL}'> 
												<span>
													<i class="fa fa-plus-circle bigger-110 purple"></i>
												</span>
											</a>
											<button id="btnDelete" type="button" onclick="warningBeforeDelete()"
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Xóa bài viết'>
												<span> <i class="fa-solid fa-trash" style="color: red;"></i>
												</span>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="table-responsive">
										<table class="table table-bordered">
											<thead>
												<tr>
												<th><input type="checkbox" id="checkAll"></th>
													<th style="text-align: center; font-size: 16px;">Tên bài viết</th>
													<th style="text-align: center; font-size: 16px;width: 8%;">Thể loại  </th>
													<th style="text-align: center; font-size: 16px;">Mô tả ngắn</th>
													<th style="text-align: center; font-size: 16px;">Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">
													<tr style="font-size: 16px;">
													<td><input type="checkbox" class="checkbox" id="checkbox_${item.id}" value="${item.id}" > </td>
														<td>${item.title}</td>
														<td>
															<c:forEach var="entry" items="${categories}">
																<c:if test="${entry.key eq item.categoryCode}">${entry.value}</c:if>
															</c:forEach>
														</td>
														<td>${item.shortDescription}</td>
														<td style="display: flex;">
															<c:url var="updateNewsURL" value="/quantri/baiviet/chinhsua">
																<c:param name="id" value="${item.id}"></c:param>
															</c:url>
															<a class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip" title="Cập nhật bài viết" 
																href='${updateNewsURL}'>
																<i class="fa-solid fa-pen-to-square" aria-hidden="true"></i> 
															</a>
															<a class="btn btn-sm btn-primary btn-delete" data-toggle="tooltip" title="Xóa bài viết" 
																style="margin-left: 10px;"  href='#'>
																<i class="fa-solid fa-trash" style="color: white;"></i>
															</a>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<div style="align-items: center; display: flex;position:absolute; bottom: -45px;left: 50%; transform: translateX(-50%);">
										<ul class="pagination" id="pagination"></ul>
										<select class="form-control"  style="width: auto; ; margin-left: 5px" id="chooseLimit" onchange="getChooseLimit()">
											<option value="5">5 bài/Trang</option>
											<option value="4">4 bài/Trang</option>
											<option value="3">3 bài/Trang</option>
										</select>
										</div>
										<input type="hidden" value="" id="page" name="page"/>
										<input type="hidden" value="" id="limit" name="limit"/>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- /.main-content -->
	<script>
	//hàm config checkbox
    $(document).ready(function() {
	    $('#checkAll').on('change', function() {
	        if ($(this).prop('checked')) {
	            $('.checkbox').prop('checked', true);
	        } else {
	            $('.checkbox').prop('checked', false);
	        }
	    });
	});
	
	
		$(function() {
			var currentPage = ${model.page};
			var totalPage = ${model.totalPage};
			var limit = ${model.limit}; 
			window.pagObj = $('#pagination').twbsPagination({
				totalPages : totalPage || 1,
				visiblePages : 6,
				startPage: currentPage,
				onPageClick : function(event, page) {
					if (currentPage != page){
						$('#page').val(page);
						$('#limit').val(limit);
						$('#formSubmit').submit();
						
					}
				}
			});
		});
		function getChooseLimit() {
            var value = $('#chooseLimit').val();
            var page = ${model.page};
            window.location.href = "${newsURL}?page="+page+"&limit="+value;
        }
		function setSelectFromURL() {
            const currentURL = new URLSearchParams(window.location.search);
            const limit = currentURL.get("limit");
            if (limit) {
                const selectElement = document.getElementById("chooseLimit");
                selectElement.value = limit;
            }
        }
        window.onload = setSelectFromURL;
        
        
        function warningBeforeDelete(){
        	swal({
        		title: "Bạn có chắc chắn muốn xóa?",
        		text: "Lưu ý xóa sẽ không thể khôi phục lại !",
        		type: "warning",
        		showCancelButton: true,
        		confirmButtonClass: "btn-success",
        		confirmButtonText: "Xác nhận",
        		cancelButtonText: "Hủy",
        		closeOnConfirm: false,
        		closeOnCancel: false
        	}).then(function(isConfirm) {
        		if (isConfirm) {
        			var ids = $('tbody input[type=checkbox]:checked').map(function(){
        				return $(this).val();
        			}).get();
        			deleteNews(ids);
        			swal("Đã xóa!", "Dữ liệu của bạn đã được xóa.", "success");
        		  }
        		});
        }
        function deleteNews(data){
			$.ajax({
	            url: '${newsAPI}',
	            type: 'DELETE',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            success: function (result) {
	            	swal("", "Dữ liệu của bạn đã được xóa.", "success").then(function(result){
	            		window.location.href = "${newsURL}?page=1&limit=5&message=delete_success";
	            	});
	            },
	            error: function (error) {
	            	window.location.href = "${newsURL}?page=1&limit=5&message=error_system";
	            }
	        });
		}
	</script>
</body>

</html>