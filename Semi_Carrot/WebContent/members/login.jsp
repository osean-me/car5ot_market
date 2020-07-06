<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- template head-->

<div align="center">
	
	<h2>로그인</h2>
	
	<form action="login.do" method="post">
		<table border="0">
			<tbody>
				<tr>
				
					<td>
						<input type="text" name="member_id"placeholder="이메일"size=30 required>
					</td>
				</tr>
				<tr>
				
					<td>
						<input type="password" name="member_pw"placeholder="비밀번호"size=30 required>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr align="center">
					<td colspan="1">
						<input type="submit" value="Login"size=100>
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

