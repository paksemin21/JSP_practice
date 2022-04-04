<%@page import="DTO.bbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="BBS.bbsDao"%>
<%@page import="DTO.bbsDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width" , initial-scale="1">
<title>Insert title here</title>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
	integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
	crossorigin="anonymous">

</head>
<body>
	<%
	String userID = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	
	int bbsID = 0;
	if(request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
		
	}
	
	if(bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
		
	}
	
	bbsDto bbsdto = new bbsDao().getBbs(bbsID);
	
	%>





	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">Navbar</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="active" href="main.jsp">메인
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="bbs.jsp">게시판</a>
				</li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-expanded="false">
						드롭다운 </a> <% 
        if(userID == null) {
        	
        %>

					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="join.jsp">회원가입</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="login.jsp">로그인</a>
					</div></li>
			</ul>
			<%
        } else {
    %>
			<div class="dropdown-menu" aria-labelledby="navbarDropdown">
				<a class="dropdown-item" href="main.jsp">회원관리</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
			</div>
			</li>
			</ul>


			<%
        }
%>

			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>



	<div class="container">
		<div class="row">
			<table class="table table-bordered"
				style="text-align: center; border: 1px solid #dddddd; table-layout:fixed">
			
				<thead>
					<tr>
						<th colspan="3" width="750px"
							style="background-color: #eeeeee;">게시판 글
							보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="20%">글 제목</td>
						<td colspan="2" style="word-break:break-all"><%= bbsdto.getBbsTitle().replaceAll(" ", "&nbsp;")
								.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2" style="word-break:break-all"><%= bbsdto.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2" style="word-break:break-all"><%= bbsdto.getBbsDate().substring(0, 11) + bbsdto.getBbsDate().substring(11, 13) + "시" + bbsdto.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height: 250px; word-break:break-all; text-align:left;"><%= bbsdto.getBbsContent().replaceAll(" ", "&nbsp;")
								.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>

				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary pull-right">목록</a>

			<%
				if(userID != null && userID.equals(bbsdto.getUserID())) {
				
				%>

			<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn primary">수정</a>
			<a href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn primary">삭제</a>


			<%
				}
				%>
		</div>
	</div>






</body>
</html>