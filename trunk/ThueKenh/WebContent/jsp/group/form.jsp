<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="doSave" namespace="/group" id="doSaveURL"/>
<s:url action="index" namespace="/group" id="indexURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%= contextPath %>/js/jquery.validate.js"></script>
<style>
.td_label {
width:100px
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
	<%@include file="/include/top.jsp"%>
	<div id="bg_wrapper">
		<center>
		<div style="width:99%">
			<fieldset class="form">
				<legend id="title"></legend>
				<form id="form" method="post" action="${doSaveURL}" onsubmit="return false">
				<input type="text" style="display:none" name="vmsgroup.id" id="id"/>
				<table width="100%">
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
						<td class="td_label">Tên nhóm <span class="required" title="Yêu cầu nhập">*</span> :</td>
						<td>
							<input type="text" class="field" name="vmsgroup.namegroup" id="namegroup"/>
							<label for="vmsgroup.namegroup" generated="false" class="error"></label>
						</td>
					</tr>
					<tr>
						<td class="td_label"></td>
						<td>
							<input type="button" class="button" id="btSubmit" value="Lưu"/>
							<input type="button" class="button" value="Trở về" onclick="location.href='${indexURL}'"/>
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
function loadContent(url) {
	location.href = contextPath + url;
}
$(document).ready(function(){	 
	$("#form").validate({
		onkeyup: false,
		onfocusout:false,
		rules: {
			"group.namegroup": {
				required: true
			}
		},
		messages: {
			"group.namegroup": "Vui lòng nhập tên nhóm!"
		}
	});
	$('ul.sf-menu').superfish();
	var form_data = '<s:property value="form_data" escape="false"/>';
	if(form_data != '') {
		$("legend#title").text("Cập nhật nhóm");
		var form_data = $.parseJSON(form_data);
		for( key in form_data) {
			$("#form #"+key).val(form_data[key]);
		}
	} else {
		$("legend#title").text("Thêm mới nhóm");
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