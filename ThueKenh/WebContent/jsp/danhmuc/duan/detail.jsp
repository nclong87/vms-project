﻿<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%><%@ taglib prefix="s" uri="/struts-tags"%><s:url action="detailduan" namespace="/danhmuc" id="detailURL" /><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><%	String contextPath = request.getContextPath();%><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="description" content="Reflect Template" /><meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /><title>Xem chi tiết dự án : <s:property value="detail.id"/></title><link rel="stylesheet" href="<%= contextPath %>/css/detailpage.css" type="text/css" media="screen" /><script>var contextPath = '<%= contextPath %>';var baseUrl = contextPath;function byId(id) { //Viet tat cua ham document.getElementById	return document.getElementById(id);}</script><script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script><script type="text/javascript" src="<%=contextPath%>/js/trangthai_utils.js"></script></head><body>	<div id="bg_wrapper">		<h3>THÔNG TIN CHI TIẾT DỰ ÁN</h3>		<dt>Mã dự án :</dt>		<dd><s:property value="detail.ma"/></dd>		<dt>Tên dự án :</dt>		<dd><s:property value="detail.tenduan"/></dd>		<dt>Mô tả :</dt>		<dd><s:property value='detail.mota'/>&nbsp;</dd>		<dt>Giảm giá :</dt>		<dd><s:property value='detail.giamgia'/></dd>		<dt>Người tạo :</dt>		<dd><s:property value='detail.usercreate'/></dd>		<dt>Thời gian :</dt>		<dd><s:property value='detail.timecreate'/></dd>	</div></body></html><script>var matrangthai = "<s:property value='detail.trangthai'/>";$(document).ready(function() {	$("#trangthai").text(trangthai_utils.tuyenkenhText(matrangthai));});</script>