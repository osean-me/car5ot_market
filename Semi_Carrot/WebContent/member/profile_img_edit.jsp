<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	long member_no = Long.parseLong(request.getParameter("no"));
%>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>당근마켓 | 프로필 이미지 수정하기</title>
<style>
* {
	margin: 0px;
	padding: 0px;
	width: 300px;
	height: 350px;
}

#thumb {
	width: 300px;
	height: 300px;
	background-color: red;
}

img {
	width: 300px;
	height: 300px;
}

input[type=file] {
	width: 300px;
	height: 50px;
	margin-top: 15px;
}
</style>
</head>
<body>
	<div>
		<form action="" method="post" enctype="multipart/form-data">
			<input type="hidden" name="member_no" value="<%=member_no %>">
			<div id="thumb">
				<img src="../img/logo_icon.png" alt="profile_img">
			</div>
			<input type="file">
		</form>
	</div>
</body>
</html>