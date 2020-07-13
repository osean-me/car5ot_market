function findAddr() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('state').value = data.sido;
			document.getElementById("city").value = data.sigungu;
			document.getElementById("base").value = data.bname;
		}
	}).open();
}

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

function changeTextBar() {
	var selectEmail = document.querySelector("#selectEmail");
	var a = document.querySelector(".a");
	var inputEmail = document.querySelector("#inputEmail");

	if (inputEmail == null) {
		if (selectEmail.value == "직접 입력") {
			var input = document.createElement("input");
			input.setAttribute("name", "email_2");
			input.setAttribute("id", "inputEmail");
			input.setAttribute("placeholder", "이메일 주소")
			input.setAttribute("oninput", "checkId();")
			a.appendChild(input);
		}
	} else {
		if (selectEmail.value != "직접 입력") {
			a.removeChild(a.childNodes[0]);
		}
	}
}

function allCheck() {
	var all = document.querySelector("#all").checked;
	var selectBox = document.querySelectorAll(".selectBox");

	for (var i in selectBox) {
		selectBox[i].checked = all;
	}

	console.log(selectBox.length);
}

function termsSwitch(num) {
	var terms = document.querySelectorAll(".terms");

	if (num == 1) {

		if (terms[0].classList.length == 1) {
			terms[0].classList.add("active");
		} else {
			terms[0].classList.remove("active");
		}

	} else if (num == 2) {

		if (terms[1].classList.length == 1) {
			terms[1].classList.add("active");
		} else {
			terms[1].classList.remove("active");
		}

	} else if (num == 3) {

		if (terms[2].classList.length == 1) {
			terms[2].classList.add("active");
		} else {
			terms[2].classList.remove("active");
		}
	}
}

function checkId() {
	var inputEmail = document.querySelector("#inputEmail").value;

	var regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	var idInfo = document.querySelector("#idInfo");
	var idInfoText = document.querySelector("#idInfoText");

	if (inputEmail != null) {
		if (inputEmail.match(regex) == null && idInfoText == null) {
			console.log(inputEmail);
			var idInfoText = document.createElement("div");
			idInfoText.textContent = "이메일 형식을 입력해주세요.";
			idInfoText.setAttribute("id", "idInfoText");
			idInfoText.setAttribute("style", "color: red; font-size: 12px;");
			idInfo.appendChild(idInfoText);

		} else if (inputEmail.match(regex) != null && idInfoText != null) {

			idInfo.removeChild(idInfo.childNodes[0]);

		}
	}
}

function checkPw() {
	var pw = document.querySelector("input[name=member_pw]").value;

	var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,15}/;

	var pwInfo = document.querySelector("#pwInfo");
	var pwInfoText = document.querySelector("#pwInfoText");

	if (pw.match(regex) == null && pwInfoText == null) {

		var pwInfoText = document.createElement("div");
		pwInfoText.textContent = "8~15자 영문 대 소문자, 숫자, 특수문자를 사용하세요."
		pwInfoText.setAttribute("id", "pwInfoText");
		pwInfoText.setAttribute("style", "color: red; font-size: 12px;");
		pwInfo.appendChild(pwInfoText);

	} else if (pw.match(regex) != null && pwInfoText != null) {

		pwInfo.removeChild(pwInfo.childNodes[0]);

	}
}

function editcheckPw() {
	var pw = document.querySelector("input[name=check_pw]").value;

	var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,15}/;

	var editpwInfo = document.querySelector("#editpwInfo");
	var editpwInfoText = document.querySelector("#editpwInfoText");

	if (pw.match(regex) == null && editpwInfoText == null) {

		var pwInfoText = document.createElement("div");
		pwInfoText.textContent = "8~15자 영문 대 소문자, 숫자, 특수문자를 사용하세요."
		pwInfoText.setAttribute("id", "editpwInfoText");
		pwInfoText.setAttribute("style", "color: red; font-size: 12px;");
		editpwInfo.appendChild(pwInfoText);

	} else if (pw.match(regex) != null && editpwInfoText != null) {

		editpwInfo.removeChild(editpwInfo.childNodes[0]);

	}
}

function doublecheckPw() {
	var check_member_pw = document.querySelector("input[name=check_member_pw]").value;
	var check_pw = document.querySelector("input[name=check_pw]").value;

	var checkpwInfo = document.querySelector("#checkpwInfo");
	var checkpwInfoText = document.querySelector("#checkpwInfoText");

	if (check_member_pw != check_pw && checkpwInfoText == null) {

		var pwInfoText = document.createElement("div");
		pwInfoText.textContent = "비밀번호가 일치하지 않습니다."
		pwInfoText.setAttribute("id", "checkpwInfoText");
		pwInfoText.setAttribute("style", "color: red; font-size: 12px;");
		checkpwInfo.appendChild(pwInfoText);

	} else if (check_member_pw == check_pw && checkpwInfoText != null) {

		checkpwInfo.removeChild(checkpwInfo.childNodes[0]);

	}
}

function checkNick() {
	var nick = document.querySelector("input[name=member_nick]").value;

	var regex = /^[\w가-힣]{3,10}$/;

	var nickInfo = document.querySelector("#nickInfo");
	var nickInfoText = document.querySelector("#nickInfoText");

	if (nick.match(regex) == null && nickInfoText == null) {

		var nickInfoText = document.createElement("div");
		nickInfoText.textContent = "3 ~ 10 자 이내의 한글과 영어를 사용하세요.";
		nickInfoText.setAttribute("id", "nickInfoText");
		nickInfoText.setAttribute("style", "color: red; font-size: 12px;");
		nickInfo.appendChild(nickInfoText);

	} else if (nick.match(regex) != null && nickInfoText != null) {

		nickInfo.removeChild(nickInfo.childNodes[0]);

	}
}

function checkPhone() {
	var phone = document.querySelector("input[name=member_phone]").value;

	var regex = /^010\d{4}\d{4}$/;

	var phoneInfo = document.querySelector("#phoneInfo");
	var phoneInfoText = document.querySelector("#phoneInfoText");

	if (phone.match(regex) == null && phoneInfoText == null) {

		var phoneInfoText = document.createElement("div");
		phoneInfoText.textContent = "휴대폰 번호를 정확히 입력해주세요.";
		phoneInfoText.setAttribute("id", "phoneInfoText");
		phoneInfoText.setAttribute("style", "color: red; font-size: 12px;");
		phoneInfo.appendChild(phoneInfoText);

	} else if (phone.match(regex) != null && phoneInfoText != null) {

		phoneInfo.removeChild(phoneInfo.childNodes[0]);

	}
}
