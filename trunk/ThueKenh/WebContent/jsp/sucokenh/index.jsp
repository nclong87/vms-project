<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="form" namespace="/sucokenh" id="formURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
</head>

<body>
	<%@include file="/include/top.jsp"%>
		<div id="bg_wrapper">
			<div style="width: 100%" class="ovf">
				<div class="s10">
					<div class="fl">
						<div class="fl tsl" id="t_1"></div>
						<div class="fl clg b tsc d" id="t_2">
							<div class="p3t">Tìm kiếm sự cố</div>
						</div>
						<div class="fl tsr" id="t_3"></div>
					</div>
					<div class="lineU">
						<img height="1px" alt="" class="w100" src="../images/spacer.gif">
					</div>
				</div>
				<div id="divSearch" class="ovf" style="padding-right: 0px;">
					<div class="kc4 p5l p15t bgw">
						<div class="bgw p5b ovf" id="tabnd_2">
							<div class="ovf p5l p5t">
								<table>
									<tr>
										<td align="right">Mã tuyến kênh</td>
										<td><input type="text" style="width: 218px" /></td>
										<td align="right">Điểm đầu :</td>
										<td><input type="text" style="width: 218px" /></td>
										
									</tr>
									<tr>
										<td align="right">Điểm cuối :</td>
										<td><input type="text" style="width: 218px" /></td>
										
										<td align="right">Dung lượng :</td>
										<td><input type="text" style="width: 218px" /></td>

									</tr>
									<tr>
										<td align="right">Thời điểm bắt đầu :</td>
										<td align="left"><input type="text"
											name="account.username" id="username" style="width: 218px" />
										</td>
										<td align="right">Thời điểm kết thúc :</td>
										<td align="left"><input type="text"
											name="account.username" id="username" style="width: 218px" />
										</td>

									</tr>
									
									<tr>
										<td align="right">Người xác nhận :</td>
										<td><select style="width: 220px">
												<option>---SELECT---</option>
												<option>Nhân viên 1</option>
												<option>Nhân viên 2</option>
										</select></td>
										<td align="right">Loại sự cố :</td>
										<td><select style="width: 220px">
												<option>---SELECT---</option>
												<option>Loại 1</option>
												<option>Loại 2</option>
										</select></td>
									</tr>

									<tr height="30px">
										<td></td>
										<td colspan="3">
											<div class="buttonwrapper">
												<input type="button" class="button" value="Tìm kiếm"></input>
												<input type="button" class="button" value="Xuất excel"></input>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="clearb"></div>
					</div>
				</div>
			</div>
			<div style="clear: both; margin: 5px 0">
				<input type="button" class="button" value="Thêm sự cố" onclick="ShowWindow('Thêm sự cố',800,600,'${formURL}',false);"></input>
				<input type="button" class="button" value="Import Excel"></input>
				<input type="button" class="button" value="Xóa chọn"></input>
			</div>
			<table width="100%" id="dataTable" class="display">
				<thead>
					<tr>
						<th width="5px">STT</th>
						<th width="50px">Mã tuyến kênh</th>
						<th>Mã điểm đầu</th>
						<th>Mã điểm cuối</th>
						<th>Giao tiếp</th>
						<th>Dung lượng</th>
						<th>Số lượng</th>
						<th width="100px">Thời gian bắt đầu</th>
						<th width="100px">Thời gian kết thúc</th>
						<th width="100px">Thời gian mất liên lạc</th>
						<th width="50px">Nguyên nhân</th>
						<th width="100px">Phương án xử lý</th>
						<th width="100px">Người xác nhận</th>
						<th width="100px">Người tạo</th>
						<th width="100px">Ngày tạo</th>
						<th width="5px">Chi tiết</th>
						<th width="5px">Sửa</th>
						<th width="5px" align="center"><input type="checkbox"
							onclick="selectAll(this)" /></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td align="center">1</td>
						<td><a target="_blank" href="tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
						<td align="center">D1</td>
						<td align="center">D2</td>
						<td align="center">E1</td>
						<td align="center">3Mb</td>
						<td align="center">3</td>
						<td align="center">8:00 PM</td>
						<td align="center">9:00 PM</td>
						<td align="center">1h</td>
						<td align="center">ko biết</td>
						<td align="right">Chưa có phương án xử lý</td>
						<td align="right">toannb</td>
						<td align="right">toannb</td>
						<td align="center">20/1/2010</td>
						<td><center>
							<a href='suco/chitietsuco.html' target="_blank"><img
								title="Xem thông tin chi tiết sự cố"
								src="../images/icons/documents.png" style="cursor: pointer"></a></center></td>
						<td align="center">Sửa</td>
						<td align="center"><input type="checkbox"
							onclick="selectAll(this)" /></td>
					</tr>
					<tr>
						<td align="center">2</td>
						<td><a target="_blank" href="tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
						<td align="center">D1</td>
						<td align="center">D2</td>
						<td align="center">E1</td>
						<td align="center">3Mb</td>
						<td align="center">3</td>
						<td align="center">8:00 PM</td>
						<td align="center">9:00 PM</td>
						<td align="center">1h</td>
						<td align="center">ko biết</td>
						<td align="right">Chưa có phương án xử lý</td>
						<td align="right">toannb</td>
						<td align="right">toannb</td>
						<td align="center">20/1/2010</td>
						<td><center>
							<a href='suco/chitietsuco.html' target="_blank"><img
								title="Xem thông tin chi tiết sự cố"
								src="../images/icons/documents.png" style="cursor: pointer"></a></center></td>
						<td align="center">Sửa</td>
						<td align="center"><input type="checkbox"
							onclick="selectAll(this)" /></td>
					</tr>
					<tr>
						<td align="center">3</td>
						<td><a target="_blank" href="tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
						<td align="center">D1</td>
						<td align="center">D2</td>
						<td align="center">E1</td>
						<td align="center">3Mb</td>
						<td align="center">3</td>
						<td align="center">8:00 PM</td>
						<td align="center">9:00 PM</td>
						<td align="center">1h</td>
						<td align="center">ko biết</td>
						<td align="right">Chưa có phương án xử lý</td>
						<td align="right">toannb</td>
						<td align="right">toannb</td>
						<td align="center">20/1/2010</td>
						<td><center>
							<a href='suco/chitietsuco.html' target="_blank"><img
								title="Xem thông tin chi tiết sự cố"
								src="../images/icons/documents.png" style="cursor: pointer"></a></center></td>
						<td align="center">Sửa</td>
						<td align="center"><input type="checkbox"
							onclick="selectAll(this)" /></td>
					</tr>
					<tr>
						<td align="center">4</td>
						<td><a target="_blank" href="tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
						<td align="center">D1</td>
						<td align="center">D2</td>
						<td align="center">E1</td>
						<td align="center">3Mb</td>
						<td align="center">3</td>
						<td align="center">8:00 PM</td>
						<td align="center">9:00 PM</td>
						<td align="center">1h</td>
						<td align="center">ko biết</td>
						<td align="right">Chưa có phương án xử lý</td>
						<td align="right">toannb</td>
						<td align="right">toannb</td>
						<td align="center">20/1/2010</td>
						<td><center>
							<a href='suco/chitietsuco.html' target="_blank"><img
								title="Xem thông tin chi tiết sự cố"
								src="../images/icons/documents.png" style="cursor: pointer"></a></center></td>
						<td align="center">Sửa</td>
						<td align="center"><input type="checkbox"
							onclick="selectAll(this)" /></td>
					</tr>
					<tr>
						<td align="center">5</td>
						<td><a target="_blank" href="tuyenkenh/Chi tiet tuyen kenh.html">123</a></td>
						<td align="center">D1</td>
						<td align="center">D2</td>
						<td align="center">E1</td>
						<td align="center">3Mb</td>
						<td align="center">3</td>
						<td align="center">8:00 PM</td>
						<td align="center">9:00 PM</td>
						<td align="center">1h</td>
						<td align="center">ko biết</td>
						<td align="right">Chưa có phương án xử lý</td>
						<td align="right">toannb</td>
						<td align="right">toannb</td>
						<td align="center">20/1/2010</td>
						<td><center>
							<a href='suco/chitietsuco.html' target="_blank"><img
								title="Xem thông tin chi tiết sự cố"
								src="../images/icons/documents.png" style="cursor: pointer"></a></center></td>
						<td align="center">Sửa</td>
						<td align="center"><input type="checkbox"
							onclick="selectAll(this)" /></td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--end bg_wrapper-->
	</div>
	<!-- end top -->
	<div id="footer"></div>
	<!--end footer-->
</body>
</html>
<script>
function doReset() {
	$("#form")[0].reset(); //Reset form cua jquery, giu lai gia tri mac dinh cua cac field
	byId("msg").innerHTML="";
}
function selectAll(_this) {
	$('#dataTable input[type=checkbox]').each(function(){
		this.checked=_this.checked;
	});
}
function newPopupWindow(file, window, width, height) {
    msgWindow = open(file, window, 'resizable=yes, width=' + width + ', height=' + height + ', titlebar=yes, toolbar=no, scrollbars=yes');
    if (msgWindow.opener == null) msgWindow.opener = self;
}
$(document).ready(function(){	
	$('ul.sf-menu').superfish();
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bAutoWidth": false,
		"bSort":false,
		"sPaginationType": "two_button"
	});
	$('#divSearch input[title!=""]').hint();
});
</script>