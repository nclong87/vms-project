<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSaveTram" namespace="/danhmuc" id="doSaveURL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%= contextPath %>/css/addedit.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/css/cupertino/jquery-ui.css" type="text/css" media="screen" />
<script>
var contextPath = '<%= contextPath %>';
var baseUrl = contextPath;
function byId(id) { //Viet tat cua ham document.getElementById
	return document.getElementById(id);
}
</script>
<script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/utils.js"></script>

<style>
input[type="text"], select {
  width: 100%;
}
</style>
</head>
<body>
	<form id="form" onsubmit="return false;">
	<input type="text" style="display:none" name="tramDTO.id" id="id" />
	<div style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
		<table class="input" style="width:475px">
			<tr>
				<td colspan='2' align="left" id="msg">
				</td>
			</tr>
			<tr>
				<td align="right" width="80px">
					Mã trạm <font title="Bắt buộc nhập" color="red">*</font> :
				</td>
				<td align="left">
					<input type="text" name="tramDTO.matram" id="matram" />
				</td>
			</tr>
			<tr>
				<td align="right" >
					Địa chỉ :
				</td>
				<td align="left">
					<input type="text" name="tramDTO.diachi" id="diachi" />
				</td>
			</tr>
		</table>
		<div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
			<input class="button" type="button" id="btSubmit" value="Lưu"/>
			<input class="button" type="button" id="btReset" value="Làm lại"/>
			<input class="button" type="button" id="btThoat" onclick="window.parent.CloseWindow();" value="Thoát"/>
		</div>
	</div>
	</form>
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
	$("#form").validate({
		onkeyup : false,
		onfocusout : false,
		rules : {
			"tramDTO.matram" : {
				required : true
			}
		}
	});
	var form_data = '<s:property value="form_data" escape="false"/>';
	if(form_data != '') {
		var form_data = $.parseJSON(form_data);
		for( key in form_data) {
			var input = document.forms[0]["tramDTO."+key];
			if(input != null) {
				input.value = form_data[key];
			}
		}
	} 
	$(document).delegate("#btSubmit","click",function() {
		var button = this;
		if (!$("#form").valid()) {
			alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
			button.disabled = false;
		} else {
			button.disabled = true;
			var dataString = $("#form").serialize();
				$.ajax({
				url: "${doSaveURL}",
				type:'POST',
				data:dataString,
				success:function(response){
					button.disabled = false;
					if(response == "EXIST") {
						message("Mã trạm này đã tồn tại trong hệ thống!",0);
						return;
					}
					if(response == "OK") {
						message("Lưu thành công!",1);
						parent.reload = true;
						return;
					}
					message("Lưu không thành công, vui lòng thử lại.",0);
				},
				error:function(response){
					button.disabled = false;
					alert("Server is too busy, please try again!");
				}
			});
		}
		return false;
	});
});
</script>