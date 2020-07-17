//창의 로딩이 완료되었을 때 실행할 코드를 예약
window.onload = function() {
	// var mySwiper = new Swiper(선택자, 옵션);
	var mySwiper = new Swiper('.swiper-container', {
		// swiper에 적용할 옵션들을 작성

		direction : 'horizontal' // 표시방식(수직:vertical, 수평:horizontal)
		,
		loop : false // 순환 모드 여부

		// 페이지 네비게이터 옵션그룹
		,
		pagination : {
			el : '.swiper-pagination', // 적용 대상의 선택자
			type : 'fraction',// 네비게이터 모양(bullets/fraction/...)
		},
		// 이전/다음 이동버튼 설정그룹
		navigation : {
			nextEl : '.swiper-button-next',
			prevEl : '.swiper-button-prev',
			grabCursor : true
		}
		// 커서 모양을 손모양으로 변경
		,
		grabCursor : false

		// 슬라이드 전환 효과(effect)
		// ,effect:'coverflow'
		// ,effect:'cube'
		// ,effect:'fade'
		// ,effect:'flip'
		,
		effect : 'slide'// 기본값
	});
};

function viewMemberInfo() {
	var memberNick = document.querySelector("#member-nick");
	var memberInfo = document.querySelector(".member-info");
	
	memberInfo.classList.remove("display-on");
	
	if(memberNick.checked) {
		console.log("성공");
		memberInfo.classList.add("display-on");
	}
}
