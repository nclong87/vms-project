<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String contextPath = request.getContextPath();
%>
<link rel="stylesheet" href="<%=contextPath%>/content/css/style_all.css"
	type="text/css" media="screen" />
<form method="post">
	<input type="hidden" name="opEdit.id"
		value="<s:property value="opEdit.id" />">
	<table>
		<tbody>
			<tr>
				<td align="right">Tên phòng ban :</td>
				<td align="left"><input type="text" name="opEdit.name"
					value="<s:property value="opEdit.name" />" id="name"></td>

			</tr>
			<tr>
				<td></td>
				<td><input type="submit" class="button" value="Hoàn tất">
				</td>
			</tr>

		</tbody>
	</table>
</form>

