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

		// pagination
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

		/*
		 * 슬라이드 효과 effect: 'coverflow' effect: 'cube' effect: 'fade' effect:
		 * 'flip' effect: 'slider'
		 */
		effect : 'fade'

	});

	var container = document.getElementById('map'); // 지도를 담을 영역의 DOM 레퍼런스

	var options = { // 지도를 생성할 때 필요한 기본 옵션
		center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표.
		level : 3
	// 지도의 레벨(확대, 축소 정도)
	};

	var map = new kakao.maps.Map(container, options); // 지도 생성 및 객체 리턴

	var productSwiper = new Swiper('#product', {
		// direction > 표현 방식 (수직 / 수평)
		direction : 'horizontal',
		// 첫과 끝페이지 연결 여부
		loop : true,

		// 자동 이미지 페이지 전환
		autoplay : {
			delay : 4000,
		},

		// pagination
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

		/*
		 * 슬라이드 효과 effect: 'coverflow' effect: 'cube' effect: 'fade' effect:
		 * 'flip' effect: 'slider'
		 */
		effect : 'slider'
	});
};