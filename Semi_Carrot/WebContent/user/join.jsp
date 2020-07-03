<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberDTO mdto = new MemberDTO();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<article>
		<form action="join.do" method="get">
			<div>회원 가입</div>
			<div>
				아이디
				<div>
					<input type="text" name="member_id" placeholder="아이디">
				</div>
			</div>
			<div>
				비밀번호
				<div>
					<input type="text" name="member_pw" placeholder="비밀번호">
				</div>
			</div>
			<div>
				닉네임
				<div>
					<input type="text" name="member_nick" placeholder="닉네임">
				</div>
			</div>
			<div>
				주소
				<div>
					<!-- 특별시 / 광역시 등 -->
					<input type="text" name="addr_state" placeholder="특별시 / 광역시">
				</div>
				<div>
					<!-- 시 / 군 / 구 등 -->
					<input type="text" name="addr_city" placeholder="시 / 군 / 구">
				</div>
				<div>
					<!-- 읍 / 면 / 동 등 -->
					<input type="text" name="addr_base" placeholder="읍 / 면 / 동">
				</div>
			</div>
			<div>
				전화번호
				<div>
					<!-- 전화번호 등 -->
					<input type="text" name="member_phone" placeholder="'-' 제외 총 11자">
				</div>
			</div>
			<div>
				<input type="submit" value="회원가입">
			</div>
		</form>
	</article>
</body>
</html>