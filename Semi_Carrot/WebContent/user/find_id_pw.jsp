<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

String path = request.getContextPath();
	String find = request.getParameter("not_find");

	if(find != null) {
		if(find.equals("id")) {
		} else if(find.equals("pw")) {
			
		}
	}

%>
	<%	if(find != null) { %>
			<%if(find.equals("id")) { %>
					<script>
						alert("아이디를 찾을 수 없습니다.");
					</script>
			<%} else if(find.equals("pw")) { %>
					<script>
						alert("비밀번호를 찾을 수 없습니다.");
					</script>
			<%} %>
	<%	} %>


<jsp:include page="/template/header.jsp"></jsp:include>

	
<link href="<%=path%>/css/10.find_id_pw.css" rel="stylesheet"
	type="text/css">

<article id="login-article">
	<div class="main-form">
	<div>
		<img src="<%=path%>/img/logo_icon.png" alt="logo_icon" id="logo_icon">
    </div>    
        <div id="find-form">
	        <div class="id-find">
	            <div class="title">아이디 찾기</div>
	            <form action="find_id.do" method="post">
	            	<div>
	             		<input id="nick1"type="text" name="member_nick" placeholder="닉네임을 입력해 주세요">
	            	</div>
	            	<div>
	            		<input id="phone1" type="text" name="member_phone"placeholder="전화 번호를 입력해 주세요">
	            	</div>
	            	<div id="id-submit"> 
	            		<input class="submit" type ="submit"value="찾기">
	            	</div>
	            </form>
	        </div>
	        <div class="pw-find">
	            <div class="title">비밀번호 찾기</div>
	            <form action="find_pw.do" method="post">
	            <div> <input id="id2" type="text" name="member_id" placeholder="이메일 을 입력해 주세요"required></div>
	            <div><input id="nick2" type="text" name="member_nick"placeholder="닉네임 을 입력해 주세요"required></div>
	            <div><input id="phone2" type="text" name="member_phone"placeholder="전화 번호 를 입력해 주세요"required></div>
	            <div><input class="submit" type ="submit"value="찾기"></div>
	            </form>
	        </div>
        </div>
    </div>
	<!-- 아이디 그리고 비번 error에 대한 처리 -->
	<%if(request.getParameter("error") != null){ %>
	<h6><font color="red">해당하는 정보로  찾지 못했습니다</font></h6>
	<%} %>
</article>
<jsp:include page="/template/footer.jsp"></jsp:include>