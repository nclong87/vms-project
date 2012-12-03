<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/tuyenkenh" id="doSaveURL" />
<s:url action="findMaTram" namespace="/ajax" id="findMaTramURL" />
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
	<input type="text" style="display:none" name="tuyenKenh.id" id="id" />
	<div style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
		<table class="input" style="width:725px">
			<tr>
				<td colspan='4' align="left" id="msg">
				</td>
			</tr>
			<tr>
				<td align="right" width="160px"><label for="madiemdau">Điểm đầu <font title="Bắt buộc nhập" color="red">*</font> :
				</label></td>
				<td align="left"><input type="text" name="tuyenKenh.madiemdau" id="madiemdau" />
				</td>
				<td align="right" width="150px"><label for="madiemcuoi">Điểm cuối <font title="Bắt buộc nhập" color="red">*</font> :
				</label></td>
				<td align="left"><input type="text" id="madiemcuoi" name="tuyenKenh.madiemcuoi" /></td>
			</tr>
			<tr>
				<td align="right"><label for="giaotiep_id">Giao tiếp <font
						title="Bắt buộc nhập" color="red">*</font> :
				</label></td>
				<td align="left" >
					<select name="tuyenKenh.giaotiep_id" id="giaotiep_id">
						<option value="">---Chọn---</option>
						<s:iterator value="loaiGiaoTieps">
							<option value='<s:property value="id" />'><s:property value="loaigiaotiep" /></option>									
						</s:iterator>
					</select>
				</td>
				<td align="right"><label for="duan_id">Dự án : </label></td>
				<td align="left">
					<select id="duan_id" name="tuyenKenh.duan_id">
						<option value="">---Chọn---</option>
						<s:iterator value="duAnDTOs">
							<option value='<s:property value="id" />'><s:property value="tenduan" /></option>									
						</s:iterator>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right"><label for="dungluong">Dung lượng <font
						title="Bắt buộc nhập" color="red">*</font> :
				</label></td>
				<td align="left"><input type="text" name="tuyenKenh.dungluong" id="dungluong" />
				</td>
				<td align="right"><label for="soluong">Số lượng <font
						title="Bắt buộc nhập" color="red">*</font> :
				</label></td>
				<td align="left"><input type="text" name="tuyenKenh.soluong" id="soluong" />
				</td>
			</tr>
			<tr>
				<td align="right"><label for="phongban_id">Đơn vị nhận
						kênh : </label></td>
				<td align="left">
					<select id="phongban_id" name="tuyenKenh.phongban_id">
						<option value="">---Chọn---</option>
						<s:iterator value="phongBans">
							<option value='<s:property value="id" />'><s:property value="tenphongban" /></option>									
						</s:iterator>
					</select>
				</td>
				<td align="right"><label for="doitac_id">Đối tác <font title="Bắt buộc nhập" color="red">*</font> : </label></td>
				<td align="left">
					<select id="doitac_id" name="tuyenKenh.doitac_id">
						<option value="">---Chọn---</option>
						<s:iterator value="doiTacDTOs">
							<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
						</s:iterator>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">Trạng thái kênh :</td>
				<td align="left">
					<select name="tuyenKenh.trangthai" id="trangthai">
						<option value="0">Không hoạt động</option>
						<option value="1">Đang bàn giao</option>
						<option value="2">Đang cập nhật số lượng</option>
						<option value="3">Đã bàn giao</option>
					</select>
				</td>
				<td align="right"></td>
				<td align="left">
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
function loadContent(url) {
	location.href = contextPath + url;
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
			"tuyenKenh.madiemdau" : {
				required : true
			},
			"tuyenKenh.madiemcuoi" : {
				required : true
			},
			"tuyenKenh.giaotiep_id" : {
				required : true
			},
			"tuyenKenh.soluong" : {
				required : true,
				number : true
			},
			"tuyenKenh.dungluong" : {
				required : true,
				number : true
			},
			"tuyenKenh.doitac_id" : {
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
		$("#madiemdau").attr("readonly","true");
		$("#madiemcuoi").attr("readonly","true");
		//$("#giaotiep_id").attr("disabled","true");
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
					if(response == "EXIST") {
						message("Đã tồn tại tuyến kênh này trong hệ thống!",0);
						return false;
					}
					if(response == "OK") {
						message("Lưu thành công!",1);
						parent.reload = true;
						if($("#id").val()!="") {
							parent.isUpdate = true;
						}
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
	
	$( "#madiemdau,#madiemcuoi" ).autocomplete({
		delay: 1000,
		source: function( request, response ) {
			$.ajax({
				url: "${findMaTramURL}",
				data: {
					matram: request.term
				},
				success: function( data ) {
					response( $.map( data.data, function( item ) {
						return {
							label: item.matram,
							value: item.matram
						}
					}));
				}
			});
		},
		minLength: 2,
		select: function( event, ui ) {
			$(".ui-menu-item").hide();
		},
		open: function() {
		},
		close: function() {
		}
	});
});

	
</script>