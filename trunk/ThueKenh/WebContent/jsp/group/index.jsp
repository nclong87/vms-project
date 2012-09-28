<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="list" namespace="/group" id="listURL"/>
<s:url action="doLock" namespace="/group" id="doLockURL"/>
<s:url action="form" namespace="/group" id="formURL"/>
<s:url action="popup" namespace="/permission" id="permissionPopupURL"/>
<s:url action="saveGroupMenu" namespace="/permission" id="saveGroupMenuURL"/>
<s:url action="getMenusByGroup" namespace="/ajax" id="getMenusByGroupURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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
		<div style="width: 100%; margin-bottom: 10px;" class="ovf">
			<div class="s10">
				<div class="fl">
					<div class="fl tsl" id="t_1">
					</div>
					<div class="fl clg b tsc d" id="t_2">
						<div class="p3t">Quản trị nhóm</div>
					</div>
					<div class="fl tsr" id="t_3">
					</div>
				</div>
				<div class="lineU"></div>
			</div>
			<div style="height: 1px;"></div>
		</div>
		<div style="clear:both;margin:5px 0 ">
		<input class="button" type="button" id="btThem" value="Thêm nhóm"/>
		<input class="button" type="button" id="btXoa" value="Xóa" style="float: right; margin-right: 10px;"/>
		</div>
		<table width="100%" id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th width="5%">ID</th>
					<th>Tên nhóm</th>
					<th>Menu chính</th>
					<th width="100px">Phân quyền</th>
					<th width="5px">Edit</th>
					<th width="5px" align="center"><input type="checkbox" onclick="selectAll(this)"/></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
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
var group_id = '';
function openPermissionWindow(id) {
	group_id = id;
	permission_popup.url_init = "${getMenusByGroupURL}?idgroup="+group_id;
	showDialogUrl("${permissionPopupURL}?id="+id,'Phân quyền nhóm',610);
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
		alert('Bạn chưa chọn dòng để xóa!');
		return;
	}
	if(!confirm("Bạn muốn thực hiện thao tác này")) return;
	block('#bg_wrapper');
	$.ajax({
		type: "POST",
		cache: false,
		url : "${doLockURL}",
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
$(document).ready(function(){	 
	$('ul.sf-menu').superfish();
	$("#btXoa").click(function(){
		doLock(0);
	});
	$("#btThem").click(function(){
		ShowWindow('Thêm mới nhóm',500,300,"${formURL}",false);
	});
	$("span.edit_icon").live("click",function(){
		var id = $(this).attr("data-ref-id");
		ShowWindow('Cập nhật nhóm',500,300,"${formURL}?id="+id,false);
	});
	permission_popup.afterSelected = function(data){
		var dataString = '&id='+group_id;
		$.each(data,function(){
			dataString+= "&menu_id="+this.id;
		});
		$.ajax({
			type: "POST",
			cache: false,
			url : "${saveGroupMenuURL}",
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
		"sAjaxSource": "${listURL}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false },
					{ "mDataProp": "id","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "namegroup","bSortable": false,"bSearchable": false},
					{ "mDataProp": "namemenu","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><img title="permission" src="'+contextPath+'/images/icons/permission.png" onclick="openPermissionWindow('+oObj.aData.id+')" style="cursor:pointer"></center>'; 
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