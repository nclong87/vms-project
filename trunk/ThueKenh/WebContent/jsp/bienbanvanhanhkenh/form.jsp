<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doSave" namespace="/bienbanvanhanhkenh" id="doSaveURL" />
<s:url action="popupSearch" namespace="/sucokenh" id="popupSearchURL" />
<s:url action="findByBienbanvanhanh" namespace="/sucokenh" id="findByBienbanvanhanhURL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%= contextPath %>/css/addedit.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%= contextPath %>/css/cupertino/jquery-ui.css" type="text/css" media="screen" />
<link rel="stylesheet" type="text/css" href="<%= contextPath %>/css/demo_table_jui.css" />
<script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script>
<script type='text/javascript' src='<%= contextPath %>/js/jquery-ui.js'></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
<script type='text/javascript' src='<%= contextPath %>/js/utils.js'></script>
<script type="text/javascript" src="<%= contextPath %>/js/jquery.dataTables.min.js"></script>
<script>
var contextPath = '<%= contextPath %>';
var baseUrl = contextPath;
function byId(id) { //Viet tat cua ham document.getElementById
	return document.getElementById(id);
}
</script>
<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/upload_utils.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_suco.js"></script>

</head>

<body>
	<form id="form" onsubmit="return false;">
		<input type="text" style="display:none" name="bienbanvhkDto.id" id="id" />
		<div style="clear: both; margin: 5px 0">
			<table class="input" style="width:700px">
				<tr>
					<td colspan='4' align="left" id="msg"></td>
				</tr>
				<tr>
					<td align="right" width="170px"><label for="xxxx">Số biên bản <font title="Bắt buộc nhập" color="red">*</font> :</label></td>
					<td align="left">
						<input type="text" name="bienbanvhkDto.sobienban" id="sobienban"/>
					</td>
					<td align="right" width="110px"><label for="xxxx">File scan <font title="Bắt buộc nhập" color="red">*</font> :</label></td>
					<td>
						<input type="text" style="display:none" name="bienbanvhkDto.filename" id="filename" value=""/>
						<input type="text" style="display:none" name="bienbanvhkDto.filepath" id="filepath" value=""/>
						<input type="text" style="display:none" name="bienbanvhkDto.filesize" id="filesize" value=""/>
						<div id="label">
						</div>
						<input type="button" class="button" id="btUploadFile" value="Chọn file..." />
					</td>
				</tr>
			</table>
			<div style="width: 100%; margin-top: 10px;">
				<fieldset class="data_list">
					<legend>Danh sách sự cố thuộc biên bản vận hành</legend>
					<div style="width: 100%; padding-bottom: 5px;text-align: right;"><input class="button" type="button" value="Chọn sự cố" id="btPopupSearchSuCo"></div>
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
								<th width="50px">Ngày tạo</th>
								<th width="5px" align="center">Xóa</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</fieldset>
			</div>
			<div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
				<input type="button" class="button" value="Lưu" id="btSubmit"></input>
				<input type="button" class="button" value="Làm lại" id="btReset"></input>
				<input type="button" class="button" value="Thoát" id="btThoat" onclick="window.parent.CloseWindow();"></input>
			</div>
		</div>
	</form>
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
function doRemoveRow(this_){
	var row = $(this_).closest("tr").get(0);
	oTable.fnDeleteRow(oTable.fnGetPosition(row));
}
function addRow(stt,data) {
	oTable.fnAddData([
		stt,data.tuyenkenh_id,data.madiemdau,data.madiemcuoi,data.loaigiaotiep,data.dungluong,data.thoidiembatdau,data.thoidiemketthuc,data.thoigianmll,data.nguyennhan,data.phuonganxuly,data.nguoixacnhan,data.usercreate,data.timecreate,'<center><input type="text" style="display:none" name="suco_ids" value="'+data.id+'" id="suco_id_'+data.id+'"/><img title="Remove" src="'+baseUrl+'/images/icons/remove.png" onclick="doRemoveRow(this)" style="cursor:pointer"></center>'
	]);
}
$(document).ready(function(){	
	//
	upload_utils.init();
	popup_search_suco.init({
		url : "${popupSearchURL}",
		afterSelected : function(data) {
			var i=1;
			$.each(data,function(){
				if($("#suco_id_"+this.id).length == 0) {
					addRow(i,this);
					i++;
				}
			});
		}
	});
	//Reset form
	$("#btReset").click(function(){
		$("#form")[0].reset();
		message('',0);
	});

	//validation form
	$("#form").validate({
		rules : {
			"bienbanvhkDto.sobienban" : {
				required : true
			},
		}
	});
	// load edit
	var bienbanvanhanh_id = '';
	var form_data = '<s:property value="form_data" escape="false"/>';
	if(form_data != '') {
		var form_data = $.parseJSON(form_data);
		for( key in form_data) {
			$("#form #"+key).val(form_data[key]);
		}
		upload_utils.createFileLabel({
			filename : form_data["filename"],
			filepath : form_data["filepath"],
			filesize : form_data["filesize"]
		});
		bienbanvanhanh_id = form_data['id'];
	} 
	if(bienbanvanhanh_id == '') {
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
			"sAjaxSource": "${findByBienbanvanhanhURL}?id="+bienbanvanhanh_id,
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
	$("#btSubmit").click(function(){
		$(this).disabled = true;
		if(!$("#form").valid())
		{
			message("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!",0);
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