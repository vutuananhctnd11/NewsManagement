<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="categoryAPI" value="/api/category"/>
<c:url var="categoryURL" value="/quantri/danhmuc/danhsach"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Danh sách danh mục</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value = '/quantri/binhluan/chitiet'/>" id="formSubmit" method="get">

			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="<c:url value = '/quantri/trangchu'/>">Trang chủ</a></li>
						<li><a href="">Quản lý danh mục</a></li>
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
											<a flag="info" class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Thêm danh mục' id="createCategory"> 
												<span>
													<i class="fa fa-plus-circle bigger-110 purple"></i>
												</span>
											</a>
											<button id="btnDelete" type="button" onclick="multiDelete()"
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Xóa  nhiều danh mục'>
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
													<th style="width:35px;"><input type="checkbox" id="checkAll"></th>
													<th style="text-align: center; font-size: 16px;">STT</th>
													<th style="text-align: center; font-size: 16px;">Mã danh mục</th>
													<th style="text-align: center; font-size: 16px;">Tên danh mục</th>
													<th style="text-align: center; font-size: 16px;">Tổng số bài viết</th>
													<th style="text-align: center; font-size: 16px;">Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">
													<tr style="font-size: 16px;">
														<td><input type="checkbox" class="checkbox" id="checkbox_${item.id}" value="${item.id}" > </td>
														<td style="text-align: center;width:35px;"></td>
														<td style="text-align: center;">${item.code}</td>
														<td style="text-align: center;">${item.name}</td>
														<td style="text-align: center;">
															<c:forEach var="total" items="${totalNews}">
																<c:if test="${total.key eq item.code}">${total.value}</c:if>
															</c:forEach>
														</td>
														<td style="display: flex; justify-content: center;">
															<a class="btn btn-sm btn-primary btn-delete" data-toggle="tooltip" title="Sửa danh mục" 
																data-idUpdate="${item.id}" data-code="${item.code}" data-name="${item.name}">
																<i class="fa-solid fa-pencil"></i> 
															</a>
															<a style="margin-left: 30px;" class="btn btn-sm btn-primary btn-delete" data-toggle="tooltip" title="Xóa danh mục" 
																data-idDelete="${item.id}">
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
	const page = ${model.page};
	const limit = ${model.limit};
    
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
	    
	    //hiển thị stt
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
        
		$('#createCategory').click(function () {
            Swal.fire({
                title: 'Nhập thông tin',
                html:
                    '<input id="code" class="swal2-input" placeholder="Nhập mã danh mục">' +
                    '<input id="name" class="swal2-input" placeholder="Nhập tên danh mục">',
                focusConfirm: false,
                showCancelButton: true,
                confirmButtonText: 'Xác nhận',
                width: '400px',
                preConfirm: () => {
                    const code = $('#code').val();
                    const name = $('#name').val();
                    if (!name || !code) {
                        Swal.showValidationMessage('Cả hai trường đều bắt buộc!');
                        return false;
                    }
                    return { code: code, name: name };
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    const { code, name } = result.value;
                    $.ajax({
        	            url: '${categoryAPI}',
        	            type: 'POST',
        	            contentType: 'application/json',
        	            data: JSON.stringify({
                            code: code,
                            name: name
                        }),
        	            success: function (result) {
        	            	Swal.fire("", "Thêm danh mục thành công.", "success").then(function(result){
        	            		window.location.href = "${categoryURL}?page=1&limit=5";
        	            	});
        	            },
        	            error: function (error) {
        	            	Swal.fire("Lỗi", error.text, "danger"); 
        	            }
        	        });
                }
            });
        });
		
		//sửa
		$(document).on('click', '[data-idUpdate]', function() {
        	
			var id = $(this).attr('data-idUpdate');
			var code = $(this).attr('data-code');
			var name = $(this).attr('data-name');
    		var ids = [id];
    		Swal.fire({
                title: 'Nhập thông tin',
                html:
                    '<input id="code" class="swal2-input" value="'+code+'">' +
                    '<input id="name" class="swal2-input" value="'+name+'">',
                focusConfirm: false,
                showCancelButton: true,
                confirmButtonText: 'Xác nhận',
                width: '400px',
                preConfirm: () => {
                    const code = $('#code').val();
                    const name = $('#name').val();
                    if (!name || !code) {
                        Swal.showValidationMessage('Cả hai trường đều bắt buộc!');
                        return false;
                    }
                    return { code: code, name: name };
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    const { code, name } = result.value;
                    $.ajax({
        	            url: '${categoryAPI}',
        	            type: 'PUT',
        	            contentType: 'application/json',
        	            data: JSON.stringify({
                            code: code,
                            name: name
                        }),
        	            success: function (result) {
        	            	Swal.fire("", "Sửa danh mục thành công.", "success").then(function(result){
        	            		window.location.href = "${categoryURL}?page=1&limit=5";
        	            	});
        	            },
        	            error: function (error) {
        	            	Swal.fire("Lỗi", error.text, "danger"); 
        	            }
        	        });
                }
            });
		});
		
		
		
		//xóa
		$(document).on('click', '[data-idDelete]', function() {
        	
			var id = $(this).attr('data-idDelete');
    		var ids = [id];
    		Swal.fire({
        		title: "Bạn có chắc chắn muốn xóa?",
        		text: "Bài viết,bình luận sẽ bị xóa theo và không thể khôi phục !",
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
        			deleteCategory(ids);
        		  }
        		});
		});
		
		function deleteCategory(ids){
			$.ajax({
	            url: '${categoryAPI}',
	            type: 'DELETE',
	            contentType: 'application/json',
	            data: JSON.stringify(ids),
	            success: function (result) {
	            	Swal.fire("", "Xóa thành công!", "success").then(function(result){
	            		window.location.href = "${categoryURL}?page=1&limit=5";
	            	});
	            },
	            error: function (error) {
	            	Swal.fire("Lỗi", error.text, "danger"); 
	            }
	        });
		}
        
        
	</script>
</body>

</html>