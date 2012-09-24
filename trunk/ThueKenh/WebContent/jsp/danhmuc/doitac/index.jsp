
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL" />
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="index" namespace="/settings" var="settingsIndexURL" />

<s:url action="ajLoaddoitac" namespace="/danhmuc" id="ajLoadData" />
<s:url action="editdoitac" namespace="/danhmuc" id="formURL" />
<s:url action="deletedoitac" namespace="/danhmuc" id="ajDeleteURL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script>
	var LOGIN_PATH = "${loginURL}";
</script>
<%@include file="/include/header.jsp"%>
<script
	src="<%=request.getContextPath()%>/js/mylibs/permission_popup.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-window-5.03/jquery.window.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/utils.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/js/jquery-window-5.03/css/jquery.window.css"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/search_box.css"
	type="text/css" media="screen" />
<script>
	function doNew(link) {
		ShowWindow('Thêm đối tác mới', 800, 400, link, false);
	}
	function doEdit(link) {
		ShowWindow('Cập nhật đối tác', 800, 400, link, false);
	}
	function hasChecked() {
		var lstCheckbox = $('#dataTable input[type=checkbox]');
		for (i = 0; i < lstCheckbox.length; i++) {
			if ("checked" == $(lstCheckbox[i]).attr("checked")) {
				return true;
			}
		}
		alert("Không có đối tượng nào được chọn");
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
		<center>
		<div class="ovf" style="width: 100%; margin-bottom: 5px;">
			<div class="s10">
				<div class="fl">
					<div id="t_1" class="fl tsl"></div>
					<div id="t_2" class="fl clg b tsc d">
						<div class="p3t">Quản lí đối tác</div>
					</div>
					<div id="t_3" class="fl tsr"></div>
				</div>
				<div class="lineU"></div>
			</div>
			<div style="padding-right: 0px;" class="ovf" id="divSearch">
				<div class="kc4 p5l p15t bgw">
					<div id="tabnd_2" class="bgw p5b ovf">
						<form id="form">

						</form>
					</div>
					<div class="clearb"></div>
				</div>
			</div>
			<div style="height: 1px;"></div>
		</div>
		<div style="width: 99%">


			<div style="float: left; margin-bottom: 5px">
				<input type="button" value="Thêm đối tác" id="btThem"
					class="button" onclick="doNew('${formURL}')"><input
					type="button" value="Xóa" id="btnDelete" class="button">

			</div>

			<div style="display: block; height: 5px;"></div>
			<table width="100%" id="dataTable" class="display">
				<thead>
					<tr>
						<th width="3px">STT</th>
						<th width="5%">ID</th>
						<th width="10%">Mã</th>
						<th>Tên đối tác</th>
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
		</div>
		</center>
	</div>
	<div id="footer"></div>
</body>
</html>
<script>
	function loadContent(url) {
		location.href = contextPath + url;
	}
	function selectAll(_this) {
		$('#dataTable input[type=checkbox]').each(function() {
			this.checked = _this.checked;
		});
	}
	function doSearch() {
		var frm = $('#form');
		var dat = "{'array':" + stringify(frm.serializeArray()) + "}";
		oTable.fnFilter(dat);
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
				"url":'${ajDeleteURL}', 
				"data": "ids="+str, 
				"success": fnCallbackDelete
			} );
			block('#bg_wrapper');
		}
	});

	function fnCallbackDelete(data){
		if(data.isDeleted){
			//refresh();
			unblock('#bg_wrapper');
			oTable.fnDraw(false);
		}
	}
	
	var account_id = '';
	function openPermissionWindow(id) {
		account_id = id;
		permission_popup.url_init = "${getMenusByAccountURL}?account_id="
				+ account_id;
		showDialogUrl("${permissionPopupURL}?id=" + id, 'Phân quyền user', 610);
	}
	$(document)
			.ready(
					function() {
						$('ul.sf-menu').superfish();
						$("#btLock").click(function() {
							doLock(0);
						});
						$("#btUnlock").click(function() {
							doLock(1);
						});
						permission_popup.afterSelected = function(data) {
							var dataString = '&id=' + account_id;
							$.each(data, function() {
								dataString += "&menu_id=" + this.id;
							});
							$
									.ajax({
										type : "POST",
										cache : false,
										url : "${saveAccountMenuURL}",
										data : dataString,
										success : function(data) {
											$("#btChon",
													permission_popup.dialog)[0].disabled = true;
											if (data.status == 0) {
												processErrorMessage(data.data);
												return;
											}
											if (data.status == 1) {
												unblock('#bg_wrapper');
												oTable.fnDraw(false);
												alert("Thao tác thành công!");
												permission_popup.dialog
														.dialog("close");
												return;
											}
										},
										error : function(data) {
											$("#btChon",
													permission_popup.dialog)[0].disabled = true;
										}
									});
						}
						oTable = $('#dataTable')
								.dataTable(
										{
											"bJQueryUI" : true,
											"bProcessing" : true,
											"bServerSide" : true,
											"bAutoWidth" : false,
											"sAjaxSource" : "${ajLoadData}",
											"aoColumns" : [
													{
														"mDataProp" : "STT",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : "ID",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : "MA",
														"bSortable" : false,
														"bSearchable" : false,
														"sClass" : 'td_center'
													},
													{
														"mDataProp" : "TENDOITAC",
														"bSortable" : false,
														"bSearchable" : false
													},
													{
														"mDataProp" : null,
														"bSortable" : false,
														"bSearchable" : false,
														"fnRender" : function(
																oObj) {
															return '<center><a class="edit_icon" onclick="doEdit(\'${formURL}?id='
																	+ oObj.aData.ID
																	+ '\')" title="Edit" href="#"></a></center>';
														}
													},
													{
														"mDataProp" : null,
														"bSortable" : false,
														"bSearchable" : false,
														"fnRender" : function(
																oObj) {
															return '<center><input type="checkbox" value="'+oObj.aData.ID+'"/></center>';
														}
													} ],
											"fnServerData" : function(sSource,
													aoData, fnCallback) {
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
					});

	
</script>