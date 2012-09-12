<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String contextPath = request.getContextPath();
%>
<script type='text/javascript'
	src='<%=contextPath%>/content/js/jquery.js'></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery.validate.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/mylibs/my.validate.js"></script>

<link rel="stylesheet" href="<%=contextPath%>/content/css/style_all.css"
	type="text/css" media="screen" />
	<style>
	.error{
		color:red;
		font-size: 11px;
		font-style: italic;
	}
	</style>
<form id="form" method="post">
	<input type="hidden" name="opEdit.id"
		value="<s:property value="opEdit.id" />">
	<table>
		<tbody>
			<tr>
				<td align="right">Tên phòng ban :</td>
				<td align="left"><input type="text" name="opEdit.name"
					id="opEdit.name" value="<s:property value="opEdit.name" />"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type=button class="button" id="btSubmit"
					value="Hoàn tất"></td>
			</tr>
		</tbody>
	</table>
</form>


<script>
var contextPath = '<%=contextPath%>';

	var baseUrl = contextPath;
	function byId(id) { //Viet tat cua ham document.getElementById
		return document.getElementById(id);
	}
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
												"opEdit.name" : {
													required : true,
													regex : '^[a-zA-Z0-9]+([a-zA-Z0-9](_|-| )[a-zA-Z0-9])*[a-zA-Z0-9]+$',
													uniqueUserName : true,
													minlength : 6,
													maxlength : 25
												}
											},
											messages : {
												"opEdit.name" : {
													required : "Vui lòng nhập tên",
													regex : "Tên đăng nhập chỉ bao gồm các ký tự từ A-z, 0-9 và các ký tự -",
													uniqueUserName : "Tên này đã được sử dụng, vui lòng chọn tên khác!",
													minlength : "Tên đăng nhập ít nhất là 6 kí tự",
													maxlength : "Tên đăng nhập ít nhất là 25 kí tự",
												}
											}
										});
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
												window.close();
												alert('close');
											}
											return false;
										});
					});

	
</script>