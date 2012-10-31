<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/hopdong" id="doSaveURL" />
<s:url action="popupSearch" namespace="/tuyenkenh" id="popupSearchURL" />
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
<script type="text/javascript"
	src="<%=contextPath%>/js/mylibs/popup_search_tuyenkenh.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>

</head>

<body>
	<form id="form" onsubmit="return false;">
		<input type="text" style="display: none" name="hopdongDTO.id" id="id" />
		<div style="clear: both; margin: 5px 0">
			<table class="input" style="width: 782px">
				<tr>
					<td align="right" width="150px"><label for="xxxx">Số hồ sơ :</label></td>
					<td align="left">
						<input  type="text" name="vanban.tenvanban" id="username"/>
					</td>
					<td align="right" width="150px"><label for="xxxx">File scan :</label></td>
					<td align="left">
						<input type="file" name="vanban.ngaygui" id="ngaygui"/>
					</td>
				</tr>
				<tr>
					<td align="right" ><label for="xxxx">Ngày chuyển kế toán :</label></td>
					<td align="left" >
						<input  type="text" name="vanban.tenvanban" id="username"/>
					</td>
					<td align="right" ><label for="xxxx">Giá trị thanh toán <font title="Bắt buộc nhập" color="red">*</font> :</label></td>
					<td align="left">
						<input  type="text" name="vanban.ngaydenghibangiao" id="ngaydenghibangiao"/>
					</td>
				</tr>
			</table>
			<div style="width: 100%; margin-top: 10px;">
				<fieldset class="data_list">
					<legend>Danh sách hợp đồng</legend>
					<div style="width: 100%; padding-bottom: 5px;text-align: right;"><input class="button" type="button" value="Chọn hợp đồng" onclick="openPopupChonHopDong()"></div>
					<div id="accordion">
						<h3><a href="#">Hợp đồng 1</a></h3>
						<div>
							<table width="100%" id="dataTable1" class="display">
								<thead>
									<tr>
										<th><input type="checkbox"/></th>
										<th width="5%">STT</th>
										<th>Tên phụ lục</th>
										<th>Đối tác</th>
										<th>Loại phụ lục</th>
										<th>Số lượng kênh</th>
										<th>Giá trị trước thuế</th>
										<th>Trạng thái</th>
										<th>Thanh toán</th>
										<th width="5px" align="center">Xóa</th>
									</tr>
								</thead>								
							</table>		
						</div>
						<h3><a href="#">Hợp đồng 2</a></h3>
						<div>
							<table width="100%" id="dataTable1" class="display">
								<thead>
									<tr>
										<th><input type="checkbox"/></th>
										<th width="5%">STT</th>
										<th>Tên phụ lục</th>
										<th>Đối tác</th>
										<th>Loại phụ lục</th>
										<th>Số lượng kênh</th>
										<th>Giá trị trước thuế</th>
										<th>Trạng thái</th>
										<th>Thanh toán</th>
										<th width="5px" align="center">Xóa</th>
									</tr>
								</thead>
								</table>
						</div>
						<h3><a href="#">Hợp đồng 3</a></h3>
						<div>
							<table width="100%" id="dataTable1" class="display">
								<thead>
									<tr>
										<th><input type="checkbox"/></th>
										<th width="5%">STT</th>
										<th>Tên phụ lục</th>
										<th>Đối tác</th>
										<th>Loại phụ lục</th>
										<th>Số lượng kênh</th>
										<th>Giá trị trước thuế</th>
										<th>Trạng thái</th>
										<th>Thanh toán</th>
										<th width="5px" align="center">Xóa</th>
									</tr>
								</thead>								
							</table>
						</div>
					</div>
					
				</fieldset>
				<fieldset class="data_list" style="margin-top:10px">
					<legend>Danh sách sự cố giảm trừ</legend>
					<div style="width: 100%; padding-bottom: 5px;text-align: right;"><input class="button" type="button" value="Chọn sự cố giảm trừ" onclick="openPopupChonSuCo()"></div>
					<table width="100%" id="dataTable2" class="display dataTable">
					<thead>
						<tr>
							<th width="5%">#</th>
							<th>Mã kênh</th>
							<th>TG bắt đầu</th>
							<th>TG kết thúc</th>
							<th>TG mất liên lạc</th>
							<th>Người xác nhận</th>
							<th width="5px" align="center">Xóa</th>
						</tr>
					</thead>
					<tbody id="tbody">
						<tr>
							<td>1</td>
							<td><a target="_blank" href="../tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
							<td>04/03/2012 10:22</td>
							<td>04/03/2012 12:22</td>
							<td>2h</td>
							<td>NCLONG</td>
							<td><center><img title="Remove" src="../../images/icons/remove.png" onclick="doRemoveRow()" style="cursor:pointer"></center></td>
						</tr>
						<tr>
							<td>2</td>
							<td><a target="_blank" href="../tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
							<td>04/03/2012 10:22</td>
							<td>04/03/2012 12:22</td>
							<td>2h</td>
							<td>NCLONG</td>
							<td><center><img title="Remove" src="../../images/icons/remove.png" onclick="doRemoveRow()" style="cursor:pointer"></center></td>
						</tr>
						<tr>
							<td>3</td>
							<td><a target="_blank" href="../tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
							<td>04/03/2012 10:22</td>
							<td>04/03/2012 12:22</td>
							<td>2h</td>
							<td>NCLONG</td>
							<td><center><img title="Remove" src="../../images/icons/remove.png" onclick="doRemoveRow()" style="cursor:pointer"></center></td>
						</tr>
						<tr>
							<td>4</td>
							<td><a target="_blank" href="../tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
							<td>04/03/2012 10:22</td>
							<td>04/03/2012 12:22</td>
							<td>2h</td>
							<td>NCLONG</td>
							<td><center><img title="Remove" src="../../images/icons/remove.png" onclick="doRemoveRow()" style="cursor:pointer"></center></td>
						</tr>
						<tr>
							<td>5</td>
							<td><a target="_blank" href="../tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
							<td>04/03/2012 10:22</td>
							<td>04/03/2012 12:22</td>
							<td>2h</td>
							<td>NCLONG</td>
							<td><center><img title="Remove" src="../../images/icons/remove.png" onclick="doRemoveRow()" style="cursor:pointer"></center></td>
						</tr>
						<tr>
							<td>6</td>
							<td><a target="_blank" href="../tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
							<td>04/03/2012 10:22</td>
							<td>04/03/2012 12:22</td>
							<td>2h</td>
							<td>NCLONG</td>
							<td><center><img title="Remove" src="../../images/icons/remove.png" onclick="doRemoveRow()" style="cursor:pointer"></center></td>
						</tr>
					</tbody>
					</table>
				</fieldset>
			</div>
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
	
		//validation form
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
		$("#btSubmit").click(function() {
			$(this).disabled = true;
			if (!$("#form").valid()) {
				alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!",0);
				$(this).disabled = false;
			} else {
				var dataString = $("#form").serialize();
				$.ajax({
					url : "${doSaveURL}",
					type : 'POST',
					data : dataString,
					success : function(
							response) {
						$(this).disabled = false;
						if (response == "OK") {
							$(this).disabled = true;
							message(
									" Lưu thành công!",
									1);
							parent.reload = true;
							return;
						}
						else if(response=="Date")
						{
							$(this).disabled = true;
							message(" Ngày hết hạn phải lớn hơn ngày ký.",0);
							return;
						}
						else if(response=="exist")
						{
							$(this).disabled = true;
							message(" Số hợp đồng đã tồn tại trong cơ sở dữ liệu. Vui lòng nhập số hợp đồng khác.",0);
							return;
						}
						message(
								" Lưu không thành công, vui lòng thử lại.",
								0);
					},
					error : function(
							response) {
						$(this).disabled = false;
						message(
								" Lưu không thành công, vui lòng thử lại.",
								0);
					}
				});
			}
		});
	});
</script>