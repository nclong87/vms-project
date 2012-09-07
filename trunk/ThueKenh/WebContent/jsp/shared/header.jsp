<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="description" content="Reflect Template" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>QUẢN LÝ KÊNH TRUYỀN DẪN</title>
<link rel="stylesheet" href="<%= contextPath %>/content/css/style_all.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/content/css/style1.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/content/css/jquery-ui.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/content/css/jquery.wysiwyg.css" type="text/css"
	media="screen" />
<link rel="stylesheet" type="text/css" href="<%= contextPath %>/content/css/superfish.css"
	media="screen">
	<link rel="stylesheet" type="text/css" href="<%= contextPath %>/content/css/demo_table_jui.css" />
	<link rel="stylesheet" href="<%= contextPath %>/content/css/search_box.css" type="text/css"
		media="screen" />
	<link rel="stylesheet" href="<%= contextPath %>/content/css/CalendarControl.css"
		type="text/css" media="screen" />
	<link rel="stylesheet"
		href="<%= contextPath %>/content/js/jquery-window-5.03/css/jquery.window.css" type="text/css"
		media="screen" />
	<!--Internet Explorer Trancparency fix-->
	<!--[if IE 6]>
        <script src="/js/ie6pngfix.js"></script>
        <script>
          DD_belatedPNG.fix('#head, a, a span, img, .message p, .click_to_close, .ie6fix');
        </script>
        <![endif]-->

	<script type='text/javascript' src='<%= contextPath %>/content/js/jquery.js'></script>
	<script type='text/javascript' src='<%= contextPath %>/content/js/jquery-ui.js'></script>
	<script type="text/javascript" src="<%= contextPath %>/content/js/jquery_blockUI.js"></script>
	<script type='text/javascript' src='<%= contextPath %>/content/js/jquery.wysiwyg.js'></script>
	<script type="text/javascript" src="<%= contextPath %>/content/js/hoverIntent.js"></script>
	<script type="text/javascript" src="<%= contextPath %>/content/js/superfish.js"></script>
	<script type="text/javascript" src="<%= contextPath %>/content/js/validator.js"></script>
	<script type="text/javascript" src="<%= contextPath %>/content/js/jquery.dataTables.min.js"></script>
	 <script type="text/javascript" src="<%= contextPath %>/content/js/jquery.hint.js"></script>
	<%-- <script type="text/javascript" src="<%= contextPath %>/content/js/CalendarControl.js"></script> --%>
	<script type="text/javascript"
		src="<%= contextPath %>/content/js/jquery-window-5.03/jquery.window.js"></script>
	<script type="text/javascript" src="<%= contextPath %>/content/js/utils.js"></script>
	<script>
		function byId(id) { //Viet tat cua ham document.getElementById
			return document.getElementById(id);
		}
		function block(id) {
			overlay = $(id).block({ 
				message: '<span style="color:white">Loading...</span>', 
				css: { 
					border: 'none', 
					padding: '15px', 
					backgroundColor: '#000', 
					'-webkit-border-radius': '10px', 
					'-moz-border-radius': '10px', 
					opacity: .5, 
					color: '#fff'
				} 
			}); 
			$('.blockOverlay', overlay).css('cursor', 'auto');
		}
		function unblock(id) {
			$(id).unblock(); 
		}
		</script>
</head>

<body>
	<div id="dialog" title="Welcome to flexy admin">
		<p>
			Xin chào admin! welcome back.<br /> You got <strong>1 new
				Message</strong> in your inbox
		</p>
		<p>This is a messagebox, you can fill it with content of your
			choice ;)</p>
	</div>

	<div id="top">

		<div id="head">
			<h1 class="logo">
				<a href="#">flexy - adjustable admin skin</a>
			</h1>

			<div class="head_memberinfo">
				<div class="head_memberinfo_logo">
					<span>1</span> <img src="<%= contextPath %>/content/images/unreadmail.png" alt="" />
				</div>

				<span class='memberinfo_span'> Welcome <a href="#"><s:property value="#session.SESS_USERLOGIN.username"/></a>
				</span> <span class='memberinfo_span'> <a href="#" onclick="loadContent('/settings/index.action')">Your Account</a>
				</span> <span> <a href="${doLogoutURL}">Logout</a>
				</span> <span class='memberinfo_span2'> <a href="#">1 Private
						Message recieved</a>
				</span>
			</div>
			<!--end head_memberinfo-->
		</div>
		<!--end head-->
		<ul class="sf-menu">

		</ul>
		<div id="bg_wrapper">