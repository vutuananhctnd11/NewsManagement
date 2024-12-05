<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@ page import="com.laptrinhjavaweb.util.SecurityUtils" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style>
	.navbar-buttons .nav > li > a {
    background-color: transparent;
    border: none;
    color: white;    
    border: none;
	}
</style>

<div id="navbar" class="navbar navbar-default ace-save-state" style="background-image: url(https://i.pinimg.com/736x/c2/e9/02/c2e902e031e1d9d932411dd0b8ab5eef.jpg)">
    <div class="navbar-container ace-save-state" id="navbar-container">
        <div class="navbar-header pull-left">
            <a href="#" class="navbar-brand">
                <small>
                    <i class="fa fa-leaf"></i>
                     Hệ thống quản lý website tin tức
                </small>
            </a>
        </div>
        <div class="navbar-buttons navbar-header pull-right collapse navbar-collapse" role="navigation">
            <ul class="nav ace-nav">
                <li>
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        Xin chào <%= SecurityUtils.getPrincipal().getFullName() %> !
                    </a>
                    <li>
                        <a href='<c:url value='/thoat'/>'>
                            <i class="ace-icon fa fa-power-off"></i>
                            Đăng xuất
                        </a>
                    </li>
                </li>
            </ul>
        </div>
    </div>
</div>