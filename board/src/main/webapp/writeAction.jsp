<%@page import="java.io.PrintWriter" %>
<%@page import="BBS.bbsDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bbs" class="DTO.bbsDto" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 회원가입</title>
</head>
<body>

	<%
	
	String userID = null;
	
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	} else {
	
	if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 존재합니다.)");
		script.println("history.back()");
		script.println("</script>");
	} 
	
		BBS.bbsDao bbsdao = new bbsDao();
		int result = bbsdao.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기 성공')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
	}
	
	
	
	
		
		
	

	%>


</body>
</html>