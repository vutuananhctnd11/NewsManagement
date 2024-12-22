<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@ page import="com.laptrinhjavaweb.util.SecurityUtils" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<head>
  	<meta charset="UTF-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300..700&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Roboto Condensed', sans-serif;
    }
    #piechart-placeholder {
      width: 100%;
      max-width: 400px;
      margin: 0 auto;
    }
    .navbar-buttons .nav > li > a {
    background-color: transparent;
    border: none;
    color: white;    
    border: none;
	}
  </style>
</head>

<div id="navbar" class="navbar navbar-default ace-save-state" style="background-image: url(https://i.pinimg.com/736x/c2/e9/02/c2e902e031e1d9d932411dd0b8ab5eef.jpg)">
    <div class="navbar-container ace-save-state" id="navbar-container">
        <div class="navbar-header pull-left">
            <a href="#" class="navbar-brand">
                <small style="font-size: 24px;">
                    <i class="fa-solid fa-newspaper"></i>
                     Hệ thống quản lý website tin tức
                </small>
            </a>
        </div>
        <div class="navbar-buttons navbar-header pull-right collapse navbar-collapse" role="navigation">
            <ul class="nav ace-nav">
                <li>
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle" style="font-size: 14px;">
                        Xin chào <%= SecurityUtils.getPrincipal().getFullName() %> !
                    </a>
                    <li>
                        <a href='<c:url value='/thoat'/>'  style="font-size: 14px;">
                            <i class="ace-icon fa fa-power-off"></i>
                            Đăng xuất
                        </a>
                    </li>
                </li>
            </ul>
        </div>
    </div>
</div>