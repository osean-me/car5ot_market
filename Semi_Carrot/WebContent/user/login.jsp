<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- template head-->
<jsp:include page="/template/header.jsp"></jsp:include>

<div style="padding-top: 185px; text-align: center;">
	<%if(request.getParameter("failed") != null) {%>
    		<div>아이디 혹은 비밀번호를 확인해주세요.</div>
    	<%}%>
	<form action="login.do" method="post">
		<table style="width: 1903px;">
			<thead>
				<tr>
				 <th>
				 	<h2>로그인</h2>
				 </th>
				</tr>
			</thead>
			<tbody>
				<tr>
				
					<td style="text-align: center;">
						<input type="text" name="member_id" placeholder="이메일"size=30 required>
					</td>
				</tr>
				<tr>
				
					<td style="text-align: center;">
						<input type="password" name="member_pw" placeholder="비밀번호"size=30 required>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center">
					<td colspan="1">
						<input type="submit" value="Login" size="100">
					</td>
				</tr>
				<tr align="center">
				<td colspan="1">
				<input type = "checkbox">
				<a>이메일 유지</a>
					<tr align="center">
					<td colspan="0">
						<a href="find_id_pw.jsp">이메일/비밀번호 찾기</a>
						<a href="join.jsp">/회원 가입</a>
						<br>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>	
	
</div>

	<!-- template footer-->
<jsp:include page="/template/footer.jsp"></jsp:include>
