<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="doSave" namespace="/user" id="doSaveURL"/>
<s:url action="index" namespace="/user" id="userIndexURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%= contextPath %>/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%= contextPath %>/js/mylibs/my.validate.js"></script>
<style>
.td_label {
width:130px;
height: 30px;
overflow: hidden;
}
.field {
width:200px
}
label.error {
color: red;
margin-left: 5px;
}
input.error,select.error,textarea.error {
border: 1px solid red;
}
</style>
</head>
<body>
	<%@include file="/include/top-nologo.jsp"%>
	<div id="bg_wrapper">
		<center>
		<div style="width:99%">
			<fieldset class="form">
				<legend id="title"></legend>
				<form id="form" method="post" action="${doSaveURL}" onsubmit="return false">
				<input type="text" style="display:none" name="user.id" id="id"/>
				<table width="350px" style="float:left">
					<tr>
						<td colspan='2' align="left">
						<s:if test='message != null'>
							<s:if test='message.getType().equals(1)'>
								<div class="ui-state-highlight ui-corner-all" style=" padding: 0pt 0.7em; text-align: left;">
									<p style="padding: 5px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
									<strong>Success! </strong> <s:property value="message.message" /></p>
								</div>
							</s:if>
							<s:elseif test='message.getType().equals(0)'>
								<div style="padding: 0pt 0.7em; text-align: left;" class="ui-state-error ui-corner-all">
									<p style="padding: 5px;"><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span>
									<strong>Error : </strong> <s:property value="message.message" default="Có lỗi xảy ra, vui lòng thử lại sau." /></p>
								</div>
							</s:elseif>
						</s:if>
						</td>
					</tr>
					<tr>
						<td class="td_label">Username <span class="required" title="Yêu cầu nhập">*</span> :</td>
						<td>
							<input type="text" class="field" name="user.username" id="username"/>
							<label style="display:none" for="user.username" generated="false" class="error"></label>
						</td>
					</tr>
					<tr>
						<td class="td_label">Mật khẩu :</td>
						<td>
							<input type="password" class="field" name="user.password" id="password"/>
						</td>
					</tr>
					<tr>
						<td class="td_label">Xác nhận mật khẩu :</td>
						<td>
							<input type="password" class="field" name="" id="re-password"/>
						</td>
					</tr>
					<tr>
					<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
							<input type="button" class="button" id="btSubmit" value="Lưu"/>
							<input type="button" class="button" value="Trở về" onclick="location.href='${userIndexURL}'"/>
						</td>
					</tr>
				</table>
				<table  style="float:left">
					<tr>
						<td class="td_label">Phòng ban :</td>
						<td>
							<select class="field" name="user.idphongban" id="idphongban">
								<option value="">-- Chọn phòng ban --</option>
								<s:iterator value="phongbans">
									<option value='<s:property value="id" />'><s:property value="tenphongban" /></option>									
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td class="td_label">Nhóm chức năng:</td>
						<td>
							<select class="field" name="user.idgroup" id="idgroup">
								<option value="">-- Chọn nhóm chức năng --</option>
								<s:iterator value="vmsgroups">
									<option value='<s:property value="id" />'><s:property value="namegroup" /></option>									
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td class="td_label">Khu vực :</td>
						<td>
							<select class="field" name="user.idkhuvuc" id="idkhuvuc">
								<option value="">-- Chọn khu vực --</option>
								<s:iterator value="khuvucs">
									<option value='<s:property value="id" />'><s:property value="tenkhuvuc" /></option>									
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td class="td_label">Trạng thái :</td>
						<td>
							<select class="field" name="user.active" id="active">
								<option value="1">Đang hoạt động</option>
								<option value="0">Đã khóa</option>
							</select>
						</td>
					</tr>
				</table>
				</form>
			</fieldset>
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
	$("#form").validate({
		onkeyup: false,
		onfocusout:false,
		rules: {
			"user.username": {
				required: true,
				regex : '^[a-zA-Z0-9]+([a-zA-Z0-9](_|-| )[a-zA-Z0-9])*[a-zA-Z0-9]+$',
				uniqueUserName : true
			}
		},
		messages: {
			"user.username": {
				required: "Vui lòng nhập username",
				regex : "Tên đăng nhập chỉ bao gồm các ký tự từ A-z, 0-9 và các ký tự -",
				uniqueUserName : "Username này đã được sử dụng, vui lòng chọn username khác!"
			}
		}
	});
	$('ul.sf-menu').superfish();
	var form_data = '<s:property value="form_data" escape="false"/>';
	if(form_data != '') {
		$("legend#title").text("Cập nhật tài khoản");
		var form_data = $.parseJSON(form_data);
		for( key in form_data) {
			$("#form #"+key).val(form_data[key]);
		}
		$('#username').attr("readonly","true");
		$("#username").rules("remove");
	} else {
		$("legend#title").text("Thêm mới tài khoản");
	}
	$(document).delegate("#btSubmit","click",function(){
		this.disabled = true;
		if(!$("#form").valid()) {
			alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
			this.disabled = false;
		} else {
			byId("form").submit();
		}
		return false;
	});
});
</script>