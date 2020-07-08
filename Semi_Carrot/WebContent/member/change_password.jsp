<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>



<div align="center"style="padding-top:200px;">
<h2>변경할 비밀번호 입력</h2>

<form action="change_password.do"method="post">
<input type="password" name="member_pw"required>
<input type="submit" value="변경">

</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>