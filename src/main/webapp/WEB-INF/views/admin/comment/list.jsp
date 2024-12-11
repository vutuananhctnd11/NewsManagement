<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:url var="commentURL" value="/quantri/binhluan/baiviet"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Danh sách bài viết</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value = '/quantri/binhluan/baiviet'/>" id="formSubmit" method="get">

			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Trang chủ</a></li>
						<li><a href="#">Theo dõi bình luận</a></li>
					</ul>
					<!-- /.breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<div class="widget-box table-filter">
								<div class="table-btn-controls">
								</div>
							</div>
							<br/><br/>
							<div class="row">
								<div class="col-xs-12">
									<div class="table-responsive">
										<table class="table table-bordered" id="dataTable">
											<thead>
												<tr>
													<th style="text-align: center; font-size: 16px;">STT</th>
													<th style="text-align: center; font-size: 16px;">Tên bài viết</th>
													<th style="text-align: center; font-size: 16px;">Thể loại  </th>
													<th style="text-align: center; font-size: 16px;">Tổng số bình luận</th>
													<th style="text-align: center; font-size: 16px;">Thao tác</th>
													
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${model.listResult}">
													<tr style="font-size: 16px;">
														<td style="text-align: center;width:35px;"></td>
														<td>${item.title}</td>
														<td>
															<c:forEach var="entry" items="${categories}">
																<c:if test="${entry.key eq item.categoryCode}">${entry.value}</c:if>
															</c:forEach>
														</td>
														<td style="text-align: center;">
															<c:forEach var="total" items="${totalComment}" >
																<c:if test="${total.key eq item.id}">${total.value}</c:if>
															</c:forEach>
														</td>
														<td style="display: flex; justify-content: center;">
															<c:url var="listCommentURL" value="/quantri/binhluan/chitiet">
																<c:param name="newsid" value="${item.id}"></c:param>
																<c:param name="page" value="1"></c:param>
																<c:param name="limit" value="${model.limit}"></c:param>
															</c:url>
															<a class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip" title="Xem bình luận" 
																href='${listCommentURL}'>
																<i class="fa-regular fa-eye"></i> 
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
		var page = ${model.page};
		var limit = ${model.limit};
		$(document).ready(function () {
	        $("#dataTable tbody tr").each(function (index) {
	            $(this).find("td:first").text( (page-1)*limit + index + 1);
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