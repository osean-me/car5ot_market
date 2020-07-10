<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		String path = request.getContextPath();
		boolean loginResult = request.getParameter("failed") != null;
	%>

<!-- template head-->
<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path %>/css/7.login.css" type="text/css" rel="stylesheet">
		<%if(loginResult) {%>
			<script>
				alert("로그인에 실패했습니다. 이메일 혹은 비밀번호를 확인해주세요.");
			</script>
		<%} %>
        <article id="login-article">
            <form action="login.do" method="get" id="login-form">
                <div>
                    <img src="<%=path %>/img/logo_icon.png" alt="logo_icon">
                </div>
                <div>
                    <input type="text" name="member_id" placeholder="이메일" id="id" required>
                </div>
                <div>
                    <input type="password" name="member_pw" placeholder="비밀번호" id="pw" required>
                </div>
                <div>
                    <div id="login-tool">
                        <input type="checkbox" id="remember-member">
                        <label for="remember-member">자동 로그인</label>
                        <span>
                            <a href="<%=path%>/user/find_id_pw.jsp">이메일 / 비밀번호 찾기</a>
                            <a href="">회원가입</a>
                        </span>
                    </div>
                </div>
                <div>
                    <input type="submit" value="로그인" id="submit">
                </div>
            </form>
        </article>

	<!-- template footer-->
<jsp:include page="/template/footer.jsp"></jsp:include>
