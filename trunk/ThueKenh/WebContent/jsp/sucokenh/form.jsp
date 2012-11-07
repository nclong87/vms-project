<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doSave" namespace="/sucokenh" id="doSaveURL" />
<s:url action="popupSearch" namespace="/tuyenkenh" id="popupSearchURL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%= contextPath %>/css/addedit.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/css/cupertino/jquery-ui.css" type="text/css" media="screen" />
<script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script>
<script type='text/javascript' src='<%= contextPath %>/js/jquery-ui.js'></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
<script type='text/javascript' src='<%= contextPath %>/js/utils.js'></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datetimepicker.js"></script>


<script>
var contextPath = '<%= contextPath %>';
var baseUrl = contextPath;
function byId(id) { //Viet tat cua ham document.getElementById
	return document.getElementById(id);
}
</script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_tuyenkenh.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/upload_utils.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>

</head>

<body>
	<form id="form" onsubmit="return false;">
		<input type="text" style="display:none" name="sucoDTO.id" id="id" />
		<input type="text" style="display:none" name="sucoDTO.filename" id="filename" value=""/>
		<input type="text" style="display:none" name="sucoDTO.filepath" id="filepath" value=""/>
		<input type="text" style="display:none" name="sucoDTO.filesize" id="filesize" value=""/>
		<div style="clear: both; margin: 5px 0">
				<table class="input" style="width: 782px">
				<tr>
					<td colspan='4' align="left" id="msg"></td>
				</tr>
				<tr>
					<td align="right">Tuyến kênh :</td>
					<td align="left"><input type="text" style="width:181px" name="sucoDTO.tuyenkenh_id" id="tuyenkenh_id"></input><input type="button" id="btPopupSearchTuyenkenh" value="..."/></select><font title="Bắt buộc nhập" color="red">*</font></td>
					<td align="right">Loại sự cố :</td>
					<td align="left">
						<select name="sucoDTO.loaisuco" id="loaisuco" style="width: 215px">
							<option value="0">Sự cố bình thường</option>
							<option value="1">Sự cố lớn</option>
						</select>
						<font title="Bắt buộc nhập" color="red">*</font>
					</td>
				</tr>
				<tr>
					<td align="right">Thời điểm bắt đầu :</td>
					<td align="left"><input type="text" name="sucoDTO.thoidiembatdau" id="thoidiembatdau" style="width: 214px" class="datetimepicker"/><font title="Bắt buộc nhập"
						color="red">*</font></td>
					<td align="right">Thời điểm kết thúc :</td>
					<td align="left"><input type="text" name="sucoDTO.thoidiemketthuc" id="thoidiemketthuc" style="width: 214px" class="datetimepicker"/><font title="Bắt buộc nhập"
						color="red">*</font></td>
	
				</tr>
				<tr>
					<td align="right">Nguyên nhân sự cố :</td>
					<td colspan="3"><textarea style="width: 601px" name="sucoDTO.nguyennhan" id="nguyennhan"></textarea><font
						title="Bắt buộc nhập" color="red">*</font></td>
				</tr>
				<tr>
					<td align="right">Phương án xử lý :</td>
					<td colspan="3"><textarea style="width: 601px" name="sucoDTO.phuonganxuly" id="phuonganxuly"></textarea><font
						title="Bắt buộc nhập" color="red">*</font></td>
				</tr>
				<tr>
					<td align="right">Người xác nhận :</td>
					<td><input type="text" style="width: 214px" name="sucoDTO.nguoixacnhan" id="nguoixacnhan"/><font
						title="Bắt buộc nhập" color="red">*</font></td>
				</tr>
			</table>
			
		</div>
	</form>
	<fieldset class="data_list" style="margin-top:5px">
		<legend>File Scan</legend>
		<form id="frmUpload" method="post" enctype="multipart/form-data" style="margin-top: 5px; float: left; width: 100%;" onsubmit="return false">
			<input type="file" name="uploadFile" id="uploadFile" style="margin-left:5px"/>
			<div id="label"></div>
		</form>
	</fieldset>
	<div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
		<input type="button" class="button" value="Lưu" id="btSubmit"></input>
		<input type="button" class="button" value="Làm lại" id="btReset"></input>
		<input type="button" class="button" value="Thoát" id="btThoat" onclick="window.parent.CloseWindow();"></input>
	</div>
</body>
</html>
<script>
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
function selectAll(_this) {
	$('#dataTable input[type=checkbox]').each(function(){
		this.checked=_this.checked;
	});
}

$(document).ready(function(){	
	//
	upload_utils.init();
	popup_search_tuyenkenh.init({
		url : "${popupSearchURL}",
		afterSelected : function(data) {
			// list tuyen kenh tra ve, sau do xu ly du lieu cho nay
			data = data[0];
			$("#tuyenkenh_id").val(data["id"]) ;
		}
	});
	LoadDateTimePicker(".datetimepicker");
	//$(".datetimepicker").datepicker(); 
	//Reset form
	$("#btReset").click(function(){
		$("#form")[0].reset();
		message('',0);
	});

	//validation form
	$("#form").validate({
		rules : {
			"sucoDTO.tuyenkenh_id" : {
				required : true
			},
			"sucoDTO.loaisuco":{
				required : true
			},
			"sucoDTO.thoidiembatdau" : {
				required : true,
				date : true
			},
			"sucoDTO.thoidiemketthuc" : {
				required : true,
				date : true
			},
			"sucoDTO.nguyennhan" : {
				required : true
			},
			"sucoDTO.phuonganxuly" : {
				required : true
			},
			"sucoDTO.nguoixacnhan" : {
				required : true,
			}
		}
	});
	// load edit
	var form_data = '<s:property value="form_data" escape="false"/>';
	if(form_data != '') {
		var form_data = $.parseJSON(form_data);
		for( key in form_data) {
			$("#form #"+key).val(form_data[key]);
		}
		if(form_data["filename"]!=null)
		{
			upload_utils.createFileLabel({
				filename : form_data["filename"],
				filepath : form_data["filepath"],
				filesize : form_data["filesize"]
			});
		}
	} 
	$("#btSubmit").click(function(){
		$(this).disabled = true;
		if(!$("#form").valid())
		{
			alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!",0);
			$(this).disabled=false;
		}
		else
		{
			var dataString=$("#form").serialize();
			$.ajax({
				url: "${doSaveURL}",
				type:'POST',
				data:dataString,
				success:function(response){
					$(this).disabled = false;
					if(response == "OK") {
						$(this).disabled = true;
						message(" Lưu thành công!",1);
						parent.reload = true;
						return;
					}
					else if(response=="ngayhientai")
					{
						$(this).disabled = true;
						message(" Thời điểm bắt đầu và thời điểm kết thúc phải nhỏ hơn hoặc bằng ngày hiện tại",0);
						return;
					}
					else if(response=="Date")
					{
						$(this).disabled = true;
						message(" Thời điểm kết thúc sự cố phải lớn hơn thời điểm bắt đầu sự cố",0);
						return;
					}
					else if(response=="TuyenKenhNotExist")
					{
						$(this).disabled = true;
						message(" Tuyến kênh bạn chọn không tồn tại",0);
						return;
					}
					message(" Lưu không thành công, vui lòng thử lại.",0);
				},
				error:function(response){
					$(this).disabled = false;
					message(" Lưu không thành công, vui lòng thử lại.",0);
				}
			});
		}
	});
	
});
</script>