<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<div align="center">
	
	<h2>로그인</h2>
	
	<form action="login.do" method="post">
		<table border="0">
			<tbody>
				<tr>
				
					<td>
						<input type="text" name="member_id"placeholder="아이디"size=30 required>
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
					<td colspan="2">
						<input type="button" value="Login"size=100>
					</td>
				</tr>
				<tr align="center">
					<td colspan="2">
						<a href="find_id.jsp">아이디가 기억나지 않습니다</a>
						<br>
						<a href="#">비밀번호가 기억나지 않습니다</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>	
	
	



