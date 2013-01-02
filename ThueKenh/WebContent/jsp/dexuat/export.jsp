<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doexport" namespace="/tuyenkenh" id="doexportURL" />
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
	#lstfields input{
	}
</style>
</head>
<body>
	<form id="form" method="post" action="${doexportURL}">
		<div style="display:block;font-weight: bold;">Chọn các trường dữ liệu đề xuất cần xuất:</div>
		<table id="lstfields">
			<tr><td><input type="checkbox" value="" id="checkall" onclick="selectAll(this)"></input><label for="checkall">Chọn tất cả</label></td></tr>
			<tr>
				<td>
					<input type="checkbox" value="madiemdau" name="fields"/>
					<input type="checkbox" style="display:none" value="Mã điểm đầu" name="fieldNames"/>
					<label for="madiemcuoi">Mã điểm đầu</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="madiemcuoi" name="fields"/>
					<input type="checkbox" style="display:none"  value="Mã điểm cuối" name="fieldNames"/>
					<label for="madiemcuoi">Mã điểm cuối</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="loaigiaotiep" name="fields"/>
					<input type="checkbox" style="display:none"  value="Giao tiếp" name="fieldNames"/>
					<label for="loaigiaotiep">Giao tiếp</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="dungluong" name="fields"/>
					<input type="checkbox" style="display:none"  value="Dung lượng" name="fieldNames"/>
					<label for="dungluong">Dung lượng</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="soluong" name="fields"/>
					<input type="checkbox" style="display:none"  value="Số lượng" name="fieldNames"/>
					<label for="soluong">Số lượng</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="tenduan" name="fields"/>
					<input type="checkbox" style="display:none"  value="Dự án" name="fieldNames"/>
					<label for="tenduan">Dự án</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="tenphongban" name="fields"/>
					<input type="checkbox" style="display:none"  value="Phòng ban" name="fieldNames"/>
					<label for="tenphongban">Phòng ban</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="tendoitac" name="fields"/>
					<input type="checkbox" style="display:none"  value="Đối tác" name="fieldNames"/>
					<label for="tendoitac">Đối tác</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="trangthai" name="fields"/>
					<input type="checkbox" style="display:none"  value="Trạng thái" name="fieldNames"/>
					<label for="trangthai">Trạng thái</label>
				</td>
			</tr>
		</table>
		<div style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
			<input class="button" type="submit" id="btExport" value="Export"/>
			<input class="button" type="button" id="btThoat" onclick="window.parent.CloseWindow();" value="Thoát"/>
		</div>
	</form>
</body>
</html>
<script>
var LOGIN_PATH = "${loginURL}";

function loadContent(url) {
	location.href = contextPath + url;
}
function selectAll(_this) {
	$('#lstfields input[type=checkbox]').each(function(){
		this.checked=_this.checked;
	});
}
$(document).ready(function() {	
	$("#form input[type=checkbox]").click(function(){
		$(this).next()[0].checked = this.checked;
	});
	/* $("#btExport").click(function() {
		var fields="";
		var fieldNames="";
		var number=0;
		$("#lstfields tr input:not(:first)").each(function(){
			if(this.checked==true)
			{
				if(fields!="")
					fields+="&";
				fields+="fields="+$(this).val();
				number++;
			}
		});
		if(number==0)
			alert("Vui lòng chọn các trường thông tin cần export");
		else
			location.href="${doexportURL}?"+fields;
	}); */
});

	
</script>