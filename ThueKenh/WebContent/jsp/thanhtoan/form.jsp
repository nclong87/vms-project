<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/thanhtoan" id="doSaveURL" />
<s:url action="popupSearch" namespace="/sucokenh" id="popupSearchSuCoKenhURL" />
<s:url action="popupSearch" namespace="/hopdong" id="popupSearchHopDongURL" />
<s:url action="findphulucByhopdong" namespace="/hopdong" id="findphulucByhopdongURL" />
<s:url action="findphulucByhopdongandthanhtoan" namespace="/hopdong" id="findphulucByhopdongandthanhtoanURL" />
<s:url action="findBythanhtoan" namespace="/sucokenh" id="findsucoBythanhtoanURL" />
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
var contextPath = '<%=contextPath%>';
var baseUrl = contextPath;
function byId(id) { //Viet tat cua ham document.getElementById
	return document.getElementById(id);
}
</script>
<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/upload_utils.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_hopdong.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_suco.js"></script>
<style>
	.ui-icon{
		background: none !important;
	}
	.del
	{
		background: url("/ThueKenh/images/icons/remove.png") no-repeat scroll 0 0 transparent;
    	height: 23px;
    	position: absolute;
    	right: 0;
    	top: 3px;
    	width: 27px;
	}
	.hopdonginfo
	{
		position: absolute;
    	left: 185px;
    	top: 3px;
	}
	.hopdonginfo td
	{
		padding: 0;
    	width: 210px;
	}
	.ui-accordion .ui-accordion-content-active
	{
		height:200px !important;
	}
</style>
</head>

<body>
	<form id="form" onsubmit="return false;">
		<input type="text" style="display: none" name="thanhtoanDTO.id" id="id" />
		<input type="text" style="display:none" name="thanhtoanDTO.filename" id="filename" value=""/>
		<input type="text" style="display:none" name="thanhtoanDTO.filepath" id="filepath" value=""/>
		<input type="text" style="display:none" name="thanhtoanDTO.filesize" id="filesize" value=""/>
		<div style="clear: both; margin: 5px 0">
			<table class="input" style="width: 782px">
				<tr>
					<td colspan='4' align="left" id="msg"></td>
				</tr>
				<tr>
					<td align="right" width="150px"><label for="xxxx">Số hồ sơ :</label></td>
					<td align="left">
						<input  type="text" name="thanhtoanDTO.sohoso" id="sohoso" />
					</td>	
					<td align="right" width="150px"><label for="xxxx">Tháng thanh toán:</label></td>
					<td align="left">
						<select name="thanhtoanDTO.thang" id="thang" style="width:96px">
							<option value="">Tháng</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
						<font title="Bắt buộc nhập" color="red">*</font>
						<select name="thanhtoanDTO.nam" id="nam" style="width:95px">
							<option value="">Năm</option>
						</select>
						<font title="Bắt buộc nhập" color="red">*</font>
					</td>	
				</tr>
				<tr>
					<td align="right" ><label for="xxxx">Ngày chuyển kế toán :</label></td>
					<td align="left" >
						<input  type="text" name="thanhtoanDTO.ngaychuyenkt" id="ngaychuyenkt" class="datepicker"/><font title="Bắt buộc nhập" color="red">*</font>
					</td>
					<td align="right" ><label for="xxxx">Giá trị thanh toán :</label></td>
					<td align="left">
						<input  type="text" name="thanhtoanDTO.giatritt" id="giatritt"/>
						<font title="Bắt buộc nhập" color="red">*</font>
					</td>
				</tr>
			</table>
			<div style="width: 100%; margin-top: 10px;">
				<fieldset class="data_list">
					<legend>Danh sách hợp đồng</legend>
					<div style="width: 100%; padding-bottom: 5px;text-align: right;"><input class="button" type="button" value="Chọn hợp đồng" id="btPopupSearchHopDong"></div>
					<div id="tab">		
					</div>
				</fieldset>
				<div style="clear:both;margin-top:10px"></div>
				<fieldset class="data_list">
					<legend>Danh sách sự cố giảm trừ</legend>
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
	var LOGIN_PATH = "${loginURL}";
	function message(msg, type) {
		if (msg == '') {
			$("#msg").html('');
			return;
		}
		if (type == 1) {
			$("#msg")
					.html(
							'<div class="ui-state-highlight ui-corner-all" style=" padding: 0pt 0.7em; text-align: left;"><p style="padding: 5px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><strong>Success! </strong> '
									+ msg + '</p></div>');
		} else {
			$("#msg")
					.html(
							'<div style="padding: 0pt 0.7em; text-align: left;" class="ui-state-error ui-corner-all"><p style="padding: 5px;"><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span><strong>Error : </strong> '
									+ msg + '</p></div>');
		}
	}
	function selectAll(_this) {
		$('#dataTable input[type=checkbox]').each(function() {
			this.checked = _this.checked;
		});
	}
	function selectAllPhuLuc(tableid,_this) {
		$('#'+tableid+' input[type=checkbox]').each(function() {
			this.checked = _this.checked;
		});
	}
	function doRemoveRow(this_){
		var row = $(this_).closest("tr").get(0);
		oTable.fnDeleteRow(oTable.fnGetPosition(row));
	}
	function addRow(stt,data) {
		oTable.fnAddData([
			stt,data.tuyenkenh_id,data.madiemdau,data.madiemcuoi,data.loaigiaotiep,data.dungluong,data.thoidiembatdau,data.thoidiemketthuc,data.thoigianmll,data.nguyennhan,data.phuonganxuly,data.nguoixacnhan,data.usercreate,data.timecreate,'<center><input type="text" style="display:none" name="suco_ids" value="'+data.suco_id+'" id="suco_id_'+data.suco_id+'"/><img title="Remove" src="'+baseUrl+'/images/icons/remove.png" onclick="doRemoveRow(this)" style="cursor:pointer"></center>'
		]);
	}

	function addphuluc(obj,stt,data){
		obj.fnAddData([
    		'<center>'+stt+'</center>',data.tenphuluc,data.loaiphuluc,data.tendoitac,data.soluongkenh,data.giatritruocthue,data.giatrisauthue,data.trangthai,'Đã thanh toán đến '+data.thang+'/'+data.nam
    		,'<center><input type="checkbox" checked="true"/><input id="phuluc_id" style="display:none" value="'+data.id+'"/></center>'
		]);
	}
	function addhopdong(container,data,i)
	{
		var loaihopdong="Có thời hạn";
		if(data.loaihopdong==1)
			loaihopdong="Có thời hạn";
		else 
			loaihopdong="Không có thời hạn";
		var rowhopdong=  '<h3 class="div_'+data.id+'"><a href="#">Số hợp đồng: '+data.sohopdong+'</a><table class="hopdonginfo"><tr><td>Loại hợp đồng: '+loaihopdong+'</td><td>Đối tác: '+data.tendoitac+'</td><td>Ngày ký: '+data.ngayky+'</td><td>Ngày hết hạn: '+data.ngayhethan+'</td></tr></table><div class="del" title="Xóa hợp đồng" id="'+data.id+'"></div></h3>'
						+'<div class="div_'+data.id+' listphuluc">'
							+'<input id="hopdong_id" style="display:none" value="'+data.id+'"/>'
							+'<input id="sohopdong" style="display:none" value="'+data.sohopdong+'"/>'
							+'<table width="100%" class="display" id="datatable_'+data.id+'">'
								+'<thead>'
									+'<tr>'
										+'<th style="width:30px">STT</th>'
										+'<th>Tên phụ lục</th>'
										+'<th>Loại phụ lục</th>'
										+'<th>Đối tác</th>'
										+'<th>Số lượng kênh</th>'
										+'<th>Giá trị trước thuế</th>'
										+'<th>Giá trị sau thuế</th>'
										+'<th>Trạng thái</th>'
										+'<th>Thanh toán</th>'
										+'<th><input type="checkbox" class="checkall"/></th>'
									+'</tr>'
								+'</thead>'	
								+'<tbody>'
								+'</tbody>'
							+'</table>'		
						+'</div>';
		container.append(rowhopdong);
	}
	function LoadHopDong(data)
	{
		$("#tab").html("");
		var div=document.createElement("div");
		$(div).attr("id","accordion");
		$.each(data,function(){
			addhopdong($(div),this);
		});
		$("#tab").append(div);
		$(div).accordion();
		$(".del").click(function(){
			var id=$(this).attr("id");
			$(".div_"+id).remove();
		});
		$.each(data,function(){
			var oPLtable=$('#datatable_'+this.id).dataTable({
				"bJQueryUI": true,
				"bProcessing": false,
				"bScrollCollapse": true,
				"bAutoWidth": true,
				"bSort":false,
				"bFilter": false,"bInfo": false,
				"bPaginate" : false,
				"sAjaxSource": "${findphulucByhopdongURL}?id="+this.id,
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
										addphuluc(oPLtable,i+1,this);
										i++;
									});
								} else {
									oPLtable.fnAddData([0,'','','','','','','','','']);
									oPLtable.fnDeleteRow(0);
								}
							}
						}
					} );
				}
			});
		});
		$.each(data,function(){
			var id=this.id;
			$('#datatable_'+this.id+' .checkall').click(function() {
				selectAllPhuLuc('datatable_'+id,this);
			});
		});
	}
	function LoadHopDongEdit(data)
	{
		$("#tab").html("");
		var div=document.createElement("div");
		$(div).attr("id","accordion");
		$(data).each(function(){
			addhopdong($(div),this);
		});
		
		$("#tab").append(div);
		$(div).accordion();
		$(".del").click(function(){
			var id=$(this).attr("id");
			$(".div_"+id).remove();
		});
		$(data).each(function(){
			var oPLtable=$('#datatable_'+this.id).dataTable({
				"bJQueryUI": true,
				"bProcessing": false,
				"bScrollCollapse": true,
				"bAutoWidth": true,
				"bSort":false,
				"bFilter": false,"bInfo": false,
				"bPaginate" : false,
				"sAjaxSource": "${findphulucByhopdongandthanhtoanURL}?id="+this.id+"&thanhtoan_id="+$("#id").val(),
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
										addphuluc(oPLtable,i+1,this);
										i++;
									});
								} else {
									oPLtable.fnAddData([0,'','','','','','','','','']);
									oPLtable.fnDeleteRow(0);
								}
							}
						}
					} );
				}
			});
		});
		$(data).each(function(){
			var id=this.id;
			$('#datatable_'+this.id+' .checkall').click(function() {
				selectAllPhuLuc('datatable_'+id,this);
			});
		});
	}
	$(document).ready(function() {
		// combobox nam
		var currentTime = new Date();
		var year = currentTime.getFullYear()
		for(var i=year-10;i<year+10;i++)
		{
			$("#nam").append("<option value='"+i+"'>"+i+"</option>");
		}
		//
		upload_utils.init();
		popup_search_hopdong.init({
			url : "${popupSearchHopDongURL}",
			afterSelected : function(data) {
				LoadHopDong(data);
			}
		});
		popup_search_suco.init({
			url : "${popupSearchSuCoKenhURL}",
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
		
		// load datetime
		$( ".datepicker" ).datepicker({
			showButtonPanel: true,
			dateFormat : "dd/mm/yy"
		});
		
		$("#btReset").click(function() {
			$("#form")[0].reset();
			message('', 0);
		});
	
		//validation form
		$("#form").validate({
			rules : {
				"thanhtoanDTO.giatritt" : {
					required : true,
					number:true
				},
				"thanhtoanDTO.thang" : {
					required : true,
					number:true
				},
				"thanhtoanDTO.nam" : {
					required : true,
					number:true
				},
				"thanhtoanDTO.ngaychuyenkt":{
					required: true,
					date:true
				}
			}
		});
		// load edit
		var thanhtoan_id = '';
		var form_data = '<s:property value="form_data" escape="false"/>';
		var phuluchopdongs_data='<s:property value="phuluchopdongs_data" escape="false"/>';
		
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
			thanhtoan_id = form_data['id'];
		} 
		if(thanhtoan_id == '') {
			oTable = $('#dataTable').dataTable({
				"bJQueryUI": true,
				"bProcessing": false,
				"bScrollCollapse": true,
				"bAutoWidth": true,
				"bSort":false,
				"bFilter": false,"bInfo": false,
				"bPaginate" : false
			});
		} else {
			oTable = $('#dataTable').dataTable({
				"bJQueryUI": true,
				"bProcessing": false,
				"bScrollCollapse": true,
				"bAutoWidth": true,
				"bSort":false,
				"bFilter": false,"bInfo": false,
				"bPaginate" : false,
				"sAjaxSource": "${findsucoBythanhtoanURL}?id="+thanhtoan_id,
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
										addRow(i+1,this);
										i++;
									});
								} else {
									oTable.fnAddData([0,'','','','','','','','','','','','','','']);
									oTable.fnDeleteRow(0);
								}
							}
						}
					} );
				}
			});
		}
		if(phuluchopdongs_data!='')
		{
			phuluchopdongs_data=$.parseJSON(phuluchopdongs_data);
			LoadHopDongEdit(phuluchopdongs_data);
		}
		$("#btSubmit").click(function() {
			$(this).disabled = true;
			if (!$("#form").valid()) {
				alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!",0);
				$(this).disabled = false;
			} else {
				var dataString = $("#form").serialize();
				var i=0;
				var error="";
				$(".listphuluc").each(function(){
					var hopdong_id=$('#hopdong_id',this).val();
					var j=0;
					dataString+="&phuluchopdongDtos["+i+"].hopdong_id="+hopdong_id;
					var soluongphuluc=0;
					$("table tbody tr",this).each(function(){
						var checkbox=$("input[type='checkbox']",this);
						if(checkbox.attr("checked")=="checked")
						{
							var phuluc_id=$("#phuluc_id",this).val();
							dataString+="&phuluchopdongDtos["+i+"].phuluc_ids["+j+"]="+phuluc_id;
							soluongphuluc++;
						}
						j++;
					});
					if(soluongphuluc==0)
					{
						if(error!="")
							error+=", ";
						error+=$("#sohopdong",this).val();
					}
					i++;
				});
				if(i==0)
				{
					alert("Vui lòng chọn hợp đồng.");
				}
				if(error!="")
				{
					alert("Hợp đồng :"+error+" chưa chọn phụ lục. Vui lòng chọn đầy đủ phụ lục cho hợp đồng.");
				}
				else
				{
					$.ajax({
						url : "${doSaveURL}",
						type : 'POST',
						data : dataString,
						success : function(response) {
							$(this).disabled = false;
							if (response == "OK") {
								$(this).disabled = true;
								message(
										" Lưu thành công!",
										1);
								parent.reload = true;
								return;
							}
							else if(response=="Date")
							{
								$(this).disabled = true;
								message(" Ngày hết hạn phải lớn hơn ngày ký.",0);
								return;
							}
							else if(response=="exist")
							{
								$(this).disabled = true;
								message(" Số hồ sơ đã tồn tại trong cơ sở dữ liệu. Vui lòng nhập số hồ sơ khác.",0);
								return;
							}
							message(
									" Lưu không thành công, vui lòng thử lại.",
									0);
						},
						error : function(response) {
							$(this).disabled = false;
							message(" Lưu không thành công, vui lòng thử lại.",0);
						}
					});	
				}
			}
		});
	});
</script>