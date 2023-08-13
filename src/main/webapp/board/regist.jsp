<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="jsp";
	String pass="1234";

	//선언부 : 멤버영역(멤버메서드, 멤버변수 선언영역)
	Connection con;
	PreparedStatement pstmt;
	
	
%>
<%
	//스크립틀릿 : 이 페이지의 메서드 영역
	//이 페이지는 클라이언트가 전송한 입력폼의 파라미터들을 받아서, 오라클에 insert 시키는 것이 목적이므로
	//즉 디자인적 처리는 필요없음. 따라서 html영역은 삭제하고 순수한 jsp영역만으로 코드를 작성함
	
	//클라이언트가 보낸 파라미터 받기
	//이미 네트워크 및 스트림에 대한 내부적 처리가 되어있는 객체들을 jsp가 지원하고 있는데
	//그 객체명은 내장객체 중 request라고 함

	//문서와 상관없이, 요청을 받을 때 전송되는 파라미터 값들에 대한 인코딩
	request.setCharacterEncoding("utf-8");

	String title=request.getParameter("title"); //제목 보관
	String writer=request.getParameter("writer"); //작성자 보관
	String content=request.getParameter("content"); //내용 보관

	//out은 우리가 선언한적도 없는, 즉 이미 jsp에서 지원해주는 내장객체 중 클라이언트에게 
	//데이터를 출력하는데 사용되는 내장객채 (문자기반의 출력스트림)
	out.print("제목은 "+title);
	out.print("<br>");
	out.print("작성자는 "+writer);
	out.print("<br>");
	out.print("내용은 "+content);
	out.print("<br>");
	
	//오라클에 넣기
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con=DriverManager.getConnection(url, user, pass);
	
	out.print(con);
	
	String sql="insert into board(board_idx, title, writer, content)";
	sql+=" values(seq_board.nextval, ?, ?, ?)";
	
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, writer);
	pstmt.setString(3, content);
	
	int result=pstmt.executeUpdate();
	
	out.print("<script>");
	if(result>0){ //성공이라면
		out.print("alert('등록 성공');");
		out.print("location.href='/board/list.jsp';");
		
	}else{
		out.print("alert('등록 실패');");
		out.print("history.back();"); //글쓰기 폼으로 돌아가기
	}
	out.print("</script>");
	
	pstmt.close();
	con.close();
	
	
%>
