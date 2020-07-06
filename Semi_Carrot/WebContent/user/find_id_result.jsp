<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String member_id = (String)session.getAttribute("member_id");
	session.removeAttribute("member_id");
%>

<!-- 헤더연결 -->

<div align="center">
	
	<h3>검색된 아이디는 <%=member_id%> 입니다</h3>
	
	
	<h5><a href="login.jsp">로그인 하러가기</a></h5>
	<h5><a href="find_pw.jsp">비밀번호가 기억나지 않아요</a></h5>
	
</div>
<!-- 풋터연결 -->