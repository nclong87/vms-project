﻿<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%><%@ taglib prefix="s" uri="/struts-tags"%><s:url action="findByBienbanvanhanh" namespace="/sucokenh" id="findByBienbanvanhanhURL" /><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><%	String contextPath = request.getContextPath();%><html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><meta name="description" content="Reflect Template" /><meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" /><title>Xem chi tiết biên bản vận hành kênh : <s:property value="detail.sobienban"/></title><link rel="stylesheet" href="<%= contextPath %>/css/detailpage.css" type="text/css" media="screen" /><link rel="stylesheet" href="<%= contextPath %>/css/cupertino/jquery-ui.css" type="text/css" media="screen" /><link rel="stylesheet" href="<%= contextPath %>/css/demo_table_jui.css" /><script>var contextPath = '<%= contextPath %>';var baseUrl = contextPath;function byId(id) { //Viet tat cua ham document.getElementById	return document.getElementById(id);}</script><script type='text/javascript' src='<%= contextPath %>/js/jquery.js'></script><script type="text/javascript" src="<%=contextPath%>/js/trangthai_utils.js"></script><script type='text/javascript' src='<%= contextPath %>/js/jquery-ui.js'></script><script type='text/javascript' src='<%= contextPath %>/js/jquery.dataTables.min.js'></script></head><body>	<div id="bg_wrapper">		<h3>THÔNG TIN CHI TIẾT BIÊN BẢN VẬN HÀNH KÊNH</h3>		<dt>Số biên bản :</dt>		<dd><s:property value="detail.sobienban"/></dd>		<dt>Ngày tạo :</dt>		<dd><s:property value="detail.timecreate"/></dd>		<dt>File Scan :</dt>		<dd><a href='/upload/<s:property value="detail.filepath"/>' title="Tải bản cứng biên bản vận hành kênh"><s:property value="detail.filename"/></a></dd>		<dt>Danh sách sự cố thuộc biên bản vận hành kênh:</dt>		<dd>			<table width="100%" id="dataTable" class="display">			<thead>				<tr>					<th width="3px">STT</th>					<th width="30px">Mã tuyến kênh</th>					<th>Mã điểm đầu</th>					<th>Mã điểm cuối</th>					<th>Giao tiếp</th>					<th>Dung lượng</th>					<th width="50px">Thời gian bắt đầu</th>					<th width="50px">Thời gian kết thúc</th>					<th width="50px">Thời gian mất liên lạc</th>					<th width="50px">Nguyên nhân</th>					<th width="50px">Phương án xử lý</th>					<th width="50px">Người xác nhận</th>					<th width="50px">Người tạo</th>					<th width="50px">Ngày tạo</th>				</tr>			</thead>			<tbody>			</tbody>			</table>		</dd>		<dt>Thông tin lịch sử :</dt>		<dd>			- TOANNB thêm mới (09/03/2012 9h22)<br/>			- TNHUY chỉnh sửa (09/03/2012 13h45)<br/>			- ...<br/>		</dd>	</div></body></html><script>var bienbanvanhanh_id = '<s:property value="detail.id"/>';function addRow(stt,data) {	oTable.fnAddData([		stt,data.tuyenkenh_id,data.madiemdau,data.madiemcuoi,data.loaigiaotiep,data.dungluong,data.thoidiembatdau,data.thoidiemketthuc,data.thoigianmll,data.nguyennhan,data.phuonganxuly,data.nguoixacnhan,data.usercreate,data.timecreate	]);}$(document).ready(function() {	if(bienbanvanhanh_id!='') {		oTable = $('#dataTable').dataTable({			"bJQueryUI": true,			"bProcessing": false,			"bScrollCollapse": true,			"bAutoWidth": true,			"bSort":false,			"bFilter": false,"bInfo": false,			"bPaginate" : false,			"sAjaxSource": "${findByBienbanvanhanhURL}?id="+bienbanvanhanh_id,			"aoColumns": null,			"fnServerData": function ( sSource, aoData, fnCallback ) {				$.ajax( {					"dataType": 'json', 					"type": "POST", 					"url": sSource, 					"data": aoData, 					"success": function(response){						if(response.result == "ERROR") {							alert("Lỗi kết nối server, vui lòng thử lại.");						} else {							if(response.aaData.length != 0) {								var i = 0;								$.each(response.aaData,function(){									addRow(i+1,this);									i++;								});							} else {								oTable.fnAddData([0,'','','','','','','','','','','','','']);								oTable.fnDeleteRow(0);							}						}					}				} );			},		});	}});</script>