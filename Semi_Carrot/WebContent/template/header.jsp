<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
		String path = request.getContextPath();
		MemberDTO mdto = (MemberDTO) session.getAttribute("memberinfo");
	%>
	
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>어서오세요! 당근마켓!</title>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link href="<%=path %>/css/1.header.css" type="text/css" rel="stylesheet">
<link href="<%=path %>/css/2.nav.css" type="text/css" rel="stylesheet">
<link href="<%=path %>/css/3.promotion.css" type="text/css" rel="stylesheet">
<link href="<%=path %>/css/4.article.css" type="text/css" rel="stylesheet">
<link href="<%=path %>/css/5.footer.css" type="text/css" rel="stylesheet">

<style>
</style>
</head>

<body>
	<main>
		<header>
			<div class="logo">
				<a href="<%=path%>"><img src="<%=path %>/img/logo.png"></a>
			</div>
			<div class="search">
				<form>
					<input type="text" class="search-bar" name="search_keyword"
						placeholder="검색어를 입력해주세요!"> <input type="submit"
						class="search-icon" value="">
				</form>
			</div>
			<div class="sign">
				<%if(mdto != null) { %>
					<img src="<%=path %>/img/user_icon.png" class="user-icon">
				<%} %>
				<ul>
					<%if(mdto == null) { %>
					<li><a href="<%=path%>/user/login.jsp">로그인</a></li>
					<li><a href="<%=path%>/user/join.jsp">회원가입</a></li>
					<%} else { %>
					<li><a href="<%=path%>/member/logout.do">로그아웃</a></li>
					<li><a href="<%=path%>/member/info.jsp">마이페이지</a></li>
					<%} %>
				</ul>
			</div>
		</header>
		
<jsp:include page="/template/nav.jsp"></jsp:include>		