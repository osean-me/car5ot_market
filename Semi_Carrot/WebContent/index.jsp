<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		String path = request.getContextPath();
	%>
	
<jsp:include page="/template/header.jsp"></jsp:include>	

<!-- Java Script -->
<script src="<%=path %>/js/swiper.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fda16046fdbb798b0eb5ce18ac2adeb0"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<!-- css -->	
<link href="<%=path %>/css/swiper.min.css" type="text/css" rel="stylesheet">
<link href="<%=path %>/css/3.promotion.css" type="text/css" rel="stylesheet">
<link href="<%=path %>/css/4.article.css" type="text/css" rel="stylesheet">
	
		<aside>
			<!-- 이미지 슬라이더 영역 -->
			<div class="promotion">
			
				<div class="swiper-container" id="promotion">
					<!-- 필수 영역 -->
					<div class="swiper-wrapper">
						<!-- 배치되는 이미지 혹은 화면 (슬라이더) -->
						<div class="swiper-slide">
							<img src="./img/banner_1903x300.png">
						</div>
						<div class="swiper-slide">
							<img src="./img/banner_1903x300_2.png">
						</div>
						<div class="swiper-slide">
							<img src="./img/banner_1903x300_3.png">
						</div>
					</div>
					<!-- pagination 이 필요하다면 (선택) -->
					<div class="swiper-pagination"></div>
				</div>
			</div>
		</aside>

		<article>
			<div class="hot-title">우리 동네 둘러보기!</div>
			<div class="dongnae">
				<div class="swiper-container" id="product" style="height: 460px;">
					<!-- 필수 영역 -->
					<div class="swiper-wrapper">
						<!-- 배치되는 이미지 혹은 화면 (슬라이더) -->
						<div class="swiper-slide">
							<div id="map"></div>
							<div id="product-list">
								<div class="list-title">우 리 동 네 중 고 게 시 글</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/animals">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/animals">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/animals">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/animals">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/animals">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/animals">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/animals">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/animals">
									<div>제목 : 어쩌고 저쩌고</div>
									<div>♥ : 150</div>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div id="promotion-list">
								<div class="list-title">우 리 동 네 홍 보 게 시 글</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/tech">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/tech">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/tech">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/tech">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/tech">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/tech">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/people">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/people">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/people">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/people">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/people">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
								<div class="hot-product">
									<img src="http://placeimg.com/100/100/people">
									<div>제목 : 어쩌고</div>
									<div>♥ : 150</div>
								</div>
							</div>
						</div>
					</div>
					<div class="swiper-pagination"></div>
				</div>
			</div>
		</article>
<jsp:include page="/template/footer.jsp"></jsp:include>	