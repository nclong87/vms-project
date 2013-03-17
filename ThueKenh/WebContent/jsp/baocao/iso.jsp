<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="rpISO" namespace="/baocao" var="rpISOURL"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script>
	var LOGIN_PATH = "${loginURL}";
	</script>
	<%@include file="/include/header.jsp"%>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/mylibs/my.validate.js"></script>
	<style>
		.reporttb{border-collapse: collapse}
		.reporttb tr td.parent {border:1px solid #DDD;padding:15px;width:50%;vertical-align: top}
		span.required {
		color:red;
		}
		label.error {
		color: red;
		display: block;
		}
		input.error, select.error {
			border:1px solid red
		}
		p {
		margin:0;
		}
		.ui-datepicker select
		{
			width: 50px !important;
		}
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
								<td colspan="4"><b>Báo cáo truyền dẫn kênh thuê</b> <br /> <br /></td>
							</tr>
							<tr>
									<td align="right"><label for="xxxx">Tháng:</label></td>
									<td align="left">
										<select name="thang" id="thang" style="width:96px">
											<option value="">Tháng</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
										<font title="Bắt buộc nhập" color="red">*</font>
									</td>	
									<td align="right"><label for="xxxx">Năm:</label></td>
									<td>
										<select name="nam" id="nam" style="width:95px">
											<option value="">Năm</option>
										</select>
										<font title="Bắt buộc nhập" color="red">*</font>
									</td>
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

$(document).ready(function(){	
	// combobox nam
	var currentTime = new Date();
	var year = currentTime.getFullYear();
	for(var i=year-10;i<year+10;i++)
	{
		$("#nam").append("<option value='"+i+"'>"+i+"</option>");
	}
	$("#thang").val(currentTime.getMonth());
	$("#nam").val(year);
	// bao cao truyen dan kenh thue
	$("#btSubmit1").click(function() {
		this.disabled=true;
		location.href="${rpISOURL}?thang="+$("#thang").val()+"&nam="+$("#nam").val();
		this.disabled=false;
	});
});
</script>