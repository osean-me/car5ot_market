
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
