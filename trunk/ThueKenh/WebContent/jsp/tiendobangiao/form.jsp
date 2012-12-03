<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="index" namespace="/login" var="loginURL" />
<s:url action="doSave" namespace="/tiendobangiao" id="doSaveURL" />

<s:set value="opEdit.ma" var="ma" />
<s:set value="opEdit.stt" var="stt" />
<s:set value="opEdit.tenphongban" var="tenphongban" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%
	String contextPath = request.getContextPath();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%=contextPath%>/css/addedit.css"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="<%=contextPath%>/css/cupertino/jquery-ui.css" type="text/css"
	media="screen" />
<script type='text/javascript' src='<%=contextPath%>/js/jquery.js'></script>
<script type='text/javascript' src='<%=contextPath%>/js/jquery-ui.js'></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery.validate.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
<script>
var contextPath = '<%=contextPath%>';
	var baseUrl = contextPath;
	function byId(id) { //Viet tat cua ham document.getElementById
		return document.getElementById(id);
	}
</script>
<style>
</style>
</head>
<body>
	<form id="form" onsubmit="return false;">
		<input type="text" style="display: none" name="id" id="id"
			value="<s:property value="id" />" />
			<input name="inew" value="1" type="hidden"/>
		<div style="background: none repeat scroll 0pt 0pt rgb(242, 242, 242); padding: 5px; width: 99%;">
			<table width="100%" class="listTieuChuan">
				<tr>
					<td colspan='4' align="left" id="msg">
					</td>
				</tr>
				<s:iterator value="listTieuChuan">
    				<tr height="30px">
						<td align="left">
						<input type="checkbox" value="<s:property value='id' />"/>
						<label for="tc1" class="tieuchuan"><s:property value="tentieuchuan" />
						<input type="hidden" class="loaitieuchuan" value="<s:property value="loaitieuchuan" />"/>
						</label>
						</td>
					</tr>
    				
				</s:iterator>
				

					<tr height="30px">
						<td align="center"><input id="btnSubmit" type="button"
							class="button" value="Lưu"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	<s:iterator value="listTieuChuanDatDuoc">
    				
					<input type="hidden" class="tieuchuandatduoc" value="<s:property value="id" />"/>
    				<input type="hidden" class="trangthai" value="<s:property value="tuyenKenhDeXuatDTO.Trangthai"/>"/>
	</s:iterator>
	<script>
	//alert($(".trangthai").val());
		function fillOption(){
			//them text loai tieu chuan
			var tieuchuan=$(".listTieuChuan .tieuchuan");
			for(i=0;i<tieuchuan.length;i++){
				if($(tieuchuan[i]).find(".loaitieuchuan").val()==1)
					$("<label>").html("<span style='color:red' title='Bắt buộc'>(*)</span>").appendTo($(tieuchuan[i]));
			}
			//check vao nhung tieu chuan da dat dc
			var tieuchuandatduoc=$(".tieuchuandatduoc");
			for(i=0;i<tieuchuandatduoc.length;i++){
				var id=$(tieuchuandatduoc[i]).val();
				$(".listTieuChuan input[type=checkbox][value="+id+"]").attr("checked",true);
			}
		}
		fillOption();
		var trangthai=$(".trangthai").val();
		if(trangthai==2){
			//trang thai da ban giao
			//disable check box
			$(".listTieuChuan input[type=checkbox][checked]").attr("disabled","disabled");
			$("#btnSubmit").attr("disabled","disabled");
		}
		
		function checkFill(){
			var tieuchuan=$(".listTieuChuan .tieuchuan");
			var iFlag=0;
			for(i=0;i<tieuchuan.length;i++){
				if($(tieuchuan[i]).find(".loaitieuchuan").val()==1){
					var strChecked=$(tieuchuan[i]).parent().find("input[type=checkbox]").is(':checked');
					//alert(strChecked);
					if(iFlag==1 && strChecked==true){
						alert("Thứ tự chọn tiêu chuẩn không đúng");
						return false;
					}
					if(iFlag==0 && strChecked!=true){
						//alert("Khong check");
						iFlag=1;
					}
				}
					
			}
			return true;
		}
		
	</script>
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
function loadContent(url) {
	location.href = contextPath + url;
}
$(document).ready(function() {
	$(document).delegate("#btnSubmit","click",function() {
		
		if(checkFill()==false)
			return;
		
		var button = this;
		button.disabled = true;
		if (!$("#form").valid()) {
			alert("Dữ liệu nhập chưa hợp lệ, vui lòng kiểm tra lại!");
			button.disabled = false;
		} else {
			var dataString = $("#form").serialize();
			$('#form input[type=checkbox]').each(function(){
				if(this.checked==true) {
					if(this.value!='on')
						dataString+='&ids='+this.value;
				}
			});
			$.ajax({
						url : "${doSaveURL}",
						type : 'GET',
						data : dataString,
						success : function(
								response) {
							button.disabled = false;
							if (response == "EXIST") {
								message(
										"Đã tồn tại tuyến kênh này trong hệ thống!",
										0);
								return false;
							}
							if (response == "OK") {
								message(
										"Lưu thành công!",
										1);
								parent.reload = true;
								return;
							}
							message(
									"Lưu không thành công, vui lòng thử lại.",
									0);
						},
						error : function(
								response) {
							button.disabled = false;
							alert("Server is too busy, please try again!");
						}
					});
		}
		return false;
	});
});

	
</script>