<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>당근마켓</title>
<style>

</style>
</head>
<body style="margin: 0px; padding: 0px;">
	<header>
		<div align="center" style="height: 120px; margin: 0; padding-top: 60px;">
			<form action="" method="post">
				<table>
				<tr>
					<td>
						<a href="<%=request.getContextPath() %>">
							<img alt="home" src="<%=request.getContextPath()%>/img/logo.png" width="132" height="37" style="padding-right: 10px;">
						</a>
					</td>
					<td>		
						<input type="text" name="keyword" placeholder="지역 , 상품 등을 검색해보세요." style="border: 3; border-color: orange;" size="70px">
					</td>
					<td>
						<input type="image" src="<%=request.getContextPath()%>/img/search.png" width="26" height="26" style="padding-left: 10px;">
					</td>
				</tr>
				</table>
			</form>
		</div>
	</header>
	<nav>
		<div align="center">
			<table style="padding: 0px; margin: 0px; color: orange; font-size: 25px;">
				<tr>
					<th>
						<div style="padding-right: 50px; text-decoration: none;">
						<a href="">중고 게시판</a>
						</div>
					</th>
					<th>
						<div style="padding-right: 50px; text-decoration: none;">
						<a href="">홍보 게시판</a>
						</div>
					</th>
					<th>
						<div style="padding-right: 50px; text-decoration: none;">
						<a href="">우리 동네</a>
						</div>
					</th>
				</tr>
			</table>
		</div>
	</nav>		
	<body>
		<div align="center" style="background-color: #f1f3f5;">
			<h1 style="font-size: 40px;">우리 동네 중고 직거래 마켓</h1>
			<p>동네 주민들과 가깝고 따뜻한 거래를 지금 경험해보세요.</p>
			<img src="<%=request.getContextPath() %>/img/phone.png" alt="main_img">
		</div>
		<div align="center" style="background-color: white; padding-bottom: 70px;">
		<table>
			<%for(int i = 0; i < 3; i++) { %>
				<tr>
					<%for(int k = 0; k < 3; k++) { %>
						<td width="300">
							<p style="font-size: 90px; padding: 0px; margin: 0px; font-style: italic; color: orange;" >"</p>
							<div style="padding: 0px; margin: 0px; width: 250px;">요즘 미니멀라이프 실천 중인데 당근마켓만한 앱이 없어요! 미니멀리즘을 위한 앱이랄까요?ㅎㅎ 동네 직거래라 쉽고 간편해서 너무 좋아요^^ 중고거래에 빠져있답니다❤︎</div>
							<div style="color: orange;">- 부산 부전제1동</div>
						</td>
					<%} %>	
				</tr>
			<%} %>	
			</table>
		</div>
	</body>
	<footer>
		<div align="center" style="padding: 40px 0 67px 0; background-color: #495057;">
			<table>
				<tr>
					<th>
						사업자 등록번호
					</th>
					<td>
						015593-6523482-1546232
					</td>
				</tr>
			</table>
		</div>
	</footer>

</body>
</html> 