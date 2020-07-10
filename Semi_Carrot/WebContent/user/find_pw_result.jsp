<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
	String member_pw = (String) session.getAttribute("member_pw");
	session.removeAttribute("member_pw");
%>

<!-- 헤더연결 -->

<div align="center">

	<h3>
		검색된 패스워드는<%=member_pw %>
		입니다
	</h3>


	<h5>
		<a href="login.jsp">로그인 하러가기</a>
	</h5>
	<h5>
		<a href="find_id_pw.jsp">비밀번호가 기억나지 않아요</a>
	</h5>

</div>
<!-- 풋터연결 -->