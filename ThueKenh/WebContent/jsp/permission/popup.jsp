<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="getMenusByRoot" namespace="/ajax" id="getMenusByRootURL"/>
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
<table width="99%" id="permission_popup">
	<tr>
		<td style="width:150px;font-weight:bold;text-align:right">Chọn menu gốc</td>
		<td>
		<select id="idrootmenu" class="field size1">	
			<option value="" selected=true>--Chọn menu gốc--</option>
			<s:iterator value="rootmenus">
				<option value='<s:property value="id" />'><s:property value="name" /></option>									
			</s:iterator>
		</select>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<select class="multiple" multiple id="select1">  
			
			</select>
			<div id="buttons" style="display: block; float: left; text-align: center; width: 40px;">
				<button id="btadd">Select</button>
				<button id="btremove">Un Select</button>
				<button id="btaddall">Select All</button>
				<button id="btremoveall">Un Select All</button>
			</div>
			<select class="multiple" multiple name="users" id="select2">  
			</select>
		</td>
	</tr>
	<tr>
		<td style="text-align:right" colspan="2">
			<input type="button" class="button" id="btChon" value="Chọn"/>
		</td>
	</tr>
</table>
<script>

$(document).ready(function(){	
	permission_popup.init({
		getMenusByRootURL : "${getMenusByRootURL}",
	});
});
</script>