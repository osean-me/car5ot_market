// 각 탭에 대한 게시글 받아 오기
function toggleTabAuto(tag) {
	var id = tag.id;
	var targetId = id + "-area";

	var list = document.querySelectorAll(".area");
	for (var i = 0; i < list.length; i++) {
		list[i].classList.remove("on");
	}

	var target = document.getElementById(targetId);
	target.classList.add("on")


	// 회원번호 파라미터로 받고, 각 탭에 게시판 번호 / 댓글 번호 보내기
/*	var member_no = getParameter("no");
	var page = getParameter("page");

	if (id == "select-1") {
		location.href = "info.jsp?no=" + member_no + "&tab_no=1&page=" + page;
	} else if (id == "select-2") {
		location.href = "info.jsp?no=" + member_no + "&tab_no=2&page=" + page;
	} else if (id == "select-3") {
		location.href = "info.jsp?no=" + member_no + "&tab_no=3&page=" + page;
	} else if (id == "select-4") {
		location.href = "info.jsp?no=" + member_no + "&tab_no=4&page=" + page;
	}*/
}

// 댓글 메뉴
function replyNav(tag) {
	var id = tag.id;
	var targetId = id + "-area";
	
	var list = document.querySelectorAll(".area2");
	for(var i = 0; i < list.length; i++) {
		list[i].classList.remove("on");
	}
	
	var target = document.getElementById(targetId);
	target.classList.add("on");
}

// 모서리 모양
function radiusEdit(tag) {
	var id = tag.id;
	var mypageBoard = document.querySelector("#mypage-board");

	mypageBoard.classList.remove("set-left");
	mypageBoard.classList.remove("set-right");
	mypageBoard.classList.remove("set-color");

	if (id == "nav-1") {
		mypageBoard.classList.add("set-left");
		mypageBoard.classList.add("set-color");
	} else if (id == "nav-4") {
		mypageBoard.classList.add("set-right");
		mypageBoard.classList.add("set-color");
	} else if (id == "nav-2" || id == "nav-3") {
		mypageBoard.classList.add("set-color");
	}

}

function profileImgButton() {
	var profileimg_button = document.querySelector(".profileimg-button");
	var checkbox = document.querySelector("#profile-check").checked;
	profileimg_button.classList.remove("button-on");
	
	if(checkbox) {
		profileimg_button.classList.add("button-on");
	}
}
