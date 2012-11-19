<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="rpSuCoTheoThoiGian" namespace="/baocao" var="rpSuCoTheoThoiGianURL"/>
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
			<div style="width: 100%; margin-bottom: 10px;" class="ovf">
				<div class="s10">
					<div class="fl">
						<div class="fl tsl" id="t_1">
						</div>
						<div class="fl clg b tsc d" id="t_2">
							<div class="p3t">Báo cáo sự cố theo thời gian</div>
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
								<form id="form" onsubmit="return false;">
									<table>
										<tr>
											<td align="right"><label for="xxxx">Đối tác:</label></td>
											<td align="left" colspan="3">
												<select name="doitac" id="doitac" style="width:216px">
													<option value="">---Chọn đối tác---</option>
													<s:iterator value="doiTacs">
														<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
													</s:iterator>
												</select>
												<font title="Bắt buộc chọn" color="red">*</font>
											</td>	
										</tr>
										<tr>
											<td align="right"><label for="xxxx">Tháng:</label></td>
											<td align="left">
												<select name="thang" id="thang" style="width:96px">
													<option value="">Tháng</option>
													<option value="0">1</option>
													<option value="1">2</option>
													<option value="2">3</option>
													<option value="3">4</option>
													<option value="4">5</option>
													<option value="5">6</option>
													<option value="6">7</option>
													<option value="7">8</option>
													<option value="8">9</option>
													<option value="9">10</option>
													<option value="10">11</option>
													<option value="11">12</option>
												</select>
												<font title="Bắt buộc nhập" color="red">*</font>
											</td>	
											<td>
												<select name="nam" id="nam" style="width:95px">
													<option value="">Năm</option>
												</select>
												<font title="Bắt buộc nhập" color="red">*</font>
											</td>
										</tr>
										<tr>
											<td></td>
											<td colspan="3"><input type="button" class="button" value="Xuất Excel" id="btSubmit"></input></td>
										</tr>
									</table>
								</form>
							</div>
						</div>
						<div class="clearb"></div>
					</div>
				</div>
				<div style="height: 1px;"></div>
			</div>
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
	//validation form
	$("#form").validate({
		rules : {
			"doitac":{
				required : true
			},
			"thang" : {
				required : true,
				number:true
			},
			"nam" : {
				required : true,
				number:true
			}
		}
	});
	// 
	$("#btSubmit").click(function() {
		$(this).disabled = true;
		if (!$("#form").valid()) {
			alert("Dữ liệu chưa hợp lệ. Vui lòng chọn lại",0);
			$(this).disabled = false;
		} else {
			location.href="${rpSuCoTheoThoiGianURL}?doitac="+$("#doitac").val()+"&thang="+$("#thang").val()+"&nam="+$("#nam").val();
			$(this).disabled = false;
		}
	});
});
</script>