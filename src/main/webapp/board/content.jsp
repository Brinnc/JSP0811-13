<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="jsp";
	String pass="1234";

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
%>
<%
	con=DriverManager.getConnection(url, user, pass);

	//현재 페이지로 요청이 들어올 때, 클라이언트가 전송한 파라미터를 받음
	//내장객체 중 요청을 처리하기 위한 객체인 request
	int board_idx=Integer.parseInt(request.getParameter("board_idx"));
	String sql="select * from board where board_idx="+board_idx;
	out.print(sql);
	
	pstmt=con.prepareStatement(sql);
	rs=pstmt.executeQuery();
	rs.next();
	

%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=button] {
  background-color: #04AA6D;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=button]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- J쿼리 라이브러리가 들어있는 JS파일을 네트워크상으로 다운로드 받은 상태이므로 이시점부터는 J쿼리 사용 사가능-->

<script type="text/javascript">
	function init(){
		$("#bt").click(function(){
			//alert();
			//현재 폼을 서버로 전송(서버 요청을 받는 jsp에게 요청을 시도함)
			$("#form1").attr("action", "/board/regist.jsp"); //서버에 요청할 주소
			$("#form1").attr("method", "post"); //전송방법(post, get)
			$("#form1").submit();
		});
		
		$("#bt_list").click(function(){
			$(location).attr("href", "/board/list.jsp"); //목록을 요청함
		});
		
	}
	
	$(function(){ //문서가 로드되면..
		init();
	});
</script>

</head>
<body>

<h3>Content Detail</h3>

<div class="container">
  <form id="form1">
    <!--
		name은 전송 시 전송 변수의 역할을 수행할 수 있음
    	즉 전송 파라미터가 될 수 있음
    -->
    <input type="text" name="title" value="<%=rs.getString("title")%>"> <!--out.print(); 표현식 : = -->

    <input type="text" name="writer" value="<%=rs.getString("writer")%>">

    <textarea name="content" style="height:200px"><%=rs.getString("content")%></textarea>

    <input type="button" id="bt" value="전송">
    <input type="button" id="bt_list" value="목록">
    
  </form>
</div>

</body>
</html>
<% 
	rs.close();
	pstmt.close();
	con.close();
%>