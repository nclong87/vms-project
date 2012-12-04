<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="findKhuVucByAccount" namespace="/ajax" var="findKhuVucByAccountURL"/>
<s:url action="saveAccountKhuvuc" namespace="/permission" var="saveAccountKhuvucURL"/>
<style>
tr {
height:30px;
}
select.multiple {
float: left;
height: 300px;
width: 265px;
}
#buttons button {
display: block;
margin: 5px;
}
</style>
<table width="99%" id="khuvucphutrach_popup">
	<tr>
		<td></td>
		<td></td>
		<td>Khu vực phụ trách :</td>
	</tr>
	<tr>
		<td align="center" >
			<select class="multiple" multiple id="select1">  
			<s:iterator value="khuvucs">
				<option value='<s:property value="id" />'><s:property value="tenkhuvuc" /></option>
			</s:iterator>
			</select>
		</td>
		<td align="center" >
			<div id="buttons" style="display: block; float: left; text-align: center; width: 40px;">
				<button id="btadd">Select</button>
				<button id="btremove">Un Select</button>
				<button id="btaddall">Select All</button>
				<button id="btremoveall">Un Select All</button>
			</div>
		</td>
		<td align="center" >
			<select class="multiple" multiple id="select2">  
			</select>
		</td>
	</tr>
	<tr>
		<td style="text-align:right" colspan="3">
			<input type="button" class="button" id="btChon" value="Lưu"/>
		</td>
	</tr>
</table>
<script>
var khuvucphutrach_popup = {
	dialog : null,
	init : function(params) {
		block("#khuvucphutrach_popup");
		$.ajax({
			type: "GET",
			cache: false,
			url : "${findKhuVucByAccountURL}?id="+account_id,
			success: function(response){
				if(response.status == 0) {
					alert("Có lỗi xảy ra, vui lòng thử lại!");
				} else {
					var select1 = $("#select1");
					var select2 = $("#select2");
					$.each(response.data,function(){
						$("option[value="+this.id+"]",select1).remove();
						select2.append('<option value="'+this.id+'">'+this.tenkhuvuc+'</option>');
					});
					unblock("#khuvucphutrach_popup");
				}
			},
			error: function(data){alert("Có lỗi xảy ra, vui lòng thử lại!")}	
		});	
		khuvucphutrach_popup.dialog = $("#khuvucphutrach_popup").parents(".ui-dialog-content");
		khuvucphutrach_popup.dialog.dialog("option", "position", "center");
		MultiSelect("btadd","btremove","btaddall","btremoveall","select1","select2");
		$( "#buttons button:first",khuvucphutrach_popup.dialog).button({
			icons: {
				primary: "ui-icon-seek-end"
			},
			text: false
		}).next().button({
			icons: {
				primary: "ui-icon-seek-first"
			},
			text: false
		}).next().button({
			icons: {
				primary: "ui-icon-seek-next"
			},
			text: false
		}).next().button({
			icons: {
				primary: "ui-icon-seek-prev"
			},
			text: false
		});
		$("#btChon",khuvucphutrach_popup.dialog).click(function(){
			var dataString = '&id='+account_id;
			$("#select2 option").each(function() {
				dataString+= "&khuvucs="+$(this).val();
			});
			this.disabled = true;
			$.ajax({
				type: "POST",
				cache: false,
				url : "${saveAccountKhuvucURL}",
				data: dataString,
				success: function(data){
					this.disabled = false;
					if(data.status == 0) {
						processErrorMessage(data.data);
						return;
					} 
					if(data.status == 1) {
						alert("Cập nhật khu vực phụ trách thành công!");
						khuvucphutrach_popup.dialog.dialog("close");
						return;
					}
				},
				error: function(data){  this.disabled = false; alert("Có lỗi xảy ra, vui lòng thử lại!")}	
			});	
		});
	}
}
$(document).ready(function(){	
	khuvucphutrach_popup.init();
});
</script>