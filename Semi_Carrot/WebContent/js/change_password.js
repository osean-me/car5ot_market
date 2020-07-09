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

function comfirmPw() {
	var pw1 = document.querySelector("input[name=member_pw]").value;
	var pw2 = document.querySelector("input[name=member_pw2]").value;
	var pwInfoText = document.querySelector("#pwInfoText");

	if (pw1 != pw2 && pwInfoText == null) {
		var pwInfoText = document.createElement("div");
		pwInfoText.textContent = "비밀번호가 틀립니다. 다시 입력해주세요."
		pwInfoText.setAttribute("id", "pwInfoText");
		pwInfoText.setAttribute("style", "color: red; font-size: 12px;");
		pwInfo.appendChild(pwInfoText);

	} else if  (pw1 == pw2 && pwInfoText != null) {
		pwInfo.removeChild(pwInfo.childNodes[0]);
	
	}
	
	
}
