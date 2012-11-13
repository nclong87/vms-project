<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="form" namespace="/sucokenh" id="formURL"/>
<s:url action="ajLoadSuCo" namespace="/sucokenh" id="ajLoadSuCo"/>
<s:url action="popupSearch" namespace="/tuyenkenh" id="popupSearchURL" />
<s:url action="delete" namespace="/sucokenh" id="deleteURL"/>
<s:url action="detail" namespace="/sucokenh" id="detailURL"/>
<s:url action="suco" namespace="/import" id="importSuCoURL"/>
<s:url action="detail" namespace="/tuyenkenh" id="tuyenkenhdetailURL"/>
<s:url action="detailLoaiGiaoTiep" namespace="/danhmuc" id="detailGiaoTiepURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datepicker-vi.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui/jquery.ui.datetimepicker.js"></script>
	<style>
		.reporttb{border-collapse: collapse}
		.reporttb tr td.parent {border:1px solid #DDD;padding:15px;width:50%;vertical-align: top}
	</style>
</head>

<body>
	<%@include file="/include/top.jsp"%>
		<div id="bg_wrapper">
			<table width="100%" align="center" style="" class="reporttb">
					<tr>
						<td align="center" class="parent">
							<table>
								<tr>
									<td colspan="4"><b>Các kênh chưa bàn giao</b> <br /> <br /></td>
								</tr>
								<tr>
									<td>Đối tác :</td>
									<td>
										<select width="200px">
											<option>Tất cả</option>
											<option>Doi tac 2</option>
											<option>Doi tac 3</option>
											<option>Doi tac 4</option>
										</select>
									</td>
								</tr>
								<tr>
									<td></td>
									<td><input type="button" class="button" value="Xuất Excel" id="btSubmit1"></input></td>
								</tr>
							</table>
						</td>
						<td align="center" class="parent">
							<table>
								<tr>
									<td colspan="4"><b>Các kênh đã bàn giao nhưng chưa có
											hợp đồng </b> <br /> <br /></td>
								</tr>
								<tr>
									<td>Đối tác :</td>
									<td>
										<select width="200px">
											<option>Tất cả</option>
											<option>Doi tac 2</option>
											<option>Doi tac 3</option>
											<option>Doi tac 4</option>
										</select>
									</td>
								</tr>
								<tr>
									<td></td>
									<td><input type="button" class="button" value="Xuất Excel" id="btSubmit1"></input></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="center"  class="parent">
							<table>
								<tr>
									<td colspan="4"><b>Các hợp đồng chưa thanh toán</b> <br />
										<br /></td>
								</tr>
								<tr>
									<td>Đối tác :</td>
									<td><select width="200px">
											<option>Tất cả</option>
											<option>Doi tac 2</option>
											<option>Doi tac 3</option>
											<option>Doi tac 4</option>
									</select></td>
								</tr>
								<tr>
									<td></td>
									<td><input type="button" class="button" value="Xuất Excel" id="btSubmit1"></input></td>
								</tr>
							</table>
						</td>
						<td align="left" class="parent">
							<table>
								<tr>
									<td colspan="4"><b>Tiền thuê kênh phát sinh - Tiền
											thuê kênh đã thanh toán</b> <br /> <br /></td>
								</tr>
								<tr>
									<td>Tháng :</td>
									<td><select width="200px">
											<option>1</option>
											<option>2</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
											<option>11</option>
											<option>12</option>
									</select></td>
									<td>Năm :</td>
									<td><select width="200px">
											<option>2010</option>
											<option>2011</option>
											<option>2012</option>
											<option>2013</option>
											<option>2014</option>

									</select></td>
								</tr>
								<tr>
									<td></td>
									<td><input type="button" class="button" value="Xuất Excel" id="btSubmit1"></input></td>
								</tr>
							</table>
						</td>
					</tr>
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
	LoadDateTimePicker(".datetimepicker");
	// popup search tuyen kenh
	popup_search_tuyenkenh.init({
		url : "${popupSearchURL}",
		afterSelected : function(data) {
			// list tuyen kenh tra ve, sau do xu ly du lieu cho nay
			data = data[0];
			$("#tuyenkenh_id").val(data["id"]);
		}
	});
	
	// Load table
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${ajLoadSuCo}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${tuyenkenhdetailURL}?id='+oObj.aData.tuyenkenh_id+'" title="Xem chi tiết tuyến kênh">'+oObj.aData.tuyenkenh_id+'</a>'; 
						}
					},
					{ "mDataProp": "madiemdau","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "madiemcuoi","bSortable": false,"bSearchable": false},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${detailGiaoTiepURL}?id='+oObj.aData.giaotiep_id+'" title="Xem chi tiết loại giao tiếp">'+oObj.aData.loaigiaotiep+'</a>'; 
						}
					},
					{ "mDataProp": "dungluong","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "soluong","bSortable": false,"bSearchable": false},
					{ "mDataProp": "thoidiembatdau","bSortable": false,"bSearchable": false},
					{ "mDataProp": "thoidiemketthuc","bSortable": false,"bSearchable": false},
					{ "mDataProp": "thoigianmll","bSortable": false,"bSearchable": false},
					{ "mDataProp": "nguyennhan","bSortable": false,"bSearchable": false},
					{ "mDataProp": "phuonganxuly","bSortable": false,"bSearchable": false},
					{ "mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							if(oObj.aData.loaisuco==0)
								return "<span>Sự cố bình thường</span>";
							else
								return "<span style='color:red'>Sự cố lớn</span>";
						}
					},
					{ "mDataProp": "nguoixacnhan","bSortable": false,"bSearchable": false},
					{ "mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":'td_center',
						"fnRender": function( oObj ) {
							return '<a target="_blank" href="${detailURL}?id='+oObj.aData.id+'" title="Xem chi tiết sự cố"><div class="detail"></div></a>';  
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
		"sPaginationType": "two_button"
	});
	// edit
	$("span.edit_icon").live("click",function(){
		var id = $(this).attr("data-ref-id");
		ShowWindow('Cập nhật thông tin sự cố kênh',800,600,"${formURL}?id="+id,false);
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