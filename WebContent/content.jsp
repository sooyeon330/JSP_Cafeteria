<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection conn =null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try{
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "cafeteria";
	String pass = "3616";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	pstmt = conn.prepareStatement("select * from cafeteria");
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		String id = rs.getString("EATDATE");
		String passwd = rs.getString("EATDAY");
		String name = rs.getString("");
		Timestamp register = rs.getTimestamp("reg");
		%>
		
		<tr>
		<td><%= id %></td>
		<td><%= passwd %></td>
		<td><%= name %></td>
		<td><%= register %></td>
		</tr>
		
	<%}//while
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(rs!=null){
		try{
			rs.close();
		}catch(Exception e){
		}
	}//if
	if(pstmt!=null){
		try{
			pstmt.close();
		}catch(Exception e){
		}
	}//if
	if(conn!=null){
		try{
			conn.close();
		}catch(Exception e){
		}
	}//if
}
%>
 
</body>
</html>