<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String contextPath = request.getContextPath();
%>
<link rel="stylesheet" href="<%=contextPath%>/content/css/style_all.css"
	type="text/css" media="screen" />
<form method="post">
	<input type="hidden" name="opEdit.Id"
		value="<s:property value="opEdit.Id" />">
	<table>
		<tbody>
			<tr>
				<td align="right">Tên dự án :</td>
				<td align="left"><input type="text" name="opEdit.Name"
					value="<s:property value="opEdit.Name" />" id="Name"></td>

			</tr>
			<tr>
				<td align="right">STT</td>
				<td align="left"><input type="text" name="opEdit.STT"
					value="<s:property value="opEdit.STT" />" id="STT"></td>

			</tr>
			<tr>
				<td></td>
				<td><input type="submit" class="button" value="Hoàn tất">
				</td>
			</tr>

		</tbody>
	</table>
</form>

