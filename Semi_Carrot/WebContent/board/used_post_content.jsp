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
.left-item66{
	width:66%;
}
.left-item50{
	width:50%;
}
.left-item40 {
	width: 40%;
}

.left-item25{
	width:25%;
}
.left-item20{
	width:20%;
}
.left-item16{
	width:16.666%;
}
.left-item10{
	width:10%;
}
.right-item34 {
	width: 34%;
}
.right-item60 {
	width: 60%;
}
.right-item75 {
	width: 75%;
}
.right-item90 {
	width: 90%;
}
/*폰트크기*/

.font12 {
	font-size: 12px;
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

.font23 {
	font-size: 23px;
}

.font45 {
	font-size: 45px;
}

.gray-font {
	color: #999999;
}

.purple-font {
	color: #6247EE;
}

.green-font {
	color: #62B1D9;
}

.left-font {
	
	text-align: left;
}

.right-float {
	float: right;
}

.reply-nick-font{
	color:dimgray;
	font-size:15px;
}

/*패딩*/
.padding-top10{
	padding-top:10px;
}
.padding-top25{
	padding-top:25px;
}

.padding-top30{
	padding-top:30px;
}
.padding-top40{
	padding-top:40px;
}
.padding-top50{
	padding-top:50px;
}
.padding15 {
	padding-bottom: 15px;
}

.padding25 {
	padding-bottom: 25px;
}

.padding40 {
	padding-bottom: 40px;
}

.padding50 {
	padding-bottom: 50px;
}

.padding-left05 {
	padding-left: 0.5rem;
}
.padding-left30 {
	padding-left: 30px;
}
.padding-left35 {
	padding-left: 35px;
}

.padding-right05 {
	padding-right: 0.5rem;
}
.padding-right10{
	padding-right:10px;
}
.padding-right30{
	padding-right:30px;
}
.text-padding{
	padding:20px;
}
.text-padding15{
	padding:15px;
}
.text-padding10{
	padding:10px;
}
.reply-div-padding{
	padding-top:15px;
}
/*마진*/
.reply-margin20{
	margin:30px 0px 20px 0px;
	}

.like-button {
	background-color: #CCCCCC;
	color: white;
	font-size: 17px;
	border: 2px solid transparent;
	outline: none;
	width: 50%;
	padding: 0.5rem;
}
.reply-button{
	background-color: white;
	color: #999999;
	font-size: 15px;
	border: 1px solid #999999;
	outline: none;
	width:50px;
	
}
/*테두리*/
.short-border {
	border-right: 1px solid lightgray;
	border-left: 1px solid lightgray;
	padding: 0.5rem;
}

.product-info-border{
	
	border-left:1px solid transparent;
	border-right:1px solid transparent;
}
.info-border{
	
	border-left:1px solid transparent;
	border-right:1px solid darkgray;
}
.reply-border{
	border:1px solid lightgray;
}
.reply-num-border{
	border-left:1px solid lightgray;
	border-right:1px solid lightgray;
	border-bottom:1px solid lightgray;
}
.pic-circle{
	 width: 100px;
   	 height:100px;
	border-radius: 50px;
}
.reply-pic-circle{
	 width: 50px;
   	 height:50px;
	border-radius: 25px;
}
textarea{
            resize:none;
            border: none;
        }
</style>

<article style="padding-top: 220px">
	<div class="padding50">
		<div class="float-box float-left">
			<div class="left-item40">
				<img src="https://placeimg.com/300/250/tech" width="100%">
			</div>
			<div class="right-item60 left-font padding-left35">
				<div class="font23 padding25">
					<span>카메라 팝니다^ㅁ^</span>
				</div>
				<div class="item padding25">
					<span class="font45">60,000</span> <span class=font20>원</span>
				</div>
				<div class="item padding25">
					<hr>
				</div>
				<div class="item font17 gray-font padding25">
					<span class="padding-right05">♥ 180</span> <span
						class="short-border">조회수30</span> 
						<span class="padding-left05">3시간전</span> 
						<span class="right-float">☎신고하기</span>
				</div>
				<div class="item font15 padding15">
					<div class="padding15">
						<span class="gray-font">&middot; 카테고리</span><span>&emsp;디지털/가전</span>
					</div>
					<div class="padding15">
						<span class="gray-font">&middot; 상품상태</span><span
							class="purple-font">&emsp;중고</span>
					</div>
					<div class="padding15">
						<span class="gray-font">&middot; 거래지역</span><span
							class="green-font">&emsp;서울특별시 영등포구 당산동</span>
					</div>
				</div>
				<div>
					<button class="like-button">♥ 찜 180</button>
				</div>
			</div>
		</div>
	</div>


	<div>
		<p class="font20 padding15 padding-top40">연관상품<p>
		
		<div class="padding40">
			<div class="float-box float-left">
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/nature">
					<p class="font17">사진1</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/tech" >
					<p class="font17">사진2</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/people" >
					<p class="font17">사진3</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/animals" >
					<p class="font17">사진4</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/architecture" >
					<p class="font17">사진5</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/architecture" >
					<p class="font17">사진6</p>
				</div>
			</div>
		</div>
	</div>
	
	<div class="padding-top50">
		<div class="float-box float-left">
			<div class="left-item66 padding-right30 info-border left-font">
				<div class="padding15">
					<p class="font20">상품정보</p>
				</div>
				<hr>
				<div class="padding-top40 padding40 product-info-border ">
				✅연락가능 시간 : 24시간<br>
				(부재시 곧연락드립니다)<br>
				<br>
				⚠️샤넬모든제품 문의환영/해외구매대행 문의 환영⚠️<br>
				⬇️번개장터: 코카크크 바로가기⬇️<br>
				👉https://stuv4.app.goo.gl/ZRfSt<br>
				<br>
				🔔코카크크만 있는 페이백 이벤트🔔<br>
				👉후기작성 해주시면 10,000원을 돌려드립니다👌<br>
				<br>
				➡️ 사진과 틀리다면 200% 보상해드리겠습니다.<br>
				➡️ "싸다", "우리가갑이다." , "비교인증" 그런말안해요.<br>
				➡️ "코카크크" 만의 차별화된 서비스로 보여드립니다.<br>
				<br>
				😉항상 고객님께 최선을 다하겠습니다😉<br>
				✔무리한 조건을 걸지않겠습니다.<br>
				✔제품을 허위로 판매하는건 불법입니다.<br>
				✔거짓없이 제대로 설명드리며 구매에대해 <br>
				      방향성을 잡아드립니다.<br>
				<br>
				❤해외배송 구매과정❤
				</div>
				<hr>
				<div class="padding-top40">
					<p class="font20">댓글</p>
					<div class="reply-div-padding">
						<div class="reply-border">
						<textarea class="text-padding" name="reply_content" placeholder="댓글 입력" cols="116" rows="5"></textarea>
						</div>
					</div>
					<div class="reply-num-border">
						<div class="float-box float-left">
							<div class="left-item50">
								<p class="font12 gray-font text-padding10">30 / 100</p>
							</div>
							<div class="left-item50 text-padding10">
								<button class="right-float reply-button">☜등록</button>
							</div>
						</div>
					</div>
				</div>
				
			<div class="padding-top25 ">	
					<div class="float-box float-left reply-margin20">
						<div class="left-item10">
							<img class="reply-pic-circle" src="https://placeimg.com/300/250/tech" >
						</div>
						<div class="right-item90">
							<div class="reply-nick-font">
								<span>닉네임뭐할까</span>
								<span class="right-float gray-font">2분전</span>
							</div>
							<div class="font17 padding-top10">
								가방 구매하고싶은데 팔렸나요?
							</div>	
						</div>
					</div>
					<hr>
									<div class="float-box float-left reply-margin20">
						<div class="left-item10">
							<img class="reply-pic-circle" src="https://placeimg.com/300/250/tech" >
						</div>
						<div class="right-item90">
							<div class="reply-nick-font">
								<span>나는야부자</span>
								<span class="right-float gray-font">5분전</span>
							</div>
							<div class="font17 padding-top10">
								어머머 가방 너무 예쁘네요~^^
							</div>	
						</div>
					</div>
					<hr>
					<div class="float-box float-left reply-margin20">
						<div class="left-item10">
							<img class="reply-pic-circle" src="https://placeimg.com/300/250/tech" >
						</div>
						<div class="right-item90">
							<div class="reply-nick-font">
								<span>욜로롤로</span>
								<span class="right-float gray-font">15분전</span>
							</div>
							<div class="font17 padding-top10">
								아~~~ 사고싶다 ㅜㅜ
							</div>	
						</div>
					</div>
					<hr>
				</div>
			</div>
			
			<div class="right-item34  padding-right30 padding-left30 left-font">
				<div class="padding15 ">
					<p class=" font20">상점정보</p>
				</div>
				<hr>
				<div class="padding-top30">
					<div class="float-box float-left">
						<div class="left-item25">
							<img class="pic-circle" src="https://placeimg.com/300/250/tech" >
						</div>
						<div class="right-item75 padding-left30">
								<div class="padding25">
									<p>기마름이야</p>
								</div>
								<div>
									<p class="gray-font">매너지수</p>
									<img src="https://placeimg.com/300/250/animal" width="100" height="25">
								</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>
