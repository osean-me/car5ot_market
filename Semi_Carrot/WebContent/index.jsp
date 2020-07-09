<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<!-- Java Script -->
<script src="<%=path%>/js/swiper.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fda16046fdbb798b0eb5ce18ac2adeb0"></script>
<script type="text/javascript" src="<%=path%>/js/index.js"></script>
<!-- css -->
<link href="<%=path%>/css/swiper.min.css" type="text/css"
	rel="stylesheet">
<link href="<%=path%>/css/3.promotion.css" type="text/css"
	rel="stylesheet">
<link href="<%=path%>/css/4.article.css" type="text/css"
	rel="stylesheet">

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
				<div class="swiper-slide" id="slide-1">
					<div id="banner-1">
						<div id="banner-1-left">
							<div id="map"></div>
						</div>
						<div id="banner-1-right">
							<div id="banner-1-right-top">
								<span>우리 동네 인기 물건을 만나보세요!</span>
							</div>
							<div id="banner-1-right-bottom">
								<div class="layer">
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">맥북 프로 팔아요!</div>
										<div id="like">5</div>
									</div>
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">강아지 옷 팔아요!</div>
										<div id="like">10</div>
									</div>
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">세탁기 팔아요!</div>
										<div id="like">32</div>
									</div>
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">멋있는 장난감 팔아요!</div>
										<div id="like">11</div>
									</div>
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">미개봉 아이폰 50</div>
										<div id="like">45</div>
									</div>
								</div>
								<div class="layer">
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">와우! 엄청난 가격!</div>
										<div id="like">8</div>
									</div>
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">고양이 사료 나눔!</div>
										<div id="like">87</div>
									</div>
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">구찌 지갑 팔아요!</div>
										<div id="like">8</div>
									</div>
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">마르지엘라 지갑 급처@</div>
										<div id="like">18</div>
									</div>
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title">티비 급처합니다!</div>
										<div id="like">25</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="swiper-slide" id="slide-2">
					<div id="banner-2">
						<div id="banner-2-top">
							<span>우리 동네의 멋진 가게들!</span>
						</div>
						<div id="banner-2-bottom">
							<div class="layer">
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
							</div>
							<div class="layer">
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
								<div class="hot-product">
									<div id="img">
										<img src="http://placeimg.com/100/100/tech">
									</div>
									<div id="title">티비 급처합니다!</div>
									<div id="like">25</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
<!-- 			<div class="swiper-pagination"></div> -->
		</div>
	</div>
</article>
<jsp:include page="/template/footer.jsp"></jsp:include>
