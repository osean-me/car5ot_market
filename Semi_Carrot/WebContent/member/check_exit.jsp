<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String member_no = request.getParameter("no");
	String path = request.getContextPath();
%>


<jsp:include page="/template/header.jsp"></jsp:include>

<script type="text/javascript" src="<%=path%>/js/change_exit.js"></script>
<article id="login-article"></article>

	<img src="<%=path%>/img/logo_icon.png" alt="logo_icon" id="logo_icon">
	
<link href="<%=path%>/css/9.check_exit.css" rel="stylesheet"
	type="text/css">
	<%if(request.getParameter("failed")!=null) {%>
		<script>
			alert("비밀번호 전화번호가 일치하지 않습니다. 다시 입력해주세요.");
		</script>
	<%} %>
	
	<h2>회원탈퇴</h2>
	<form action="gone.do" method="get">
	
		<div>
		<input type="hidden"name="member_no"value=<%=member_no %>>
		<input id="pw"type="password" name="member_pw" placeholder="비밀번호를 입력해 주세요" required="required" maxlength="15"oninput="checkPw()">
		</div>
		 <div id="pwInfo"></div>
		<input id="phone" type="text" name="member_phone"placeholder="전화번호를 입력해 주세요"required maxlength="11"oninput="checkPhone()">
		 <div id="phoneInfo"></div>
		<div>
			<h2>탈퇴 사유 선택</h2>
		</div>
		<div>
<!-- 관리자 기능 추가가 되면 form 으로 전송할 계획 -->
			<label for="first"><input type="checkbox" name="select" id="first">이용 불편</label>
			<label><input type="checkbox" name="select">사기</label>
			<label><input type="checkbox" name="select">원하는 서비스가 없음</label>
			<label><input type="checkbox" name="select">서비스가 마음에 들지 않음</label>
			<div>
				<h2>기타 사유</h2>
				<textarea style="resize: none;" rows="7" cols="60" name="intro"></textarea>
			</div>
		</div>
		<div>
			<input id="submit" type="submit" value="탈퇴하기">
		</div>
	</form>

<jsp:include page="/template/footer.jsp"></jsp:include>