function findAddr() {
    new daum.Postcode({
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
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

    if (navMenu.classList.length == 1 ||
        navMenu.classList.item(1) == "off") {
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
