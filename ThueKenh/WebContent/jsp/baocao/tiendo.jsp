<%@ taglib prefix="s" uri="/struts-tags"%>
<s:url action="doLogout" namespace="/login" var="doLogoutURL"/>
<s:url action="index" namespace="/login" var="loginURL"/>
<s:url action="rpTuyenKenhChuaBanGiao" namespace="/baocao" var="rpTuyenKenhChuaBanGiaoURL"/>
<s:url action="rpHopDongChuaThanhToan" namespace="/baocao" var="rpHopDongChuaThanhToanURL"/>
<s:url action="rpKenhDaBanGiaoNhungChuaCoHopDong" namespace="/baocao" var="rpKenhDaBanGiaoNhungChuaCoHopDongURL"/>
<s:url action="rpTienThueKenhPhatSinh" namespace="/baocao" var="rpTienThueKenhPhatSinhURL"/>
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
								<td colspan="4"><b>Các kênh chưa bàn giao</b> <br /> <br /></td>
							</tr>
							<tr>
								<td>Đối tác :</td>
								<td>
									<select style="width: 210px" name="doitac_id1" id="doitac_id1">
										<option value="">---Tất cả---</option>
										<s:iterator value="doiTacs">
											<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
										</s:iterator>
									</select>
								</td>
							</tr>
							<tr>
								<td></td>
								<td><input type="button" class="button" value="Xuất Excel" id="btSubmit1"></input></td>
							</tr>
						</table>
					</td>
					<td align="center" class="parent">
						<table>
							<tr>
								<td colspan="4"><b>Các kênh đã bàn giao nhưng chưa có
										hợp đồng </b> <br /> <br /></td>
							</tr>
							<tr>
								<td>Đối tác :</td>
								<td>
									<select style="width: 210px" name="doitac_id2" id="doitac_id2">
										<option value="">---Tất cả---</option>
										<s:iterator value="doiTacs">
											<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
										</s:iterator>
									</select>
								</td>
							</tr>
							<tr>
								<td></td>
								<td><input type="button" class="button" value="Xuất Excel" id="btSubmit2"></input></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center"  class="parent">
						<table>
							<tr>
								<td colspan="4"><b>Các hợp đồng chưa thanh toán</b> <br />
									<br /></td>
							</tr>
							<tr>
								<td>Đối tác :</td>
								<td>
									<select style="width: 210px" name="doitac_id3" id="doitac_id3">
										<option value="">---Tất cả---</option>
										<s:iterator value="doiTacs">
											<option value='<s:property value="id" />'><s:property value="tendoitac" /></option>									
										</s:iterator>
									</select>
								</td>
							</tr>
							<tr>
								<td></td>
								<td><input type="button" class="button" value="Xuất Excel" id="btSubmit3"></input></td>
							</tr>
						</table>
					</td>
					<td align="left" class="parent">
						<form id="form" onsubmit="return false;">
							<table>
								<tr>
									<td colspan="4"><b>Tiền thuê kênh phát sinh - Tiền
											thuê kênh đã thanh toán</b> <br /> <br /></td>
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
									<td><input type="button" class="button" value="Xuất Excel" id="btSubmit4"></input></td>
								</tr>
							</table>
						</form>
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
	
	// bao cao 1: Các kênh chưa bàn giao
	$("#btSubmit1").click(function() {
		this.disabled=true;
		location.href="${rpTuyenKenhChuaBanGiaoURL}?doitac_id="+$("#doitac_id1").val();
		this.disabled=false;
	});
	
	// bao cao 2 : Các hợp đồng chưa thanh toán
	$("#btSubmit2").click(function() {
		this.disabled=true;
		location.href="${rpKenhDaBanGiaoNhungChuaCoHopDongURL}?doitac_id="+$("#doitac_id2").val();
		this.disabled=false;
	});
	
	// bao cao 3 : Các kênh đã bàn giao nhưng chưa có hợp đồng
	$("#btSubmit3").click(function() {
		this.disabled=true;
		location.href="${rpHopDongChuaThanhToanURL}?doitac_id="+$("#doitac_id3").val();
		this.disabled=false;
	});
	//validation form
	$("#form").validate({
		rules : {
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
	$("#btSubmit4").click(function() {
		this.disabled = true;
		if (!$("#form").valid()) {
			alert("Dữ liệu chưa hợp lệ. Vui lòng chọn lại",0);
			this.disabled = false;
		} else {
			location.href="${rpTienThueKenhPhatSinhURL}?thang="+$("#thang").val()+"&nam="+$("#nam").val();
			this.disabled = false;
		}
	});
});
</script>