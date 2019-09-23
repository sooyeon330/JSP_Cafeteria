<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mirim Cafeteria</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/serchbar.css">
<link rel="stylesheet" href="css/datepicker.css">
<head>

 <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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