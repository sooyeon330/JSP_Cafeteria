<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mirim Cafeteria</title>
<link rel="stylesheet" href="css/main.css">

</head>

<body>
	<%
		request.setCharacterEncoding("utf-8");
		String contentPage = request.getParameter("CONTENTPAGE");
	%>
	

	<table class="template" cellpadding="2" cellspacing="0">

		<tr>
			<td class="top" colspan="3"><jsp:include page="top.jsp"
					flush="false" /></td>
		</tr>
		
		<tr>
			<td class="content" valign="top">
			<jsp:include  page="<%=contentPage%>" flush="false" /></td>
		</tr>
		<tr>
			<td class="bottom" colspan="3"><jsp:include page="bottom.jsp"
					flush="false" /></td>
		</tr>
	</table>

</body>
</html>