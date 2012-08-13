<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="ajLoadAccounts" namespace="/user" id="ajLoadAccountsURL"/>
<s:url action="lockAccounts" namespace="/user" id="lockAccountsURL"/>
<s:url action="form" namespace="/user" id="formURL"/>
<s:url action="popup" namespace="/permission" id="permissionPopupURL"/>
<s:url action="saveAccountMenu" namespace="/permission" id="saveAccountMenuURL"/>
<s:url action="getMenusByAccount" namespace="/ajax" id="getMenusByAccountURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script src="<%= request.getContextPath() %>/js/mylibs/permission_popup.js" type="text/javascript" ></script>
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
		<div style="width:99%">
			<fieldset class="form">
				<legend>Quản lý tài khoản</legend>
				<div style="float:right">
				<a class="admin_icon" title="Thêm mới" href="${formURL}">
					<img alt="Add" src="<%=contextPath%>/images/icons/add_32.png"/>
					<span>Thêm mới</span>
				</a>
				<a class="admin_icon" title="Mở khóa" id="btUnlock">
					<img alt="Xóa" src="<%=contextPath%>/images/icons/unlock_32.png"/>
					<span>Mở khóa</span>
				</a>
				<a class="admin_icon" title="Khóa" id="btLock">
					<img alt="Xóa" src="<%=contextPath%>/images/icons/lock_32.png"/>
					<span>Khóa</span>
				</a>
				</div>
			</fieldset>
			<form id="form">
			<div style="float: right; padding-top: 5px; padding-bottom: 3px; display: block;">
			<div class="block">
				Username : <input type="text" class="field" name="username" id="username"/>
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
			<div style="display: block; height: 5px;"></div>
			<table width="100%" id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th width="5%">ID</th>
					<th>Username</th>
					<th>Phòng ban</th>
					<th>Khu vực</th>
					<th width="5%">Active</th>
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
					{ "mDataProp": "phongban","bSortable": false,"bSearchable": false},
					{ "mDataProp": "khuvuc","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							if(oObj.aData.active==1) 
								return '<center><div title="Đang hoạt động"  class="active"></div></center>'; 
							return '<center><div title="Đã khóa"  class="inactive"></div></center>';
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><img title="permission" src="'+contextPath+'/images/icons/permission.png" onclick="openPermissionWindow('+oObj.aData.id+')" style="cursor:pointer"></center>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><a class="edit_icon" title="Edit" href="${formURL}?id='+oObj.aData.id+'"></a></center>'; 
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