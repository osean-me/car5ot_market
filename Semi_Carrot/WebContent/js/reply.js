function reReply(tag) {
	// 현재 체크한 체크박스의 아이디
	var thisTag = tag.id;
	// 현재 체크한 체크박스의 count 값
	var count = tag.value;
	// 해당 체크 박스의 체크 여부
	var replyCheck = document.getElementById(thisTag);
	// rereply-form 아이디 불러오기
	var rereplyform = document.getElementById("rereply-form" + count);
	// rereply-form 에서 rereply-on 클래스 지우기
	rereplyform.classList.remove("rereply-on");

	if (replyCheck.checked) {
		rereplyform.classList.add("rereply-on");
	}

}