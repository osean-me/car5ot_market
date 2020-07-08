// 네비게이션 메뉴 on/off 애니메이션
function navSwitch() {
	var navMenu = document.querySelector(".nav-menu");

	if (navMenu.classList.length == 1 || navMenu.classList.item(1) == "off") {
		navMenu.classList.remove("off");
		navMenu.classList.add("on");
	} else {
		navMenu.classList.remove("on");
		navMenu.classList.add("off");
	}
};