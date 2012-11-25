<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="form" namespace="/sucokenh" id="formURL"/>
<s:url action="ajLoadSuCo" namespace="/sucokenh" id="ajLoadSuCo"/>
<s:url action="popupSearchForSuCo" namespace="/tuyenkenh" id="popupSearchForSuCoURL" />
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
	<script type="text/javascript" src="<%=contextPath%>/js/mylibs/popup_search_tuyenkenh.js"></script>
</head>

<body>
	<%@include file="/include/top.jsp"%>
		<div id="bg_wrapper">
			<div style="width: 100%" class="ovf">
				<div class="s10">
					<div class="fl">
						<div class="fl tsl" id="t_1"></div>
						<div class="fl clg b tsc d" id="t_2">
							<div class="p3t">Tìm kiếm sự cố</div>
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
											<td align="right">Mã tuyến kênh</td>
											<td><input type="text" style="width: 182px" name="tuyenkenh_id" id="tuyenkenh_id"/><input type="button" id="btPopupSearchTuyenkenh" value="..."/></td>
											<td align="right">Dung lượng (MB) :</td>
											<td><input type="text" style="width: 218px" name="dungluong" id="dungluong" /></td>
											
										</tr>
										<tr>
											<td align="right">Mã điểm đầu :</td>
											<td><input type="text" style="width: 218px" name="madiemdau" id="madiemdau"/></td>
											<td align="right">Mã điểm cuối :</td>
											<td><input type="text" style="width: 218px" name="madiemcuoi" id="madiemcuoi"/></td>
										</tr>
										<tr>
											<td align="right">Thời điểm bắt đầu từ:</td>
											<td align="left"><input type="text"
												name="thoidiembatdautu" id="thoidiembatdautu" style="width: 218px" class="datetimepicker"/>
											</td>
											<td align="right">Thời điểm bắt đầu đến :</td>
											<td align="left"><input type="text"
												name="thoidiembatdauden" id="thoidiembatdauden" style="width: 218px" class="datetimepicker"/>
											</td>
	
										</tr>
										<tr>
											<td align="right">Thời điểm kết thúc từ:</td>
											<td align="left"><input type="text"
												name="thoidiemketthuctu" id="thoidiemketthuctu" style="width: 218px" class="datetimepicker"/>
											</td>
											<td align="right">Thời điểm kết thúc đến :</td>
											<td align="left"><input type="text"
												name="thoidiemketthucden" id="thoidiemketthucden" style="width: 218px" class="datetimepicker"/>
											</td>
	
										</tr>
										<tr>
											<td align="right">Loại sự cố :</td>
											<td>
												<select name="loaisuco" id="loaisuco" style="width:220px">
													<option value="">Tất cả</option>
													<option value="0">Sự cố bình thường</option>
													<option value="1">Sự cố lớn</option>
												</select>
											</td>
											<td align="right">Người xác nhận :</td>
											<td><input type="text"
												name="nguoixacnhan" id="nguoixacnhan" style="width: 218px"/></td>
										</tr>
	
										<tr height="30px">
											<td></td>
											<td colspan="3">
												<div class="buttonwrapper">
													<input type="button" class="button" value="Tìm kiếm" onclick="doSearch()"></input>
													<input type="button" class="button" value="Xuất excel"></input>
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
			<div style="clear: both; margin: 5px 0">
				<input type="button" class="button" value="Thêm sự cố" onclick="ShowWindow('Thêm sự cố',800,600,'${formURL}',false);"></input>
				<input type="button" class="button" value="Import Excel" onclick="location.href='${importSuCoURL}'"></input>
				<input class="button" type="button" id="btXoa" value="Xóa" style="float: right; margin-right: 10px;"/>
			</div>
			<table width="100%" id="dataTable" class="display">
				<thead>
					<tr>
						<th width="3px">STT</th>
						<th width="30px">Mã tuyến kênh</th>
						<th width="30px">Mã điểm đầu</th>
						<th width="30px">Mã điểm cuối</th>
						<th width="30px">Giao tiếp</th>
						<th width="30px">Dung lượng</th>
						<th width="30px">Số lượng</th>
						<th width="50px">Thời gian bắt đầu</th>
						<th width="50px">Thời gian kết thúc</th>
						<th width="50px">Thời gian mất liên lạc</th>
						<th width="50px">Nguyên nhân</th>
						<th width="50px">Phương án xử lý</th>
						<th width="50px">Loại sự cố</th>
						<th width="50px">Người xác nhận</th>
						<th width="50px">Chi tiết</th>
						<th width="5px">Sửa</th>
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
	LoadDateTimePicker(".datetimepicker");
	// popup search tuyen kenh
	popup_search_tuyenkenh.init({
		url : "${popupSearchForSuCoURL}",
		afterSelected : function(data) {
			// list tuyen kenh tra ve, sau do xu ly du lieu cho nay
			data = data[0];
			$("#tuyenkenh_id").val(data["id"]) ;
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