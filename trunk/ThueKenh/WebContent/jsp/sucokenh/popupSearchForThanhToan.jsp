<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="ajLoadSuCoForThanhToan" namespace="/sucokenh" id="ajLoadSuCoForThanhToanURL"/>
<s:url action="popupSearch" namespace="/tuyenkenh" id="popupSearchURL" />
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
	<form id="form">
		<input type="text" name="tungay" value="<s:property value='tungay'/>" style="display:none" />
		<input type="text" name="denngay" value="<s:property value='denngay'/>" style="display:none"/>
		<input type="text" value="<s:property value='ids'/>" name="phulucids" id="phulucids" style="display:none"/>									
		<input class="button" id="btSelect" style="display:none" type="button" value="Chọn" onclick="doClose()"/>
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
	</form>
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
	var seq=0;
	// Load table
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${ajLoadSuCoForThanhToanURL}",
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