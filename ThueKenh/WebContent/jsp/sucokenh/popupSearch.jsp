<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="ajLoadSuCoWithBBVH" namespace="/sucokenh" id="ajLoadSuCoWithBBVH"/>
<s:url action="detail" namespace="/sucokenh" id="detailURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_tuyenkenh.js"></script>
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
						<div class="p3t">Tìm kiếm sự cố</div>
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
									<td>Đối tác</td>
									<td colspan="3">
										<select name="doitac" id="doitac" style="width:220px">
											<option value="">---Tất cả---</option>
											<s:iterator value="doiTacDTOs">
												<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
											</s:iterator>
										</select>
									</td>
								</tr>
								<tr>
									<td align="right">Mã tuyến kênh</td>
									<td><input type="text" style="width: 182px" name="tuyenkenh_id" id="tuyenkenh_id"/><input type="hidden" style="width: 218px" name="bienbanvanhanh_id" id="bienbanvanhanh_id" value="0" /><input type="button" id="btPopupSearchTuyenkenh" value="..."/></td>
									<td align="right">Dung lượng (MB) :</td>
									<td><input type="text" style="width: 218px" name="dungluong" id="dungluong" /></td>
									
								</tr>
								<tr>
									<td align="right">Mã điểm đầu :</td>
									<td><input type="text" style="width: 218px" name="madiemdau" id="madiemdau"/></td>
									<td align="right">Mã điểm cuối :</td>
									<td><input type="text" style="width: 218px" name="madiemcuoi" id="madiemcuoi"/></td>
								</tr>
								<tr>
									<td align="right">Thời điểm bắt đầu :</td>
									<td align="left"><input type="text"
										name="thoidiembatdau" id="thoidiembatdau" style="width: 218px" class="datetimepicker"/>
									</td>
									<td align="right">Thời điểm kết thúc :</td>
									<td align="left"><input type="text"
										name="thoidiemketthuc" id="thoidiemketthuc" style="width: 218px" class="datetimepicker"/>
									</td>

								</tr>
								<tr>
									<td align="right">Người xác nhận :</td>
									<td><input type="text"
										name="nguoixacnhan" id="nguoixacnhan" style="width: 218px"/></td>
								</tr>
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
		<table width="100%" id="dataTable" class="display">
		<thead>
			<tr>
				<th width="3px">STT</th>
				<th width="30px">Mã tuyến kênh</th>
				<th>Mã điểm đầu</th>
				<th>Mã điểm cuối</th>
				<th>Giao tiếp</th>
				<th>Dung lượng</th>
				<th width="50px">Thời gian bắt đầu</th>
				<th width="50px">Thời gian kết thúc</th>
				<th width="50px">Thời gian mất liên lạc</th>
				<th width="50px">Nguyên nhân</th>
				<th width="50px">Phương án xử lý</th>
				<th width="50px">Người xác nhận</th>
				<th width="50px">Người tạo</th>
				<th width="50px">Chi tiết</th>
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
function doReset() {
	$("#form")[0].reset(); //Reset form cua jquery, giu lai gia tri mac dinh cua cac field
	byId("msg").innerHTML="";
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
	// load datetime
	LoadDateTimePicker(".datetimepicker");
	// Load table
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${ajLoadSuCoWithBBVH}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false },
					{ "mDataProp": "tuyenkenh_id","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "madiemdau","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "madiemcuoi","bSortable": false,"bSearchable": false},
					{ "mDataProp": "loaigiaotiep","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "dungluong","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "thoidiembatdau","bSortable": false,"bSearchable": false},
					{ "mDataProp": "thoidiemketthuc","bSortable": false,"bSearchable": false},
					{ "mDataProp": "thoigianmll","bSortable": false,"bSearchable": false},
					{ "mDataProp": "nguyennhan","bSortable": false,"bSearchable": false},
					{ "mDataProp": "phuonganxuly","bSortable": false,"bSearchable": false},
					{ "mDataProp": "nguoixacnhan","bSortable": false,"bSearchable": false},
					{ "mDataProp": "usercreate","bSortable": false,"bSearchable": false},
					{ "mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${detailURL}?id='+oObj.aData.id+'" title="Xem chi tiết sự cố"><div class="detail"></div></a>';  
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><input type="checkbox" value="'+oObj.iDataRow+'"/></center>'; 
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
	$('#dataTable input[type=checkbox]').live("click",function(){
		if($('#dataTable input:checked').size()>0) {
			$("#btSelect").show();
		} else {
			$("#btSelect").hide();
		}
	});
});
function doClose(){
	var data = [];
	$('#dataTable tbody input:checked').each(function(){
		data.push(oTable.fnGetData(this.value));
	});
	window.opener.popup_search_suco.afterSelected(data);
	window.close();
}
</script>