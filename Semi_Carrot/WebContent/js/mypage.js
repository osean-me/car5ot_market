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
        }

        // 모서리 모양
        function radiusEdit(tag) {
            var id = tag.id;
            console.log(id);
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
