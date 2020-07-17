<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 비밀번호 검사 -->
<!-- 목적지 정보 파라미터 이름 go -->

<%
	String go = request.getParameter("go");
	String path = request.getContextPath();
%>


<jsp:include page="/template/header.jsp"></jsp:include>

<link href="<%=path%>/css/check.css" rel="stylesheet" type="text/css">
<article id="full-article">
	<div class="main-form">
		<div style="height: 150px;">
			<img src="<%=path%>/img/shoping.png" alt="logo_icon" id="logo_icon"
				style="width: 300px;">
		</div>
		<div id="find-form">
			<div class="pw-find">
				<div>
					<form action="checks.do" method="get" style="margin-top: 200px">
						<input id="pw" type="password" name="member_pw" required
							placeholder="비밀번호 입력" style="display:block;margin: 0px auto;"> <input class="submit"
							type="submit" value="확인"
							style="width: 345px; height: 55px margin-top:100px;">

					</form>
				</div>
				<%
					if (request.getParameter("error") != null) {
				%>
				<!-- 비번이 틀릴경우 메시지 송출 -->
				<script>
					alert("비밀번호가 다릅니다");
				</script>
				<%
					}
				%>

			</div>
		</div>
	</div>

</article>




<jsp:include page="/template/footer.jsp"></jsp:include>