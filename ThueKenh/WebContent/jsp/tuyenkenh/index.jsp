
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="ajLoadTuyenkenh" namespace="/tuyenkenh" id="ajLoadTuyenkenh"/>
<s:url action="form" namespace="/tuyenkenh" id="formURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-window-5.03/jquery.window.js"></script>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/js/jquery-window-5.03/css/jquery.window.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/search_box.css" type="text/css" media="screen" />
	<script>
	function doNew(link) {
		ShowWindow('Thêm tuyến kênh mới',800,400,link,false);
	}
	function doEdit(link) {
		ShowWindow('Cập nhật tuyến kênh',800,400,link,false);
	}
	function hasChecked(){
		var lstCheckbox=$('#dataTable input[type=checkbox]');
		for(i=0;i<lstCheckbox.length;i++){
			if("checked"==$(lstCheckbox[i]).attr("checked")){
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
					<div class="fl tsl" id="t_1">
					</div>
					<div class="fl clg b tsc d" id="t_2">
						<div class="p3t">Tìm kiếm tuyến kênh</div>
					</div>
					<div class="fl tsr" id="t_3">
					</div>
				</div>
				<div class="lineU"></div>
			</div>
			<div id="divSearch" class="ovf" style="padding-right: 0px;">
				<div class="kc4 p5l p15t bgw">
					<div class="bgw p5b ovf" id="tabnd_2">
						<div class="ovf p5l p5t">
							<table width="970px">
								<tbody id="display">
								<tr>
									<td width="150px" align="right">
										Mã kênh :
									</td>
									<td align="left">
										<input type="text" name="id" id="id"/>
									</td>
									<td align="right" width="150px">
										Loại giao tiếp :
									</td>
									<td align="left">
										<select name="loaigiaotiep" id="loaigiaotiep">
											<option value="">---Chọn---</option>
											<s:iterator value="loaiGiaoTieps">
												<option value='<s:property value="id" />'><s:property value="loaigiaotiep" /></option>									
											</s:iterator>
										</select>
									</td>
								</tr>
								<tr>
									<td width="150px" align="right">
										Mã điểm đầu :
									</td>
									<td align="left">
										<input type="text" name="madiemdau" id="madiemdau"/>
									</td>
									<td width="150px" align="right">
										Mã điểm cuối :
									</td>
									<td align="left">
										<input type="text" name="madiemcuoi" id="madiemcuoi"/>
									</td>
								</tr>
								</tbody>
								<tbody id="hidden" style="display:none">
								<tr>
									<td align="right">
										Dự án :
									</td>
									<td align="left">
										<select name="duan" id="duan">
											<option value="">---Chọn---</option>
											<s:iterator value="duAnDTOs">
												<option value='<s:property value="id" />'><s:property value="tenduan" /></option>									
											</s:iterator>
										</select>
									</td>
									<td align="right">
										Khu vực :
									</td>
									<td align="left">
										<select>
											<option value="">---Chọn---</option>
											<s:iterator value="khuVucDTOs">
												<option value='<s:property value="id" />'><s:property value="name" /></option>									
											</s:iterator>
										</select>
									</td>
									<td align="right">Đ/V nhận kênh :</td>
									<td align="left">
										<select>
											<option value="">---Chọn---</option>
											<s:iterator value="phongBans">
												<option value='<s:property value="id" />'><s:property value="tenphongban" /></option>									
											</s:iterator>
										</select>
									</td>
								</tr>
								<tr>
									<td align="right">
										Ngày ĐN BG :
									</td>
									<td align="left"><input type="text" id="" /></td>
									<td align="right">
										Ngày hẹn BG :
									</td>
									<td align="left"><input type="text" id="" /></td>
									<td align="right">
										Tình trạng :
									</td>
									<td align="left">
										<select>
											<option value="">---Chọn---</option>
											<option value="0">Đang bàn giao</option>
											<option value="1">Đang thay đổi dung lượng</option>
											<option value="2">Đang thay đổi số lượng</option>
											<option value="3">Đã bàn giao</option>
											<option value="4">Đã có biên bản bàn giao</option>
											<option value="5">Đã có phụ lục hợp đồng</option>
										</select>
									</td>
								</tr>
								</tbody>
								<tbody id="advSearch">
									<tr>
										<td></td>
										<td  align="left" colspan="5">
											<input type="checkbox" id="chkAdvSearch" name="chkAdvSearch"><label for="chkAdvSearch">Tìm kiếm nâng cao</label>
										</td>
									</tr>
								</tbody>
								<tfoot>
									<td></td>
									<td align="left">
									<input class="button" type="button" value="Tìm Kiếm"/>
									</td>
								</tfoot>
							</table>
						</div>
					</div>
					<div class="clearb">
					</div>
				</div>
			</div>
			<div style="height: 1px;"></div>
		</div>
		<div style="clear:both;margin:5px 0 ">
		<input class="button" type="button" id="btThem" value="Thêm tuyến kênh"/>
		<input class="button" type="button" id="btXoa" value="Xóa"/>
		</div>
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
					<th width="30px">Dự án</th>
					<th width="120px">ĐV nhận kênh</th>
					<th width="80px">Tỉnh</th>
					<th width="5px">Trạng thái</th>
					<th width="5px" align="center">Sửa</th>
					<th width="5px" align="center"><input type="checkbox" onclick="selectAll(this)"/></th>
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
function loadContent(url) {
	location.href = contextPath + url;
}
function selectAll(_this) {
	$('#dataTable input[type=checkbox]').each(function(){
		this.checked=_this.checked;
	});
}
function doSearch() {
	var frm = $('#form');
	var dat = "{'array':"+stringify(frm.serializeArray())+"}";
	oTable.fnFilter(dat);
}
function doLock(flag) {
	if(hasChecked()==false)
		return;
	var dataString = '&active='+flag;
	$('#dataTable input[type=checkbox]').each(function(){
		if(this.checked==true) {
			if(this.value!='on')
				dataString+='&ids='+this.value;
		}
	});
	
	if(dataString=='') {
		alert('Bạn chưa chọn dòng để khóa / mở khóa!');
		return;
	}
	if(!confirm("Bạn muốn thực hiện thao tác này")) return;
	block('#bg_wrapper');
	$.ajax({
		type: "POST",
		cache: false,
		url : "${lockAccountsURL}",
		data: dataString,
		success: function(data){
			if(data == "END_SESSION") {
				location.href = LOGIN_PATH;
				return;
			}
			if(data == "OK") {
				unblock('#bg_wrapper');
				oTable.fnDraw(false);
				alert("Thao tác thành công!");
				return;
			}
			alert(data);
		},
		error: function(data){ alert (data);unblock('#bg_wrapper');}	
	});	
}
var account_id = '';
function openPermissionWindow(id) {
	account_id = id;
	permission_popup.url_init = "${getMenusByAccountURL}?account_id="+account_id;
	showDialogUrl("${permissionPopupURL}?id="+id,'Phân quyền user',610);
}
$(document).ready(function(){	 
	$('ul.sf-menu').superfish();
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${ajLoadTuyenkenh}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false },
					{ "mDataProp": "id","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "username","bSortable": false,"bSearchable": false},
					{ "mDataProp": "phongban","bSortable": false,"bSearchable": false},
					{ "mDataProp": "khuvuc","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							if(oObj.aData.active==1) 
								return '<center><div title="Đang hoạt động"  class="active"></div></center>'; 
							return '<center><div title="Đã khóa"  class="inactive"></div></center>';
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><img title="permission" src="'+contextPath+'/images/icons/permission.png" onclick="openPermissionWindow('+oObj.aData.id+')" style="cursor:pointer"></center>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><a class="edit_icon" onclick="doEdit(\'${formURL}?id='+oObj.aData.id+'\')" title="Edit" href="#"></a></center>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><input type="checkbox" value="'+oObj.aData.id+'"/></center>'; 
						}
					}
				],
		"fnServerData": function ( sSource, aoData, fnCallback ) {
			$.ajax( {
				"dataType": 'json', 
				"type": "POST", 
				"url": sSource, 
				"data": aoData, 
				"success": fnCallback
			} );
		},
		"sPaginationType": "two_button"
	});
});
</script>