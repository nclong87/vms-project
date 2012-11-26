<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="form" namespace="/thanhtoan" id="formURL"/>
<s:url action="ajLoadThanhToan" namespace="/thanhtoan" id="ajLoadThanhToanURL"/>
<s:url action="delete" namespace="/thanhtoan" id="deleteURL"/>
<s:url action="detail" namespace="/thanhtoan" id="detailURL"/>
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
			<div style="width: 100%" class="ovf">
				<div class="s10">
					<div class="fl">
						<div class="fl tsl" id="t_1"></div>
						<div class="fl clg b tsc d" id="t_2">
							<div class="p3t">Tìm kiếm hồ sơ thanh toán</div>
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
										<td width="150px" align="right">
											Số hồ sơ :
										</td>
										<td align="left">
											<input type="text" name="sohoso" id="sohoso" style="width: 218px"/>
										</td>
									</tr>
									<tr>
										<td align="right">Ngày chuyển hồ sơ từ:</td>
										<td align="left"><input type="text" name="ngaychuyenhosotu" id="ngaychuyenhosotu" style="width: 218px" class="datepicker"/>
										</td>
										<td align="right">đến :</td>
										<td align="left"><input type="text" name="ngaychuyenhosoden" id="ngaychuyenhosoden" style="width: 218px" class="datepicker"/>
										</td>
									</tr>
									<tr>
										<td align="right" width="150px">
											Trạng thái hồ sơ :
										</td>
										<td align="left">
											<select name="trangthai" id="trangthai" style="width: 220px">
												<option value="">Tất cả</option>
												<option value="0">Chưa thanh toán</option>
												<option value="1">Đã thanh toán</option>
											</select>
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
				<input type="button" class="button" value="Thêm hồ sơ thanh toán" onclick="ShowWindow('Thêm hồ sơ thanh toán',800,600,'${formURL}',true);MaxWindow();"></input>
				<input class="button" type="button" id="btXoa" value="Xóa" style="float: right; margin-right: 10px;"/>
			</div>
			<table width="100%" id="dataTable" class="display">
				<thead>
					<tr>
						<th width="30px">STT</th>
						<th>Số hồ sơ</th>
						<th>Tháng/Năm thanh toán</th>
						<th>Ngày chuyển hồ sơ kế toán</th>
						<th>Ngày ký UNC</th>
						<th>Ngày chuyển khoản</th>
						<th>Giá trị thanh toán</th>
						<th>Trạng thái</th>
						<th>Chi tiết</th>
						<th width="30px">Sửa</th>
						<th width="5px" align="center"><input type="checkbox" onclick="selectAll(this)"/></th>
					</tr>
				</thead>
				<tbody>
					<tr><td colspan="13" class="dataTables_empty">Đang tải dữ liệu...</td></tr>
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
		"sAjaxSource": "${ajLoadThanhToanURL}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ "mDataProp": "sohoso","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return oObj.aData.thang+"/"+oObj.aData.nam;
						}
					},
					{ "mDataProp": "ngaychuyenkt","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ "mDataProp": "ngaykyunc","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ "mDataProp": "ngaychuyenkhoan","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ "mDataProp": "giatritt","bSortable": false,"bSearchable": false,"sClass":'td_right number' },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							if(oObj.aData.trangthai==0)
								return "<span style='color:red'>Chưa thanh toán</span>";
							else 
								return "<span style='color:green'>Đã thanh toán</span>";
						}
					},
					{ "mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${detailURL}?id='+oObj.aData.id+'" title="Xem chi tiết hồ sơ thanh toán"><div class="detail"></div></a>';  
						}
					},
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
		"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
			$(".number",nRow).formatCurrency({ 
				region : 'vn',
				roundToDecimalPlace: 0, 
				eventOnDecimalsEntered: true 
			});
        },
		"sPaginationType": "two_button"
	});
	
	// edit
	$("span.edit_icon").live("click",function(){
		var id = $(this).attr("data-ref-id");
		ShowWindow('Cập nhật thông tin hồ sơ thanh toán',800,600,"${formURL}?id="+id,true);
		MaxWindow();
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