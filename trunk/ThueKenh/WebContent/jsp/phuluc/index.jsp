
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="load" namespace="/phuluc" id="loadURL"/>
<s:url action="form" namespace="/phuluc" id="formURL"/>
<s:url action="delete" namespace="/phuluc" id="deleteURL"/>
<s:url action="detail" namespace="/phuluc" id="detailPhuLucURL"/>
<s:url action="detail" namespace="/hopdong" id="detailHopDongURL"/>
<s:url action="index" namespace="/chitietphuluc" id="indexChiTietPhuLucURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
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
						<div class="p3t">Tìm kiếm phụ lục hợp đồng</div>
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
							<table width="650px">
								<form id="form">
								<tbody id="display">
								<tr>
									<td width="100px" align="right">
										Số hợp đồng :
									</td>
									<td align="left">
										<select name="sohopdong" id="sohopdong">
											<option value="">---Chọn hợp đồng---</option>
											<s:iterator value="hopDongDTOs">
												<option disabled="true"><s:property value="value.tendoitac" /></option>
												<s:iterator value="value.hopdong">
													<option style="padding-left:20px" value='<s:property value="id" />'><s:property value="sohopdong" /></option>
												</s:iterator>
											</s:iterator>
										</select>
									</td>
									<td align="right" width="100px">
										Tên phụ lục :
									</td>
									<td align="left">
										<input type="text" name="tenphuluc" />
									</td>
								</tr>
								<tr>
									<td align="right">Loại phụ lục :</td>
									<td align="left">
										<select name="loaiphuluc">
												<option value="">---Tất cả---</option>
												<option value="1">Độc lập</option>
												<option value="2">Thay thế</option>
										</select>
									</td>
									<td align="right">Trạng thái :</td>
									<td align="left">
										<select name="trangthai">
												<option value="">---Tất cả---</option>
												<option value="1">Còn hiệu lực</option>
												<option value="0">Hết hiệu lực</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="right" width="150px">
										Ngày ký :
									</td>
									<td align="left" colspan="3">
										<input type="text" name="ngayky_from" class="date">
										<span style="margin-left:5px;margin-right:5px">đến</span>
										<input type="text" name="ngayky_end" class="date">
									</td>
								</tr>
								<tr>
									<td align="right" width="150px">
										Ngày hiệu lực :
									</td>
									<td align="left" colspan="3">
										<input type="text" name="ngayhieuluc_from" class="date">
										<span style="margin-left:5px;margin-right:5px">đến</span>
										<input type="text" name="ngayhieuluc_end" class="date">
									</td>
								</tr>
								</tbody>
								</form>
								<tfoot>
									<td></td>
									<td align="left">
									<input class="button" type="button" value="Tìm Kiếm" onclick="doSearch()"/>
									<input class="button" type="button" value="Reset" onclick="reset()"/>
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
		<div style="width: 100%; clear: both; float: left; margin: 5px;">
		<input class="button" type="button" id="btThem" value="Thêm mới phụ lục" style="float: left; margin-right: 10px;" />
		<input class="button" type="button" id="btXoa" value="Xóa" style="float: left; margin-right: 10px;"/>
		<input class="button" type="button" value="Tính giá trị phụ lục" style="float: left; margin-right: 10px;" onclick="location.href='${indexChiTietPhuLucURL}'"/>
		</div>
			<table width="100%" id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th>Tên phụ lục</th>
					<th>Hợp đồng</th>
					<th>Loại phụ lục</th>
					<th>Số lượng kênh</th>
					<th>Thành tiền trước thuế</th>
					<th>Thành tiền sau thuế</th>
					<th>Cước đấu nối hòa mạng</th>
					<th>Ngày ký phụ lục</th>
					<th>Ngày có hiệu lực</th>
					<th>Ngày hết hiệu lực</th>
					<th width="100px" align="center">Thay thế</th>
					<th width="5px" align="center">Sửa</th>
					<th width="5px" align="center"><input type="checkbox" onclick="selectAll(this)"/></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="15" class="dataTables_empty">Đang tải dữ liệu...</td>
				</tr>
			</tbody>
			</table>
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
var seq = 0;
$(document).ready(function(){	 
	$( "input.date" ).datepicker({
		showButtonPanel: true,
		dateFormat : "dd/mm/yy"
	});
	$("#btThem").click(function(){
		ShowWindow('Thêm mới phụ lục hợp đồng',750,500,"${formURL}",true);
		MaxWindow();
	});
	$("#btXoa").click(function(){
		var dataString = '';
		$('#dataTable input[type=checkbox]').each(function(){
			if(this.checked==true) {
				if(this.value!='on')
					dataString+='&ids='+this.value;
			}
		});
		if(dataString=='') {
			alert('Bạn chưa chọn dòng để xóa!');
			return;
		}
		if(!confirm("Bạn muốn xóa dữ liệu?")) return;
		var button = this;
		button.disabled = true;
		$.ajax({
			type: "POST",
			cache: false,
			url : "${deleteURL}",
			data: dataString,
			success: function(data){
				button.disabled = false;
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
			error: function(data){ alert (data);button.disabled = false;}	
		});	
	});
	$("span.edit_icon").live("click",function(){
		var id = $(this).attr("data-ref-id");
		ShowWindow('Cập nhật phụ lục hợp đồng',750,500,"${formURL}?id="+id,false);
		MaxWindow();
	});
	$('ul.sf-menu').superfish();
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${loadURL}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${detailPhuLucURL}?id='+oObj.aData.id+'" title="Xem chi tiết phụ lục">'+oObj.aData.tenphuluc+'</a>'; 
						}
					},
					//{ "mDataProp": "sohopdong","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${detailHopDongURL}?id='+oObj.aData.hopdong_id+'" title="Xem chi tiết hợp đồng">'+oObj.aData.sohopdong+'</a>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							if(oObj.aData.loaiphuluc == 1) {
								return "Độc lập";
							} else {
								return "Thay thế";
							}
						}
					},
					{ "mDataProp": "soluongkenh","bSortable": false,"bSearchable": false},
					{ "mDataProp": "giatritruocthue","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ "mDataProp": "giatrisauthue","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ "mDataProp": "cuocdaunoi","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ "mDataProp": "ngayky","bSortable": false,"bSearchable": false},
					{ "mDataProp": "ngayhieuluc","bSortable": false,"bSearchable": false},
					{ "mDataProp": "ngayhethieuluc","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							var str = "";
							$.each(oObj.aData.phulucbithaythe,function(){
								str+='<a href="${detailPhuLucURL}?id='+this.id+'" title="'+this.tenphuluc+'">'+this.tenphuluc.vmsSubstr(20)+"</a><br>";
							})
							return str; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><span class="edit_icon" data-ref-id="'+oObj.aData.id+'" title="Edit" href="#"></span></center>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><input type="checkbox" value="'+oObj.aData.id+'"/></center>'; 
						}
					}
				],
		"fnServerData": function ( sSource, aoData, fnCallback ) {
			seq++;
			if(seq == 1) return;
			$.ajax( {
				"dataType": 'json', 
				"type": "POST", 
				"url": sSource, 
				"data": aoData, 
				"success": fnCallback
			} );
		},
		"sPaginationType": "two_button",
		"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
			$(".number",nRow).formatCurrency({ 
				region : 'vn',
				roundToDecimalPlace: 0, 
				eventOnDecimalsEntered: true 
			});
        }
	});
	doSearch();
});
</script>