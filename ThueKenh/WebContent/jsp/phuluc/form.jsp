<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/phuluc" id="doSaveURL" />
<s:url action="doUpload" namespace="/fileupload" id="doUploadURL" />
<s:url action="findHopDongByDoiTac" namespace="/ajax" id="findHopDongByDoiTacURL" />
<s:url action="findTuyenKenhByChiTietPhuLuc" namespace="/ajax" id="findTuyenKenhByChiTietPhuLucURL" />
<s:url action="popupSearch" namespace="/chitietphuluc" id="popupSearchChiTietPhuLucURL" />
<s:url action="popupSearch" namespace="/phuluc" id="popupSearchPhuLucURL" />
<s:url action="detail" namespace="/tuyenkenh" id="detailTuyenKenhURL" />
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
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>
<script type='text/javascript' src='<%= contextPath %>/js/jquery.formatCurrency.min.js'></script>
<script type="text/javascript" src="<%=contextPath%>/js/utils.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/upload_utils.js"></script>

<style>
</style>
</head>
<body>
	<div style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
		<form id="form" onsubmit="return false;">
		<input type="text" style="display:none" name="phuLucDTO.id" id="id" />
		<input type="text" style="display:none" name="phuLucDTO.filename" id="filename" value=""/>
		<input type="text" style="display:none" name="phuLucDTO.filepath" id="filepath" value=""/>
		<input type="text" style="display:none" name="phuLucDTO.filesize" id="filesize" value=""/>
		<input type="text" style="display:none" name="phuLucDTO.chitietphuluc_id" id="chitietphuluc_id" value=""/>
		<table class="input" style="width:725px">
			<tr>
				<td colspan='4' align="left" id="msg">
				</td>
			</tr>
			<tr>
				<td colspan='4' align="center">
					<input class="button" type="button" value="Chọn giá trị phụ lục" id="btPopupSearchChiTietPhuLuc">
				</td>
			</tr>
			<tr>
				<td align="right" width="140px">
					Hợp đồng <font title="Bắt buộc nhập" color="red">*</font> :
				</td>
				<td align="left">
					<select name="phuLucDTO.hopdong_id" id="hopdong_id">
						<option value="">---Chọn hợp đồng---</option>
						<s:iterator value="hopDongDTOs">
							<option disabled="true"/><s:property value="value.tendoitac" /></option>
							<s:iterator value="value.hopdong">
								<option style="padding-left:20px" value='<s:property value="id" />'><s:property value="sohopdong" /></option>
							</s:iterator>
						</s:iterator>
					</select>
				</td>
				<td align="right" width="140px">
					Tên phụ lục <font title="Bắt buộc nhập" color="red">*</font> :
				</td>
				<td align="left">
					<input type="text" name="phuLucDTO.tenphuluc" id="tenphuluc">
				</td>
			</tr>
			<tr>
				<td align="right" valign="center">
					Loại phụ lục <font title="Bắt buộc nhập" color="red">*</font> :
				</td>
				<td align="left">
					<select id="loaiphuluc" name="phuLucDTO.loaiphuluc" >
						<option value="1">Độc lập</option>
						<option value="2">Thay thế</option>
					</select>
				</td>
				<td align="right">
					Cước đấu nối :
				</td>
				<td align="left">
					<input type="text" id="cuocdaunoi" class="number" disabled="true">
				</td>
			</tr>
			<tr>
				<td align="right" valign="center">
					Giá trị trước thuế :
				</td>
				<td align="left">
					<input type="text" id="giatritruocthue" class="number" disabled="true">
				</td>
				<td align="right">
					Giá trị sau thuế :
				</td>
				<td align="left">
					<input type="text" id="giatrisauthue" class="number" disabled="true">
				</td>
			</tr>
			<tr>
				<td align="right" valign="center">
					Ngày ký :
				</td>
				<td align="left">
					<input type="text" name="phuLucDTO.ngayky" id="ngayky" class="date">
				</td>
				<td align="right">
					Ngày hiệu lực <font title="Bắt buộc nhập" color="red">*</font> :
				</td>
				<td align="left">
					<input type="text" name="phuLucDTO.ngayhieuluc" id="ngayhieuluc" class="date">
				</td>
			</tr>
		</table>
		</form>
		<div style="width: 100%; margin-top: 10px;">
		<fieldset class="data_list" style="margin-top: 5px; margin-bottom: 10px;display:none" id="fieldsetPhuLucThayThe">
			<legend>Thay thế cho các phụ lục sau</legend>
			<span class="tags"></span>
			<input class="button" type="button" value="  +  " id="btPopupSearchPhuLuc">
		</form>
		</fieldset>
		<fieldset class="data_list" style="margin-top: 5px; margin-bottom: 10px;">
			<legend>File Scan</legend>
			<form id="frmUpload" method="post" enctype="multipart/form-data" style="margin-top: 5px; float: left; width: 100%;" onsubmit="return false">
			<input type="file" name="uploadFile" id="uploadFile" style="margin-left:5px"/>
			<div id="label"></div>
		</form>
		</fieldset>
		<fieldset class="data_list">
			<legend>Danh sách tuyến kênh thuộc phụ lục</legend>
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
					<th>Đối tác</th>
				</tr>
			</thead>
			<tbody></tbody>
			</table>
		</fieldset>
		</div>
		</form>
		</fieldset>
		<div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
			<input class="button" type="button" id="btSubmit" value="Lưu"/>
			<input class="button" type="button" id="btReset" value="Làm lại"/>
			<input class="button" type="button" id="btThoat" onclick="window.parent.CloseWindow();" value="Thoát"/>
		</div>
	</div>
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
		$("#msg").html('<div style="padding: 0pt 0.7em; text-align: left;" class="ui-state-error ui-corner-all"><p style="padding: 5px;"><strong>Error : </strong> '+msg+'</p></div>');
	}
}
function doRemoveRow(this_){
	var row = $(this_).closest("tr").get(0);
	oTable.fnDeleteRow(oTable.fnGetPosition(row));
}
function addRow(stt,data) {
	oTable.fnAddData([
		stt,'<a target="_blank" href="${detailTuyenKenhURL}?id='+data.id+'" title="Xem chi tiết tuyến kênh">'+data.id+'</a>',
		data.madiemdau, data.madiemcuoi, data.loaigiaotiep, data.dungluong, data.soluong, data.tendoitac
	]);
}
var searchChiTietPhuLuc = new PopupSearch();
var searchPhuLuc = new PopupSearch();
$(document).ready(function() {
	/* $("select#doitac").change(function(){
		if(this.value == "") return;
		$("#spanHopDong").html("Loading...");
		$.get("${findHopDongByDoiTacURL}?doitac_id="+this.value,function(response){
			if(response.status == "ERROR") {
				alert(response.data);
			} else {
				$("#spanHopDong").html('<select name="phuLucDTO.hopdong_id" id="hopdong_id"></select>');
				var selectHopdong = $("select#hopdong_id");
				$.each(response.data,function(){
					selectHopdong.append('<option value="'+this.id+'">'+this.sohopdong+'</option>');
				});
			}
		});
	}); */
	$("#loaiphuluc").change(function(){
		if(this.value == "1") { //phu luc doc lap
			$("#fieldsetPhuLucThayThe").hide();
		} else { //phu luc thay the
			$("#fieldsetPhuLucThayThe").show();
		}
	});
	$("#fieldsetPhuLucThayThe .tags").delegate(".selected a.remove","click",function(){
		$(this).parents(".selected").remove();
	});
	searchChiTietPhuLuc.init({
		url : "${popupSearchChiTietPhuLucURL}",
		button : "#btPopupSearchChiTietPhuLuc",
		afterSelected : function(data) {	
			data = data[0];
			$("#chitietphuluc_id").val(data.id);
			$("#cuocdaunoi").val(data.cuocdaunoi);
			$("#giatritruocthue").val(data.giatritruocthue);
			$("#giatrisauthue").val(data.giatrisauthue);
			$("#form input.number").formatCurrency({ 
				region : 'vn',
				roundToDecimalPlace: 0, 
				eventOnDecimalsEntered: true 
			});
			var oSettings = oTable.fnSettings();
			 var iTotalRecords = oSettings.fnRecordsTotal();
			 for (i=0;i<=iTotalRecords;i++) {
				oTable.fnDeleteRow(0,null,true);
			 }
			$.get("${findTuyenKenhByChiTietPhuLucURL}?id="+data.id,function(response){
				if(response.result == "ERROR") {
					alert(response.data);
				} else {
					if(response.data.length != 0) {
						var i = 1;
						$.each(response.data,function(){
							addRow(i,this);
							i++;
						});
					} else {
						oTable.fnAddData([0,'','','','','','','','','']);
						oTable.fnDeleteRow(0);
					}
				}
			});
		}
	}); 
	searchPhuLuc.init({
		url : "${popupSearchPhuLucURL}",
		button : "#btPopupSearchPhuLuc",
		afterSelected : function(data) {	
			$.each(data,function(){
				$("#fieldsetPhuLucThayThe .tags").append(replaceText(templates.tag,{
					tag_id : "phuluc_"+this.id,
					data_ref : this.id,
					tag_title : this.tenphuluc,
					tag_name : this.tenphuluc.vmsSubstr(40)
				}));
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
			"phuLucDTO.hopdong_id" : {
				required : true
			},
			"phuLucDTO.tenphuluc" : {
				required : true
			},
			"phuLucDTO.loaiphuluc" : {
				required : true
			},
			"phuLucDTO.ngayhieuluc" : {
				required : true
			}
		}
	});
	var form_data = '<s:property value="form_data" escape="false"/>';
	var tuyenkenh_id = '';
	if(form_data != '') {
		var form_data = $.parseJSON(form_data);
		for( key in form_data) {
			var input = document.forms[0]["phuLucDTO."+key];
			if(input != null) {
				input.value = form_data[key];
			}
		}
		if(form_data["filename"] != null) {
			upload_utils.createFileLabel({
				filename : form_data["filename"],
				filepath : form_data["filepath"],
				filesize : form_data["filesize"]
			});
		}
		tuyenkenh_id = form_data['id'];
	} 
	if(tuyenkenh_id == '') {
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
			}
		});
	}
	$(document).delegate("#btSubmit","click",function() {
		if($("#chitietphuluc_id").val() == "") {
			alert("Vui lòng chọn giá trị phụ lục!");
			return;
		}
		var button = this;
		if (!$("#form").valid()) {
			alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
			button.disabled = false;
		} else {
			button.disabled = true;
			var dataString = $("#form").serialize();
			$.ajax({
				url: "${doSaveURL}",
				type:'POST',
				data:dataString,
				success:function(response){
					button.disabled = false;
					if(response.status == "ERROR") {
						message(response.data,0);
						return;
					} else {
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