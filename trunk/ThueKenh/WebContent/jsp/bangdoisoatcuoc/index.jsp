<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/bangdoisoatcuoc" id="doSaveURL" />
<s:url action="popupSearchForThanhToan" namespace="/sucokenh" id="popupSearchSuCoKenhURL" />
<s:url action="popupSearch" namespace="/hopdong" id="popupSearchHopDongURL" />
<s:url action="findphulucByhopdong" namespace="/phuluc" id="findphulucByhopdongURL" />
<s:url action="form" namespace="/bangdoisoatcuoc" var="formURL"/>
<s:url action="detail" namespace="/phuluc" id="detailPhuLucURL"/>
<s:url action="detail" namespace="/sucokenh" id="detailSuCoURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
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
	    	left: 200px;
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
		fieldset.data_list {
-moz-border-radius: 5px 5px 5px 5px;
border: 1px solid #DDDDDD;
}
fieldset.data_list  legend{
color: gray;
font-weight: bold;
}

span.required {
color:red;
}
label.error {
color: red;
display: block;
}
input.error, select.error {
	border:1px solid red
}
p {
margin:0;
}
.ui-datepicker select
{
	width: 50px !important;
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
							<div class="p3t">Xuất bảng đối soát cước</div>
						</div>
						<div class="fl tsr" id="t_3">
						</div>
					</div>
					<div class="lineU"></div>
				</div>
				<form id="form" onsubmit="return false;">
					<div id="divSearch" class="ovf" style="padding-right: 0px;">
						<div class="kc4 p5l p15t bgw">
							<div class="bgw p5b ovf" id="tabnd_2">
								<div class="ovf p5l p5t">
									<table>
										<tr>
											<td colspan='5' align="left" id="msg"><a name="msg"></a></td>
										</tr>
										<tr>
											<td align="right" width="50px"><label for="xxxx">Đối tác :</label></td>
											<td align="left">
												<select style="width: 210px" name="doitac_id" id="doitac_id">
													<option value="">---Chọn---</option>
													<s:iterator value="doiTacs">
														<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
													</s:iterator>
												</select>
												<font title="Bắt buộc nhập" color="red">*</font>
											</td>	
											<td align="right" width="110px"><label for="xxxx">Tháng thanh toán:</label></td>
											<td align="left">
												<select name="thang" id="thang" style="width:96px">
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
											</td>	
											<td>
												<select name="nam" id="nam" style="width:95px">
													<option value="">Năm</option>
												</select>
												<font title="Bắt buộc nhập" color="red">*</font>
											</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="clearb"></div>
						</div>
					</div>
				</form>
				<div style="height: 1px;"></div>
			</div>
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
					<form id="form-chonsuco">
						<div style="padding-bottom: 5px;float: right"><input class="button" type="button" value="Chọn sự cố" id="btPopupSearchSuCo"></div>
						<table style="float:right">
							<tr>
								<td align="right">Thời điểm từ:</td>
								<td align="left"><input type="text"
									name="thoidiembatdautu" id="thoidiembatdautu" style="width: 100px" class="datepicker"/>
								</td>
								<td align="right">đến :</td>
								<td align="left"><input type="text"
									name="thoidiembatdauden" id="thoidiembatdauden" style="width: 100px" class="datepicker"/>
								</td>

							</tr>
						</table>
					</form>
					<div style="clear:both"></div>
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
		<div style="clear:both"></div>
		<div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
			<input type="button" class="button" value="Lưu" id="btSubmit"></input>
			<input type="button" class="button" value="Làm lại" id="btReset"></input>
		</div>
		<!--end bg_wrapper-->
	</div>
	<!-- end top -->
	<div id="footer"></div>
	<!--end footer-->
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
		rowChanges(0);
	}
	function addRow(stt,data) {
		oTable.fnAddData([
			"<center id='stt'></center>",'<a href="${detailSuCoURL}?id='+data.id+'" target="_blank" title="Xem chi tiết">'+data.tuyenkenh_id+'</a>','<center>'+data.madiemdau+'</center>','<center>'+data.madiemcuoi+'</center>','<center>'+data.loaigiaotiep+'</center>','<center>'+data.dungluong+' MB</center>','<center>'+data.thoidiembatdau+'</center>','<center>'+data.thoidiemketthuc+'</center>','<center>'+data.thoigianmll+'</center>',data.nguyennhan,data.phuonganxuly,'<center>'+data.nguoixacnhan+'</center>','<center>'+data.usercreate+'</center>',data.timecreate,'<center><input type="text" style="display:none" name="suco_ids" value="'+data.id+'" id="suco_id_'+data.id+'"/><img title="Remove" src="'+baseUrl+'/images/icons/remove.png" onclick="doRemoveRow(this)" style="cursor:pointer"></center>'
		]);
	}
	function rowChanges(flag){
		var i = 1;
		$("#dataTable tbody tr #stt").each(function(){
			$(this).text(i);
			i++;
		});
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
				trangthai+='Thay thế các phụ lục: <a href="${detailPhuLucURL}?id='+this.id+'" title="Xem chi tiết phụ lục" style="color:blue !important">'+this.tenphuluc.vmsSubstr(20)+"</a><br>";
			});
		obj.fnAddData([
			'<center>'+stt+'</center>','<center><a href="${detailPhuLucURL}?id='+data.id+'" target="_blank" title="'+data.tenphuluc+'" style="color:blue !important"><center>'+data.tenphuluc+'</a>','<center>'+loaiphuluc+'/<center>','<center>'+data.tendoitac+'</center>','<center>'+data.soluongkenh+'</center>','<center class="currency">'+data.giatritruocthue+'</center>','<center class="currency">'+data.giatrisauthue+'</center>','<center>'+data.ngayhieuluc+'</center>','<center>'+trangthai+'</center>','<center>'+thanhtoan+'</center>'
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
										+'<th>Ngày hiệu lực</th>'
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
				"sAjaxSource": "${findphulucByhopdongURL}?hopdong_id="+this.id,
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
									$(".currency").formatCurrency({ 
										region : 'vn',
										roundToDecimalPlace: 0, 
										eventOnDecimalsEntered: true 
									});
								} else {
									oPLtable.fnAddData([0,'','','','','','','','','','']);
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
	function enableSubmit()
	{
		$("#btSubmit").disabled=false;
	}
	$(document).ready(function() {
		// combobox nam
		var currentTime = new Date();
		var year = currentTime.getFullYear();
		for(var i=year-10;i<year+10;i++)
		{
			$("#nam").append("<option value='"+i+"'>"+i+"</option>");
		}
		//
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
				rowChanges(1);
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
				"thang" : {
					required : true,
					number:true
				},
				"nam" : {
					required : true,
					number:true
				},
				"doitac_id":{
					required: true
				}
			}
		});
		
		$("#form-chonsuco").validate({
			rules : {
				"thoidiembatdautu" : {
					required : true,
					date:true
				},
				"thoidiembatdauden" : {
					required : true,
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
									rowChanges(1);
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
		$("#btSubmit").click(function() {
			var button=this;
			button.disabled = true;
			if (!$("#form").valid()) {
				alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!",0);
				button.disabled = false;
			} else {
				var dataString = $("#form").serialize()+"&"+$("#form-chonsuco").serialize();
				var i=0;
				var error="";
				$(".listphuluc").each(function(){
					var soluongphuluc=0;
					$("table tbody tr",this).each(function(){
						var checkbox=$("input[type='checkbox']",this);
						if(checkbox.attr("checked")=="checked")
						{
							var phuluc_id=$("#phuluc_id",this).val();
							dataString+="&phuluc_ids="+phuluc_id;
							soluongphuluc++;
						}
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
					button.disabled = false;
					return;
				}
				if(error!="")
				{
					alert("Hợp đồng :"+error+" chưa chọn phụ lục. Vui lòng chọn đầy đủ phụ lục cho hợp đồng.");
					button.disabled = false;
				}
				else
				{
					// suco
					$("#dataTable tr input[type='text']").each(function(){
						dataString+="&suco_ids="+$(this).val();
					});
					$.ajax({
						url : "${doSaveURL}",
						type : 'POST',
						data : dataString,
						success : function(response) {
							button.disabled = false;
							if(response.status == "ERROR") {
								button.disabled = false;
								if(response.data == "END_SESSION") {
									location.href = LOGIN_PATH;
									return;
								}
								alert(response.data);
							} else if(response.status == "OK") {
								button.disabled = false;
								showDialogUrl("${formURL}?thanhtien="+response.data.thanhtien+"&giamtrumll="+response.data.giamtrumll+"&id="+response.data.id,"Lưu bảng đối soát cước",450);
							}
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