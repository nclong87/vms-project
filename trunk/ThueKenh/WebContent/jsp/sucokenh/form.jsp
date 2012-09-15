<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="description" content="Reflect Template" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link rel="stylesheet" href="../../css/addedit.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="../../css/jquery-ui.css" type="text/css"
	media="screen" />
<link rel="stylesheet" type="text/css"
	href="../../css/demo_table_jui.css" />
<link rel="stylesheet" href="../../css/search_box.css" type="text/css"
	media="screen" />
<!--Internet Explorer Trancparency fix-->
<!--[if IE 6]>
        <script src="/js/ie6pngfix.js"></script>
        <script>
          DD_belatedPNG.fix('#head, a, a span, img, .message p, .click_to_close, .ie6fix');
        </script>
        <![endif]-->

<script type='text/javascript' src='../../js/jquery.js'></script>
<script type='text/javascript' src='../../js/jquery-ui.js'></script>

<script type="text/javascript" src="../../js/jquery.dataTables.min.js"></script>

<!--Internet Explorer Trancparency fix-->
<!--[if IE 6]>
      	<script src="/js/ie6pngfix.js"></script>
      	<script>
        DD_belatedPNG.fix('#head, a, a span, img, .message p, .click_to_close, .ie6fix');
      	</script>
      	<![endif]-->
</head>

<body>
	<div style="clear: both; margin: 5px 0">
		<table class="input" style="width: 100%">
			<tr>
				<td align="right">Tuyến kênh :</td>
				<td><input type="text" style="width:214px"></input><input type="button" value="..." onclick="openPopupChooseTuyenkenh();"></input></td>
				<td align="right">Loại sự cố :</td>
				<td><select style="width: 220px">
						<option>---SELECT---</option>
						<option>Loại 1</option>
						<option>Loại 2</option>
				</select><font title="Bắt buộc nhập" color="red">*</font></td>
			</tr>
			<tr>
				<td align="right">Thời điểm bắt đầu :</td>
				<td align="left"><input type="text" name="account.username"
					id="username" style="width: 214px" /><font title="Bắt buộc nhập"
					color="red">*</font></td>
				<td align="right">Thời điểm kết thúc :</td>
				<td align="left"><input type="text" name="account.username"
					id="username" style="width: 214px" /><font title="Bắt buộc nhập"
					color="red">*</font></td>

			</tr>
			<tr>
				<td align="right">Nguyên nhân sự cố :</td>
				<td><input type="text" style="width: 214px" /><font
					title="Bắt buộc nhập" color="red">*</font></td>
				<td align="right">Phương án xử lý :</td>
				<td><input type="text" style="width: 214px" /><font
					title="Bắt buộc nhập" color="red">*</font></td>
			</tr>
			<tr>
				<td align="right">Người xác nhận :</td>
				<td><input type="text" style="width: 214px" /><font
					title="Bắt buộc nhập" color="red">*</font></td>
				<td align="right">File scan :</td>
				<td><input type="file" style="width: 214px" /></td>
			</tr>

			<tr height="30px">
				<td></td>
				<td colspan="3">
					<input type="button" class="button" value="Lưu"></input>
					<input type="button" class="button" value="Làm lại"></input>
					<input type="button" class="button" value="Thoát" onclick="window.parent.CloseWindow();"></input>
				</td>
			</tr>
		</table>
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
function openPopupChooseTuyenkenh() {
	window.open('../Tim kiem tuyen kenh.html','STK','resizable=yes,scrollbars=yes,menubar=no,toolbar=no,status=no,width=900,height=500,screenX=100,screenY=100,top=100,left=100');
}
$(document).ready(function(){	 
	//$('ul.sf-menu').load("menu.html");
	//$('ul.sf-menu').superfish();
	oTable = $('#dataTable').dataTable({
		"bJQueryUI": true,
		"bProcessing": true,
		"bAutoWidth": false,
		"bSort":false,
		"sPaginationType": "two_button"
	});
	$('#divSearch input[title!=""]').hint();
});
</script>