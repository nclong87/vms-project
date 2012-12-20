<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/hopdong" id="doSaveURL" />
<s:url action="ajLoadHopDong" namespace="/hopdong" id="ajLoadHopDong"/>
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
<script type='text/javascript' src='<%=contextPath%>/js/utils.js'></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
<script>
var contextPath = '<%=contextPath%>
	';
	var baseUrl = contextPath;
	function byId(id) { //Viet tat cua ham document.getElementById
		return document.getElementById(id);
	}
</script>
<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>

</head>

<body>
	<form id="form" onsubmit="return false;">
		<input type="text" style="display: none" name="hopdongDTO.id" id="id" />
		<div style="clear: both; margin: 5px 0">
			<table class="input" style="width: 782px">
				<tr>
					<td colspan='4' align="left" id="msg"></td>
				</tr>
				<tr>
					<td align="right">Loại hợp đồng <font title="Bắt buộc nhập" color="red">*</font>:</td>
					<td><select style="width: 220px" name="hopdongDTO.loaihopdong"
						id="loaihopdong">
							<option value="">---Chọn---</option>
							<option value="1">Có thời hạn</option>
							<option value="0">Không thời hạn</option>
					</select></td>
				</tr>
				<tr>
					<td align="right">Số hợp đồng <font title="Bắt buộc nhập"
						color="red">*</font>:</td>
					<td><input type="text" name="hopdongDTO.sohopdong"
						id="sohopdong" style="width: 218px" /></td>
					<td align="right">Đối tác <font title="Bắt buộc nhập" color="red">*</font>:</td>
					<td><select style="width: 220px" name="hopdongDTO.doitac_id"
						id="doitac_id">
							<option value="">---Chọn---</option>
							<s:iterator value="doiTacs">
								<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
							</s:iterator>
					</select></td>
				</tr>
				<tr>
					<td align="right">Ngày ký <font
						title="Bắt buộc nhập" color="red">*</font>:</td>
					<td align="left"><input type="text" name="hopdongDTO.ngayky"
						id="ngayky" style="width: 218px" class="datepicker" /></td>
					<td align="right">Ngày hết hạn <font title="Bắt buộc nhập" color="red">*</font>:</td>
					<td align="left"><input type="text"
						name="hopdongDTO.ngayhethan" id="ngayhethan" style="width: 218px"
						class="datepicker" />
					</td>
				</tr>
				<tr height="30px">
					<td></td>
					<td colspan="3"><input type="button" class="button"
						value="Lưu" id="btSubmit"></input> <input type="button"
						class="button" value="Làm lại" id="btReset"></input> <input
						type="button" class="button" value="Thoát" id="btThoat"
						onclick="window.parent.CloseWindow();"></input></td>
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
	function selectAll(_this) {
		$('#dataTable input[type=checkbox]').each(function() {
			this.checked = _this.checked;
		});
	}
	function validateForm()
	{
		//validation form
		if($("#loaihopdong").val()==1)
		{
			$("#form").validate({
				rules : {
					"hopdongDTO.loaihopdong" : {
						required : true
					},
					"hopdongDTO.sohopdong" : {
						required : true
					},
					"hopdongDTO.doitac_id" : {
						required : true
					},
					"hopdongDTO.ngayky" : {
						required : true,
						date : true
					},
					"hopdongDTO.ngayhethan" : {
						required : true,
						date : true
					}
				}
			});
		}
		else
		{
			$("#form").validate({
				rules : {
					"hopdongDTO.loaihopdong" : {
						required : true
					},
					"hopdongDTO.sohopdong" : {
						required : true
					},
					"hopdongDTO.doitac_id" : {
						required : true
					},
					"hopdongDTO.ngayky" : {
						required : true,
						date : true
					}
				}
			});
		}
	}
	$(document).ready(function() {
		// load datetime
		$( ".datepicker" ).datepicker({
			showButtonPanel: true,
			dateFormat : "dd/mm/yy"
		});
		
		$("#btReset").click(function() {
			$("#form")[0].reset();
			message('', 0);
		});
		// load edit
		var form_data = '<s:property value="form_data" escape="false"/>';
		if (form_data != '') {
			var form_data = $.parseJSON(form_data);
			for (key in form_data) {
				$("#form #" + key).val(form_data[key]);
			}
			if (form_data["filename"] != null) {
				upload_utils.createFileLabel({
					filename : form_data["filename"],
					filepath : form_data["filepath"],
					filesize : form_data["filesize"]
				});
			}
		}
		validateForm();
		$("#btSubmit").click(function() {
			$("#msg").html("");
			var button=this;
			button.disabled = true;
			if (!$("#form").valid()) {
				alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!",0);
				button.disabled = false;
			} else {
				var dataString = $("#form").serialize();
				$.ajax({
					url : "${doSaveURL}",
					type : 'POST',
					data : dataString,
					success : function(
							response) {
						button.disabled = false;
						if (response == "OK") {
							button.disabled = false;
							message(" Lưu thành công!",1);
							parent.reload = true;
							if($("#id").val()!="") {
							   parent.isUpdate = true;
							}
							return;
						}
						else if(response=="Date")
						{
							button.disabled = false;
							message(" Ngày hết hạn phải lớn hơn ngày ký.",0);
							return;
						}
						else if(response=="exist")
						{
							button.disabled = false;
							message(" Số hợp đồng đã tồn tại trong cơ sở dữ liệu. Vui lòng nhập số hợp đồng khác.",0);
							return;
						}
						message(" Lưu không thành công, vui lòng thử lại.",0);
					},
					error : function(
							response) {
						button.disabled = false;
						message(
								" Lưu không thành công, vui lòng thử lại.",
								0);
					}
				});
			}
		});

	});
</script>