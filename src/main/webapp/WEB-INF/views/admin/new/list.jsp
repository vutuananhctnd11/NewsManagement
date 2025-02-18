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
					<ul class="breadcrumb" style="font-size: 14px;">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="<c:url value='/quantri/trangchu' />">Trang chủ</a></li>
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
							<div class="table-filter">	
								<div class="table-btn-controls">
									<div class="pull-right tableTools-container" style="display: flex; justify-content: space-between;  width: 100%;">
										<div style="width: 60%">
											<label>Tìm kiếm:</label>
											<input type="text" id="searchText" placeholder="Nhập từ khóa" style="width: 60%"/>
											<input type="button" id="searchButton" value="Tìm" class="btn btn-white btn-primary btn-bold" style="width: 10%"/>
											
											<select class="dt-button btn btn-white btn-primary " id="filterCategory" style="height: 100%">
										    <option value="">Lọc theo thể loại</option>
										    <c:forEach var="item" items="${categories}">
										    	<option value="${item.key}">${item.value}</option>
										    </c:forEach>
											</select>
										</div>
									
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
										<table class="table table-bordered" id="dataTable">
											<thead>
												<tr>
													<th><input type="checkbox" id="checkAll"></th>
													<th style="text-align: center; font-size: 16px;width: 35px">STT</th>
													<th style="text-align: center; font-size: 16px;">Tên bài viết</th>
													<th style="text-align: center; font-size: 16px;width: 8%;">Thể loại  </th>
													<th style="text-align: center; font-size: 16px;">Mô tả ngắn</th>
													<th style="text-align: center; font-size: 16px;">Thao tác</th>
												</tr>
											</thead>
											<tbody id="searchResults">
												<c:forEach var="item" items="${model.listResult}">
													<tr style="font-size: 16px;">
													<td><input type="checkbox" class="checkbox" id="checkbox_${item.id}" value="${item.id}" > </td>
													<td style="text-align: center;"></td>
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
															<a class="btn btn-sm btn-primary btn-delete" data-toggle="tooltip" title="Xóa nhiều bài viết" 
																style="margin-left: 10px;"  data-id="${item.id}">
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
											<option value="8">8 bài/Trang</option>
											<option value="10">10 bài/Trang</option>
										</select>
										</div>
										<input type="hidden" value="" id="page" name="page"/>
										<input type="hidden" value="" id="limit" name="limit"/>
										<input type="hidden" value="" id="filterName" name="filter"/>
										<input type="hidden" value="" id="search" name="search"/>
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
	const page = ${model.page};
	const limit = ${model.limit};
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
						const search = $('#searchText').val();
		                const category = $('#filterCategory').val();
		                $('#page').val(page);
		    			$('#limit').val(limit);
		                if (search) {
		                    $('#search').val(search);
		                } else {
		                    $('#search').val('');
		                    $('#search').remove();
		                }
		                if (category) {
		                    $('#filterName').val(category);
		                } else {
		                    $('#filterName').val('');
		                    $('#filterName').remove();
		                }
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
            const filter = currentURL.get("filter");
            const search = currentURL.get("search");
            if (limit) {
                $('#chooseLimit').val(limit);
            }
            if (filter){
            	const filterElement = $('#filterCategory');
                filterElement.val(filter);
            }
            if (search){
            	$('#searchText').val(search);
            }
        }
        window.onload = setSelectFromURL;
        
        
        function warningBeforeDelete(){
        	Swal.fire({
        		title: "Bạn có chắc chắn muốn xóa?",
        		text: "Các bình luận sẽ bị xóa theo và không thể khôi phục lại !",
        		icon: "warning",
        		showCancelButton: true,
        		confirmButtonClass: "btn-success",
        		confirmButtonText: "Xác nhận",
        		cancelButtonText: "Hủy",
        		width: '550px',
        		closeOnConfirm: false,
        		closeOnCancel: false
        	}).then(function(isConfirm) {
        		if (isConfirm) {
        			var ids = $('tbody input[type=checkbox]:checked').map(function(){
        				return $(this).val();
        			}).get();
        			deleteNews(ids);
        		  }
        		});
        }
        
		$(document).on('click', '[data-id]', function() {
        	
    		var id = $(this).data('id'); // Lấy giá trị của thuộc tính data-id
    		var ids = [id];
    		Swal.fire({
        		title: "Bạn có chắc chắn muốn xóa?",
        		text: "Các bình luận sẽ bị xóa theo và không thể khôi phục lại !",
        		icon: "warning",
        		showCancelButton: true,
        		confirmButtonClass: "btn-success",
        		confirmButtonText: "Xác nhận",
        		cancelButtonText: "Hủy",
        		width: '550px',
        		closeOnConfirm: false,
        		closeOnCancel: false
        	}).then(function(result) {
        		if (result.isConfirmed) {
        			deleteNews(ids);
        		  }
        		});
		});
        
        function deleteNews(data){
			$.ajax({
	            url: '${newsAPI}',
	            type: 'DELETE',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            success: function (result) {
	            	Swal.fire("", "Dữ liệu của bạn đã được xóa.", "success").then(function(result){
	            		window.location.href = "${newsURL}?page=1&limit=5";
	            	});
	            },
	            error: function (error) {
	            	window.location.href = "${newsURL}?page=1&limit=5&message=error_system";
	            }
	        });
		}
        
        $(document).ready(function () {
            $('#searchButton').on('click', function () {
                const search = $('#searchText').val();
                const category = $('#filterCategory').val();
                $('#page').val(page);
    			$('#limit').val(limit);
                if (search) {
                    $('#search').val(search);
                } else {
                    $('#search').val('');
                    $('#search').remove();
                }
                if (category) {
                    $('#filterName').val(category);
                } else {
                    $('#filterName').val('');
                    $('#filterName').remove();
                }
                $('#formSubmit').submit();
            });
        });
        
        
            
	</script>
</body>

</html>