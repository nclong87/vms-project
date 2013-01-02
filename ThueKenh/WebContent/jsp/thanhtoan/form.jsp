<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/thanhtoan" id="doSaveURL" />
<s:url action="findphulucByhopdonganddoisoatcuoc" namespace="/phuluc" id="findphulucByhopdonganddoisoatcuocURL" />
<s:url action="findByDoiSoatCuoc" namespace="/sucokenh" id="findsucoByDoiSoatCuocURL" />
<s:url action="popupSearch" namespace="/bangdoisoatcuoc" id="popupSearchbangdoisoatcuocURL" />
<s:url action="detail" namespace="/phuluc" id="detailPhuLucURL"/>
<s:url action="detail" namespace="/sucokenh" id="detailSuCoURL"/>
<s:url action="loadformbydoisoatcuoc" namespace="/thanhtoan" id="loadformbydoisoatcuocURL"/>
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

<script type="text/javascript" src="<%= contextPath %>/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery.formatCurrency.min.js"></script>
<script type='text/javascript' src='<%= contextPath %>/js/utils.js'></script>
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
<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_suco_for_thanhtoan.js"></script>
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
    	left: 280px;
    	top: 3px;
	}
	.hopdonginfo td
	{
		padding: 0 10px;
	}
	.ui-accordion .ui-accordion-content-active
	{
		height:auto !important;
	}
</style>
</head>

<body>
	<form id="form" onsubmit="return false;">
		<input type="text" style="display: none" name="thanhtoanDTO.id" id="id" />
		<input type="text" style="display: none" name="thanhtoanDTO.doisoatcuoc_id" id="doisoatcuoc_id" />
		<input type="text" style="display:none" name="thanhtoanDTO.filename" id="filename" value=""/>
		<input type="text" style="display:none" name="thanhtoanDTO.filepath" id="filepath" value=""/>
		<input type="text" style="display:none" name="thanhtoanDTO.filesize" id="filesize" value=""/>
		<div style="clear: both; margin: 5px 0">
			<table class="input" style="width: 782px">
				<tr>
					<td colspan='4' align="left" id="msg"><a name="msg"></a></td>
				</tr>
				<tr>
					<td colspan='4' align="center">
						<input class="button" type="button" value="Chọn bảng đối soát cước" id="btPopupSearchBangDoiSoatCuoc">
					</td>
				</tr>
				<tr>
					<td align="right" width="150px"><label for="xxxx">Số hồ sơ :</label></td>
					<td align="left">
						<input  type="text" name="thanhtoanDTO.sohoso" id="sohoso" />
					</td>	
					<td align="right" width="150px"><label for="xxxx">Tháng thanh toán <font title="Bắt buộc nhập" color="red">*</font>:</label></td>
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
						<select name="thanhtoanDTO.nam" id="nam" style="width:95px">
							<option value="">Năm <font title="Bắt buộc nhập" color="red">*</font>:</option>
						</select>
					</td>	
				</tr>
				<tr>
					<td align="right" ><label for="xxxx">Ngày chuyển kế toán <font title="Bắt buộc nhập" color="red">*</font>:</label></td>
					<td align="left" >
						<input  type="text" name="thanhtoanDTO.ngaychuyenkt" id="ngaychuyenkt" class="datepicker"/>
					</td>
					<td align="right" ><label for="xxxx">Giá trị thanh toán <font title="Bắt buộc nhập" color="red">*</font>:</label></td>
					<td align="left">
						<input  type="text" name="thanhtoanDTO.giatritt" id="giatritt"/>
					</td>
				</tr>
			</table>
			<div style="width: 100%; margin-top: 10px;">
				<fieldset class="data_list">
					<legend>Danh sách hợp đồng</legend>
					<div id="tab">		
					</div>
				</fieldset>
				<div style="clear:both;margin-top:10px"></div>
				<fieldset class="data_list">
					<legend>Danh sách sự cố giảm trừ</legend>
					<table width="100%" id="dataTable" class="display">
					<thead>
							<tr>
								<th width="3px">STT</th>
								<th width="30px">Mã tuyến kênh</th>
								<th width="50px">Mã điểm đầu</th>
								<th width="50px">Mã điểm cuối</th>
								<th width="50px">Giao tiếp</th>
								<th width="50px">Dung lượng</th>
								<th width="100px">Thời gian bắt đầu</th>
								<th width="100px">Thời gian kết thúc</th>
								<th width="50px">Thời gian mất liên lạc</th>
								<th width="200px">Nguyên nhân</th>
								<th width="100px">Phương án xử lý</th>
								<th width="50px">Người xác nhận</th>
								<th width="50px">Người tạo</th>
								<th width="50px">Ngày tạo</th>
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
	function addRow(stt,data) {
		oTable.fnAddData([
			stt,'<a href="${detailSuCoURL}?id='+data.id+'" target="_blank" title="Xem chi tiết">'+data.tuyenkenh_id+'</a>','<center>'+data.madiemdau+'</center>','<center>'+data.madiemcuoi+'</center>','<center>'+data.loaigiaotiep+'</center>','<center>'+data.dungluong+' MB</center>','<center>'+data.thoidiembatdau+'</center>','<center>'+data.thoidiemketthuc+'</center>','<center>'+data.thoigianmll+'</center>',data.nguyennhan,data.phuonganxuly,'<center>'+data.nguoixacnhan+'</center>','<center>'+data.usercreate+'</center>',data.timecreate+'<input type="text" style="display:none" name="suco_ids" value="'+data.id+'" id="suco_id_'+data.id+'"/>'
		]);
	}

	function addphuluc(obj,stt,data){
		var thanhtoan="";
		if(data.thang!="" && data.nam!="")
			thanhtoan="Đã thanh toán đến tháng "+data.thang+"/"+data.nam;
		else
			thanhtoan="Chưa thanh toán";
		var loaiphuluc="";
		if(data.loaiphuluc==1)
			loaiphuluc="Độc lập";
		else 
			loaiphuluc="Thay thế";
		var trangthai = "";
		if(data.phulucbithaythe!="<root></root>")
			$.each(data.phulucbithaythe,function(){
				trangthai+='Thay thế cho các phụ lục: <a href="${detailPhuLucURL}?id='+this.id+'" title="'+this.tenphuluc+'">'+this.tenphuluc.vmsSubstr(20)+"</a><br>";
			});
		obj.fnAddData([
			'<center>'+stt+'</center>','<center><a href="${detailPhuLucURL}?id='+data.id+'" target="_blank" title="Xem chi tiết phụ lục" style="color:blue !important"></center>'+data.tenphuluc+'</a>','<center>'+loaiphuluc+'/<center>','<center>'+data.tendoitac+'</center>','<center>'+data.soluongkenh+'</center>','<center class="currency">'+data.giatritruocthue+'</center>','<center class="currency">'+data.giatrisauthue+'</center>','<center>'+data.ngayhieuluc+'</center>','<center>'+trangthai+'</center>','<center>'+thanhtoan+'</center>'
		]);
	}
	function addhopdong(container,data,i)
	{
		var loaihopdong="Có thời hạn";
		if(data.loaihopdong==1)
			loaihopdong="Có thời hạn";
		else 
			loaihopdong="Không có thời hạn";
		var rowhopdong=  '<h3 class="div_'+data.id+'"><a href="#" style="margin-left:15px">Số hợp đồng: '+data.sohopdong+'</a><table class="hopdonginfo"><tr><td>Loại hợp đồng: '+loaihopdong+'</td><td>Đối tác: '+data.tendoitac+'</td><td>Ngày ký: '+data.ngayky+'</td><td>Ngày hết hạn: '+data.ngayhethan+'</td></tr></table></h3>'
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
										+'<th>Ngày hiệu lực</th>'
										+'<th>Trạng thái</th>'
										+'<th>Thanh toán</th>'
									+'</tr>'
								+'</thead>'	
								+'<tbody>'
								+'</tbody>'
							+'</table>'		
						+'</div>';
		container.append(rowhopdong);
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
				"sAjaxSource": "${findphulucByhopdonganddoisoatcuocURL}?hopdong_id="+this.id+"&doisoatcuoc_id="+$("#doisoatcuoc_id").val(),
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
									$(".currency,#giatritt").formatCurrency({ 
										region : 'vn',
										roundToDecimalPlace: 0, 
										eventOnDecimalsEntered: true 
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
	}
	function LoadInfo(id,thanhtien,tungay)
	{
		oTable.fnClearTable();
		$("#doisoatcuoc_id").val(id);
		var fThanhTien=parseFloat(thanhtien);
		$("#giatritt").val(fThanhTien+fThanhTien*10/100);
		$("#giatritt").attr("disabled","disabled");
		tungay=tungay.replace(" 00:00:00.0","");
		tungay=tungay.split("-");
		if(tungay.length>=3)
		{
			$("#thang").val(parseInt(tungay[1],10));
			$("#thang").attr("disabled","disabled");
			$("#nam").val(tungay[0]);
			$("#nam").attr("disabled","disabled");
		}
		$.ajax( {
			"dataType": 'json', 
			"type": "POST", 
			"url": "${loadformbydoisoatcuocURL}", 
			"data": "doisoatcuoc_id="+id, 
			"success": function(response){
				if(response.result == "ERROR") {
					alert("Lỗi kết nối server, vui lòng thử lại.");
				} else {
					if(response.phuluc_hopdongs.length!=0)
					{
						var phuluc_hopdong=$.parseJSON(response.phuluc_hopdongs);
						LoadHopDongEdit(phuluc_hopdong);
					}
					// load su co
					if(response.sucos.length != 0) {
						var i = 0;
						$.each(response.sucos,function(){
							addRow(i+1,this);
							i++;
						});
					} else {
						oTable.fnAddData([0,'','','','','','','','','','','','','']);
						oTable.fnDeleteRow(0);
					}
				}
			}
		});
	}
	var searchbangdoisoatcuoc = new PopupSearch();
	$(document).ready(function() {
		oTable = $('#dataTable').dataTable({
			"bJQueryUI": true,
			"bProcessing": false,
			"bScrollCollapse": true,
			"bAutoWidth": true,
			"bSort":false,
			"bFilter": false,"bInfo": false,
			"bPaginate" : false
		});	

		searchbangdoisoatcuoc.init({
			url : "${popupSearchbangdoisoatcuocURL}",
			button : "#btPopupSearchBangDoiSoatCuoc",
			afterSelected : function(data) {	
				data = data[0];
				LoadInfo(data.id,data.tongconthanhtoan,data.tungay);
			}
		}); 
		
		// combobox nam
		var currentTime = new Date();
		var year = currentTime.getFullYear();
		for(var i=year-10;i<year+10;i++)
		{
			$("#nam").append("<option value='"+i+"'>"+i+"</option>");
		}
		//
		upload_utils.init();
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
		var doisoatcuoc_info='<s:property value="doisoatcuoc_info" escape="false"/>';
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
			if(doisoatcuoc_info!='')
			{
				dscData=$.parseJSON(doisoatcuoc_info);
				LoadInfo(dscData[0].id,dscData[0].tongconthanhtoan,dscData[0].tungay);
			}
		} 
		
		$("#btSubmit").click(function() {
			$("#msg").html("");
			var button=this;
			button.disabled = true;
			if (!$("#form").valid()) {
				alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!",0);
				button.disabled = false;
			} else {
				var dataString = $("#form").serialize();
				if($("#doisoatcuoc_id").val()=="")
				{
					alert("Vui lòng chọn bảng đối soát cước");
				}
				else
				{
					$.ajax({
						url : "${doSaveURL}",
						type : 'POST',
						data : dataString,
						success : function(response) {
							button.disabled = false;
							if (response == "OK") {
								button.disabled = false;
								message(" Lưu thành công!",1);
								parent.reload = true;
								if($("#id").val()!="") {
								   parent.isUpdate = true;
								}
								return;
							}
							else if(response=="exist")
							{
								button.disabled = false;
								message("Số hồ sơ này đã tồn tại trong hệ thống. Vui lòng nhập số hồ sơ khác",0);
								return;
							}
							message(" Lưu không thành công, vui lòng thử lại.",0);
						},
						error : function(response) {
							button.disabled = false;
							message(" Lưu không thành công, vui lòng thử lại.",0);
						}
					});	
				}
			}
			window.location.href="#msg";
		});
	});
</script>