
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="ajLoadAccounts" namespace="/user" id="ajLoadAccountsURL"/>
<s:url action="lockAccounts" namespace="/user" id="lockAccountsURL"/>
<s:url action="chonKhuVucPhuTrach" namespace="/user" id="chonKhuVucPhuTrachURL"/>
<s:url action="form" namespace="/user" id="formURL"/>
<s:url action="popup" namespace="/permission" id="permissionPopupURL"/>
<s:url action="saveAccountMenu" namespace="/permission" id="saveAccountMenuURL"/>
<s:url action="getMenusByAccount" namespace="/ajax" id="getMenusByAccountURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script src="<%= request.getContextPath() %>/js/mylibs/permission_popup.js" type="text/javascript" ></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-window-5.03/jquery.window.js"></script>
	<script type="text/javascript" src="<%= request.getContextPath() %>/js/utils.js"></script>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/js/jquery-window-5.03/css/jquery.window.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/search_box.css" type="text/css" media="screen" />
	<script>
	function doNew(link) {
		ShowWindow('Thêm tài khoản mới',720,400,link,false);
	}
	function doEdit(link) {
		ShowWindow('Cập nhật tài khoản',720,400,link,false);
	}
	function hasChecked(){
		var lstCheckbox=$('#dataTable input[type=checkbox]');
		for(i=0;i<lstCheckbox.length;i++){
			if("checked"==$(lstCheckbox[i]).attr("checked")){
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
							<div class="p3t">Tìm kiếm user</div>
						</div>
						<div id="t_3" class="fl tsr"></div>
					</div>
					<div class="lineU">
					</div>
				</div>
				<div style="padding-right: 0px;" class="ovf" id="divSearch">
					<div class="kc4 p5l p15t bgw">
						<div id="tabnd_2" class="bgw p5b ovf">
						<form id="form">
			<div style=" padding-top: 5px; padding-bottom: 3px; display: block;">
			<div class="block">
				Username : <input style="padding: 4px;" type="text" class="field" name="username" id="username"/>
			</div>
			<div class="block">
				<select class="field" name="phongban_id" id="phongban_id">
					<option value="">-- Chọn phòng ban --</option>
					<s:iterator value="phongbans">
						<option value='<s:property value="id" />'><s:property value="tenphongban" /></option>									
					</s:iterator>
				</select>
			</div>
			<div class="block">
				<select class="field" name="khuvuc_id" id="khuvuc_id">
					<option value="">-- Chọn khu vực --</option>
					<s:iterator value="khuvucs">
						<option value='<s:property value="id" />'><s:property value="tenkhuvuc" /></option>									
					</s:iterator>
				</select>
			</div>
			<div class="block">
				<select class="field" name="active" id="active">
					<option value="">-- Chọn trạng thái --</option>
					<option value="1">Đang hoạt động</option>
					<option value="0">Đã khóa</option>
				</select>
			</div>
			<div class="block">
				<input type="button" class="button" id="btSearch" value="Tìm kiếm" onclick="doSearch()"/>
			</div>
			</div>
			</form>
						</div>
						<div class="clearb"></div>
					</div>
				</div>
				<div style="height: 1px;">
				</div>
			</div>
		<div style="width:99%">
			
			
			<div style="float:left;margin-bottom:5px">
				<input type="button" value="Thêm tài khoản" id="btThem" class="button"  onclick="doNew('${formURL}')" >
				<input type="button" value="Mở Khóa" id="btUnlock" class="button" >
				<input type="button" value="Khóa" id="btLock" class="button"  >
				
				</div>
			
			<div style="display: block; height: 5px;"></div>
			<table width="100%" id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th width="5%">ID</th>
					<th>Username</th>
					<th>Phòng ban</th>
					<th>Menu chính</th>
					<th width="5%">Active</th>
					<th>Khu vực</th>
					<th>Email</th>
					<th>Số điện thoại</th>
					<th width="100px">Phân quyền</th>
					<th width="5px">Edit</th>
					<th width="5px" align="center"><input type="checkbox" onclick="selectAll(this)"/></th>
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
	$('#dataTable input[type=checkbox]').each(function(){
		this.checked=_this.checked;
	});
}
function doSearch() {
	var frm = $('#form');
	var dat = "{'array':"+stringify(frm.serializeArray())+"}";
	oTable.fnFilter(dat);
}
function doLock(flag) {
	if(hasChecked()==false)
		return;
	var dataString = '&active='+flag;
	$('#dataTable input[type=checkbox]').each(function(){
		if(this.checked==true) {
			if(this.value!='on')
				dataString+='&ids='+this.value;
		}
	});
	
	if(dataString=='') {
		alert('Bạn chưa chọn dòng để khóa / mở khóa!');
		return;
	}
	if(!confirm("Bạn muốn thực hiện thao tác này")) return;
	block('#bg_wrapper');
	$.ajax({
		type: "POST",
		cache: false,
		url : "${lockAccountsURL}",
		data: dataString,
		success: function(data){
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
		error: function(data){ alert (data);unblock('#bg_wrapper');}	
	});	
}
var account_id = '';
function openPermissionWindow(id) {
	account_id = id;
	permission_popup.url_init = "${getMenusByAccountURL}?account_id="+account_id;
	showDialogUrl("${permissionPopupURL}?id="+id,'Phân quyền user',610);
}
function openKhuVucPhuTrachWindow(id) {
	account_id = id;
	showDialogUrl("${chonKhuVucPhuTrachURL}?id="+id,'Phân quyền khu vực phụ trách',610);
}
$(document).ready(function(){	 
	$('ul.sf-menu').superfish();
	$("#btLock").click(function(){
		doLock(0);
	});
	$("#btUnlock").click(function(){
		doLock(1);
	});
	permission_popup.afterSelected = function(data){
		var dataString = '&id='+account_id;
		$.each(data,function(){
			dataString+= "&menu_id="+this.id;
		});
		$.ajax({
			type: "POST",
			cache: false,
			url : "${saveAccountMenuURL}",
			data: dataString,
			success: function(data){
				$("#btChon",permission_popup.dialog)[0].disabled = true;
				if(data.status == 0) {
					processErrorMessage(data.data);
					return;
				} 
				if(data.status == 1) {
					unblock('#bg_wrapper');
					oTable.fnDraw(false);
					alert("Thao tác thành công!");
					permission_popup.dialog.dialog("close");
					return;
				}
			},
			error: function(data){ $("#btChon",permission_popup.dialog)[0].disabled = true;}	
		});	
	}
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${ajLoadAccountsURL}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false },
					{ "mDataProp": "id","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "username","bSortable": false,"bSearchable": false},
					{ "mDataProp": "tenphongban","bSortable": false,"bSearchable": false},
					{ "mDataProp": "namemenu","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center>'+trangthai_utils.userDisplay(oObj.aData.active)+'</center>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><img title="Chọn khu vực phụ trách" src="'+contextPath+'/images/icons/location.png" height="25px" onclick="openKhuVucPhuTrachWindow('+oObj.aData.id+')" style="cursor:pointer"></center>'; 
						}
					},
					{ "mDataProp": "email","bSortable": false,"bSearchable": false},
					{ "mDataProp": "phone","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><img title="permission" src="'+contextPath+'/images/icons/permission.png" onclick="openPermissionWindow('+oObj.aData.id+')" style="cursor:pointer"></center>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><a class="edit_icon" onclick="doEdit(\'${formURL}?id='+oObj.aData.id+'\')" title="Edit" href="#"></a></center>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><input type="checkbox" value="'+oObj.aData.id+'"/></center>'; 
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
});
</script>