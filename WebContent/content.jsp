<%@page import="test.Cafeteria"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  
    <style>
    
    .MenuDiv{
    }
    aside,section{
    	float:left;
    	margin:15px;
    }
    nav{
    	padding:10px;
    }
    .card{
    	width:188px;
    	margin-bottom: 5px;
    }
    .btn{
    	margin:5px;
    }
    </style>
    <script>
    $(function(){  
    	var m = <%=request.getParameter("m")%>

    	if(m==1) {
    		$(".lun").css("display","none");
    		$(".din").css("display","none");
    	}else if(m==2) {
    		$(".brf").css("display","none");
    		$(".din").css("display","none");
    	}else if(m==3) {
    		$(".brf").css("display","none");
    		$(".lun").css("display","none");
    	}
    	 
    	
        $('#datepicker').datepicker({  
            
        	dateFormat: 'yy-mm-dd',
            inline: true,  
            showOtherMonths: true,
            dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
            altField: "#date",
            
        });  
        $("#datepicker").datepicker("show");
	});
	
	

    </script>
</head>
<body>


<aside>
<div class="topnav">
  <div class="search-container">
    <form action="main.jsp">
      <input type="text" placeholder="Search.." name="search">
      <button type="submit"><i class="fa fa-search"></i></button>
    </form>
  </div>
</div>
<div id="calendar">
  <div class="date-block ui-datepicker-trigger">
          <div class="date-day">Monday</div>
          <div class="date-date">9</div>
          <span class="date-month">September</span>
          <span class="date-year">2019</span>
  </div>
  <div id="datepicker"></div>
  <form id="form" action="main.jsp" method="post">
 	 <input name="picdate" id="date" type="text"><br>
	 <input type="radio" name="m" value="1">조식
	 <input type="radio" name="m" value="2">중식
	 <input type="radio" name="m" value="3">석식
 	 <input type="submit" value="찾기">
  </form>
 
</div>
<nav>
	<button type="button" class="btn btn-success" onclick="location.href='main.jsp?m=1'">조식</button> 
	<button type="button" class="btn btn-success" onclick="location.href='main.jsp?m=2'">중식</button>
	<button type="button" class="btn btn-success" onclick="location.href='main.jsp?m=3'">석식</button>
	<button type="button" class="btn btn-success" onclick="location.href='main.jsp'">전체보기</button>
	<button type="button" class="btn btn-success" onclick="location.href='main.jsp?to=t'">오늘보기</button>
</nav>
</aside>
<section>
<%! SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd"); %>
<%

	request.setCharacterEncoding("utf-8");

	String date = request.getParameter("picdate"); //검색날짜
	String select = request.getParameter("select"); //검색 조중석
	
	String search  = request.getParameter("search"); //검색어
	String today  = request.getParameter("to"); //오늘날짜

Connection conn =null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try{
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "cafeteria";
	String pass = "3616";
	String sql="select id,to_char(eatdate,'MM/DD') eatdate,eatday,breakfast,lunch,dinner from cafeteria";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	if(today !=null) date = format1.format(new Date());
	
	if(date!= null){
		sql ="select id,to_char(eatdate,'MM/DD') eatdate,eatday,breakfast,lunch,dinner from cafeteria"
				+ " where eatdate = '" +date+ "'";
	}
	
	if(search!= null){
		sql ="select id,to_char(eatdate,'MM/DD') eatdate,eatday,breakfast,lunch,dinner from cafeteria"
				+ " where dinner like '%"+search+"%' or  lunch like '%"+search+"%' or breakfast like '%"+search+"%' ";
	}
	
	pstmt = conn.prepareStatement(sql);
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
	        <div class="col">
	          <div class="card">
	            <div class="card-header">
	             <input type="hidden" class="eatdate" value="<%= menuall.get(i).getEatdate()%>">
	             <%= menuall.get(i).getEatdate()+" ("+menuall.get(i).getEatday()+")"%>
	            </div>
	            <div class="card-body">
	            <p class="brf" class='card-text'>
<%
				for(String menulist:menuall.get(i).getBreakfast()){ //정확한 값만 추출하기위함
					out.println(menulist);
				}
%>
				</p>
				<p class='lun' class='card-text'>
<%				
				for(String menulist:menuall.get(i).getLunch()){ //정확한 값만 추출하기위함
					out.println(menulist);
				}
%>				</p>
				<p class='din' class='card-text'>
				
<%				for(String menulist:menuall.get(i).getDinner()){ //정확한 값만 추출하기위함
					out.println(menulist);
				} 
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
</section>


</body>
</html>
 	
 <%!
 
 public ArrayList<String> addlist(String[] menuarray ){
		ArrayList<String> menulist = new ArrayList<>();
		for(int i=0; i<menuarray.length; i++){ //가져온 길이만큼 반복해 
			menulist.add(menuarray[i]+"<br>");//그냥 임시리스트에 추가
		}
		
		return menulist;
 }
 
 %>
 
 
 
 
 
 
 