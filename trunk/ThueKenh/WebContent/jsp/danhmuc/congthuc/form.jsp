<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="dosavecongthuc" namespace="/danhmuc" id="doSaveURL" />

<s:set value="opEdit.ma" var="ma"/>
<s:set value="opEdit.stt" var="stt"/>
<s:set value="opEdit.tencongthuc" var="tencongthuc"/>
<s:set value="opEdit.chuoicongthuc" var="chuoicongthuc"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%=contextPath%>/css/addedit.css"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="<%=contextPath%>/css/cupertino/jquery-ui.css" type="text/css"
	media="screen" />
<script type='text/javascript' src='<%=contextPath%>/js/jquery.js'></script>
<script type='text/javascript' src='<%=contextPath%>/js/jquery-ui.js'></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery.validate.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
<script>
var contextPath = '<%=contextPath%>';
	var baseUrl = contextPath;
	function byId(id) { //Viet tat cua ham document.getElementById
		return document.getElementById(id);
	}

</script>
<style>
</style>
</head>
<body>
	<form id="form" onsubmit="return false ;">
		<input type="text" style="display: none" name="opEdit.id" id="id"
			value="<s:property value="opEdit.id" />" />
		<div
			style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
			<table class="input" style="width: 725px">
				<tr>
					<td colspan='4' align="left" id="msg"></td>
				</tr>
				<tr>
					<td align="right" width="160px"><label for="ma">Mã : </label></td>
					<td align="left"><input type="text" name="opEdit.ma" id="ma"
						value="<s:property value="opEdit.ma" />" /></td>
					<td align="right" width="150px"><label for="stt">STT :
					</label></td>
					<td align="left"><input type="text" id="stt" name="opEdit.stt"
						value="<s:property value="opEdit.stt" />" /></td>
				</tr>
				<tr>
					<td align="right"><label for="tencongthuc">Tên công
							thức <font title="Bắt buộc nhập" color="red">*</font> :
					</label></td>
					<td align="left"><input type="text" id="tencongthuc"
						name="opEdit.tencongthuc"
						value="<s:property value="opEdit.tencongthuc" />" /></td>
					<td align="right" width="150px"><label for="stt">Chuỗi
							công thức <font title="Bắt buộc nhập" color="red">*</font> : </label></td>
					<td align="left"><input type="text" id="chuoicongthuc"
						name="opEdit.chuoicongthuc"
						value="<s:property value="opEdit.chuoicongthuc" />" />
						</td>
				</tr>
				<tr>
					<td align="right"></td>
					<td align="left"></td>
					<style>
						.congthuc button{
							float:right
						}
						.congthuc .s1 button{
							width:100px;
						}
						.congthuc .s2 button{
							width:50px;
						}
					</style>
					
					<td align="left" colspan="2" class="congthuc">
						<div class="s1">
							<button value="SL">Số lượng</button>
							<button value="GG">Giảm giá</button>
							<button value="CC">Cước cổng</button>
						</div>
						<div class="s2">
							<button value="+">+</button>
							<button value="-">-</button>
							<button value="*">*</button>
							<button value="/">/</button>
							<button value=")">)</button>
							<button value="(">(</button>
						</div>
						<script>
							$(".congthuc button").click(function(o){
								//alert($(this).attr("value"));
								var txtCongThuc=$("#chuoicongthuc").attr("value");
								txtCongThuc+=$(this).attr("value")+" ";
								$("#chuoicongthuc").attr("value",txtCongThuc);
							});
						</script>
						</td>
						
				</tr>


				<tr height="30px">
					<td colspan="6" align="right"><input class="button"
						type="button" id="btSubmit" value="Lưu" /> <input class="button"
						type="button" id="btReset" value="Làm lại" /> <input
						class="button" type="button" id="btThoat"
						onclick="window.parent.CloseWindow();" value="Thoát" /></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>
<script>
	var LOGIN_PATH = "${loginURL}";
	function message(msg, type) {
		if (msg == '') {
			$("#msg").html('');
			return;
		}
		if (type == 1) {
			$("#msg")
					.html(
							'<div class="ui-state-highlight ui-corner-all" style=" padding: 0pt 0.7em; text-align: left;"><p style="padding: 5px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><strong>Success! </strong> '
									+ msg + '</p></div>');
		} else {
			$("#msg")
					.html(
							'<div style="padding: 0pt 0.7em; text-align: left;" class="ui-state-error ui-corner-all"><p style="padding: 5px;"><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span><strong>Error : </strong> '
									+ msg + '</p></div>');
		}
	}
	function loadContent(url) {
		location.href = contextPath + url;
	}
	$(document)
			.ready(
					function() {
						$("#btReset").click(function() {
							$('#btnSubmit').attr('disabled', false);
							$("#ma").attr("value","${ma}");
							$("#stt").attr("value","${stt}");
							$("#tencongthuc").attr("value","${tencongthuc}");
							$("#chuoicongthuc").attr("value","${chuoicongthuc}");
							
							

						});
						$("#form").validate({
							onkeyup : false,
							onfocusout : false,
							rules : {
								"opEdit.tencongthuc" : {
									required : true
								},
								"opEdit.stt" : {
									number : true
								},
								"opEdit.chuoicongthuc" : {
									required : true
								}
							},
							messages : {
								"opEdit.tencongthuc" : {
									required : "Yêu cầu nhập tên công thức"
								},
								"opEdit.stt" : {
									number : 'Yêu cầu nhập số'
								},
								"opEdit.chuoicongthuc" : {
									required : "Yêu cầu nhập chuỗi công thức"
								}
							}
						});
						var form_data = '<s:property value="form_data" escape="false"/>';
						if (form_data != '') {
							var form_data = $.parseJSON(form_data);
							for (key in form_data) {
								$("#form #" + key).val(form_data[key]);
							}
							$("#ma").attr("disabled", "true");
							$("#stt").attr("disabled", "true");
							$("#tencongthuc").attr("disabled", "true");
							$("#chuoicongthuc").attr("disabled", "true");
							$("#btnSubmit").attr("disabled", true);
						}
						$(document)
								.delegate(
										"#btSubmit",
										"click",
										function() {
											var button = this;
											button.disabled = true;
											if (!$("#form").valid()) {
												alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
												button.disabled = false;
											} else {
												var stt = $("#stt").attr(
														"value");

												if (stt == "") {
													$("#stt")
															.attr("value", "0");
													//alert(stt);
												}
												var dataString = $("#form")
														.serialize();
												$
														.ajax({
															url : "${doSaveURL}",
															type : 'POST',
															data : dataString,
															success : function(
																	response) {
																button.disabled = false;
																if (response == "EXIST") {
																	message(
																			"Đã tồn tại tuyến kênh này trong hệ thống!",
																			0);
																	return false;
																}
																if (response == "OK") {
																	button.disabled = true;
																	message(
																			"Lưu thành công!",
																			1);
																	parent.reload = true;
																	return;
																}
																message(
																		"Lưu không thành công, vui lòng thử lại.",
																		0);
															},
															error : function(
																	response) {
																button.disabled = false;
																alert("Server is too busy, please try again!");
															}
														});
											}
											return false;
										});
					});

	
</script>