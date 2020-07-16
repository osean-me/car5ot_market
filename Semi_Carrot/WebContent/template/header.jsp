<%@page import="carrot.bean.dto.ProfileImgDTO"%>
<%@page import="carrot.bean.dao.ProfileImgDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
		String path = request.getContextPath();
		MemberDTO mdto = (MemberDTO) session.getAttribute("memberinfo");
		
		ProfileImgDAO pidao = new ProfileImgDAO();
		Long member_img_no = null;
		
		if(mdto != null) {
			member_img_no = pidao.getProfileImgNo(mdto.getMember_no());
		}
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
				<form action="<%=path%>/board/used_all_post_list.jsp" method="get">
					<input type="hidden" name="type" value="post_title">
					<input type="text" class="search-bar" name="keyword" placeholder="검색어를 입력해주세요!"> 
					<input type="submit" class="search-icon" value="">
				</form>
			</div>
			<div class="sign">
				<%if(mdto != null) { %>
					<%
						if(member_img_no != null) {
							ProfileImgDTO pidto = pidao.get(mdto.getMember_no());
					%>
						<%if(pidto != null) {%>
							<!-- 회원 이미지가 있을 때  -->
							<%System.out.println(pidto.getMember_img_no()); %>
							<img alt="<%=mdto.getMember_nick() %>" src="<%=path %>/member/profile_img_down.do?member_img_no=<%=pidto.getMember_img_no()%>" class="user-icon">
						<%}%>
					<%} else { %>
						<!-- 회원 이미지가 없을 때 -->
						<img src="<%=path %>/img/user_icon.png" class="user-icon">
					<%} %>
				<%} %>
				<ul>
					<%if(mdto == null) { %>
					<li><a href="<%=path%>/user/login.jsp">로그인</a></li>
					<li><a href="<%=path%>/user/join.jsp">회원가입</a></li>
					<%} else { %>
					<li><a href="<%=path%>/member/logout.do">로그아웃</a></li>
					<li><a href="<%=path%>/member/info.jsp?no=<%=mdto.getMember_no()%>">마이페이지</a></li>
					<%} %>
				</ul>
			</div>
		</header>
		
<jsp:include page="/template/nav.jsp"></jsp:include>		