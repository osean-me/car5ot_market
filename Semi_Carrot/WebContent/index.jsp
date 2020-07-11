<%@page import="carrot.bean.dto.AddrDTO"%>
<%@page import="carrot.bean.dao.AddrDAO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="carrot.bean.dao.UsedPostDAO"%>
<%@page import="carrot.bean.dto.UsedPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	
	// 회원 번호 불러오기
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = (MemberDTO)session.getAttribute("memberinfo");
	
	// 최신 중고 게시물 불러오기
	UsedPostDAO updao = new UsedPostDAO();
	List<UsedPostDTO> list = updao.newUsedPost();
	
	// 로그인 세션이 있는 경우 > 회원 번호 / 주소 번호 구해오기
	if(mdto != null) {
		// 최신 회원 정보 얻기
		
		MemberDTO member = mdao.get(mdto.getMember_no());
		
		AddrDAO adao = new AddrDAO();
		AddrDTO adto = adao.get(member.getMember_addr_no());
		
		list = updao.newUsedPost(member.getMember_addr_no());
		
		if(list.isEmpty()) {
			
			list = updao.newUsedPost();
			
		}
		
	}
	
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
				</div>s
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
		<div id="map-area">
			<div id="map"></div>
		</div>
		<div class="swiper-container" id="product">
			<!-- 필수 영역 -->
			<div class="swiper-wrapper">
				<!-- 배치되는 이미지 혹은 화면 (슬라이더) -->
				<div class="swiper-slide" id="slide-1">
					<div id="banner-1">
						<div id="banner-1-right">
							<div id="banner-1-right-top">
								<span>우리 동네 인기 물건을 만나보세요!</span>
							</div>
							<div id="banner-1-right-bottom">
								<div class="layer">
								<%
									int count = 0;
									for(UsedPostDTO newpost : list) { 
										if(count >= 5) {
											break;
										}
								%> 
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title"><%=newpost.getPost_title().substring(0, 10) %> ..</div>
										<div id="like"><%=newpost.getPost_like() %></div>
									</div>
								<%
										count++;
									}
									
								%>
							</div>
							<div class="layer">
								<%
									int count2 = 0;
									for(UsedPostDTO newpost : list) { 
										if(count2 >= 10) {
											break;
										}
										
										if(count2 > 4) {
								%> 
									<div class="hot-product">
										<div id="img">
											<img src="http://placeimg.com/100/100/tech">
										</div>
										<div id="title"><%=newpost.getPost_title().substring(0, 10) %> ..</div>
										<div id="like"><%=newpost.getPost_like() %></div>
									</div>
								<%
										}
										count2++;
									}
									
								%>	
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
						<div class="swiper-pagination"></div>
		</div>
	</div>
</article>
<jsp:include page="/template/footer.jsp"></jsp:include>
