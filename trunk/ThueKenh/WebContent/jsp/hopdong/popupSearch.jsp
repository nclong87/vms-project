<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="ajLoadHopDong" namespace="/hopdong" id="ajLoadHopDong"/>
<s:url action="detail" namespace="/hopdong" id="detailURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
	<div id="bg_wrapper">
		<div style="width: 100%; margin-bottom: 10px;" class="ovf">
			<div class="s10">
				<div class="fl">
					<div class="fl tsl" id="t_1">
					</div>
					<div class="fl clg b tsc d" id="t_2">
						<div class="p3t">Tìm kiếm hợp đồng</div>
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
										<td align="right">Loại hợp đồng :</td>
										<td><select style="width: 220px" name="loaihopdong" id="loaihopdong">
												<option value="">---Tất cả---</option>
												<option value="1">Có thời hạn</option>
												<option value="0">Không thời hạn</option>
										</select></td>
									</tr>
									<tr>
										<td align="right">Số hợp đồng :</td>
										<td><input type="text" name="sohopdong" id="sohopdong" style="width: 218px"/></td>
										<td align="right">Đối tác :</td>
										<td>
											<select style="width: 220px" name="sdoitac_id" id="sdoitac_id">
													<option value="">---Chọn---</option>
													<s:iterator value="doiTacs">
														<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
													</s:iterator>
											</select>
											<input type='text' name="doitac_id" id="doitac_id" style="display:none"></input>
										</td>

									</tr>
									<tr>
										<td align="right">Ngày ký từ:</td>
										<td align="left"><input type="text"
											name="ngaykytu" id="ngaykytu" style="width: 218px" class="datepicker"/>
										</td>
										<td align="right">Ngày ký đến :</td>
										<td align="left"><input type="text"
											name="ngaykyden" id="ngaykyden" style="width: 218px" class="datepicker"/>
										</td>

									</tr>
									<tr>
										<td align="right">Ngày hết hạn từ:</td>
										<td align="left"><input type="text"
											name="ngayhethantu" id="ngayhethantu" style="width: 218px" class="datepicker"/>
										</td>
										<td align="right">Ngày hết hạn đến :</td>
										<td align="left"><input type="text"
											name="ngayhethanden" id="ngayhethanden" style="width: 218px" class="datepicker"/>
										</td>

									</tr>
								<tfoot>
									<td></td>
									<td align="left">
									<input class="button" type="button" value="Tìm Kiếm" onclick="doSearch()" id="btsearch"/>
									<input class="button" type="button" value="Reset" onclick="reset()"/>
									<input class="button" id="btSelect" style="display:none" type="button" value="Chọn" onclick="doClose()"></input>
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
				<th width="30px">Số hợp đồng</th>
				<th width="30px">Loại hợp đồng</th>
				<th width="30px">Đối tác</th>
				<th width="30px">Ngày ký</th>
				<th width="30px">Ngày hết hạn</th>
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
	
	//doitac
	var doitac="<s:property value='doitac'/>";
	if(doitac!="")
	{
		$("#sdoitac_id").val(doitac);
		$("#sdoitac_id").attr("disabled",true);
		$("#doitac_id").val(doitac);
	}
	// load datetime
	$( ".datepicker" ).datepicker({
		showButtonPanel: true,
		dateFormat : "dd/mm/yy"
	});
	
	// Load table
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${ajLoadHopDong}",
		"aoColumns": [{ "mDataProp": "stt","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					  { 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${detailURL}?id='+oObj.aData.id+'" title="Xem chi tiết hợp đồng">'+oObj.aData.sohopdong+'</a>'; 
						}
					  },
					  { "mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							if(oObj.aData.loaihopdong==0)
								return "Không thời hạn";
							else
								return "Có thời hạn";
						}
					  },
					{ "mDataProp": "tendoitac","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "ngayky","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "ngayhethan","bSortable": false,"bSearchable": false},					
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
	$("#btsearch").click();
});
function doClose(){
	var data = [];
	$('#dataTable tbody input:checked').each(function(){
		data.push(oTable.fnGetData(this.value));
	});
	window.opener.popup_search_hopdong.afterSelected(data);
	window.close();
}
</script>