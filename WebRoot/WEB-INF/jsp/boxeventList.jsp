<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>光交箱监控管理系统</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />
		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		

		<!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		

		<!-- fonts -->

		<link rel="stylesheet" href="assets/css/jquery-ui-1.10.3.full.min.css" />
		<link rel="stylesheet" href="assets/css/ui.jqgrid.css" />
		

		<!-- ace styles -->

		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->

		<script src="assets/js/ace-extra.min.js"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
		<script>
			function onKeyDown()
			{
				if ((window.event.ctrlKey)||(window.event.shiftKey))
				{
					event.keyCode=0;
					event.returnValue=false;
				}
			}
		</script>
		
		<script>
			function yxl() { 
				if(window.event.altKey) 
				{
					window.event.returnValue=false;
				}
			}
			function scrollFunc() {
				var e = window.event;
				if (e.button == 0)
				{
					if ($('#rightclick_contextmenu').css('display') == 'block')
					{
						if (e.pageX < g_obj.rightClickPos.pageX || e.pageX > (g_obj.rightClickPos.pageX + 160) || e.pageY < g_obj.rightClickPos.pageY || e.pageY > (g_obj.rightClickPos.pageY + 150))
						{
							$('#rightclick_contextmenu').hide();
						}
					}
				}
			}
			document.onkeydown=yxl;
			document.onMouseDown=scrollFunc;
		</script> 
	</head>

	<body  onkeydown="onKeyDown()" onmousedown="scrollFunc()" oncontextmenu="return false">
		<div class="col-sm-6" id="rightclick_contextmenu" onmouseover="rightMenuMouseOver()" onmouseout="rightMenuMouseOut()" style="display:none; z-index:9999; position: absolute;">
			<ul id="menu">
				<li>
					<a href="javascript:void(0);" onclick="showModules()">光交接箱面板图</a>
				</li>
				<li>
					<a href="javascript:void(0);" onclick="managelock()">智能锁管理</a>
				</li>
				<li>
					<a href="javascript:void(0);">光交接箱端子管理</a>
				</li>

				<li>
					<a href="javascript:void(0);" onclick="jumpTerminal()">跳纤管理</a>
				</li>

				<li>
					<a href="javascript:void(0);" onclick="coreToTerminal()">纤芯关联</a>
				</li>

				<li>
					<a href="javascript:void(0);">端子直熔</a>
				</li>
				
			</ul>
		</div><!-- ./span -->

		<div class="navbar navbar-default" id="navbar">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand"> <small> <img src="assets/images/logo-Small.png" /> 光交箱监控管理系统 </small> </a>
					<!-- /.brand -->
				</div>
				<!-- /.navbar-header -->

				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="light-blue">
							<a data-toggle="dropdown" href="#" class="dropdown-toggle"> <img
									class="nav-user-photo" src="assets/avatars/avatar2.png"
									alt="用户头像" /> <span class="user-info"> <small>欢迎光临,</small>
									${sessionScope.user_name} </span> <i class="icon-caret-down"></i>
							</a>
							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">

								<li>
									<a href="preUpdateUser?id=${sessionScope.user.id}"><i
										class="icon-user"></i>个人资料修改</a>
								</li>
								<li class="divider"></li>
								<li>
									<a href="logout"> <i class="icon-off"></i> 退出 </a>
								</li>
							</ul>
						</li>
					</ul>
					<!-- /.ace-nav -->
				</div>
				<!-- /.navbar-header -->
			</div>
			<!-- /.container -->
		</div>

		<div class="main-container" id="main-container" style="background-color: white">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
				function dyniframesize(down) { 
					setTimeout("javascript:window.frames['menu'].initmenu(1, 4);", 1);
					
				}
			</script>

			<div class="main-container-inner" style="background-color: #f2f2f2">
				<a class="menu-toggler" id="menu-toggler" href="#"> <span
					class="menu-text"></span> </a>
				<div class="sidebar" id="sidebar" style="background-color: #f2f2f2">
					<iframe id="menu" width="190px" height="480px"  style="background-color: #f2f2f2" frameborder="0" scrolling="no" onload="dyniframesize('menu')" src="menutemplate.jsp"></iframe>
				</div>

				<div class="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<script type="text/javascript">
							try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
						</script>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="#">首页</a>
							</li>
							<li>
								<a href="#">安全管控</a>
							</li>
							<li class="active">开关门记录</li>
						</ul>
						<!-- .breadcrumb -->
					</div>
					<div class="page-content">
						<div class="page-header">
							<h1>
								安全管控
								<small>
									<i class="icon-double-angle-right"></i>
									开关门记录
								</small>
							</h1>
						</div><!-- /.page-header -->

						<div class="row">
							<div class="col-xs-12">
								<!-- PAGE CONTENT BEGINS -->
								<div class="well well-sm">
									控制器ID：<input id="f_s_controller_id" type="text" placeholder="控制器ID"/> 
									<a class="green" href="javascript:void(0);" onclick="fastsearch()" title="快速检索"><i class="icon-search bigger-130"></i></a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<button onclick="detailsearch()" class="btn btn-xs btn-success">
										高级检索
										<i class="icon-zoom-in icon-on-right"></i>
									</button>
									<button onclick="resetsearch()" class="btn btn-xs btn-success">
										重置检索
										<i class="icon-refresh icon-on-right"></i>
									</button>
								</div>
								
							 	<div id="manage_grant_warn" class="alert alert-danger" style="display:none;">
									<i class="icon-hand-right"></i>
									<label id="manage_grant_warn_label"></label>
									<button class="close" data-dismiss="alert">
										<i class="icon-remove"></i>
									</button>
								</div>
								<table id="manage-grant-grid-table"></table>
				
								<div id="manage-grant-grid-pager"></div>
								 	
								<script type="text/javascript">
									var $path_base = "/";//this will be used in gritter alerts containing images
								</script>

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
						
					</div><!-- /.page-content -->
				</div>
				<!-- /.row -->
			</div>
		</div>
		<!-- /.main-content -->
		<!-- /.main-container-inner -->
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="icon-double-angle-up icon-only bigger-110"></i> </a>
		<!-- /.main-container -->
		<div id="dialog-view-door" class="hide">
			<div style="padding:10px 50px 20px 50px">
				<form>
					<table width="100%" height="auto">
						<tr>
							<td>控制器ID：</td>
							<td><input type="text" readonly="readonly" id="controller_id" value=""/></td>
						</tr>
						<tr>
							<td>光交箱地址：</td>
							<td><input type="text" readonly="readonly" id="address" value=""/></td>
						</tr>
						<tr>
							<td>所属部门：</td>
							<td><input type="text" readonly="readonly" id="department" value=""/></td>
						</tr>
						<tr>
							<td>开门时间：</td>
							<td><input type="text" readonly="readonly" id="open_time" value=""/></td>
						</tr>
						<tr>
							<td>开门钥匙：</td>
							<td><input type="text" readonly="readonly" id="open_keys" value=""/></td>
						</tr>
						<tr>
							<td>开门人员：</td>
							<td><input type="text" readonly="readonly" id="open_operators" value=""/></td>
						</tr>
						<tr>
							<td>开门RFID：</td>
							<td><input type="text" readonly="readonly" id="open_rfids" value=""/></td>
						</tr>
						<tr>
							<td>关门时间：</td>
							<td><input type="text" readonly="readonly" id="close_time" value=""/></td>
						</tr>
						<tr>
							<td>关门钥匙：</td>
							<td><input type="text" readonly="readonly" id="close_keys" value=""/></td>
						</tr>
						<tr>
							<td>关门人员：</td>
							<td><input type="text" readonly="readonly" id="close_operators" value=""/></td>
						</tr>
						<tr>
							<td>关门RFID：</td>
							<td><input type="text" readonly="readonly" id="close_rfids" value=""/></td>
						</tr>
						<tr>
							<td>备注：</td>
							<td><textarea rows="5" cols="40" disabled="disabled" id="remarks"></textarea></td>
						</tr>
					</table>
				</form>
			</div>
		</div><!-- #dialog-view-door -->
		
		<div id="dialog-search-door" class="hide">
			<div style="padding:10px 50px 20px 50px">
				<form id="d_search_form">
					<table width="100%" height="auto">
						<tr>
							<td>控制器ID：</td>
							<td><input type="text"  id="s_controller_id" value=""/></td>
							<td>光交箱地址：</td>
							<td><input type="text"  id="s_address" value=""/></td>
						</tr>
						<tr>
							<td>所属部门：</td>
							<td><input type="text"  id="s_department" value=""/></td>
							<td>开门时间：</td>
							<td><input type="text"  id="s_open_time" value=""/></td>
						</tr>
						<tr>
							<td>开门钥匙：</td>
							<td><input type="text"  id="s_open_keys" value=""/></td>
							<td>开门人员：</td>
							<td><input type="text"  id="s_open_operators" value=""/></td>
						</tr>
						<tr>
							<td>开门RFID：</td>
							<td><input type="text"  id="s_open_rfids" value=""/></td>
							<td>关门时间：</td>
							<td><input type="text"  id="s_close_time" value=""/></td>
						</tr>
						<tr>
							<td>关门钥匙：</td>
							<td><input type="text"  id="s_close_keys" value=""/></td>
							<td>关门人员：</td>
							<td><input type="text"  id="s_close_operators" value=""/></td>
						</tr>
						<tr>
							<td>关门RFID：</td>
							<td colspan="3"><input type="text"  id="s_close_rfids" value=""/></td>
						</tr>
					</table>
				</form>
			</div>
		</div><!-- #dialog-search-door -->
		
		<!-- basic scripts -->

		<!--[if !IE]> -->

		<script src="assets/js/googleapis-jq-2.0.3.min.js"></script>

		<!-- <![endif]-->

		<!--[if IE]>
		<script src="assets/js/googleapis-jq-1.10.2.min.js"></script>
		<![endif]-->

		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
		<script type="text/javascript">
		 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
		</script>
		<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="assets/js/bootstrap.min.js"></script>
		<script src="assets/js/typeahead-bs2.min.js"></script>

		<!-- page specific plugin scripts -->

		<!--[if lte IE 8]>
		  <script src="assets/js/excanvas.min.js"></script>
		<![endif]-->

		<script src="assets/js/jquery-ui-1.10.3.full.min.js"></script>
		<script src="assets/js/jquery.ui.touch-punch.min.js"></script>
		<script src="assets/js/jquery.slimscroll.min.js"></script>
		<script src="assets/js/jquery.easy-pie-chart.min.js"></script>
		<script src="assets/js/bootbox.min.js"></script>
		<script src="assets/js/jquery.sparkline.min.js"></script>
		<script src="assets/js/flot/jquery.flot.min.js"></script>
		<script src="assets/js/flot/jquery.flot.pie.min.js"></script>
		<script src="assets/js/flot/jquery.flot.resize.min.js"></script>
		
		<script src="assets/js/jqGrid/jquery.jqGrid.min.js"></script>
		<script src="assets/js/jqGrid/i18n/grid.locale-en.js"></script>
		<script src="My97DatePicker/WdatePicker.js"></script>
		<script src="assets/js/jquery.bootstrap.min.js"></script>
		<script src="js/jquery.validate.js"></script>
		<script src="js/validate-ex.js"></script>
		<script src="assets/js/fuelux/data/fuelux.tree-sampledata.js"></script>
		<script src="assets/js/fuelux/fuelux.tree.min.js"></script>

		<!-- ace scripts -->

		<script src="assets/js/ace-elements.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script src="js/boxevent.js"></script>
		
	</body>
</html>

