<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="sidebar" class="sidebar responsive ace-save-state" >
    <script type="text/javascript">
        try{ace.settings.loadState('sidebar')}catch(e){}
    </script>
    <ul class="nav nav-list">
    	<li class="active">
			<a href="<c:url value='/quantri/trangchu'/>">
               	<i class="fa-solid fa-house" style="margin: 0px 5px; font-size: 16px;"></i>
                   Trang chủ
            </a>
		</li>
        <li >
            <a href="#" class="dropdown-toggle">
                <i class="fa-regular fa-newspaper" style="margin: 0px 5px; font-size: 18px;"></i>
                <span class="menu-text">Quản lý bài viết</span>  
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li>
                    <a href="<c:url value='/quantri/baiviet/danhsach?page=1&limit=5'/>">
                        <i class="fa-solid fa-list" style="margin: 0px 5px;"></i>
                        Danh sách bài viết
                    </a>
                    <b class="arrow"></b>
                </li>
                <li>
                    <a href="<c:url value='/quantri/baiviet/chinhsua'/>">
                    	<i class="fa-solid fa-square-plus" style="margin: 0px 5px;"></i>
                        Thêm bài viết mới
                    </a>
                    <b class="arrow"></b>
                </li>
            </ul>
        </li>
        	
        <li class="">
			<a href="<c:url value='/quantri/danhmuc/danhsach?page=1&limit=5'/>">
				<i class="menu-icon fa fa-list-alt"></i>
				<span class="menu-text"> Quản lý danh mục </span>
			</a>

			<b class="arrow"></b>
		</li>
		<li >
            <a href="#" class="dropdown-toggle">
                <i class="fa-regular fa-user" style="margin: 0px 5px; font-size: 18px;"></i>
                <span class="menu-text">Quản lý tài khoản</span>  
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li>
                    <a href="<c:url value='/quantri/taikhoan/thongtin'/>">
                    <i class="fa-solid fa-user" style="margin: 0px 5px;"></i>

                        Thông tin tài khoản
                    </a>
                    <b class="arrow"></b>
                </li>
                <li>
                    <a href="<c:url value='/quantri/taikhoan/danhsach?page=1&limit=5'/>">
                    	<i class="fa-solid fa-list-ul" style="margin: 0px 5px;"></i>
                        Danh sách tài khoản
                    </a>
                    <b class="arrow"></b>
                </li>
                <li>
                    <a href="<c:url value='/quantri/taikhoan/taomoi'/>">
                    	<i class="fa-solid fa-square-plus" style="margin: 0px 5px;"></i>
                        Thêm tài khoản
                    </a>
                    <b class="arrow"></b>
                </li>
            </ul>
        </li>
        <li class="">
			<a href="<c:url value='/quantri/binhluan/baiviet?page=1&limit=5'/>">
				<i class="fa-regular fa-comment"  style="margin: 0px 5px; font-size: 18px;"></i>
				<span class="menu-text"> Theo dõi bình luận </span>
			</a>

			<b class="arrow"></b>
		</li>
    </ul>
    <div class="sidebar-toggle sidebar-collapse">
        <i class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
    </div>
</div>