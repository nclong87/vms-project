<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/include/header.jsp"%>
<style>
.td_label {
	width:100px;
}
</style>
</head>
<body>
	<%@include file="/include/top.jsp"%>
	<div id="bg_wrapper">
		<center>
		<div style="width:99%">
			<div style="padding: 0pt 0.7em; text-align: left;" class="ui-state-error ui-corner-all">
				<p style="padding: 5px;"><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
				<strong>Lỗi : </strong> <s:property value="message" default="Có lỗi xảy ra, vui lòng thử lại sau." /></p>
			</div>
		</div>
		</center>
	</div>
	<div id="footer"></div>
</body>
</html>
<script>
var LOGIN_PATH = "${loginURL}";
function loadContent(url) {
	location.href = contextPath + url;
}
$(document).ready(function(){	 
	$('ul.sf-menu').superfish();
	//$("input[type=button]").button();
});
</script>