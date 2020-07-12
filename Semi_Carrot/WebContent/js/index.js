/*
		    window.onload > 창의 로딩이 완료되었을 때 실행할 코드를 예약
 */
window.onload = function() {
	// swiper 관련 js 코드 작성

	// var mySwiper = new Swiper(선택자, 옵션);
	var mySwiper = new Swiper('#promotion', {
		// direction > 표현 방식 (수직 / 수평)
		direction: 'horizontal',
		// 첫과 끝페이지 연결 여부
		loop: true,

		// 자동 이미지 페이지 전환
		autoplay: {
			delay: 3000,
		},

		// pagination
		pagination: {
			el: '.swiper-pagination',
			type: 'bullets',
			color: 'orange',
		},

		// Navigation
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},

		// scrollbar
		scrollbar: {
			el: '.swiper-scrollbar',
		},

		// 커서 모양 변경
		grabCursor: true,

		/*
		 * 슬라이드 효과 effect: 'coverflow' effect: 'cube' effect: 'fade' effect:
		 * 'flip' effect: 'slider'
		 */
		effect: 'fade'

	});


	// 지도 영역
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level: 7 // 지도의 확대 레벨
		};

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 회원 주소 받아오기 
	var memberAddr = document.querySelector("#member_address").value;
	var memberBase = document.querySelector("#member_base").value;
	console.log(memberAddr);
	
	if (memberAddr == "null") {
		console.log(memberAddr);
		memberAddr = "제주특별자치도 제주시 첨단로 242";
		memberBase = "환영해요!";

	}

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(memberAddr, function(result, status) {

		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {

			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			// 결과값으로 받은 위치를 마커로 표시합니다
			var marker = new kakao.maps.Marker({
				map: map,
				position: coords
			});

			// 인포윈도우로 장소에 대한 설명을 표시합니다
			var infowindow = new kakao.maps.InfoWindow({
				content: '<div style="width:150px;text-align:center;padding:6px 0;">' + memberBase + '</div>'
			});
			infowindow.open(map, marker);

			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
		}
	});

	var productSwiper = new Swiper('#product', {
		// direction > 표현 방식 (수직 / 수평)
		direction: 'horizontal',
		// 첫과 끝페이지 연결 여부
		loop: true,

		// 자동 이미지 페이지 전환
		autoplay: {
			delay: 4000,
		},

		// pagination
		pagination: {
			el: '.swiper-pagination',
			type: 'bullets',
			color: 'orange',
		},

		// Navigation
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},

		// scrollbar
		scrollbar: {
			el: '.swiper-scrollbar',
		},

		// 커서 모양 변경
		grabCursor: true,

		/*
		 * 슬라이드 효과 effect: 'coverflow' effect: 'cube' effect: 'fade' effect:
		 * 'flip' effect: 'slider'
		 */
		effect: 'slider'
	});
};