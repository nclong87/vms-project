<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doexport" namespace="/sucokenh" id="doexportURL" />
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
		<div style="display:block;font-weight: bold;">Chọn các trường dữ liệu văn bản đề xuất cần xuất:</div>
		<table id="lstfields">
			<tr><td><input type="checkbox" value="" id="checkall" onclick="selectAll(this)"></input><label for="checkall">Chọn tất cả</label></td></tr>
			<tr>
				<td>
					<input type="checkbox" value="tuyenkenh_id" name="fields"/>
					<input type="checkbox" style="display:none" value="Mã tuyến kênh" name="fieldNames"/>
					<label for="tuyenkenh_id">Mã tuyến kênh</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="madiemdau" name="fields"/>
					<input type="checkbox" style="display:none" value="Mã điểm đầu" name="fieldNames"/>
					<label for="madiemdau">Mã điểm đầu</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="madiemcuoi" name="fields"/>
					<input type="checkbox" style="display:none" value="Mã điểm cuối" name="fieldNames"/>
					<label for="madiemcuoi">Mã điểm cuối</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="loaigiaotiep" name="fields"/>
					<input type="checkbox" style="display:none" value="Giao tiếp" name="fieldNames"/>
					<label for="loaigiaotiep">Giao tiếp</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="dungluong" name="fields"/>
					<input type="checkbox" style="display:none" value="Dung lượng" name="fieldNames"/>
					<label for="dungluong">Dung lượng</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="soluong" name="fields"/>
					<input type="checkbox" style="display:none" value="Số lượng" name="fieldNames"/>
					<label for="soluong">Số lượng</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="thoidiembatdau" name="fields"/>
					<input type="checkbox" style="display:none" value="Thời gian bắt đầu" name="fieldNames"/>
					<label for="thoidiembatdau">Thời gian bắt đầu</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="thoidiemketthuc" name="fields"/>
					<input type="checkbox" style="display:none" value="Thời gian kết thúc" name="fieldNames"/>
					<label for="thoidiemketthuc">Thời gian kết thúc</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="thoigianmll" name="fields"/>
					<input type="checkbox" style="display:none" value="Thời gian mất liên lạc" name="fieldNames"/>
					<label for="thoigianmll">Thời gian mất liên lạc</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="nguyennhan" name="fields"/>
					<input type="checkbox" style="display:none" value="Nguyên nhân" name="fieldNames"/>
					<label for="nguyennhan">Nguyên nhân</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="phuonganxuly" name="fields"/>
					<input type="checkbox" style="display:none" value="Phương án xử lý" name="fieldNames"/>
					<label for="phuonganxuly">Phương án xử lý</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="loaisuco" name="fields"/>
					<input type="checkbox" style="display:none" value="Loại sự cố" name="fieldNames"/>
					<label for="loaisuco">Loại sự cố</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="nguoixacnhan" name="fields"/>
					<input type="checkbox" style="display:none" value="Người xác nhận" name="fieldNames"/>
					<label for="nguoixacnhan">Người xác nhận</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" value="bienbanvanhanh_id" name="fields"/>
					<input type="checkbox" style="display:none" value="Có biên bản" name="fieldNames"/>
					<label for="bienbanvanhanh_id">Có biên bản</label>
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