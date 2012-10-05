<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="load" namespace="/tuyenkenhdexuat" id="loadURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/include/header.jsp"%>
<style>
.block {
float: left;
margin-left: 10px;
}
</style>
</head>
<body>
	<div id="bg_wrapper">
		<div style="width: 100%; margin-bottom: 10px;" class="ovf">
			<div class="s10">
				<div class="fl">
					<div class="fl tsl" id="t_1">
					</div>
					<div class="fl clg b tsc d" id="t_2">
						<div class="p3t">Tìm kiếm đề xuất tuyến kênh</div>
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
								<form id="form">
								<tbody id="display">
								<tr>
									<td width="150px" align="right">
										Mã kênh :
									</td>
									<td align="left">
										<input type="text" name="makenh" id="makenh"/>
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
								<tbody>
								<tr>
									<td align="right">Ngày hẹn bàn giao :</td>
									<td align="left">
										<input type="text" name="ngayhenbangiao" id="ngayhenbangiao" class="date">
									</td>
									<td align="right">Ngày đề nghị bàn giao :</td>
									<td align="left"><input type="text" name="ngaydenghibangiao"
										id="ngaydenghibangiao" class="date"/></td>
								</tr>
								<tr>
									<td align="right">Đơn vị nhận kênh :</td>
									<td align="left">
										<select name="phongban" id="phongban">
											<option value="">---Chọn---</option>
											<s:iterator value="phongBans">
												<option value='<s:property value="id" />'><s:property value="tenphongban" /></option>									
											</s:iterator>
										</select>
									</td>
									<td align="right">
										Trạng thái :
									</td>
									<td align="left">
										<select name="trangthai" id="trangthai">
											<option value="">-- Chọn --</option>
											<option selected=true value="-1">Chưa có biên bản đề xuất</option>
											<option value="0">Đang bàn giao</option>
											<option value="1">Đã bàn giao</option>
											<option value="2">Đã có biên bản bàn giao</option>
										</select>
									</td>
								</tr>
								</tbody>
								</form>
								<tfoot>
									<td></td>
									<td align="left">
									<input class="button" type="button" value="Tìm Kiếm" onclick="doSearch()"/>
									<input class="button" type="button" value="Reset" onclick="reset()"/>
									<input class="button" id="btSelect" style="display:none" type="button" value="Chọn" onclick="doClose()"/>
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
		</div>
			<table width="100%" id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th></th>
					<th>Mã kênh</th>
					<th>Mã điểm đầu</th>
					<th>Mã điểm cuối</th>
					<th>Giao tiếp</th>
					<th>Dung lượng</th>
					<th>Số lượng đề xuất</th>
					<th width="120px">ĐV nhận kênh</th>
					<th>Ngày đề nghị BG</th>
					<th>Ngày hẹn BG</th>
					<th width="5px">Trạng thái</th>
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
$(document).ready(function(){	 
	$( "input.date" ).datepicker({
		showButtonPanel: true,
		dateFormat : "dd/mm/yy"
	});
	var json_data = '<s:property value="json_data" escape="false"/>';
	if(json_data != '') {
		var json_data = $.parseJSON(json_data);
		for( key in json_data) {
			var input = $("#"+key);
			$("option",input).each(function(){
				if(this.value != json_data[key])
					$(this).attr("disabled","true");
			});
			input.val(json_data[key]);
		}
	}
	$("#chkAdvSearch").click(function(){
		if(this.checked == true) {
			$("#hidden").show();
		} else {
			$("#hidden").hide();
		}
	});
	$('#dataTable input[type=checkbox]').live("click",function(){
		if($('#dataTable input:checked').size()>0) {
			$("#btSelect").show();
		} else {
			$("#btSelect").hide();
		}
	});
	seq = 0;
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${loadURL}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false },
					{ "mDataProp": "id","bSortable": false,"bSearchable": false,"sClass":'td_hidden'},
					{ "mDataProp": "tuyenkenh_id","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "madiemdau","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "madiemcuoi","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "loaigiaotiep","bSortable": false,"bSearchable": false},
					{ "mDataProp": "dungluong","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "soluong","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "tenphongban","bSortable": false,"bSearchable": false},
					{ "mDataProp": "ngaydenghibangiao","bSortable": false,"bSearchable": false},
					{ "mDataProp": "ngayhenbangiao","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center>'+trangthai_utils.tuyenkenhdexuatDisplay(oObj.aData.trangthai)+'</center>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><input type="checkbox" value="'+oObj.iDataRow+'"/></center>'; 
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
		"sPaginationType": "two_button"
	});
	doSearch();
});
function doClose(){
	var data = [];
	$('#dataTable tbody input:checked').each(function(){
		data.push(oTable.fnGetData(this.value));
	});
	window.opener.popup_search_tuyenkenhdexuat.afterSelected(data);
	window.close();
}
</script>