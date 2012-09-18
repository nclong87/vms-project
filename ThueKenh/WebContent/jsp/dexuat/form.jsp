<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/dexuat" id="doSaveURL" />
<s:url action="popupSearch" namespace="/tuyenkenh" id="popupSearchURL" />
<s:url action="doUpload" namespace="/fileupload" id="doUploadURL" />
<s:url action="findByDexuat" namespace="/tuyenkenhdexuat" id="findByDexuatURL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%= contextPath %>/css/addedit.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/css/cupertino/jquery-ui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/css/demo_table_jui.css" />
<script>
var contextPath = '<%= contextPath %>';
var baseUrl = contextPath;
function byId(id) { //Viet tat cua ham document.getElementById
	return document.getElementById(id);
}
</script>
<script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script>
<script type='text/javascript' src='<%= contextPath %>/js/jquery-ui.js'></script>
<script type='text/javascript' src='<%= contextPath %>/js/jquery.dataTables.min.js'></script>

<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_tuyenkenhdexuat.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/utils.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/upload_utils.js"></script>

<style>
</style>
</head>
<body>
	<form id="form" onsubmit="return false;">
	<input type="text" style="display:none" name="deXuatDTO.id" id="id" />
	<div style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
		<table class="input" style="width:725px">
			<tr>
				<td colspan='4' align="left" id="msg">
				</td>
			</tr>
			<tr>
				<td align="right" width="160px">
					Tên văn bản <font title="Bắt buộc nhập" color="red">*</font> :
				</td>
				<td align="left">
					<input type="text" name="deXuatDTO.tenvanban" id="tenvanban" />
				</td>
				<td align="right" width="150px">
					File Scan :
				</td>
				<td align="left">
					<input type="text" style="display:none" name="deXuatDTO.filename" id="filename" value=""/>
					<input type="text" style="display:none" name="deXuatDTO.filepath" id="filepath" value=""/>
					<input type="text" style="display:none" name="deXuatDTO.filesize" id="filesize" value=""/>
					<div id="label">
					</div>
					<input type="button" class="button" id="btUploadFile" value="Chọn file..." />
				</td>
			</tr>
			<tr>
				<td align="right">
					Đối tác <font title="Bắt buộc nhập" color="red">*</font> :
				</td>
				<td align="left">
					<select name="deXuatDTO.doitac_id" id="doitac_id">
						<s:iterator value="doiTacDTOs">
							<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
						</s:iterator>
					</select>
				</td>
				<td align="right">
					Ngày gửi :
				</td>
				<td align="left">
					<input type="text" name="deXuatDTO.ngaygui" id="ngaygui" class="date">
				</td>
			</tr>
			<tr>
				<td align="right">
					Ngày đề nghị bàn giao :
				</td>
				<td align="left">
					<input type="text" name="deXuatDTO.ngaydenghibangiao" id="ngaydenghibangiao" class="date">
				</td>
			</tr>
		</table>
		
		<div style="width: 100%; margin-top: 10px;">
		<fieldset class="data_list">
			<legend>Danh sách đề xuất</legend>
			<div style="width: 100%; padding-bottom: 5px;text-align: right;"><input class="button" type="button" value="Chọn đề xuất..." id="btPopupSearchTuyenkenhDexuat"></div>
			<table width="100%" id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th>Mã kênh</th>
					<th>Mã điểm đầu</th>
					<th>Mã điểm cuối</th>
					<th>Giao tiếp</th>
					<th>Dung lượng</th>
					<th>Số lượng</th>
					<th>Ngày đề nghị BG</th>
					<th>Ngày hẹn BG</th>
					<th width="5px" align="center">Xóa</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
			</table>
		</fieldset>
		</div>
		<div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
			<input class="button" type="button" id="btSubmit" value="Lưu"/>
			<input class="button" type="button" id="btReset" value="Làm lại"/>
			<input class="button" type="button" id="btThoat" onclick="window.parent.CloseWindow();" value="Thoát"/>
		</div>
	</div>
	</form>
</body>
</html>
<script>
var LOGIN_PATH = "${loginURL}";
function message(msg,type) {
	if(msg == '') {
		$("#msg").html('');
		return;
	}
	if(type == 1) {
		$("#msg").html('<div class="ui-state-highlight ui-corner-all" style=" padding: 0pt 0.7em; text-align: left;"><p style="padding: 5px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><strong>Success! </strong> '+msg+'</p></div>');
	} else {
		$("#msg").html('<div style="padding: 0pt 0.7em; text-align: left;" class="ui-state-error ui-corner-all"><p style="padding: 5px;"><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span><strong>Error : </strong> '+msg+'</p></div>');
	}
}
function doRemoveRow(this_){
	var row = $(this_).closest("tr").get(0);
	oTable.fnDeleteRow(oTable.fnGetPosition(row));
}
function addRow(stt,data) {
	oTable.fnAddData([
		stt,data.tuyenkenh_id,data.madiemdau,data.madiemcuoi,data.loaigiaotiep,data.dungluong,data.soluong,data.ngaydenghibangiao,data.ngayhenbangiao,'<center><input type="text" style="display:none" name="dexuat_ids" value="'+data.id+'" id="dexuat_id_'+data.id+'"/><img title="Remove" src="'+baseUrl+'/images/icons/remove.png" onclick="doRemoveRow(this)" style="cursor:pointer"></center>'
	]);
}
$(document).ready(function() {
	popup_search_tuyenkenhdexuat.init({
		afterSelected : function(data) {	
			var i = 1;
			$.each(data,function(){
				if($("#dexuat_id_"+this.id).length == 0) {
					addRow(i,this);
					i++;
				}
			});
		}
	}); 
	upload_utils.init();
	$("#btReset").click(function(){
		$("#form")[0].reset();
		message('',0);
	});
	$( "input.date" ).datepicker({
		showButtonPanel: true,
		dateFormat : "dd/mm/yy"
	});
	$("#form").validate({
		onkeyup : false,
		onfocusout : false,
		rules : {
			"deXuatDTO.tenvanban" : {
				required : true
			},
			"tuyenKenh.doitac_id" : {
				required : true
			}
		}
	});
	var form_data = '<s:property value="form_data" escape="false"/>';
	var dexuat_id = '';
	if(form_data != '') {
		var form_data = $.parseJSON(form_data);
		for( key in form_data) {
			var input = document.forms[0]["deXuatDTO."+key];
			if(input != null) {
				input.value = form_data[key];
			}
		}
		upload_utils.createFileLabel({
			filename : form_data["filename"],
			filepath : form_data["filepath"],
			filesize : form_data["filesize"]
		});
		dexuat_id = form_data['id'];
	} 
	if(dexuat_id == '') {
		oTable = $('#dataTable').dataTable({
			"bJQueryUI": true,
			"bProcessing": false,
			"bScrollCollapse": true,
			"bAutoWidth": true,
			"bSort":false,
			"bFilter": false,"bInfo": false,
			"bPaginate" : false
		})
	} else {
		oTable = $('#dataTable').dataTable({
			"bJQueryUI": true,
			"bProcessing": false,
			"bScrollCollapse": true,
			"bAutoWidth": true,
			"bSort":false,
			"bFilter": false,"bInfo": false,
			"bPaginate" : false,
			"sAjaxSource": "${findByDexuatURL}?id="+dexuat_id,
			"aoColumns": null,
			"fnServerData": function ( sSource, aoData, fnCallback ) {
				$.ajax( {
					"dataType": 'json', 
					"type": "POST", 
					"url": sSource, 
					"data": aoData, 
					"success": function(response){
						if(response.result == "ERROR") {
							alert("Lỗi kết nối server, vui lòng thử lại.");
						} else {
							if(response.aaData.length != 0) {
								var i = 0;
								$.each(response.aaData,function(){
									addRow(i,this);
									i++;
								});
							} else {
								oTable.fnAddData([0,'','','','','','','','','']);
								oTable.fnDeleteRow(0);
							}
						}
					}
				} );
			},
		});
	}
	$(document).delegate("#btSubmit","click",function() {
		var button = this;
		button.disabled = true;
		if (!$("#form").valid()) {
			alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
			button.disabled = false;
		} else {
			var dataString = $("#form").serialize();
				$.ajax({
				url: "${doSaveURL}",
				type:'POST',
				data:dataString,
				success:function(response){
					button.disabled = false;
					if(response == "OK") {
						button.disabled = true;
						message("Lưu thành công!",1);
						parent.reload = true;
						return;
					}
					message("Lưu không thành công, vui lòng thử lại.",0);
				},
				error:function(response){
					button.disabled = false;
					alert("Server is too busy, please try again!");
				}
			});
		}
		return false;
	});
});
</script>