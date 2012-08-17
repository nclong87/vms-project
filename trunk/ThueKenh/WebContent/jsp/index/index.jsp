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
</head>
<body>
	<%@include file="/include/top.jsp"%>
	<style>
		.td_label {
			width: 75px;
		}
	</style>
	<div id="bg_wrapper">
		<center>
		<fieldset style="width:600px">
		<legend>Tìm kiếm user</legend>
		<table style="width:100%">
			<tr>
				<td class="td_label">Username</td>
				<td>
					<input type="text" class="field"/>
				</td>
				<td class="td_label">Phòng ban</td>
				<td>
					<select class="field field-cbb">
						<option value="">-- Chọn phòng ban --</option>
						<s:iterator value="phongbans">
							<option value='<s:property value="id" />'><s:property value="tenphongban" /></option>									
						</s:iterator>
					</select>
				</td>
			</tr>
			<tr>
				<td class="td_label">Khu vực</td>
				<td>
					<select class="field field-cbb">
						<option value="">-- Chọn khu vực --</option>
						<s:iterator value="khuvucs">
							<option value='<s:property value="id" />'><s:property value="tenkhuvuc" /></option>									
						</s:iterator>
					</select>
				</td>
				<td class="td_label">Trạng thái</td>
				<td>
					<select class="field field-cbb">
						<option value="">-- Chọn trạng thái --</option>
						<option value="1">Đang hoạt động</option>
						<option value="0">Đã khóa</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="4">
					<input style="margin: 0" type="button" class="button" id="btSearch" value="Tìm kiếm"/>
				</td>
			</tr>
		</table>
		</fieldset>
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