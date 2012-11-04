﻿<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="load" namespace="/chitietphuluc" id="loadURL"/>
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
						<div class="p3t">Tìm kiếm giá trị phụ lục</div>
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
									<td width="120px" align="right">
										Tên giá trị phụ lục :
									</td>
									<td align="left">
										<input type="text" name="tenchitietphuluc"/>
									</td>
								</tr>
								</tbody>
								<tfoot>
									<td align="left" colspan="2">
									<input class="button" type="button" value="Tìm Kiếm" onclick="doSearch()"/>
									<input class="button" type="button" value="Reset" onclick="reset()"/>
									<input class="button" id="btSelect" type="button" value="Chọn" onclick="doClose()"/>
									</td>
								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div style="height: 1px;"></div>
		</div>
		<table width="100%" id="dataTable" class="display">
		<thead>
			<tr>
				<th width="5%">#</th>
				<th></th>
				<th>Tên giá trị PL</th>
				<th>Số lượng kênh</th>
				<th>Giá trị trước thuế</th>
				<th>Giá trị sau thuế</th>
				<th>Cước đấu nối</th>
				<th width="5px" align="center">Chọn</th>
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
	/* $('#dataTable input[type=checkbox]').live("click",function(){
		if($('#dataTable input:checked').size()>0) {
			$("#btSelect").show();
		} else {
			$("#btSelect").hide();
		}
	}); */
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${loadURL}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false },
					{ "mDataProp": "id","bSortable": false,"bSearchable": false,"sClass":'td_hidden'},
					{ "mDataProp": "tenchitietphuluc","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "soluongkenh","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "giatritruocthue","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ "mDataProp": "giatrisauthue","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ "mDataProp": "cuocdaunoi","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><input type="radio" name="radChiTietPhuLuc" value="'+oObj.iDataRow+'"/></center>'; 
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
		"sPaginationType": "two_button",
		"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
			$(".number",nRow).formatCurrency({ 
				region : 'vn',
				roundToDecimalPlace: 0, 
				eventOnDecimalsEntered: true 
			});
        }
	});
});
function doClose(){
	var data = [];
	$('#dataTable tbody input:checked').each(function(){
		data.push(oTable.fnGetData(this.value));
	});
	if(data.length == 0) {
		alert("Vui lòng chọn 1 giá trị phụ lục!");
		return;
	}
	window.opener.searchChiTietPhuLuc.afterSelected(data);
	window.close();
}
</script>