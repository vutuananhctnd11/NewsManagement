<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="commentURL" value="/quantri/binhluan/danhsach"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Danh sách bài viết</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value = '/quantri/binhluan/danhsach'/>" id="formSubmit" method="get">

			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Trang chủ</a></li>
						<li><a href="#">Danh sách bình luận</a></li>
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
										<c:url var="createNewsURL" value="/quantri/baiviet/chinhsua"/>
											<a flag="info" class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Thêm bài viết' href='${createNewsURL}'> 
												<span>
													<i class="fa fa-plus-circle bigger-110 purple"></i>
												</span>
											</a>
											<button id="btnDelete" type="button" 
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
										<table class="table table-bordered" style="align-items: center;">
											<thead>
												<tr>
													<th style="text-align: center; font-size: 16px;">Tên bài viết</th>
													<th style="text-align: center; font-size: 16px;">Thể loại  </th>
													<th style="text-align: center; font-size: 16px;">Tổng số bình luận</th>
													<th style="text-align: center; font-size: 16px;">Thao tác</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">
													<tr style="font-size: 16px;">
														<td>${item.title}</td>
														<td style="text-align: center;">
															<c:forEach var="entry" items="${categories}">
																<c:if test="${entry.key eq item.categoryCode}">${entry.value}</c:if>
															</c:forEach>
														</td>
														<td style="text-align: center;">30</td>
														<td style="display: flex;">
															<c:url var="updateNewsURL" value="/quantri/binhluan/chitiet">
																<c:param name="id" value="${item.id}"></c:param>
															</c:url>
															<a class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip" title="Chi tiết bình luận" 
																href='${updateNewsURL}'>
																<i class="fa-solid fa-pen-to-square" aria-hidden="true"></i> 
															</a>
															<a class="btn btn-sm btn-primary btn-delete" data-toggle="tooltip" title="Xóa bình luận" 
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
		$(function() {
			var currentPage = ${model.page};
			var totalPage = ${model.totalPage};
			var limit = ${model.limit}; 
			window.pagObj = $('#pagination').twbsPagination({
				totalPages : totalPage,
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
        
        
	</script>
</body>

</html>