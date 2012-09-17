<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL" />
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="index" namespace="/settings" var="settingsIndexURL" />
<s:url action="doSave" namespace="/user" id="doSaveURL" />
<s:url action="index" namespace="/user" id="userIndexURL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%= contextPath %>/css/addedit.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/css/cupertino/jquery-ui.css" type="text/css" media="screen" />
<script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script>
<script type='text/javascript' src='<%= contextPath %>/js/jquery-ui.js'></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
<script>
var contextPath = '<%= contextPath %>';
var baseUrl = contextPath;
function byId(id) { //Viet tat cua ham document.getElementById
	return document.getElementById(id);
}
</script>
<style>
.td_label {
	width: 135px;
	height: 30px;
	overflow: hidden;
}

.field {
	width: 200px
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
<body style="background: none;">
	<div id="bg_wrapper">
		<center>
		<div style="width: 99%">
			<form id="form" method="post"
				onsubmit="return false;">
				<input type="hidden" name="opEdit.Id"
		value="<s:property value="opEdit.Id" />">
				<table width="370px" style="float: left">
					<tr>
						<td colspan='2' align="left"><s:if test='message != null'>
								<s:if test='message.getType().equals(1)'>
									<div class="ui-state-highlight ui-corner-all"
										style="padding: 0pt 0.7em; text-align: left;">
										<p style="padding: 5px;">
											<span class="ui-icon ui-icon-info"
												style="float: left; margin-right: .3em;"></span> <strong>Success!
											</strong>
											<s:property value="message.message" />
										</p>
									</div>
								</s:if>
								<s:elseif test='message.getType().equals(0)'>
									<div style="padding: 0pt 0.7em; text-align: left;"
										class="ui-state-error ui-corner-all">
										<p style="padding: 5px;">
											<span style="float: left; margin-right: .3em;"
												class="ui-icon ui-icon-alert"></span> <strong>Error
												: </strong>
											<s:property value="message.message"
												default="Có lỗi xảy ra, vui lòng thử lại sau." />
										</p>
									</div>
								</s:elseif>
							</s:if></td>
					</tr>
					<tr>
						<td class="td_label">Tên phòng ban<span class="required"
							title="Yêu cầu nhập">*</span> :
						</td>
						<td><input type="text" class="field" name="opEdit.Tenphongban"
							id="opEdit.Tenphongban" value="<s:property value="opEdit.Tenphongban" />"/> <label style="display: none"
							for="opEdit.Tenphongban" generated="false" class="error"></label></td>
					</tr>
					<tr>
						<td class="td_label">Mã
						</td>
						<td><input type="text" class="field" name="opEdit.Ma"
							id="opEdit.Ma" value="<s:property value="opEdit.Ma" />"/> <label style="display: none"
							for="opEdit.Ma" generated="false" class="error"></label></td>
					</tr>
					
					<tr>
						<td class="td_label">Số thứ tự <span class="required"
							title="Yêu cầu nhập">*</span> :
						</td>
						<td><input type="text" class="field"
							name="opEdit.Stt" id="opEdit.Stt" value="<s:property value="opEdit.Stt" />"/> <label
							style="display: none" for="opEdit.Stt" generated="false"
							class="error"></label></td>
					</tr>

					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><input type="button" class="button" id="btSubmit"
							value="Lưu" /></td>
					</tr>
				</table>
				
			</form>
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
	$(document)
			.ready(
					function() {
						$("#form")
								.validate(
										{
											onkeyup : false,
											onfocusout : false,
											rules : {
												"opEdit.Tenphongban" : {
													required : true,
													uniqueUserName : true,
													minlength : 6,
													maxlength : 25
												}
											},
											messages : {
												"opEdit.Tenphongban" : {
													required : "Vui lòng nhập tên phòng ban ",
													uniqueUserName : "Username này đã được sử dụng, vui lòng chọn username khác!",
													minlength : "Tên đăng nhập ít nhất là 6 kí tự",
													maxlength : "Tên đăng nhập ít nhất là 25 kí tự",
												}
											}
										});
						var form_data = '<s:property value="form_data" escape="false"/>';
						if (form_data != '') {
							$("legend#title").text("Cập nhật tài khoản");
							var form_data = $.parseJSON(form_data);
							for (key in form_data) {
								$("#form #" + key).val(form_data[key]);
							}
							$('#username').attr("readonly", "true");
							$("#username").rules("remove");
						} else {
							$("legend#title").text("Thêm mới tài khoản");
						}
						$(document)
								.delegate(
										"#btSubmit",
										"click",
										function() {
											this.disabled = true;
											if (!$("#form").valid()) {
												alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
												this.disabled = false;
											} else {
												byId("form").submit();
											}
											return false;
										});
					});

	
</script>