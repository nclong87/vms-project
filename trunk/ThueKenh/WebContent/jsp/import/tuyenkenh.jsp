
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/settings" var="settingsIndexURL"/>
<s:url action="detail" namespace="/tuyenkenh" id="tuyenkenhDetailURL"/>
<s:url action="doUploadTuyenkenh" namespace="/import" id="doUploadTuyenkenhURL"/>
<s:url action="loadTuyenkenhImport" namespace="/import" id="loadTuyenkenhImportURL"/>
<s:url action="doImportTuyenkenh" namespace="/import" id="doImportTuyenkenhURL"/>
<s:url action="doDeleteTuyenkenh" namespace="/import" id="doDeleteTuyenkenhURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.form.js"></script>
<style>
.block {
float: left;
margin-left: 10px;
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
						<div class="p3t">Import tuyến kênh</div>
					</div>
					<div class="fl tsr" id="t_3">
					</div>
				</div>
				<div class="lineU"></div>
			</div>
			<div id="divSearch" class="ovf" style="padding-right: 0px;">
				<div class="kc4 p5l p15t bgw">
					<div class="bgw p5b ovf" id="tabnd_2">
						<div class="ovf p5l p5t">
							<table width="500px">
								<form id="frmUpload" method="post" enctype="multipart/form-data">
								<tbody id="display">
								<tr>
									<td width="150px" align="right">
										Chọn file excel :
									</td>
									<td align="left">
										<input type="file" name="fileupload" />
									</td>
									<td align="right" width="150px">
										<a href="<%=contextPath%>/files/TuyenKenhExcelMau.xls">File mẫu</a>
									</td>
								</tr>
								</tbody>
								</form>
								<tfoot>
									<td></td>
									<td align="left">
									<input class="button" type="button" value="Upload" onclick="doUpload()"/>
									</td>
								</tfoot>
							</table>
						</div>
					</div>
					<div class="clearb">
					</div>
				</div>
			</div>
			<div style="height: 1px;"></div>
		</div>
		<div style="clear:both;margin:5px 0 ">
		<input class="button" type="button" id="btImport" value="Import"/>
		<input class="button" type="button" id="btXoa" value="Xóa"/>
		</div>
			<table width="100%" id="dataTable" class="display">
			<thead>
				<tr>
					<th width="5%">#</th>
					<th>Mã điểm đầu</th>
					<th>Mã điểm cuối</th>
					<th>Giao tiếp</th>
					<th>Dung lượng</th>
					<th>Số lượng</th>
					<th>Dự án</th>
					<th width="120px">ĐV nhận kênh</th>
					<th width="80px">Khu vực</th>
					<th width="80px">Trùng</th>
					<th width="5px" align="center"><input type="checkbox" onclick="selectAll(this)"/></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="13" class="dataTables_empty">Đang tải dữ liệu...</td>
				</tr>
			</tbody>
			</table>
	</div>
	<div id="footer"></div>
</body>
</html>
<script>
function reset(){
	$("#form")[0].reset();
}
function selectAll(_this) {
	$('#dataTable input[type=checkbox]').each(function(){
		this.checked=_this.checked;
	});
}
function doUpload() {
	$('#frmUpload').submit();
}
var seq = 0;
$(document).ready(function(){	 
	$("#btImport").click(function(){
		var dataString = '';
		$('#dataTable input[type=checkbox]').each(function(){
			if(this.checked==true) {
				if(this.value!='on')
					dataString+='&ids='+this.value;
			}
		});
		if(dataString=='') {
			alert('Bạn chưa chọn dòng để import!');
			return;
		}
		if(!confirm("Bạn muốn import những dòng đã chọn?")) return;
		var button = this;
		button.disabled = true;
		$.ajax({
			type: "POST",
			cache: false,
			url : "${doImportTuyenkenhURL}",
			data: dataString,
			success: function(response){
				button.disabled = false;
				if(response.result == "ERROR") {
					if(response.data == "ERROR") {
						alert(ERROR_MESSAGE);
						return;
					}
					alert(response.data);
				} else {
					alert("Import thành công!");
					oTable.fnDraw(false);
				}
			},
			error: function(data){ alert (data);button.disabled = false;}	
		});	
	});
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
		if(!confirm("Bạn muốn xóa những dòng đã chọn?")) return;
		var button = this;
		button.disabled = true;
		$.ajax({
			type: "POST",
			cache: false,
			url : "${doDeleteTuyenkenhURL}",
			data: dataString,
			success: function(response){
				button.disabled = false;
				if(response.result == "ERROR") {
					if(response.data == "ERROR") {
						alert(ERROR_MESSAGE);
						return;
					}
					alert(response.data);
				} else {
					oTable.fnDraw(false);
				}
			},
			error: function(data){ alert (data);button.disabled = false;}	
		});	
	});
	$('ul.sf-menu').superfish();
	$('#frmUpload').ajaxForm({ 
		url:  "${doUploadTuyenkenhURL}",
		type: "post",
		dataType : "json",
		success:    function(response) { 
			if(response.result == "ERROR") {
				alert(response.data);
				return;
			}
			if(response.result == "OK") {
				//upload_utils.createFileLabel(response.data);
				alert("Upload thành công!");
				oTable.fnFilter();
				return;
			}
			alert("Kết nối bị lỗi, vui lòng thử lại!");
		},
		error : function(data) {
			alert("Kết nối bị lỗi, vui lòng thử lại!");
		}
	});
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${loadTuyenkenhImportURL}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ "mDataProp": "madiemdau","bSortable": false,"bSearchable": false },
					{ "mDataProp": "madiemcuoi","bSortable": false,"bSearchable": false },
					//{ "mDataProp": "loaigiaotiep","bSortable": false,"bSearchable": false },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function(response) {
							if(response.aData.loaigiaotiep != '')
								return response.aData.loaigiaotiep;
							else
								return '<span title="Chưa có danh mục" class="warning">'+response.aData.giaotiep_ma+'</span>';
						}
					},
					{ "mDataProp": "dungluong","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					{ "mDataProp": "soluong","bSortable": false,"bSearchable": false,"sClass":'td_center' },
					//{ "mDataProp": "tenduan","bSortable": false,"bSearchable": false },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function(response) {
							if(response.aData.tenduan != '')
								return response.aData.tenduan;
							else
								return '<span title="Chưa có danh mục" class="warning">'+response.aData.duan_ma+'</span>';
						}
					},
					//{ "mDataProp": "tenphongban","bSortable": false,"bSearchable": false },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function(response) {
							if(response.aData.tenphongban != '')
								return response.aData.tenphongban;
							else
								return '<span title="Chưa có danh mục" class="warning">'+response.aData.phongban_ma+'</span>';
						}
					},
					//{ "mDataProp": "tenkhuvuc","bSortable": false,"bSearchable": false },
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function(response) {
							if(response.aData.tenkhuvuc != '')
								return response.aData.tenkhuvuc;
							else
								return '<span title="Chưa có danh mục" class="warning">'+response.aData.khuvuc_ma+'</span>';
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function(response) {
							if(response.aData.duplicate != '0')
								return '<a class="warning" target="_blank" title="Xem tuyến kênh trùng" href="${tuyenkenhDetailURL}?id='+response.aData.duplicate+'">'+response.aData.duplicate+'</a>';
							else
								return '';
						}
					},
					{ 	"mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							if(oObj.aData.loaigiaotiep == '') 
								return ''; 
							else 
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
});
</script>