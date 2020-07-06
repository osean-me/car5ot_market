<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		String path = request.getContextPath();
	%>
		<footer>
			<div class="footer-top">
				<a href="">이용약관</a> <a href="">개인정보처리방침</a> <a href="">위치기반서비스</a> <a
					href="">이용약관</a> <a href="">광고주센터</a> <a href="">회사 소개</a>
			</div>
			<div class="footer-middle-top">
				<a href="">사업자 등록번호 : 000-00-00000</a> 
				<a href="">서울특별시 구로구 디지털로 30길 28 마리오타워 609호</a>
			</div>
			<div class="footer-middle-center">
				<a href="">고객 문의 : danggeun@market.co</a> 
				<a href="">제휴 문의 : contact@market.co</a>
			</div>
			<div class="footer-middle-bottom">
				<a href="">(주)당근마켓 대표 김누구, 박저기</a>
			</div>
			<div class="footer-bottom">Copyright © Danggeun Market Inc. Allrights reserved.</div>
			<div class="footer-icon">
				<a><img src="<%=path %>/img/facebook.png"></a> 
				<a><img src="<%=path %>/img/instagram.png"></a>
			</div>
		</footer>
	</main>
	<script src="./2.js/swiper.min.js"></script>
	<script>
		/*
		    window.onload > 창의 로딩이 완료되었을 때 실행할 코드를 예약
		 */
		window.onload = function() {
			// swiper 관련 js 코드 작성

			// var mySwiper = new Swiper(선택자, 옵션);
			var mySwiper = new Swiper('#promotion', {
				// direction > 표현 방식 (수직 / 수평)                
				direction : 'horizontal',
				// 첫과 끝페이지 연결 여부
				loop : true,

				// 자동 이미지 페이지 전환
				autoplay : {
					delay : 3000,
				},

				//pagination
				pagination : {
					el : '.swiper-pagination',
					type : 'bullets',
					color : 'orange',
				},

				// Navigation
				navigation : {
					nextEl : '.swiper-button-next',
					prevEl : '.swiper-button-prev',
				},

				// scrollbar
				scrollbar : {
					el : '.swiper-scrollbar',
				},

				// 커서 모양 변경
				grabCursor : true,

				/* 슬라이드 효과
				    effect: 'coverflow'
				    effect: 'cube'
				    effect: 'fade'
				    effect: 'flip'
				    effect: 'slider'
				 */
				effect : 'fade'

			});

			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스

			var options = { //지도를 생성할 때 필요한 기본 옵션
				center : new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
				level : 3
			//지도의 레벨(확대, 축소 정도)
			};

			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

			var productSwiper = new Swiper('#product', {
				// direction > 표현 방식 (수직 / 수평)                
				direction : 'horizontal',
				// 첫과 끝페이지 연결 여부
				loop : true,

				// 자동 이미지 페이지 전환
				autoplay : {
					delay : 4000,
				},

				//pagination
				pagination : {
					el : '.swiper-pagination',
					type : 'bullets',
					color : 'orange',
				},

				// Navigation
				navigation : {
					nextEl : '.swiper-button-next',
					prevEl : '.swiper-button-prev',
				},

				// scrollbar
				scrollbar : {
					el : '.swiper-scrollbar',
				},

				// 커서 모양 변경
				grabCursor : true,

				/* 슬라이드 효과
				    effect: 'coverflow'
				    effect: 'cube'
				    effect: 'fade'
				    effect: 'flip'
				    effect: 'slider'
				 */
				effect : 'slider'
			});
		};

		// 네비게이션 메뉴 on/off 애니메이션
		function navSwitch() {
			var navMenu = document.querySelector(".nav-menu");

			if (navMenu.classList.length == 1
					|| navMenu.classList.item(1) == "off") {
				navMenu.classList.remove("off");
				navMenu.classList.add("on");
			} else {
				navMenu.classList.remove("on");
				navMenu.classList.add("off");
			}
		};
	</script>
</body>
</html>