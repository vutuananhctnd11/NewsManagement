<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="commentAPI" value="/api/comment"/>
<c:url var="listAccountURL" value="/quantri/taikhoan/dahsach"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Danh sách tài khoản</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value = '/quantri/binhluan/chitiet'/>" id="formSubmit" method="get">

			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="<c:url value = '/quantri/trangchu'/>">Trang chủ</a></li>
						<li><a href="<c:url value = '/quantri/binhluan/baiviet?page=1&limit=5'/>">Quản lý tài khoản</a></li>
						<li><a href="#">Danh sách tài khoản</a></li>
					</ul>
					<!-- /.breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div class="widget-box table-filter">
								<div class="table-btn-controls">
									<div class="pull-right tableTools-container" style="display: flex;">
									
										<div class="dt-buttons btn-overlap btn-group" style="display: flex;">
										<c:url var="createNewsURL" value="#"/>
											<a flag="info" class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Thêm bình luận' >
												<span>
													<i class="fa fa-plus-circle bigger-110 purple"></i>
												</span>
											</a>
											<button id="btnDelete" type="button" 
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Xóa nhiều bình luận'>
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
										<table class="table table-bordered" id="dataTable">
											<thead>
												<tr>
													<th><input type="checkbox" id="checkAll"></th>
													<th style="text-align: center; font-size: 16px;">STT</th>
													<th style="text-align: center; font-size: 16px;">Tên đăng nhập</th>
													<th style="text-align: center; font-size: 16px;">Họ và tên</th>
													<th style="text-align: center; font-size: 16px;">Vai trò</th>
													<th style="text-align: center; font-size: 16px;">Trạng thái</th>
													<th style="text-align: center; font-size: 16px;">Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">
													<tr style="font-size: 16px;">
														<td style="width: 30px;"><input type="checkbox" class="checkbox" id="checkbox_${item.id}" value="${item.id}" > </td>
														<td style="text-align: center;width: 35px;"></td>
														<td style="text-align: center;">${item.userName}</td>
														<td style="text-align: center;">${item.fullName}</td>
														<td style="text-align: center;">${item.roleName}</td>
														<td style="text-align: center;">
															<c:if test="${item.status == 1}">Hoạt động</c:if>
															<c:if test="${item.status == 0}">Bị khóa</c:if>
														</td>
														<td style="display: flex; justify-content: center;">
														<c:url var="accountDetailURL" value="/quantri/taikhoan/danhsach/chitiet">
																<c:param name="userid" value="${item.id}"></c:param>
															</c:url>
															<a class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip" title="Xem chi tiết" 
																href='${accountDetailURL}'>
																<i class="fa-regular fa-eye"></i> 
															</a>
															<a class="btn btn-sm btn-primary btn-delete" data-toggle="tooltip" title="Khóa tài khoản" 
																data-id="${item.id}" style="margin-left: 20px;">
																<i class="fas fa-lock"></i> 
															</a>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<div style="align-items: center; display: flex;position:absolute; bottom: -45px;left: 50%; transform: translateX(-50%);">
										<ul class="pagination" id="pagination"></ul>
										<select class="form-control"  style="width: auto; ; margin-left: 5px" id="chooseLimit" onchange="getChooseLimit()">
											<option value="5">5/Trang</option>
											<option value="4">4/Trang</option>
											<option value="3">3/Trang</option>
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
	
	var page = ${model.page};
	var limit = ${model.limit};
	
	var currentURL = new URLSearchParams(window.location.search);
    const newsId = currentURL.get("newsid");
    
    //hàm chọn số lượng bản ghi hiển thị
    function getChooseLimit() {
        var value = $('#chooseLimit').val();
        var page = ${model.page}; 
        window.location.href = "${commentURL}?page="+page+"&limit="+value;
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
    
    //hàm config checkbox
    $(document).ready(function() {
	    $('#checkAll').on('change', function() {
	        if ($(this).prop('checked')) {
	            $('.checkbox').prop('checked', true);
	        } else {
	            $('.checkbox').prop('checked', false);
	        }
	    });
	    
	    //hiển thị STT
	    $("#dataTable tbody tr").each(function (index) {
            $(this).find("td:eq(1)").text( (page-1)*limit + index + 1);
        });
	});
	    
    
	//hàm quản lý phân trang
	$(function() {
		var currentPage = ${model.page};
		var totalPage = ${model.totalPage};
		var limit = ${model.limit};
		//var totalItem = ${model.totalItem};
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
        
        
        
	</script>
</body>

</html>