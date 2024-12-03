<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="commentAPI" value="/api/comment"/>
<c:url var="commentURL" value="/quantri/binhluan/chitiet"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Xem bình luận bài viết</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value = '/quantri/binhluan/chitiet'/>" id="formSubmit" method="get">

			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="<c:url value = '/quantri/trangchu'/>">Trang chủ</a></li>
						<li><a href="<c:url value = '/quantri/binhluan/baiviet?page=1&limit=5'/>">Theo dõi bình luận</a></li>
						<li><a href="#">Xem bình luận bài viết</a></li>
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
												data-toggle="tooltip" title='Thêm bình luận' onclick="add()"> 
												<span>
													<i class="fa fa-plus-circle bigger-110 purple"></i>
												</span>
											</a>
											<button id="btnDelete" type="button" 
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Xóa bình luận'>
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
													<th style="text-align: center; font-size: 16px;">Tên người đăng bình luận</th>
													<th style="text-align: center; font-size: 16px;">Nội dung bình luận</th>
													<th style="text-align: center; font-size: 16px;">Số lượt thích </th>
													<th style="text-align: center; font-size: 16px;">Ngày đăng bình luận</th>
													<th style="text-align: center; font-size: 16px;">Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">
													<tr style="font-size: 16px;">
														<td><input type="checkbox" class="checkbox" id="checkbox_${item.id}" value="${item.id}" > </td>
														<td style="text-align: center;">${item.userName}</td>
														<td>${item.content}</td>
														<td style="text-align: center;">${item.likeComment}</td>
														<td style="text-align: center;">${item.createdDate}</td>
														<td style="display: flex; justify-content: center;">
														<c:url var="listCommentURL" value="/quantri/binhluan/chitiet">
																<c:param name="newsid" value="${model.id}"></c:param>
															</c:url>
															<a class="btn btn-sm btn-primary btn-delete" data-toggle="tooltip" title="Xóa bình luận" 
																data-id="${item.id}">
																<i class="fa-solid fa-trash" aria-hidden="true"></i> 
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
										<input type="hidden" value="${model.newsId}" id="newsid" name="newsid"/>
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
	
	var currentURL = new URLSearchParams(window.location.search);
    const newsId = currentURL.get("newsid");
    
    //hàm chọn số lượng bản ghi hiển thị
    function getChooseLimit() {
        var value = $('#chooseLimit').val();
        var page = ${model.page}; 
        window.location.href = "${commentURL}?newsid="+newsId+"&page="+page+"&limit="+value;
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
        
       
        
        //xóa 1 bình luận
        $(document).on('click', '[data-id]', function() {
        	
    		var id = $(this).data('id'); // Lấy giá trị của thuộc tính data-id
    		var ids = [id];
    		Swal.fire({
        		title: "Bạn có chắc chắn muốn xóa?",
        		text: "Lưu ý xóa sẽ không thể khôi phục lại !",
        		type: "warning",
        		showCancelButton: true,
        		confirmButtonClass: "btn-success",
        		confirmButtonText: "Xác nhận",
        		cancelButtonText: "Hủy",
        		closeOnConfirm: false,
        		closeOnCancel: false
        	}).then(function(result) {
        		if (result.isConfirmed) {
        			deleteComment(ids);
        		  }
        		});
		});
        
        //xóa nhiều bình luận 
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
        			
        		  }
        		});
        }
        
        //gọi api xóa
        function deleteComment(ids){
			$.ajax({
	            url: '${commentAPI}',
	            type: 'DELETE',
	            contentType: 'application/json',
	            data: JSON.stringify(ids),
	            success: function (result) {
	            	swal("", "Dữ liệu của bạn đã được xóa.", "success").then(function(result){
	            		window.location.href = "${commentURL}?newsid="+newsId+"&page=1&limit=5";
	            	});
	            },
	            error: function (error) {
	            	swal("Lỗi hệ thống!", "", "error");
	            }
	        });
		}
        
        
        //tạo cmt
        function add(){
        	swal({
        	    title: 'Nhập thông tin',
        	    text: 'Viết bình luận của bạn:',
        	    input: 'text',
        	    inputPlaceholder: 'Viết nội dung bình luận',
        	    showCancelButton: true,
        	    confirmButtonText: 'Thêm',
        	    cancelButtonText: 'Hủy',
        	    preConfirm: function(inputValue) {
        	        if (!inputValue) {
        	        	alert("Bạn chưa nhập nội dung");

        	        }
        	        return inputValue;
        	    }
        	}).then(function(result) {
        	    if (result.value) {
        	        var inputValue = result.value;
        	        insertComment(newsId, inputValue);
        	        
        	    }
        	});
        }
        
        //thêm bình luận
        function insertComment(newsId, content){
			$.ajax({
	            url: '${commentAPI}',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ newsId : newsId, content : content}),
	            dataType: 'json',
	            success: function (result) {
	            	//location.reload();
	            	swal("", "Đã thêm bình luận của bạn", "success").then(function(result){
	            		window.location.href = "${commentURL}?newsid="+newsId+"&page=1&limit=5";
	            	});
	            },
	            error: function (error) {
	            	swal("Thất bại", "đã sảy ra lỗi không thực hiện được", "error");
	            }
	        });
		}
        
        
	</script>
</body>

</html>