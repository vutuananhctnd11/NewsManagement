<%@include file="/common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <title>Trang chủ</title> -->
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs ace-save-state" id="breadcrumbs">
            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Trang chủ</a>
                </li>
            </ul><!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row" >
                <div class="col-xs-12">
					<div class="row">
									<div class="space-6"></div>

									<div class="col-sm-7 infobox-container">
										<div class="infobox infobox-green" style="height: 100px;">
											<div class="infobox-icon" style="height: 50px;width: 50px;">
												<i class="ace-icon fa fa-comments"></i>
											</div>

											<div class="infobox-data">
												<div style="font-size: 30px;margin-top: 10px;">${totalCmt}</div>
											</div>
											<div style="font-size: 18px;">Tổng số bình luận</div>

											<div class="stat stat-success">8%</div>
										</div>

										<div class="infobox infobox-blue" style="height: 100px;">
											<div class="infobox-icon" style="height: 50px;width: 50px;">
												<i class="ace-icon fa fa-user"></i>
											</div>
											<div class="infobox-data">
												<div style="font-size: 30px;margin-top: 10px;">${totalUser}</div>
											</div>
											<div style="font-size: 18px;">Tổng số người dùng</div>

											<div class="stat stat-success">12%</div>
										</div>

										<div class="infobox infobox-pink" style="height: 100px;">
											<div class="infobox-icon" style="height: 50px;width: 50px;">
												<i class="ace-icon fa-solid fa-user-tie"></i>
											</div>
											<div class="infobox-data">
												<div style="font-size: 30px;margin-top: 10px;">${totalEditor}</div>
											</div>
											<div style="font-size: 18px;">Tổng số biên tâp viên</div>
											<div class="stat stat-important">4%</div>
										</div>

										<div class="infobox infobox-red" style="height: 100px;">
											<div class="infobox-icon" style="height: 50px;width: 50px;">
												<i class="ace-icon fa-regular fa-newspaper"></i>
											</div>

											<div class="infobox-data">
												<div style="font-size: 30px;margin-top: 10px;">${totalNews}</div>
											</div>
											<div style="font-size: 18px;">Tổng số bài viết</div>
										</div>
										
										<div class="infobox infobox-orange2" style="height: 100px;">
											<div class="infobox-icon" style="height: 50px;width: 50px;">
												<i class="ace-icon fa-solid fa-list"></i>
											</div>

											<div class="infobox-data">
												<div style="font-size: 30px;margin-top: 10px;">${totalCategory}</div>
											</div>
											<div style="font-size: 18px;">Tổng số Danh mục</div>
										</div>

										<div class="space-6"></div>
										
										<div class="infobox infobox-black" style="height: 200px; width: 90%;">
											<p style="font-size: 18px; margin: 0;">Bài viết mới nhất </p>
											<div style="display: flex;">
												<img src="<c:url value='/${news.thumbnail}'/> " height="150" style="margin-right: 10px;"/>
												<div>
													<p style="font-size: 18px; font-weight: bold;"> ${news.title} </p>
													<p style="font-size: 16px; margin: 0;"> ${news.shortDescription} </p>
												</div>
											</div>
										</div>
									</div>
									
									

									<div class="vspace-12-sm"></div>

									<div class="col-sm-5">
										<div class="widget-box">
											<div class="widget-header widget-header-flat">
												<h4>
													<i class="ace-icon fa fa-signal"></i>
													Lưu lượng truy cập
												</h4>
											</div>

											<div class="widget-body">
												<div class="widget-main">
													<div id="piechart-placeholder"></div>

													<div class="hr hr8 hr-double"></div>

													<div class="clearfix">
														<div class="grid3">
															<span class="grey">
																<i class="fa-brands fa-facebook fa-2x blue"></i>
																&nbsp; Fb
															</span>
															<h4 class="bigger pull-right">1,255</h4>
														</div>

														<div class="grid3">
															<span class="grey">
																<i class="fa-solid fa-globe fa-2x green"></i>
																&nbsp; Web
															</span>
															<h4 class="bigger pull-right">2,645</h4>
														</div>

														<div class="grid3">
															<span class="grey">
																<i class="fa-brands fa-instagram fa-2x red"></i>
																&nbsp; Insta
															</span>
															<h4 class="bigger pull-right">648</h4>
														</div>
													</div>
												</div><!-- /.widget-main -->
											</div><!-- /.widget-body -->
										</div><!-- /.widget-box -->
									</div><!-- /.col -->
								</div><!-- /.row -->
                </div>
            </div>
        </div>
    </div>
</div><!-- /.main-content -->

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  // Load Google Charts
  google.charts.load('current', {'packages':['corechart']});

  // Draw the chart when the Google Charts library is loaded
  google.charts.setOnLoadCallback(drawChart);

  function drawChart() {
    // Data for the chart
    var data = google.visualization.arrayToDataTable([
      ['Source', 'Visits'],
      ['Facebook', 1255],
      ['Website', 2645],
      ['Instagram', 648]
    ]);

    // Chart options
    var options = {
      pieHole: 0.4, // If you want a donut chart
      colors: ['#3366FF', '#66CC66', '#E95950'],
      height: 280
    };

    // Render the chart inside the div
    var chart = new google.visualization.PieChart(document.getElementById('piechart-placeholder'));
    chart.draw(data, options);
  }
</script>

</body>
</html>