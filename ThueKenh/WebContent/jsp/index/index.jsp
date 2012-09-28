<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/include/header.jsp"%>
</head>
<body>
	<%@include file="/include/top.jsp"%>
	<style>
		.td_label {
			width: 75px;
		}
	</style>
	<div id="bg_wrapper">
	</div>
	<div id="footer"></div>
</body>
</html>
<script>
var LOGIN_PATH = "${loginURL}";
$(document).ready(function(){	 
	$('ul.sf-menu').superfish();
	//$("input[type=button]").button();
});
</script>