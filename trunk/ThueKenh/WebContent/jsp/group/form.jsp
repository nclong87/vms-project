<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/group" id="doSaveURL"/>
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
</style>
</head>
<body>
	<form id="form" onsubmit="return false;">
	<input type="text" style="display:none" name="vmsgroup.id" id="id" />
	<div style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
		<table class="input" style="width:475px">
			<tr>
				<td colspan='4' align="left" id="msg">
				</td>
			</tr>
			<tr>
				<td align="right" width="100px">Tên nhóm <font title="Bắt buộc nhập" color="red">*</font> :</td>
				<td align="left">
					<input type="text" class="field" name="vmsgroup.namegroup" id="namegroup"/>
					<label for="vmsgroup.namegroup" generated="false" class="error"></label>
				</td>
			</tr>
			<tr>
				<td align="right">Menu chính :</td>
				<td align="left" >
					<select name="vmsgroup.mainmenu" id="mainmenu">
						<option value="">---Chọn---</option>
						<s:iterator value="menus">
							<option value='<s:property value="id" />'><s:property value="namemenu" /></option>									
						</s:iterator>
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
			"vmsgroup.namegroup" : {
				required : true
			}
		}
	});
	var form_data = '<s:property value="form_data" escape="false"/>';
	if(form_data != '') {
		var form_data = $.parseJSON(form_data);
		for( key in form_data) {
			$("#form #"+key).val(form_data[key]);
		}
	} 
	$(document).delegate("#btSubmit","click",function() {
		var button = this;
		button.disabled = true;
		if (!$("#form").valid()) {
			alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
			button.disabled = false;
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