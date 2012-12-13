<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="doSave" namespace="/chitietphuluc" var="doSaveURL"/>
<s:url action="form" namespace="/chitietphuluc" var="formURL"/>
<s:url action="popupSearch2" namespace="/tuyenkenh" id="popupSearch2URL" />
<s:url action="getAllCongThuc" namespace="/ajax" id="getAllCongThucURL" />
<s:url action="getAllLoaiGiaoTiep" namespace="/ajax" id="getAllLoaiGiaoTiepURL" />
<s:url action="index" namespace="/popup" id="popupURL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header1.jsp"%>
	<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_tuyenkenh.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>
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
tr.error {
color:red;
}
</style>
</head>
<body>
	<div id="dialog" title="Welcome to VMS"><center>Loading...</center></div>
	<div id="bg_wrapper">
		<div style="width: 100%; margin-bottom: 10px;" class="ovf">
			<div id="divSearch" class="ovf" style="padding-right: 0px;">
				<div class="kc4 p5l p15t bgw">
					<div class="bgw p5b ovf" id="tabnd_2">
						<div class="ovf p5l p5t">
							<table>
								<tr>
									<td align="left">
										<input class="button" type="button" value="Chọn kênh cần tính giá trị" id="btPopupSearchTuyenkenh">
										<input class="button" type="button" value="Import từ excel" id="btPopupImport">
										<input type="button" class="button" value="Tính giá trị phụ lục" id="btTinhGiaTriPhuLuc" style="display:none"></input>
									</td>

								</tr>
							</table>
						</div>
					</div>
					<div class="clearb"></div>
				</div>
			</div>
			<div style="height: 1px;"></div>
		</div>
		<div style="clear:both;margin:5px 0;width:100% ">
		</div>
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
		</form>
		</div>
	<div id="footer"></div>
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
	var numError = 0;
	$("#dataTable tbody tr").each(function(){
		$("#stt",this).text(i);
		if($("#tuyenkenh_id",this).val() =="") {
			$(this).addClass("error");
			numError++;
		}
		i++;
	});
	if(numError > 0) {
		alert("Phát hiện có "+numError+" tuyến kênh bị lỗi, vui lòng kiểm tra lại những dòng màu đỏ!");
	}
	if(i > 1 && numError ==0) {
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
function clearDatatable(){
	$("#dataTable tbody tr").each(function(){
		oTable.fnDeleteRow(oTable.fnGetPosition(this));
	});
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
		})
	}
	var result = '';
	if(arrCongThuc != null) {
		$.each(arrCongThuc, function(){
			if((this.isdefault == "1" && congthuc_id=="") || this.id == congthuc_id) { // cong thuc mac dinh
				result+= '<option selected value="'+this.id+'">'+this.tencongthuc+'</option>';
			} else {
				result+= '<option value="'+this.id+'">'+this.tencongthuc+'</option>';
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
		})
	}
	var result = 0;
	if(arrLoaiGiaoTiep != null) {
		result = arrLoaiGiaoTiep[i].cuoccong; 
	}
	return result;
}
function addRow(data) {
	oTable.fnAddData([
		'<input type="text" id="loaigiaotiep" style="display:none" value="'+data.loaigiaotiep+'"/><span id="stt"></span>',
		'<a target="_blank" href="tuyenkenh/Chi tiet tuyen kenh.html">'+data.id+'</a>',
		data.madiemdau,data.madiemcuoi,data.loaigiaotiep,data.dungluong,
		'<input type="text" id="soluong" disabled="true" style="width:30px;text-align:center" value="'+data.soluong+'"/>',
		'<input type="text" class="currency" id="cuoccong" style="width:120px;text-align:right" value="'+(data.cuoccong != ''?data.cuoccong:generateCuocCongValue(data.giaotiep_id))+'"/>',
		'<input type="text" class="currency" id="cuocdaunoi" style="width:120px" value="'+data.cuocdaunoi+'" />',
		'<input type="text" class="currency" id="dongia" style="width:120px" value="'+data.dongia+'"/>',
		'<input type="text" maxlength="2" id="giamgia" style="width:30px;text-align:center" value="'+data.giamgia+'"/> %',
		'<select id="congthuc_id" style="width: 100px"><option>---SELECT---</option>'+generateCongThucOptions(data.congthuc_id)+'</select>',
		'<input type="text" style="display:none" value="'+data.id+'" id="tuyenkenh_id"/><input type="text" style="display:none" value="'+data.id+'" id="tuyenkenh_'+data.id+'"/><img title="Remove" src="'+baseUrl+'/images/icons/remove.png" onclick="doRemoveRow(this)" style="cursor:pointer">'
	]);
}
var seq = 0;
$(document).ready(function(){
	popup_search_tuyenkenh.init({
		url : "${popupSearch2URL}",
		afterSelected : function(data) {
			$.each(data,function(){
				if($("#frmTinhGiaTriPhuLuc #tuyenkenh_"+this.id).length == 0) {
					this.congthuc_id="";
					this.cuocdaunoi=0;
					this.dongia = 0;
					this.giamgia = 0;
					this.cuoccong = '';
					addRow(this);
				}
			});
			rowChanges(1);
		}
	});
	$("#btThem").click(function(){
		ShowWindow('Thêm mới  văn bản đề xuất',750,500,"${formURL}",false);
	});
	$("#btPopupImport").click(function(){
		//clearDatatable();
		showDialogUrl("${popupURL}?action=1",'Import tuyến kênh tính giá trị phụ lục',520);
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
					showDialogUrl("${formURL}?cuocDauNoi="+response.data.cuocDauNoi+"&giaTriTruocThue="+response.data.giaTriTruocThue+"&giaTriSauThue="+response.data.giaTriSauThue+"&soLuongKenh="+response.data.soLuongKenh,"Lưu giá trị phụ lục",500);
				}
			},
			error: function(data){ alert (data);button.disabled = false;}	
		});	
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
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bAutoWidth": false,
		"bSort":false,
		"bFilter": false,
		"bInfo": false,
		"bPaginate" : false
	});
});
</script>