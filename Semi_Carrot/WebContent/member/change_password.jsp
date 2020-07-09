<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();

%>
<jsp:include page="/template/header.jsp"></jsp:include>

	
<script type="text/javascript" src="<%=path%>/js/change_password.js"></script>


<div align="center" style="padding-top: 200px;">
	<h2>변경할 비밀번호를 입력해 주세요</h2>

	<form action="change_password.do" method="post">

		<input type="password" name="member_pw" placeholder="변경할 비밀번호 입력" maxlength="15" oninput="checkPw();"> 
		<input type="password" name="member_pw2"placeholder="비밀번호 확인" maxlength="15"oninput="comfirmPw();">
		<input type="submit" value="변경">
		<div id="pwInfo"></div>


	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>