<%@page import="test.Cafeteria"%>
<%@page import="java.util.ArrayList"%>
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
<table>
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
	pstmt = conn.prepareStatement("select id,to_char(eatdate,'YYYY-MM-DD') eatdate,eatday,breakfast,lunch,dinner from cafeteria");
	rs = pstmt.executeQuery();
	
	ArrayList<Cafeteria> menuall = new ArrayList<>();
	Cafeteria menu=null;	
	
	String id="";
	String eatdate="";
	String eatday="";
	String[] breaklist,lunchlist,dinnerlist;
	ArrayList<String> breakfast = new ArrayList<>();
	ArrayList<String> lunch = new ArrayList<>();
	ArrayList<String> dinner = new ArrayList<>();
	
	while(rs.next()){
	//	out.print("dd");

		id = rs.getString("id");
		eatdate = rs.getString("eatdate");
		eatday = rs.getString("eatday");
		
		breaklist = rs.getString("breakfast").split(",");
		lunchlist = rs.getString("lunch").split(",");
		dinnerlist = rs.getString("dinner").split(",");
		
		breakfast = addlist(breaklist);
		lunch = addlist(lunchlist);
		dinner = addlist(dinnerlist);

		menuall.add(new Cafeteria(id,eatdate,eatday,breakfast,lunch,dinner));
		
		
	}//while



		for(int i=0; i<menuall.size(); i++){
%>
		<tr>
			<td><%= menuall.get(i).getEatdate() %></td>
			<td><%= menuall.get(i).getEatday() %></td>
			<td><%= menuall.get(i).getBreakfast() %></td>
			<td><%= menuall.get(i).getLunch() %></td>
			<td><%= menuall.get(i).getDinner() %></td>
		</tr>

<%	
		}//for

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
 	
 	
 <%!
 
 public ArrayList<String> addlist(String[] menuarray ){
		ArrayList<String> menulist = new ArrayList<>();
		for(int i=0; i<menuarray.length; i++){ //가져온 길이만큼 반복해 
			menulist.add(menuarray[i]+"<br>");//그냥 임시리스트에 추가
		}
		
		return menulist;
 }
 
 %>
 </table>
</body>
</html>