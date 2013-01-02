﻿<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="index" namespace="/chitietphuluc" id="formURL"/>
<s:url action="edit" namespace="/chitietphuluc" id="editURL"/>
<s:url action="load" namespace="/chitietphuluc" id="loadURL"/>
<s:url action="delete" namespace="/chitietphuluc" id="deleteURL"/>
<s:url action="detail" namespace="/chitietphuluc" id="detailURL"/>
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
							<div class="p3t">Tìm kiếm giá trị phụ lục</div>
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
											<td width="120px" align="right">
												Tên giá trị phụ lục :
											</td>
											<td align="left">
												<input type="text" name="tenchitietphuluc"/>
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
				<input type="button" class="button" value="Thêm giá trị phụ lục" onclick="ShowWindow('Tính giá trị phụ lục',750,500,'${formURL}',true);MaxWindow();"></input>
				<input class="button" type="button" id="btXoa" value="Xóa" style="float: right; margin-right: 10px;"/>
			</div>
			<table width="100%" id="dataTable" class="display">
				<thead>
					<tr>
						<th width="5%">#</th>
						<th></th>
						<th>Tên giá trị PL</th>
						<th>Số lượng kênh</th>
						<th>Giá trị trước thuế</th>
						<th>Giá trị sau thuế</th>
						<th>Cước đấu nối</th>
						<th>Sửa</th>
						<th width="5px" align="center"><input type="checkbox" onclick="selectAll(this)"/></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="15" class="dataTables_empty">Đang tải dữ liệu...</td>
					</tr>
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
function reset(){
	$("#form")[0].reset();
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
$(document).ready(function(){	 
	/* $('#dataTable input[type=checkbox]').live("click",function(){
		if($('#dataTable input:checked').size()>0) {
			$("#btSelect").show();
		} else {
			$("#btSelect").hide();
		}
	}); */
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bServerSide": true,
		"bAutoWidth": false,
		"sAjaxSource": "${loadURL}",
		"aoColumns": [
					{ "mDataProp": "stt","bSortable": false,"bSearchable": false,"class":"td_center" },
					{ "mDataProp": "id","bSortable": false,"bSearchable": false,"sClass":'td_hidden'},
					{ "mDataProp": "tenchitietphuluc","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "soluongkenh","bSortable": false,"bSearchable": false,"sClass":'td_center'},
					{ "mDataProp": "giatritruocthue","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ "mDataProp": "giatrisauthue","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ "mDataProp": "cuocdaunoi","bSortable": false,"bSearchable": false,"sClass":'td_right number'},
					{ "mDataProp": null,"bSortable": false,"bSearchable": false,"sClass":"td_center",
						"fnRender": function( oObj ) {
							if(oObj.aData.isblock==true)
								return '<center><img src="'+contextPath+'/images/icons/permission.png" title="Giá trị phụ lục này đã được sử dụng nên bạn không được phép sửa"></center>'; 
							else
								return '<center><span class="edit_icon" data-ref-id="'+oObj.aData.id+'" title="Sửa" href="#"></span></center>'; 
						}
					},
					{ "mDataProp": null,"bSortable": false,"bSearchable": false,
						"fnRender": function( oObj ) {
							if(oObj.aData.isblock==true)
								return '<center><img src="'+contextPath+'/images/icons/permission.png" title="Giá trị phụ lục này đã được sử dụng nên bạn không được phép sửa"></center>'; 
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
		"sPaginationType": "two_button",
		"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
			$(".number",nRow).formatCurrency({ 
				region : 'vn',
				roundToDecimalPlace: 0, 
				eventOnDecimalsEntered: true 
			});
        }
	});
	// edit
	$("span.edit_icon").live("click",function(){
		var id = $(this).attr("data-ref-id");
		ShowWindow('Cập nhật thông tin giá trị phụ lục',800,600,"${editURL}?id="+id,false);
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
function doClose(){
	var data = [];
	$('#dataTable tbody input:checked').each(function(){
		data.push(oTable.fnGetData(this.value));
	});
	if(data.length == 0) {
		alert("Vui lòng chọn 1 giá trị phụ lục!");
		return;
	}
	window.opener.searchChiTietPhuLuc.afterSelected(data);
	window.close();
}
</script>