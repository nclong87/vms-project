<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="form" namespace="/hopdong" id="formURL"/>
<s:url action="ajLoadHopDong" namespace="/hopdong" id="ajLoadHopDong"/>
<s:url action="delete" namespace="/hopdong" id="deleteURL"/>
<s:url action="detail" namespace="/hopdong" id="detailURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
</head>

<body>
	<%@include file="/include/top.jsp"%>
		<div id="bg_wrapper">
			<a class="help" target="_blank" href="<%= request.getContextPath() %>/files/HDSD_v4.0.htm#_Toc352351962" title="Hướng dẫn"></a>
			<div style="width: 100%" class="ovf">
				<div class="s10">
					<div class="fl">
						<div class="fl tsl" id="t_1"></div>
						<div class="fl clg b tsc d" id="t_2">
							<div class="p3t">Tìm kiếm hợp đồng</div>
						</div>
						<div class="fl tsr" id="t_3"></div>
					</div>
					<div class="lineU">
						<img height="1px" alt="" class="w100" src="../images/spacer.gif">
					</div>
				</div>
				<div id="divSearch" class="ovf" style="padding-right: 0px;">
					<div class="kc4 p5l p15t bgw">
						<div class="bgw p5b ovf" id="tabnd_2">
							<div class="ovf p5l p5t">
								<form id="form">
									<table>
										<tr>
											<td align="right">Loại hợp đồng :</td>
											<td><select style="width: 220px" name="loaihopdong" id="loaihopdong">
													<option value="">---Tất cả---</option>
													<option value="1">Có thời hạn</option>
													<option value="0">Không thời hạn</option>
											</select></td>
										</tr>
										<tr>
											<td align="right">Số hợp đồng :</td>
											<td><input type="text" name="sohopdong" id="sohopdong" style="width: 218px"/></td>
											<td align="right">Đối tác :</td>
											<td>
												<select style="width: 220px" name="doitac_id" id="doitac_id">
														<option value="">---Chọn---</option>
														<s:iterator value="doiTacs">
															<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
														</s:iterator>
												</select>
											</td>
	
										</tr>
										<tr>
											<td align="right">Ngày ký từ:</td>
											<td align="left"><input type="text"
												name="ngaykytu" id="ngaykytu" style="width: 218px" class="datepicker"/>
											</td>
											<td align="right">Ngày ký đến :</td>
											<td align="left"><input type="text"
												name="ngaykyden" id="ngaykyden" style="width: 218px" class="datepicker"/>
											</td>
	
										</tr>
										<tr>
											<td align="right">Ngày hết hạn từ:</td>
											<td align="left"><input type="text"
												name="ngayhethantu" id="ngayhethantu" style="width: 218px" class="datepicker"/>
											</td>
											<td align="right">Ngày hết hạn đến :</td>
											<td align="left"><input type="text"
												name="ngayhethanden" id="ngayhethanden" style="width: 218px" class="datepicker"/>
											</td>
	
										</tr>
										<tr height="30px">
											<td></td>
											<td colspan="3">
												<div class="buttonwrapper">
													<input type="button" class="button" value="Tìm kiếm" onclick="doSearch()"></input>
												</div>
											</td>
										</tr>
									</table>
								</form>
							</div>
						</div>
						<div class="clearb"></div>
					</div>
				</div>
			</div>
			<div style="clear: both; margin: 5px 0 0 0">
				<input type="button" class="button" value="Thêm hợp đồng" onclick="ShowWindow('Thêm hợp đồng',800,600,'${formURL}',false);"></input>
				<input class="button" type="button" id="btXoa" value="Xóa" style="float: right; margin-right: 10px;"/>
			</div>
			<table width="100%" id="dataTable" class="display">
				<thead>
					<tr>
						<th width="3%">STT</th>
						<th width="30px">Số hợp đồng</th>
						<th width="30px">Loại hợp đồng</th>
						<th width="30px">Đối tác</th>
						<th width="30px">Ngày ký</th>
						<th width="30px">Ngày hết hạn</th>
						<th width="30px">Sửa</th>
						<th width="5px" align="center"><input type="checkbox" onclick="selectAll(this)"/></th>
					</tr>
				</thead>
				<tbody>
					<tr><td colspan="8" class="dataTables_empty">Đang tải dữ liệu...</td></tr>
				</tbody>
			</table>
		</div>
		<!--end bg_wrapper-->
	</div>
	<!-- end top -->
	<div id="footer"></div>
	<!--end footer-->
</body>
</html>
<script>
function doReset() {
	$("#form")[0].reset(); //Reset form cua jquery, giu lai gia tri mac dinh cua cac field
	byId("msg").innerHTML="";
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
function newPopupWindow(file, window, width, height) {
    msgWindow = open(file, window, 'resizable=yes, width=' + width + ', height=' + height + ', titlebar=yes, toolbar=no, scrollbars=yes');
    if (msgWindow.opener == null) msgWindow.opener = self;
}
$(document).ready(function(){	
	// load datetime
	$( ".datepicker" ).datepicker({
		showButtonPanel: true,
		dateFormat : "dd/mm/yy"
	});
	
	// Load table
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${ajLoadHopDong}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${detailURL}?id='+oObj.aData.id+'" title="Xem chi tiết hợp đồng">'+oObj.aData.sohopdong+'</a>'; 
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							if(oObj.aData.loaihopdong==0)
								return "Không thời hạn";
							else
								return "Có thời hạn";
						}
					},
					{ "mDataProp": "tendoitac","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "ngayky","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "ngayhethan","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							return '<center><span class="edit_icon" data-ref-id="'+oObj.aData.id+'" title="Sửa" href="#"></span></center>'; 
						}
					},
					{ "mDataProp": null,"bSortable": false,"bSearchable": false,
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
	// edit
	$("span.edit_icon").live("click",function(){
		var id = $(this).attr("data-ref-id");
		ShowWindow('Cập nhật thông tin hợp đồng',800,600,"${formURL}?id="+id,false);
	});
	
	// delete
	
	$("#btXoa").click(function(){
		var dataString = '';
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
		if(!confirm("Bạn muốn xóa dữ liệu?")) return;
		var button = this;
		button.disabled = true;
		$.ajax({
			type: "POST",
			cache: false,
			url : "${deleteURL}",
			data: dataString,
			success: function(data){
				button.disabled = false;
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
			error: function(data){ alert (data);button.disabled = false;}	
		});	
	});
});
</script>