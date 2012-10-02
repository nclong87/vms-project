<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="dosavephongban" namespace="/danhmuc" id="doSaveURL" />

<s:set value="opEdit.ma" var="ma" />
<s:set value="opEdit.stt" var="stt" />
<s:set value="opEdit.tenphongban" var="tenphongban" />

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
	<form id="form">
		<input type="text" style="display: none" name="id" id="id"
			value="<s:property value="id" />" />
		<div
			style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
			<table width="100%" class="listTieuChuan">
				<s:iterator value="listTieuChuan">
    				<tr height="30px">
						<td align="left"><input  type="checkbox" name="<s:property value="id" />" id="<s:property value="id" />"
							> <label for="tc1" class="tieuchuan"><s:property value="tentieuchuan" />
							
							<input type="hidden" class="loaitieuchuan" value="<s:property value="loaitieuchuan" />"/>
							
							</label>
							
							</td>
					</tr>
    				
				</s:iterator>
				

					<tr height="30px">
						<td align="center"><input type="submit" onclick=""
							class="button" value="Lưu"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	<s:iterator value="listTieuChuanDatDuoc">
    				
					<input type="hidden" class="tieuchuandatduoc" value="<s:property value="id" />"/>
    				
				</s:iterator>
	<script>
		function fillOption(){
			//them text loai tieu chuan
			var tieuchuan=$(".listTieuChuan .tieuchuan");
			for(i=0;i<tieuchuan.length;i++){
				if($(tieuchuan[i]).find(".loaitieuchuan").val()==1)
					$("<label>").html("(Bắt buộc)").appendTo($(tieuchuan[i]));
			}
			//check vao nhung tieu chuan da dat dc
			var tieuchuandatduoc=$(".tieuchuandatduoc");
			for(i=0;i<tieuchuandatduoc.length;i++){
				var id=$(tieuchuandatduoc[i]).val();
				$(".listTieuChuan #"+id).attr("checked","true");
			}
		}
		fillOption();
		
	</script>
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
							$("#ma").attr("value", "${ma}");
							$("#stt").attr("value", "${stt}");
							$("#tenphongban").attr("value", "${tenphongban}");
						});
						$("#form").validate({
							onkeyup : false,
							onfocusout : false,
							rules : {
								"opEdit.tenphongban" : {
									required : true
								},
								"opEdit.stt" : {
									number : true
								}
							},
							messages : {
								"opEdit.tenphongban" : {
									required : "Yêu cầu nhập tên phòng ban"
								},
								"opEdit.stt" : {
									number : 'Yêu cầu nhập số'
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
							$("#tenphongban").attr("disabled", "true");
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