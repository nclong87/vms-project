
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL" />
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="index" namespace="/settings" var="settingsIndexURL" />
<s:url action="ajLoadtiendobangiao" namespace="/tiendobangiao"
	id="ajLoad" />
<s:url action="form" namespace="/tiendobangiao" id="formURL" />
<s:url action="delete" namespace="/tuyenkenh" id="deleteURL" />
<s:url action="detail" namespace="/tuyenkenh" id="detailURL" />
<s:url action="detailLoaiGiaoTiep" namespace="/danhmuc"
	id="detailGiaoTiepURL" />
<s:url action="detailduan" namespace="/danhmuc" id="detailDuAnURL" />
<s:url action="detail" namespace="/dexuat" id="detailVanBanDeXuatURL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script>
	var LOGIN_PATH = "${loginURL}";
</script>
<%@include file="/include/header.jsp"%>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
<script>
	function doNew(link) {
		ShowWindow('Thêm tuyến kênh mới', 800, 400, link, false);
	}
	function doEdit(link) {
		ShowWindow('Cập nhật tiến độ bàn giao kênh', 800, 400, link, false);
	}
	function hasChecked() {
		var lstCheckbox = $('#dataTable input[type=checkbox]');
		for (i = 0; i < lstCheckbox.length; i++) {
			if ("checked" == $(lstCheckbox[i]).attr("checked")) {
				return true;
			}
		}
		alert("Không có dòng nào được chọn");
		return false;
	}
</script>


<style>
.block {
	float: left;
	margin-left: 10px;
}
</style>
</head>
<body>
	<%@include file="/include/top.jsp"%>
	<div id="bg_wrapper">
		<div style="width: 100%; margin-bottom: 10px;" class="ovf">
			<div class="s10">
				<div class="fl">
					<div class="fl tsl" id="t_1"></div>
					<div class="fl clg b tsc d" id="t_2">
						<div class="p3t">Tìm kiếm tuyến kênh</div>
					</div>
					<div class="fl tsr" id="t_3"></div>
				</div>
				<div class="lineU"></div>
			</div>
			<div id="divSearch" class="ovf" style="padding-right: 0px;">
				<div class="kc4 p5l p15t bgw">
					<div class="bgw p5b ovf" id="tabnd_2">
						<div class="ovf p5l p5t">
							<table width="970px">
								<form id="form">
									<tbody id="display">
										<tr>
											<td width="150px" align="right">Mã kênh :</td>
											<td align="left"><input type="text" name="makenh"
												id="makenh" /></td>
											<td align="right" width="150px">Loại giao tiếp :</td>
											<td align="left"><select name="loaigiaotiep"
												id="loaigiaotiep">
													<option value="">---Chọn---</option>
													<s:iterator value="loaiGiaoTieps">
														<option value='<s:property value="id" />'>
															<s:property value="loaigiaotiep" />
														</option>
													</s:iterator>
											</select></td>
										</tr>
										<tr>
											<td width="150px" align="right">Mã điểm đầu :</td>
											<td align="left"><input type="text" name="madiemdau"
												id="madiemdau" /></td>
											<td width="150px" align="right">Mã điểm cuối :</td>
											<td align="left"><input type="text" name="madiemcuoi"
												id="madiemcuoi" /></td>
										</tr>
									</tbody>
									<tbody id="hidden" style="display: none">
										<tr>
											<td align="right">Ngày hẹn BG :</td>
											<td align="left"><input type="text"
												name="ngayhenbangiao" class="date" id="ngayhenbangiao" /></td>
											<td align="right">Ngày ĐNBG :</td>
											<td align="left"><input type="text" class="date" name="ngaybangiao"
												id="ngaybangiao" /></td>
										</tr>
										<tr>
											<td align="right">Tên VBĐX :</td>
											<td align="left"><input type="text" name="dexuat_id"
												id="dexuat_id" /></td>
											<td align="right">Dự án</td>
											<td align="left"><input type="text" name="duan"
												id="duan" /></td>
										</tr>
										<tr>
											<td align="right">Trạng thái</td>
											<td align="left"><select name="iTrangThai">
													<option value="0">Đang bàn giao</option>
													<option value="1">Đã bàn giao</option>
													<option value="2">Đã có biên bản bàn giao</option>
											</select></td>
										</tr>
									</tbody>
								</form>
								<tbody id="advSearch">
									<tr>
										<td></td>
										<td align="left" colspan="5"><input type="checkbox"
											id="chkAdvSearch"><label for="chkAdvSearch">Tìm
												kiếm nâng cao</label></td>
									</tr>
								</tbody>
								<tfoot>
									<td></td>
									<td align="left"><input class="button" type="button"
										value="Tìm Kiếm" onclick="doSearch()" /> <input class="button"
										type="button" value="Reset" onclick="reset()" /></td>
								</tfoot>
							</table>
						</div>
					</div>
					<div class="clearb"></div>
				</div>
			</div>
			<div style="height: 1px;"></div>
		</div>
		<div style="clear: both; margin: 5px 0"></div>
		<table width="100%" id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th>Mã kênh</th>
					<th>Mã điểm đầu</th>
					<th>Mã điểm cuối</th>
					<th>Giao tiếp</th>
					<th>Dung lượng</th>
					<th>Số lượng</th>
					<th>Phòng nhận kênh</th>
					<th>Đối tác</th>
					<th width="120px">VB đề xuất</th>
					<th width="80px">Tiến độ</th>
					<th width="5px" align="center">Update</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="13" class="dataTables_empty">Đang tải dữ liệu...</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div id="footer"></div>
</body>
</html>
<script>
	function reset() {
		$("#form")[0].reset();
	}
	function selectAll(_this) {
		$('#dataTable input[type=checkbox]').each(function() {
			this.checked = _this.checked;
		});
	}
	function doSearch() {
		var frm = $('#form');
		var dat = "{'array':" + stringify(frm.serializeArray()) + "}";
		oTable.fnFilter(dat);
	}
	var account_id = '';
	function openPermissionWindow(id) {
		account_id = id;
		permission_popup.url_init = "${getMenusByAccountURL}?account_id="
				+ account_id;
		showDialogUrl("${permissionPopupURL}?id=" + id, 'Phân quyền user', 610);
	}

	$(document)
			.ready(
					function() {
						$("input.date").datepicker({
							showButtonPanel : true,
							dateFormat : "dd/mm/yy"
						});
						document.title = "QUẢN LÝ TIẾN ĐỘ BÀN GIAO KÊNH - VMS MOBIFONE";
						$("#btThem").click(
								function() {
									ShowWindow('Thêm mới tuyến kênh', 750, 500,
											"${formURL}", false);
								});
						$("#btXoa").click(
								function() {
									var dataString = '';
									$('#dataTable input[type=checkbox]').each(
											function() {
												if (this.checked == true) {
													if (this.value != 'on')
														dataString += '&ids='
																+ this.value;
												}
											});
									if (dataString == '') {
										alert('Bạn chưa chọn dòng để xóa!');
										return;
									}
									if (!confirm("Bạn muốn xóa dữ liệu?"))
										return;
									var button = this;
									button.disabled = true;
									$.ajax({
										type : "POST",
										cache : false,
										url : "${deleteURL}",
										data : dataString,
										success : function(data) {
											button.disabled = false;
											if (data == "END_SESSION") {
												location.href = LOGIN_PATH;
												return;
											}
											if (data == "OK") {
												unblock('#bg_wrapper');
												oTable.fnDraw(false);
												alert("Thao tác thành công!");
												return;
											}
											alert(data);
										},
										error : function(data) {
											alert(data);
											button.disabled = false;
										}
									});
								});
						$("span.edit_icon").live(
								"click",
								function() {
									var id = $(this).attr("data-ref-id");
									ShowWindow(
											'Cập nhật tiến độ bàn giao kênh',
											250, 300, "${formURL}?id=" + id,
											false);
								});
						$('ul.sf-menu').superfish();
						$("#chkAdvSearch").click(function() {
							if (this.checked == true) {
								$("#hidden").show();
							} else {
								$("#hidden").hide();
							}
						});
						oTable = $('#dataTable')
								.dataTable(
										{
											"bJQueryUI" : true,
											"bProcessing" : true,
											"bServerSide" : true,
											"bAutoWidth" : false,
											"sAjaxSource" : "${ajLoad}",
											"aoColumns" : [
													{
														"mDataProp" : "stt",
														"bSortable" : false,
														"bSearchable" : false
													},
													{
														"mDataProp" : null,
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center',
														"fnRender" : function(
																oObj) {
															return '<a target="_blank" href="${detailURL}?id='
																	+ oObj.aData.tuyenkenh_id
																	+ '" title="Xem chi tiết tuyến kênh">'
																	+ oObj.aData.tuyenkenh_id
																	+ '</a>';
														}
													},
													{
														"mDataProp" : "madiemdau",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : "madiemcuoi",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : null,
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center',
														"fnRender" : function(
																oObj) {
															return '<a target="_blank" href="${detailGiaoTiepURL}?id='
																	+ oObj.aData.giaotiep_id
																	+ '" title="Xem chi tiết loại giao tiếp">'
																	+ oObj.aData.loaigiaotiep
																	+ '</a>';
														}
													},
													{
														"mDataProp" : "dungluong",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : "soluong",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : "tenphongban",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : "tendoitac",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : null,
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center',
														"fnRender" : function(
																oObj) {
															if (oObj.aData.mavanbandexuat != null) {
																return '<a target="_blank" href="${detailVanBanDeXuatURL}?id='
																		+ oObj.aData.mavanbandexuat
																		+ '" title="Xem chi tiết văn bản đề xuất">'
																		+ oObj.aData.tenvanbandexuat
																		+ '</a>';
															} else {
																return "";
															}

														}
													},
													{
														"mDataProp" : null,
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center',
														"fnRender" : function(
																oObj) {
															return oObj.aData.tiendo
																	+ "%";

														}
													},
													{
														"mDataProp" : null,
														"bSortable" : false,
														"bSearchable" : false,
														"fnRender" : function(
																oObj) {
															return '<center><span class="edit_icon" data-ref-id="'+oObj.aData.id+'" title="Update" href="#"></span></center>';
														}
													} ],
											"fnServerData" : function(sSource,
													aoData, fnCallback) {
												$.ajax({
													"dataType" : 'json',
													"type" : "POST",
													"url" : sSource,
													"data" : aoData,
													"success" : fnCallback
												});
											},
											"sPaginationType" : "two_button"
										});
					});

	
</script>