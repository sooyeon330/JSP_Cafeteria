<%@page import="test.Cafeteria"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <style>
     
    </style>
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
			if((i+1)== 1 || i%5==0	) { out.print("<div class='row'>");}
%>
	        <div class="col-2">
	          <div class="card">
	            <div class="card-header">
	             <%= menuall.get(i).getEatdate()+"  , " +(i+1) %>
	            </div>
	            <div class="card-body">
	            <p class='card-text'>
<%
				for(String menulist:menuall.get(i).getBreakfast()){ //정확한 값만 추출하기위함
					out.println(menulist);
				}
			/* 	out.println("<hr>");
				for(String menulist:menuall.get(i).getLunch()){ //정확한 값만 추출하기위함
					out.println(menulist);
				}
				out.println("<hr>");
				for(String menulist:menuall.get(i).getDinner()){ //정확한 값만 추출하기위함
					out.println(menulist);
				}  */
%>
				</p>
	            </div>
	          </div>
	        </div>
	        
<%
		if(i!=5 && (i+1)%5==0) { out.print("</div>");}
	
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
 
<!--   <div class="row">
        <div class="col-4">
          <p>Card</p>
          <div class="card">
            <div class="card-header">
              My Card
            </div>
            <div class="card-body">
              <h5 class="card-title">Lorem</h5>
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam egestas sed sem ut malesuada.</p>
              <a href="#" class="btn btn-primary">More</a>
            </div>
          </div>
        </div>
  </div> -->
</body>
</html>