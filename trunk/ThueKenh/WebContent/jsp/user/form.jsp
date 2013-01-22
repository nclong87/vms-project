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
			<form id="form" onsubmit="return false;">
				<input type="text" style="display: none" name="user.id" id="id" />
				<table style="width:700px;float: left">
					<tr>
						<td colspan='4' align="left" id="msg">
						</td>
					</tr>
					<tr>
						<td class="td_label" align="right">Username <span class="required"
							title="Yêu cầu nhập">*</span> :
						</td>
						<td align="left">
							<input type="text" name="user.username"
							id="username" /> <label style="display: none"
							for="user.username" generated="false" class="error"></label>
						</td>
						<td class="td_label" align="right">Mật khẩu :
						</td>
						<td align="left">
							<input type="password"
							name="user.password" id="password" /> <label
							style="display: none" for="user.password" generated="false"
							class="error"></label>
						</td>
					</tr>
					<tr>
						<td class="td_label" align="right">Phòng ban :</td>
						<td align="left">
							<select name="user.idphongban"
							id="idphongban">
								<option value="">-- Chọn phòng ban --</option>
								<s:iterator value="phongbans">
									<option value='<s:property value="id" />'>
										<s:property value="tenphongban" />
									</option>
								</s:iterator>
							</select>
						</td>
						<td class="td_label" align="right">Nhóm chức năng:</td>
						<td align="left">
							<select name="user.idgroup" id="idgroup">
								<option value="">-- Chọn nhóm chức năng --</option>
								<s:iterator value="vmsgroups">
									<option data-ref='<s:property value="mainmenu" />' value='<s:property value="id" />'>
										<s:property value="namegroup" />
									</option>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td class="td_label" align="right">Email:</td>
						<td align="left">
							<input type="text" name="user.email"
							id="email" />
						</td>
						<td class="td_label" align="right">Số điện thoại :</td>
						<td align="left">
							<input type="text" name="user.phone"
							id="phone" />
						</td>
					</tr>
					<tr>
						<td class="td_label" align="right">Menu chính:</td>
						<td align="left">
							<select name="user.mainmenu" id="mainmenu">
								<option value="">-- Chọn menu chính --</option>
								<s:iterator value="menus">
									<option value='<s:property value="id" />'>
										<s:property value="namemenu" />
									</option>
								</s:iterator>
							</select>
						</td>
						<td class="td_label" align="right">Trạng thái :</td>
						<td align="left">
							<select name="user.active" id="active">
								<option value="1">Đang hoạt động</option>
								<option value="0">Khóa</option>
							</select>
						</td>
					</tr>
					<tr height="30px">
						<td colspan="6" align="right">
							<input class="button" type="button" id="btSubmit" value="Lưu"/>
							<input class="button" type="button" id="btReset" value="Làm lại"/>
							<input class="button" type="button" id="btThoat" onclick="window.parent.CloseWindow();" value="Thoát"/>
						</td>
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
function message(msg,type) {
	if(msg == '') {
		$("#msg").html('');
		return;
	}
	if(type == 1) {
		$("#msg").html('<div class="ui-state-highlight ui-corner-all" style=" padding: 0pt 0.7em; text-align: left;"><p style="padding: 5px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><strong>Success! </strong> '+msg+'</p></div>');
	} else {
		$("#msg").html('<div style="padding: 0pt 0.7em; text-align: left;" class="ui-state-error ui-corner-all"><p style="padding: 5px;"><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span><strong>Error : </strong> '+msg+'</p></div>');
	}
}
$(document).ready(function() {
	$("#btReset").click(function(){
		$("#form")[0].reset();
		message('',0);
	});
	$("#form #idgroup").change(function(){
		var option = $("option:selected",this);
		var mainmenu = option.attr("data-ref");
		$("#form #mainmenu").val(mainmenu); 
	});
	$("#form")
			.validate(
					{
						onkeyup : false,
						onfocusout : false,
						rules : {
							"user.username" : {
								required : true,
								regex : '^[a-zA-Z0-9]+([a-zA-Z0-9](_|-| )[a-zA-Z0-9])*[a-zA-Z0-9]+$',
								uniqueUserName : true,
								minlength : 3,
								maxlength : 25
							}
						},
						messages : {
							"user.username" : {
								required : "Vui lòng nhập username",
								regex : "Tên đăng nhập chỉ bao gồm các ký tự từ A-z, 0-9 và các ký tự -",
								uniqueUserName : "Username này đã được sử dụng, vui lòng chọn username khác!",
								minlength : "Tên đăng nhập ít nhất là 6 kí tự",
								maxlength : "Tên đăng nhập ít nhất là 25 kí tự",
							}
						}
					});
	var form_data = '<s:property value="form_data" escape="false"/>';
	if (form_data != '') {
		var form_data = $.parseJSON(form_data);
		for (key in form_data) {
			$("#form #" + key).val(form_data[key]);
		}
		$('#username').attr("readonly", "true");
		$("#username").rules("remove");
	} else {
		$("legend#title").text("Thêm mới tài khoản");
	}
	$(document).delegate("#btSubmit","click",function() {
		var button = this;
		this.disabled = true;
		if (!$("#form").valid()) {
			alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
			this.disabled = false;
		} else {
			var dataString = $("#form").serialize();
			$.ajax({
				url: "${doSaveURL}",
				type:'POST',
				data:dataString,
				success:function(response){
					button.disabled = false;
					if(response.result == "ERROR") {
						if(response.data == "ERROR") {
							message(ERROR_MESSAGE,0);
							return;
						}
						message(response.data,0);
					} else {
						message("Lưu thành công!",1);
						parent.reload = true;
						if($("#id").val()!="") {
						   parent.isUpdate = true;
						}
					}
				},
				error:function(response){
					button.disabled = false;
					alert(ERROR_MESSAGE);
				}
			});
		}
		return false;
	});
});

	
</script>