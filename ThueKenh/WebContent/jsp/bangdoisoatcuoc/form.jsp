﻿<%@ taglib prefix="s" uri="/struts-tags"%><s:url action="doSavebangdoisoatcuoc" namespace="/bangdoisoatcuoc" var="doSaveBangDoiSoatCuocURL"/><s:url action="rpDoiSoatCuoc" namespace="/baocao" id="rpDoiSoatCuocURL"/><form id="frmLuuBangDoiSoatCuoc" onsubmit="return false"><div id="msg"></div><input type="text" name="thanhtien" id="thanhtien" style="display:none" value="<s:property value='json.thanhtien' />"/><input type="text" name="giamtrumll" id="giamtrumll" style="display:none" value="<s:property value='json.giamtrumll' />"/><input type="text" name="id" id="id" style="display:none" value="<s:property value='json.id' />"/><ul style="list-style: disc inside none;">	<li>Thành tiền : <b><s:property value="json.thanhtien" /></b> VNĐ</li>	<li>Giảm trừ mất liên lạc: <b><s:property value="json.giamtrumll" /></b> VNĐ</li>	<li><a style="color:blue" href="${rpDoiSoatCuocURL}?id=<s:property value='json.id' />" title="">Download bảng đối soát cước</a></li>	<li>Bạn có muốn lưu bảng đối soát cước này không ?  <input type="radio" value="1" name="check" class="check" id="checkyes">Có</input><input type="radio" value="0" name="check" class="check" id="checkno">Không</input></li>	<li id="show" style="display:none">		<div style="display:block">Tên bảng đối soát cước muốn lưu: <input type="text" name="tenbangdoisoatcuoc" id="tenbangdoisoatcuoc" style="width: 200px"></input></div>	</li>	<li style="list-style: none">		<div style="width: 100%; text-align: right;margin-top:5px">			<input class="button" type="button" id="btSubmitForm" value="Lưu" style="display: none"/>			<input class="button" type="button" id="btThoatForm" value="Thoát"/>		</div>	</li></ul></form><script>function message(msg,type) {	if(msg == '') {		$("#frmLuuBangDoiSoatCuoc #msg").html('');		return;	}	if(type == 1) {		$("#frmLuuBangDoiSoatCuoc #msg").html('<div class="ui-state-highlight ui-corner-all" style=" padding: 0pt 0.7em; text-align: left;"><p style="padding: 5px;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span><strong>Success! </strong> '+msg+'</p></div>');	} else {		$("#frmLuuBangDoiSoatCuoc #msg").html('<div style="padding: 0pt 0.7em; text-align: left;" class="ui-state-error ui-corner-all"><p style="padding: 5px;"><span style="float: left; margin-right: .3em;" class="ui-icon ui-icon-alert"></span><strong>Error : </strong> '+msg+'</p></div>');	}}$(document).ready(function(){		$("#btThoatForm").click(function(){		$("#dialog").dialog("close");	});	$("#frmLuuBangDoiSoatCuoc b").formatCurrency({ 		region : 'vn',		roundToDecimalPlace: 0, 		eventOnDecimalsEntered: true 	});	$("#frmLuuBangDoiSoatCuoc input[name=check]").click(function(){		if(this.value == "1") {			$("#frmLuuBangDoiSoatCuoc li#show").show();			$("#frmLuuBangDoiSoatCuoc #tenbangdoisoatcuoc").focus();			$("#btSubmitForm").show();		} else {			$("#frmLuuBangDoiSoatCuoc li#show").hide();			$("#btSubmitForm").hide();		}	});	$("#btSubmitForm").click(function() {		$("#msg").html("");		var button = this;		if ($("#frmLuuBangDoiSoatCuoc #tenbangdoisoatcuoc").val() == "" && $("#checkyes").attr("checked")!=undefined) {			alert("Vui lòng nhập tên bảng đối soát cước cần lưu!");			button.disabled = false;		} else {			button.disabled = true;			var dataString = $("#frmLuuBangDoiSoatCuoc").serialize();				$.ajax({				url: "${doSaveBangDoiSoatCuocURL}",				type:'POST',				data:dataString,				success:function(response){					button.disabled = false;					if(response.status == "ERROR") {						if(response.data == "END_SESSION") {							location.href = LOGIN_PATH;							return;						}						if(response.data == "DUPLICATE") {							message("Tên "+$("#frmLuuBangDoiSoatCuoc #tenbangdoisoatcuoc").val()+ " đã được sử dụng, vui lòng chọn tên khác",0);							$("#frmLuuBangDoiSoatCuoc #tenbangdoisoatcuoc").focus();							return;						}						message("Lưu không thành công, vui lòng thử lại.",0);					} else if(response.status == "OK") {						alert("Lưu thành công!",0);						$("#dialog").dialog("close");					}				},				error:function(response){					button.disabled = false;					message("Lỗi kết nối server, vui lòng thử lại sau!",1);				}			});		}		$("#btSubmit").attr("disabled",false);		return false;	});	$("#btThoatForm").click(function() {		if(!confirm("Bạn thực sự không muốn lưu?")) 			return;		var button = this;		button.disabled = true;		var dataString = $("#frmLuuBangDoiSoatCuoc").serialize();			$.ajax({			url: "${doSaveBangDoiSoatCuocURL}",			type:'POST',			data:dataString,			success:function(response){				button.disabled = false;				$("#dialog").dialog("close");			},			error:function(response){				button.disabled = false;				alert("Lỗi kết nối server, vui lòng thử lại sau!");			}		});		$("#btSubmit").attr("disabled",false);		return false;	});});</script>