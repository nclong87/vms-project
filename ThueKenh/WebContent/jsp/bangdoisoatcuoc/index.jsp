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
<s:url action="loadformbydoisoatcuoc" namespace="/thanhtoan" id="loadformbydoisoatcuocURL"/>
<s:url action="findphulucByhopdonganddoisoatcuoc" namespace="/phuluc" id="findphulucByhopdonganddoisoatcuocURL" />
<s:url action="findByDoiSoatCuoc" namespace="/sucokenh" id="findsucoByDoiSoatCuocURL" />
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
	<script type='text/javascript' src='<%= contextPath %>/js/jquery.formatCurrency.min.js'></script>
	<script type='text/javascript' src='<%= contextPath %>/js/utils.js'></script>
	<script type="text/javascript" src="<%= contextPath %>/js/jquery.dataTables.min.js"></script>
	<script>
		var contextPath = '<%=contextPath%>';
		var baseUrl = contextPath;
		function byId(id) { //Viet tat cua ham document.getElementById
			return document.getElementById(id);
		}
	</script>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datetimepicker.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/templates.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_hopdong.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_suco_for_thanhtoan.js"></script>
	<style>
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
	<div id="dialog" title="Welcome to VMS" style="display:none"><center>Loading...</center></div>
	<input type="text" style="display:none" id="id" />
			<div style="width: 100%; margin-bottom: 10px;">	
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
											<td align="right" width="55px"><label for="xxxx">Đối tác <font title="Bắt buộc nhập" color="red">*</font>:</label></td>
											<td align="left">
												<select style="width: 210px" name="doitac_id" id="doitac_id">
													<option value="">---Chọn---</option>
													<s:iterator value="doiTacs">
														<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
													</s:iterator>
												</select>
											</td>	
											<td align="right" width="116px"><label for="xxxx">Tháng thanh toán </label><font title="Bắt buộc nhập" color="red">*</font>:</td>
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
											</td>	
											<td align="right">Năm <font title="Bắt buộc nhập" color="red">*</font>:</td>
											<td>
												<select name="nam" id="nam" style="width:95px">
													<option value="">Năm</option>
												</select>
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
				<div id="list_hopdong">
					<fieldset class="data_list">
						<legend>Danh sách hợp đồng</legend>
						<div style="width: 100%; padding-bottom: 5px;text-align: right;"><input class="button" type="button" value="Chọn hợp đồng" id="btPopupSearchHopDong"></div>
						<div id="tab">		
						</div>
					</fieldset>
				</div>
				<div style="clear:both;margin-top:10px" id="list_suco">
					<fieldset class="data_list">
						<legend>Danh sách sự cố giảm trừ</legend>
						<form id="form-chonsuco">
							<div style="padding-bottom: 5px;float: right"><input class="button" type="button" value="Chọn sự cố" id="btPopupSearchSuCo"></div>
							<table style="float:right">
								<tr>
									<td align="right">Thời điểm từ <font title="Bắt buộc nhập" color="red">*</font>:</td>
									<td align="left"><input type="text"
										name="thoidiembatdautu" id="thoidiembatdautu" style="width: 100px" class="datepicker"/>
									</td>
									<td align="right">đến <font title="Bắt buộc nhập" color="red">*</font>:</td>
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
			<input class="button" type="button" id="btThoat" onclick="window.parent.CloseWindow();" value="Thoát"/>
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
	function doRemoveAllRow(){
		var table=document.getElementById("dataTable");
		for(var i=0;i<table.rows.length;i++)
			oTable.fnDeleteRow(i);
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
		{
			$.each(data.phulucbithaythe,function(){
				if(trangthai!="")
					trangthai+=", ";
				trangthai+='<a href="${detailPhuLucURL}?id='+this.id+'" title="Xem chi tiết phụ lục" style="color:blue !important">'+this.tenphuluc.vmsSubstr(20)+"</a><br>";
			});
			if(trangthai!="")
				trangthai="Thay thế các phụ lục: "+trangthai;
		}
		obj.fnAddData([
			'<center>'+stt+'</center>','<center><a href="${detailPhuLucURL}?id='+data.id+'" target="_blank" title="'+data.tenphuluc+'" style="color:blue !important"><center>'+data.tenphuluc+'</a>','<center>'+loaiphuluc+'/<center>','<center>'+data.tendoitac+'</center>','<center>'+data.soluongkenh+'</center>','<center class="currency">'+data.giatritruocthue+'</center>','<center class="currency">'+data.giatrisauthue+'</center>','<center>'+data.ngayhieuluc+'</center>','<center>'+data.ngayhethieuluc+'</center>','<center>'+trangthai+'</center>','<center>'+thanhtoan+'</center>'
    		,'<center><input type="checkbox" checked="true"/><input id="phuluc_id" style="display:none" value="'+data.id+'"/></center>'
		]);
	}
	function addhopdong(container,data)
	{
		var loaihopdong="Có thời hạn";
		if(data.loaihopdong==1)
			loaihopdong="Có thời hạn";
		else 
			loaihopdong="Không có thời hạn";
		var rowhopdong=  '<h3 class="div_'+data.id+'"><a href="#" style="margin-left:15px">Số hợp đồng: '+data.sohopdong+'</a><table class="hopdonginfo"><tr><td>Loại hợp đồng: '+loaihopdong+'</td><td>Đối tác: '+data.tendoitac+'</td><td>Ngày ký: '+data.ngayky+'</td><td>Ngày hết hạn: '+data.ngayhethan+'</td></tr></table><div class="del" title="Xóa hợp đồng" id="'+data.id+'"></div></h3>'
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
										+'<th>Ngày hết hiệu lực</th>'
										+'<th width="150px">Trạng thái</th>'
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
			
			// kiem tra load su co
			var i=0;
			$(".listphuluc").each(function(){
				i++;
			});
			if(i==0)
			{
				$("#list_suco").hide();
			}
			else
				$("#list_suco").show();
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
				"sAjaxSource": "${findphulucByhopdongURL}?hopdong_id="+this.id+"&thang="+$("#thang").val()+"&nam="+$("#nam").val(),
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
									oPLtable.fnAddData([0,'','','','','','','','','','','']);
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
	function LoadHopDongEdit(data,doisoatcuoc_id)
	{
		$("#tab").html("");
		var div=document.createElement("div");
		$(div).attr("id","accordion");
		$(data).each(function(){
			addhopdong($(div),this);
		});
		
		$("#tab").append(div);
		$(div).accordion();
		// kiem tra load su co
		var i=0;
		$(".listphuluc").each(function(){
			i++;
		});
		if(i==0)
		{
			$("#list_suco").hide();
		}
		else
			$("#list_suco").show();
		
		$(".del").click(function(){
			var id=$(this).attr("id");
			$(".div_"+id).remove();
			
			// kiem tra load su co
			var i=0;
			$(".listphuluc").each(function(){
				i++;
			});
			if(i==0)
			{
				$("#list_suco").hide();
			}
			else
				$("#list_suco").show();
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
				"sAjaxSource": "${findphulucByhopdonganddoisoatcuocURL}?hopdong_id="+this.id+"&doisoatcuoc_id="+doisoatcuoc_id,
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
	function LoadInfo(dscdata)
	{
		oTable.fnClearTable();
		$("#doitac_id").val(dscdata.doitac_id);
		tungay=dscdata.tungay.replace(" 00:00:00.0","");
		tungay=tungay.split("-");
		if(tungay.length>=3)
		{
			$("#thang").val(parseInt(tungay[1],10));
			//$("#thang").attr("disabled","disabled");
			$("#nam").val(tungay[0]);
			//$("#nam").attr("disabled","disabled");
		}
		$("#id").val(dscdata.id);
		$.ajax( {
			"dataType": 'json', 
			"type": "POST", 
			"url": "${loadformbydoisoatcuocURL}", 
			"data": "doisoatcuoc_id="+dscdata.id, 
			"success": function(response){
				if(response.result == "ERROR") {
					alert("Lỗi kết nối server, vui lòng thử lại.");
				} else {
					if(response.phuluc_hopdongs.length!=0)
					{
						var phuluc_hopdong=$.parseJSON(response.phuluc_hopdongs);
						LoadHopDongEdit(phuluc_hopdong,dscdata.id);
						hidHopDongData=phuluc_hopdong;
					}
					// load su co
					if(response.sucos.length != 0) {
						var i = 0;
						$.each(response.sucos,function(){
							addRow(i+1,this);
							i++;
						});
					} else {
						oTable.fnAddData([0,'','','','','','','','','','','','','','']);
						oTable.fnDeleteRow(0);
					}
				}
			}
		});
	}
	var hidHopDongData=null;
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
		
		// combobox nam,thangs
		var currentTime = new Date();
		var year = currentTime.getFullYear();
		for(var i=year-10;i<year+10;i++)
		{
			$("#nam").append("<option value='"+i+"'>"+i+"</option>");
		}
		$("#thang").val(currentTime.getMonth());
		$("#nam").val(year);
		//
		popup_search_hopdong.init({
			url : "${popupSearchHopDongURL}",
			afterSelected : function(data) {
				LoadHopDong(data);
				hidHopDongData=data;
				if(data.length>0)
				{
					$("#list_suco").show();
				}
				else 
				{
					doRemoveAllRow();
					$("#list_suco").hide();
				}
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
		var doisoatcuoc_info='<s:property value="doisoatcuoc_info" escape="false"/>';
		if(doisoatcuoc_info!='')
		{
			dscData=$.parseJSON(doisoatcuoc_info);
			LoadInfo(dscData[0]);
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
					dataString+="&id="+$("#id").val();
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
								parent.reload = true;
								if($("#id").val()!="") {
								   parent.isUpdate = true;
								}
								var strId=response.data.id;
								if($("#id").val()!="")
									strId=$("#id").val();
								showDialogUrl("${formURL}?thanhtien="+response.data.tongconthanhtoan+"&giamtrumll="+response.data.giamtrumll+"&id="+strId,"Lưu bảng đối soát cước",450);
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
		InitData();
	});
	function InitData()
	{
		$("#list_hopdong").hide();
		$("#list_suco").hide();
		if($("#doitac_id").val()!="")
		{
			$("#list_hopdong").show();
		}
		else
		{
			$("#tab").html("");
			$("#list_hopdong").hide();
			$("#list_suco").hide();
		}
		$("#doitac_id").change(function(){
			if($(this).val()!="")
			{
				$("#tab").html("");
				doRemoveAllRow();
				$("#list_hopdong").show();
			}
			else
			{
				$("#tab").html("");
				doRemoveAllRow();
				$("#list_hopdong").hide();
				$("#list_suco").hide();
			}
		});
		$("#thang,#nam").change(function(){
			if(hidHopDongData!=null)
				LoadHopDong(hidHopDongData);
		});
	}
</script>