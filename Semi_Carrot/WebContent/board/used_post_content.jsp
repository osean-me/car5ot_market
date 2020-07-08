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
.font17 {
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

.right_float {
	float:right;
}
.padding15 {
	padding-bottom: 15px;
}

.padding25 {
	padding-bottom: 25px;
}


.padding-left05{
	padding-left: 0.5rem;
}

.padding-right05{
	padding-right: 0.5rem;
}
.like_button{
	background-color: #CCCCCC;
	color:white;
	font-size:17px;
	border: 2px solid transparent;
	outline: none;
	width:20%;
	padding:0.5rem;
}
.short-border{
        border-right: 1px solid lightgray;
        border-left: 1px solid lightgray;
        padding:0.5rem;
        
    } 

</style>

<article style="padding-top: 220px">
	<div class="float-box float-left">
		<div class="left-item">
			<img src="https://placeimg.com/300/250/tech" width="90%">
		</div>
		<div class="right-item left_font">
			<div class="font20 padding25">
				<span>카메라 팝니다^ㅁ^</span>
			</div>
			<div class="item padding25">
				<span class="font40">60,000</span> <span class=font20>원</span>
			</div>
			<div class="item padding25">
				<hr>
			</div>
			<div class="item font17 gray_font padding25">
				<span class="padding-right05">♥ 180</span> 
			
				<span class="short-border">조회수30</span> 
				
				<span class="padding-left05">3시간 전</span> 
				
				<span class="right_float">☎신고하기</span>
			</div>
			<div class="item font15 padding15">
				<div class="padding15">
					<span class="gray_font">&middot; 카테고리</span><span>&emsp;디지털/가전</span>
				</div>
				<div class="padding15">
					<span class="gray_font">&middot; 상품상태</span><span
						class="purple_font">&emsp;중고</span>
				</div>
				<div class="padding15">
					<span class="gray_font">&middot; 거래지역</span><span class="green_font">&emsp;서울특별시
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
