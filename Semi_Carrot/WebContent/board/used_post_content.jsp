<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dao.UsedPostConDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="carrot.bean.dto.UsedPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		String path = request.getContextPath();
	
	long post_no = 1;
	UsedPostConDAO upcdao = new UsedPostConDAO();
	UsedPostDTO updto = upcdao.get(post_no);
	
	//"글작성자 닉네임"을 표시하기 위해 작성자 회원정보가 필요 
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.get(updto.getMember_no());
	%>
	
	
<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path %>/css/8.board_content.css" type="text/css" rel="stylesheet">

<article style="padding-top: 220px">
	<div class="padding50">
		<div class="float-box float-left">
			<div class="left-item40">
				<img src="https://placeimg.com/300/250/tech" width="100%">
			</div>
			<div class="right-item60 left-font padding-left35">
				<div class="font23 padding25">
					<span><%=updto.getPost_title() %></span>
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
							<img class="reply-pic-circle" src="<%=path %>/img/manner_sample.jpg">
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
									
									<img src="<%=path %>/img/manner_sample.jpg" width="200" height="50">
								</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>
