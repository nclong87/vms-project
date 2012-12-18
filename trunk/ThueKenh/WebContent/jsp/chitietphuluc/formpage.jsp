<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="doSave" namespace="/chitietphuluc" var="doSaveURL"/>
<s:url action="form" namespace="/chitietphuluc" var="formURL"/>
<s:url action="popupSearch2" namespace="/tuyenkenh" id="popupSearch2URL" />
<s:url action="getAllCongThuc" namespace="/ajax" id="getAllCongThucURL" />
<s:url action="getAllLoaiGiaoTiep" namespace="/ajax" id="getAllLoaiGiaoTiepURL" />
<s:url action="detail" namespace="/tuyenkenh" id="detailTuyenKenhURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel="stylesheet" href="<%= contextPath %>/css/addedit.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="<%= contextPath %>/css/cupertino/jquery-ui.css" type="text/css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%= contextPath %>/css/demo_table_jui.css" />
	<script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script>
	<script type='text/javascript' src='<%= contextPath %>/js/jquery-ui.js'></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
	<script type='text/javascript' src='<%= contextPath %>/js/jquery.formatCurrency.min.js'></script>
	<script type='text/javascript' src='<%= contextPath %>/js/utils.js'></script>
	<script type="text/javascript" src="<%= contextPath %>/js/jquery.dataTables.min.js"></script>
<script>
var contextPath = '<%=contextPath%>';
	var baseUrl = contextPath;
	function byId(id) { //Viet tat cua ham document.getElementById
		return document.getElementById(id);
	}
</script>
<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_tuyenkenh.js"></script>
<style>
.block {
float: left;
margin-left: 10px;
}
.currency {
text-align:right
}
table.display td {
  padding: 5px 0;
}
td {
  text-align: center;
}
#frmLuuPhuLuc ul {
padding: 0px; list-style: none outside none;
}
#frmLuuPhuLuc ul li{
padding: 5px; 
}
</style>
</head>
<body>
	<input type="text" style="display:none" name="chiTietPhuLucDTO.id" id="id" />
	<div id="dialog" title="Welcome to VMS" style="display:none"><center>Loading...</center></div>
	<table>
		<tr>
			<td align="left">
				<input class="button" type="button" value="Chọn kênh cần tính giá trị" id="btPopupSearchTuyenkenh">
				<input type="button" class="button" value="Tính giá trị phụ lục" id="btTinhGiaTriPhuLuc" style="display:none"></input>
			</td>

		</tr>
	</table>
	<form id="frmTinhGiaTriPhuLuc" onsubmit="return false">
		<table id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5px">STT</th>
					<th width="50px">Mã tuyến kênh</th>
					<th width="200px">Điểm đầu</th>
					<th width="200px">Điểm cuối</th>
					<th width="150px">Giao tiếp</th>
					<th width="150px">Dung lượng</th>
					<th width="150px">Số lượng</th>
					<th width="150px">Cước cổng</th>
					<th width="150px">Cước đấu nối</th>
					<th width="150px">Đơn giá</th>
					<th width="150px">Giảm giá</th>
					<th width="200px">Công thức</th>
					<th width="10px">Xóa</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>	
		<div style="clear:both;float:right; padding-top:5px"><input class="button" type="button" id="btThoat" onclick="window.parent.CloseWindow();" value="Thoát"/></div>
	</form>
</body>
</html>
<script>
function reset(){
	$("#form")[0].reset();
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
function rowChanges(flag){
	var i = 1;
	$("#dataTable tbody tr #stt").each(function(){
		$(this).text(i);
		i++;
	});
	if(i > 1) {
		$("#btTinhGiaTriPhuLuc").show();
	} else {
		$("#btTinhGiaTriPhuLuc").hide();
	}
	if(flag == 1) { //add rows
		$('#frmTinhGiaTriPhuLuc .currency').formatCurrency({ 
			region : 'vn',
			roundToDecimalPlace: 0, 
			eventOnDecimalsEntered: true 
		});
	}
}
function doRemoveRow(this_){
	var row = $(this_).closest("tr").get(0);
	oTable.fnDeleteRow(oTable.fnGetPosition(row));
	rowChanges(0);
}
var arrCongThuc = null;
function generateCongThucOptions(congthuc_id){
	if(arrCongThuc == null) {
		$.ajax({
			type: "GET",
			url: "${getAllCongThucURL}",
			async: false, 
			success: function(response){
				if(response.status == 0) { //error
					alert("Kết nối server bị lỗi, vui lòng thử lại sau.");
					return;
				} else if(response.status == 1) { //success
					arrCongThuc = response.data;
				}
			}
		});
	}
	var result = '';
	if(arrCongThuc != null) {
		$.each(arrCongThuc, function(){
			if(congthuc_id!="")
			{
				if(congthuc_id==this.id)
					result+= '<option selected value="'+this.id+'">'+this.tencongthuc+'</option>';
				else
					result+= '<option value="'+this.id+'">'+this.tencongthuc+'</option>';
			}
			else
			{
				if(this.isdefault == 1) { // cong thuc mac dinh
					result+= '<option selected value="'+this.id+'">'+this.tencongthuc+'</option>';
				} else {
					result+= '<option value="'+this.id+'">'+this.tencongthuc+'</option>';
				}
			}
				
		});
	}
	return result;
}
var arrLoaiGiaoTiep = null;
function generateCuocCongValue(i){
	if(arrLoaiGiaoTiep == null) {
		$.ajax({
			type: "GET",
			url: "${getAllLoaiGiaoTiepURL}",
			async: false, 
			success: function(response){
				if(response.status == 0) { //error
					alert("Kết nối server bị lỗi, vui lòng thử lại sau.");
					return;
				} else if(response.status == 1) { //success
					arrLoaiGiaoTiep = new Array();
					$.each(response.data,function(){
						arrLoaiGiaoTiep[this.id] = this;
					});
				}
			}
		});
	}
	var result = 0;
	if(arrLoaiGiaoTiep != null) {
		result = arrLoaiGiaoTiep[i].cuoccong; 
	}
	return result;
}
function addRow(stt,data) {
	oTable.fnAddData([
		'<input type="text" id="loaigiaotiep" style="display:none" value="'+data.loaigiaotiep+'"/><span id="stt"></span>',
		'<a target="_blank" href="${detailTuyenKenhURL}?id='+data.id+'">'+data.id+'</a>',
		data.madiemdau,data.madiemcuoi,data.loaigiaotiep,data.dungluong,
		'<input type="text" id="soluong" disabled="true" style="width:30px;text-align:center" value="'+data.soluong+'"/>',
		'<input type="text" class="currency" id="cuoccong" style="width:120px;text-align:right" value="'+generateCuocCongValue(data.giaotiep_id)+'"/>',
		'<input type="text" class="currency" id="cuocdaunoi" style="width:120px" />',
		'<input type="text" class="currency" id="dongia" style="width:120px" />',
		'<input type="text" maxlength="2" id="giamgia" style="width:30px;text-align:center" value="0"/> %',
		'<select id="congthuc_id" style="width: 100px"><option>---SELECT---</option>'+generateCongThucOptions("")+'</select>',
		'<input type="text" style="display:none" value="'+data.id+'" id="tuyenkenh_id"/><input type="text" style="display:none" value="'+data.id+'" id="tuyenkenh_'+data.id+'"/><img title="Remove" src="'+baseUrl+'/images/icons/remove.png" onclick="doRemoveRow(this)" style="cursor:pointer">'
	]);
}
function addRowForEdit(stt,data) {
	oTable.fnAddData([
		'<input type="text" id="loaigiaotiep" style="display:none" value="'+data.loaigiaotiep+'"/><span id="stt"></span>',
		'<a target="_blank" href="${detailTuyenKenhURL}?id='+data.id+'">'+data.id+'</a>',
		data.madiemdau,data.madiemcuoi,data.loaigiaotiep,data.dungluong,
		'<input type="text" id="soluong" disabled="true" style="width:30px;text-align:center" value="'+data.sltuyenkenh+'"/>',
		'<input type="text" class="currency" id="cuoccong" style="width:120px;text-align:right" value="'+data.cuoccong+'"/>',
		'<input type="text" class="currency" id="cuocdaunoi" style="width:120px" value="'+data.cuocdaunoi+'"/>',
		'<input type="text" class="currency" id="dongia" style="width:120px" value="'+data.dongia+'"/>',
		'<input type="text" maxlength="2" id="giamgia" style="width:30px;text-align:center" value="0" value="'+data.giamgia+'"/> %',
		'<select id="congthuc_id" class="congthuc_'+data.congthuc_id+'" style="width: 100px"><option>---SELECT---</option>'+generateCongThucOptions(data.congthuc_id)+'</select>',
		'<input type="text" style="display:none" value="'+data.id+'" id="tuyenkenh_id"/><input type="text" style="display:none" value="'+data.id+'" id="tuyenkenh_'+data.id+'"/><img title="Remove" src="'+baseUrl+'/images/icons/remove.png" onclick="doRemoveRow(this)" style="cursor:pointer">'
	]);
}
var seq = 0;
$(document).ready(function(){
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bAutoWidth": false,
		"bSort":false,
		"bFilter": false,
		"bInfo": false,
		"bPaginate" : false
	});
	var form_data = '<s:property value="form_data" escape="false"/>';
	if(form_data != '') {
		var id='<s:property value="id" escape="false"/>';
		$("#id").val(id);
		$("#btTinhGiaTriPhuLuc").show();
		form_data = $.parseJSON(form_data);
		var i = 1;
		$.each(form_data,function(){
			addRowForEdit(i,this);
			i++;
		});
		rowChanges(1);
	} 
	popup_search_tuyenkenh.init({
		url : "${popupSearch2URL}",
		afterSelected : function(data) {
			var i = 1;
			$.each(data,function(){
				if($("#frmTinhGiaTriPhuLuc #tuyenkenh_"+this.id).length == 0) {
					addRow(i,this);
					i++;
				}
			});
			rowChanges(1);
		}
	});
	$("#btThem").click(function(){
		ShowWindow('Thêm mới  văn bản đề xuất',750,500,"${formURL}",false);
	});
	$("#btTinhGiaTriPhuLuc").click(function(){
		//$('#frmTinhGiaTriPhuLuc .currency').toNumber({region:'vn'});
		var dataString = '';
		var i = 0;
		$("#dataTable tbody tr").each(function(){
			var soLuong = $("#soluong",this).val();
			var loaiGiaoTiep = $("#loaigiaotiep",this).val();
			var tuyenKenhId = $("#tuyenkenh_id",this).val();
			var cuocCong = $("#cuoccong",this).asNumber({region:'vn'});
			var cuocDauNoi = $("#cuocdaunoi",this).asNumber({region:'vn'});
			var donGia = $("#dongia",this).asNumber({region:'vn'});
			var giamGia = $("#giamgia",this).val();
			var selectCongThuc = $("#congthuc_id",this);
			var chuoiCongThuc = $("option[selected]",selectCongThuc).attr("chuoicongthuc");
			dataString += '&chiTietPhuLucTuyenKenhDTOs['+i+'].soluong='+soLuong+ 	
				'&chiTietPhuLucTuyenKenhDTOs['+i+'].tuyenkenh_id='+tuyenKenhId+
				'&chiTietPhuLucTuyenKenhDTOs['+i+'].cuoccong='+cuocCong+
				'&chiTietPhuLucTuyenKenhDTOs['+i+'].cuocdaunoi='+cuocDauNoi+
				'&chiTietPhuLucTuyenKenhDTOs['+i+'].dongia='+donGia+
				'&chiTietPhuLucTuyenKenhDTOs['+i+'].giamgia='+giamGia+
				'&chiTietPhuLucTuyenKenhDTOs['+i+'].loaigiaotiep='+loaiGiaoTiep+
				'&chiTietPhuLucTuyenKenhDTOs['+i+'].congthuc_id='+selectCongThuc.val();
			i++;
		});
		if($("#id").val()!="")
			dataString+="&chiTietPhuLucDTO.id="+$("#id").val();
		var button = this;
		button.disabled = true;
		$.ajax({
			type: "POST",
			cache: false,
			url : "${doSaveURL}",
			data: dataString,
			success: function(response){
				button.disabled = false;
				if(response.status == "ERROR") {
					if(response.data == "END_SESSION") {
						location.href = LOGIN_PATH;
						return;
					}
					alert(response.data);
				} else if(response.status == "OK") {	
					parent.reload = true;
					if($("#id").val()!="") {
					   parent.isUpdate = true;
					}
					showDialogUrl("${formURL}?cuocDauNoi="+response.data.cuocDauNoi+"&giaTriTruocThue="+response.data.giaTriTruocThue+"&giaTriSauThue="+response.data.giaTriSauThue+"&soLuongKenh="+response.data.soLuongKenh+"&id="+$("#id").val(),"Lưu giá trị phụ lục",500);
				}
			},
			error: function(data){ alert (data);button.disabled = false;}	
		});	
	});
	$("#frmTinhGiaTriPhuLuc .currency").formatCurrency({ 
		region : 'vn',
		roundToDecimalPlace: 0, 
		eventOnDecimalsEntered: true 
	});
	$('#frmTinhGiaTriPhuLuc .currency').live("blur",function(){
		$(this).formatCurrency({ 
			region : 'vn',
			roundToDecimalPlace: 0, 
			eventOnDecimalsEntered: true 
		});
	});
	$('#frmTinhGiaTriPhuLuc .currency').live("focusin",function(){
		$(this).toNumber({region:'vn'}).select();
	});
});
</script>