﻿<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%><%@ taglib prefix="s" uri="/struts-tags"%><%	String contextPath = request.getContextPath();%><meta name="description" content="Reflect Template" /><meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /><title>QUẢN LÝ KÊNH TRUYỀN DẪN - VMS MOBIFONE</title><link rel="stylesheet" href="<%= contextPath %>/css/style_all.css" type="text/css" media="screen" /><link rel="stylesheet" href="<%= contextPath %>/css/style1.css" type="text/css" media="screen" /><link rel="stylesheet" href="<%= contextPath %>/css/cupertino/jquery-ui.css" type="text/css" media="screen" /><link rel="stylesheet" href="<%= contextPath %>/css/jquery.wysiwyg.css" type="text/css" media="screen" /><link rel="stylesheet" type="text/css" href="<%= contextPath %>/css/superfish.css" media="screen"><link rel="stylesheet" type="text/css" href="<%= contextPath %>/css/demo_table_jui.css" /><!--Internet Explorer Trancparency fix--><!--[if IE 6]><script src="<%= contextPath %>/js/ie6pngfix.js"></script><script>  DD_belatedPNG.fix('#head, a, a span, img, .message p, .click_to_close, .ie6fix');</script><![endif]--> <script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script><script type='text/javascript' src='<%= contextPath %>/js/jquery-ui.js'></script><script type="text/javascript" src="<%= contextPath %>/js/jquery_blockUI.js"></script><script type='text/javascript' src='<%= contextPath %>/js/jquery.wysiwyg.js'></script><script type="text/javascript" src="<%= contextPath %>/js/hoverIntent.js"></script><script type="text/javascript" src="<%= contextPath %>/js/superfish.js"></script><script type="text/javascript" src="<%= contextPath %>/js/validator.js"></script><script type="text/javascript" src="<%= contextPath %>/js/jquery.dataTables.min.js"></script><script type="text/javascript" src="<%= contextPath %>/js/jquery.hint.js"></script><script type="text/javascript" src="<%= contextPath %>/js/templates.js"></script><script type="text/javascript" src="<%= contextPath %>/js/date.js"></script><script type='text/javascript' src='<%= contextPath %>/js/jquery.formatCurrency.min.js'></script><script type="text/javascript" src="<%= contextPath %>/js/utils.js"></script><script type="text/javascript" src="<%= contextPath %>/js/trangthai_utils.js"></script><script type="text/javascript" src="<%= contextPath%>/js/jquery-window-5.03/jquery.window.js"></script><link rel="stylesheet" href="<%= contextPath%>/js/jquery-window-5.03/css/jquery.window.css" type="text/css" media="screen" /><link rel="stylesheet" href="<%= contextPath %>/css/search_box.css" type="text/css" media="screen" /><script>var contextPath = '<%= contextPath %>';var baseUrl = contextPath;function byId(id) { //Viet tat cua ham document.getElementById	return document.getElementById(id);}function jsdebug(data) { //Ho tro debug voi ajax	alert(data);}function block(id) {	overlay = $(id).block({ 		message: '<span style="color:white">Loading...</span>', 		css: { 			border: 'none', 			padding: '15px', 			backgroundColor: '#000', 			'-webkit-border-radius': '10px', 			'-moz-border-radius': '10px', 			opacity: .5, 			color: '#fff'		} 	}); 	$('.blockOverlay', overlay).css('cursor', 'auto');}function unblock(id) {	$(id).unblock(); }function loadContent(url) {	location.href = contextPath + url;}</script>