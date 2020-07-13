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
	height: 30px;
	margin-top: 15px;
}

input[type=submit] {
	width: 100%;
	height: 20px;
}
</style>
</head>
<body>
	<div>
		<form action="reg_profile.do" method="post" enctype="multipart/form-data">

			<div id="thumb">
				<img src="../img/logo_icon.png" alt="profile_img">
			</div>
			<input type="file" name="member_profile" accept=".jpeg , .jpg , .png">
			<input type="hidden" name="member_no"  value="<%=member_no%>">
			<input type="submit" value="프로필 등록">
		</form>
	</div>
</body>
</html>