<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="ajLoadPhongBan" namespace="/danhmuc"
	id="ajLoadPhongBanURL" />
<s:url action="deletePhongBan" namespace="/danhmuc" id="ajDeleteURL" />
<s:url action="editPhongBan" namespace="/danhmuc" id="formURL" />
<%@include file="/jsp/shared/header.jsp"%>


<%-- 
<div style="width: 100%" class="ovf">
	<div class="s10">
		<div class="fl">
			<div class="fl tsl" id="t_1"></div>
			<div class="fl clg b tsc d" id="t_2">
				<div class="p3t">Tìm kiếm phòng ban</div>
			</div>
			<div class="fl tsr" id="t_3"></div>
		</div>
		<div class="lineU">
			<img height="1px" alt="" class="w100"
				src="<%=contextPath%>/content/images/spacer.gif">
		</div>
	</div>
	<div id="divSearch" class="ovf" style="padding-right: 0px;">
		<div class="kc4 p5l p15t bgw">
			<div class="bgw p5b ovf" id="tabnd_2">
				<div class="ovf p5l p5t">
					<form id="fSearch" onsubmit="return false;">
						<table>
							<tr>
								<td align="right">Tên phòng ban :</td>
								<td align="left"><input type="text" name="opEdit.name"
									id="opEdit.name" /></td>
								<td><input type="button" onclick="doSearch()"
									class="button" value="Tìm kiếm"></input></td>
							</tr>

						</table>
					</form>
				</div>
			</div>
			<div class="clearb"></div>
		</div>
	</div>
</div> --%>
<div style="clear: both; margin: 5px 0">
	<input type="button" class="button" value="Thêm phòng ban"
		onclick="ShowWindow('Thêm phòng ban',600,300,'${formURL}',false);"></input>
	<input type="button" id="btnDelete" class="button" value="Xóa chọn"></input>

</div>
<table width="100%" id="dataTable" class="display">
	<thead>
		<tr>
			<th width="5%">#</th>
			<th width="5%">ID</th>
			<th>Tên phòng ban</th>
			<th width="5px">Edit</th>
			<th width="5px" align="center"><input type="checkbox"
				onclick="selectAll(this)" /></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td colspan="10" class="dataTables_empty">Đang tải dữ liệu...</td>
		</tr>
	</tbody>
</table>
<%@include file="/jsp/shared/footer.jsp"%>

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
$("#btnDelete").click(function(){
	var str="";
	$('#dataTable input[type=checkbox]').each(function(){
		if(this.checked==true){
			if(this.value>0)
				str+=this.value+",";
		}
	});
	if(str.length>0){
		str=str.substring(0, str.length-1);
		$.ajax( {
			"dataType": 'json', 
			"type": "POST", 
			"url":'/ThueKenh/danhmuc/deletePhongBan.action', 
			"data": "ids="+str, 
			"success": fnCallbackDelete
		} );
	}
});

function fnCallbackDelete(data){
	if(data.isDeleted){
		//refresh();
		oTable.fnDraw(false);
	}
}

function doEdit(url){
	ShowWindow('Sửa phòng ban',400,200,url,false);
}

function refresh(){
	contextPath='<%=contextPath%>';

		oTable = $('#dataTable')
				.dataTable(
						{
							"bJQueryUI" : true,
							"bProcessing" : true,
							"bServerSide" : true,
							"bAutoWidth" : false,
							"sAjaxSource" : "${ajLoadPhongBanURL}",
							"aoColumns" : [
									{
										"mDataProp" : "stt",
										"bSortable" : false,
										"bSearchable" : false
									},
									{
										"mDataProp" : "id",
										"bSortable" : false,
										"bSearchable" : false,
										"sClass" : 'td_center'
									},
									{
										"mDataProp" : "name",
										"bSortable" : false,
										"bSearchable" : false
									},
									{
										"mDataProp" : null,
										"bSortable" : false,
										"bSearchable" : false,
										"fnRender" : function(oObj) {
											return '<center><a class="edit_icon" onclick="doEdit(\'${formURL}?id='
													+ oObj.aData.id
													+ '\')" title="Edit" href="#"></a></center>';
										}
									},
									{
										"mDataProp" : null,
										"bSortable" : false,
										"bSearchable" : false,
										"fnRender" : function(oObj) {
											return '<center><input type="checkbox" value="'+oObj.aData.id+'"/></center>';
										}
									} ],
							"fnServerData" : function(sSource, aoData,
									fnCallback) {
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

	}

	$(document).ready(function() {
		$('ul.sf-menu').load("menu.html");

		$('#divSearch input[title!=""]').hint();

		refresh();
	});
	function doSearch() {
		var frm = $('#fSearch');
		var dat = "{'array':" + stringify(frm.serializeArray()) + "}";
		oTable.fnFilter(dat);
	}
	
</script>


