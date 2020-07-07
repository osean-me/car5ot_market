<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<%
	String path = request.getContextPath();
%>
<link href="<%=path%>/css/6.board_content.css" type="text/css"
	rel="stylesheet">
<style>
.float-box:after {
	content: "";
	display: block;
	clear: both;
}

.float-box.float-left>* {
	float: left;
}

.float-box.float-right>* {
	float: right;
}

.float-box>.float-left {
	float: left;
}

.float-box>.float-right {
	float: right;
}

.left-item {
	width: 40%;
}

.right-item {
	width: 60%;
}

.font15 {
	font-size: 15px;
}

.font20 {
	font-size: 20px;
}

.font40 {
	font-size: 40px;
}

.gray_font {
	color: #999999;
}

.purple_font {
	color: #6247EE;
}

.green_font {
	color: #62B1D9;
}

.left_font {
	padding-left: 0.5rem;
	text-align: left;
}

.right_font {
	text-align: right;
}

.padding05 {
	padding-bottom: 0.5rem;
}
.like_button{
	background-color: #CCCCCC;
	color:white;
	font-size:17px;
	border: border: 5px solid transparent;
	outline: none;
	width:20%;
	padding:0.5rem;
}
</style>

<article style="padding-top: 200px">
	<div class="float-box float-left">
		<div class="left-item">
			<img src="https://placeimg.com/300/200/tech" width="90%" height="300">
		</div>
		<div class="right-item left_font">
			<div class="font20 padding05">
				<span>카메라 팝니다^ㅁ^</span>
			</div>
			<div class="item padding05">
				<span class="font40">60,000</span> <span class=font20>원</span>
			</div>
			<div class="item padding05">
				<hr>
			</div>
			<div class="item font20 gray_font padding05">
				<span>♥ 180</span> <span>조회수30</span> <span>3시간 전</span> <span
					class="right_font">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;☎신고하기</span>
			</div>
			<div class="item font15 padding05">
				<div>
					<span class="gray_font">&middot;카테고리</span><span>&emsp;디지털/가전</span>
				</div>
				<div>
					<span class="gray_font">&middot;상품상태</span><span
						class="purple_font">&emsp;중고</span>
				</div>
				<div>
					<span class="gray_font">&middot;거래지역</span><span class="green_font">&emsp;서울특별시
						영등포구 당산동</span>
				</div>
			</div>
			<div>
				<button class="like_button">♥ 찜 180</button> 
			</div>
		</div>
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>
