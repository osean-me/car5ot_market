<%@page import="carrot.bean.dao.AddrDAO"%>
<%@page import="carrot.bean.dto.AddrDTO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();

	MemberDTO member = (MemberDTO) session.getAttribute("memberinfo");

	Long member_no = member.getMember_no();
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.get(member_no);
	
	/*
		현재 회원번호 가지고 있음.
		회원번호를 가지고 있으면 회원의 주소 고유번호를 알 수 있어요.
		
		근데 나는 이 회원의 주소 고유번호를 이용해서 어드레스의 이 번호에 대한 주소(데이터) 를 보고 싶어요.
	*/
	
	long member_addr_no = mdto.getMember_addr_no();
	
	AddrDAO adao = new AddrDAO();
	
	AddrDTO adto = adao.get(member_addr_no);

%>

<jsp:include page="/template/header.jsp"></jsp:include>
    <link href="<%=path %>/css/8-1.mypage-top.css" type="text/css" rel="stylesheet">
    <link href="<%=path %>/css/8-2.mypage-bottom.css" type="text/css" rel="stylesheet">

        <article id="mypage-article">
            <div id="mypage-form">
                <div id="mypage-top">
                    <div id="mypage-top-left">
                        <div id="mypage-top-left-up">
                            <img alt="user_profile" src="<%=path %>/img/user_profile.jpg">
                        </div>
                        <div id="mypage-top-left-down">
                            <div>
                                <button><a href="">비밀번호 변경</a></button>
                                <button><a href="">회원정보 수정</a></button>
                                <button><a href="">회원 탈퇴</a></button>
                            </div>
                        </div>
                    </div>
                    <div id="mypage-top-right">
                        <div id="mypage-top-right-up">
                            <div id="nickname">
                                <div>
                                    여기는 닉네임
                                    <ul>
                                        <li><a href="">쪽지 보내기</a></li>
                                        <li><a href="">좋아요</a></li>
                                        <li><a href="">싫어요</a></li>
                                        <li><a href="">신고하기</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div id="manner">
                                <div>
                                    <input type="range" value="80" readonly>
                                </div>
                            </div>
                        </div>
                        <div id="mypage-top-right-down">
                            <div id="mypage-top-right-down-in">
                                <div id="intro-top">
                                    <div id="post-count">
                                        게시글 수 : 10
                                    </div>
                                    <div id="reply-count">
                                        댓글 수 : 150
                                    </div>
                                </div>
                                <div id="intro-bottom">
                                    <form action="" method="get">
                                        <textarea maxlength="800">

                                        </textarea>
                                        <input type="submit" value="소개글 등록">
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="mypage-bottom">
                    <div id="mypage-nav">
                        <div id="nav-1" onmouseover="radiusEdit(this);">
                            <label for="select-1">
                                <input type="radio" name="board" id="select-1" onchange="toggleTabAuto(this);" checked>
                                <span>중고</span>
                            </label>
                        </div>

                        <div id="nav-2" onmouseover="radiusEdit(this);">
                            <label for="select-2">
                                <input type="radio" name="board" id="select-2" onchange="toggleTabAuto(this);">
                                <span>홍보</span>
                            </label>
                        </div>

                        <div id="nav-3" onmouseover="radiusEdit(this);">
                            <label for="select-3">
                                <input type="radio" name="board" id="select-3" onchange="toggleTabAuto(this);">
                                <span>텃밭</span>
                            </label>
                        </div>

                        <div id="nav-4" onmouseover="radiusEdit(this);">
                            <label for="select-4">
                                <input type="radio" name="board" id="select-4" onchange="toggleTabAuto(this);">
                                <span>댓글</span>
                            </label>
                        </div>
                    </div>

                    <div id="mypage-board">
                        <div class="area on" id="select-1-area">
                            <div class="mypage-board-table">
                                <div class="mypage-post-search">
                                    <form>
                                        <input type="text" placeholder="검색">
                                        <input type="submit" value="검색">
                                    </form>
                                </div>
                                <div class="mypage-post-list">
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                </div>
                                <div class="mypage-post-list">
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                    <div class="product">
                                        중고 거래 게시글 리스트
                                    </div>
                                </div>
                                <div class="mypage-pagination">
                                    1 2 3 4 5 6 7 8 9 10
                                </div>
                            </div>
                        </div>
                        <div class="area" id="select-2-area">
                            <div class="mypage-board-table">
                                <div class="mypage-post-search">
                                    <form>
                                        <input type="text" placeholder="검색">
                                        <input type="submit" value="검색">
                                    </form>
                                </div>
                                <div class="mypage-post-list">
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                </div>
                                <div class="mypage-post-list">
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                    <div class="product">
                                        홍보 게시글 리스트
                                    </div>
                                </div>
                                <div class="mypage-pagination">
                                    1 2 3 4 5 6 7 8 9 10
                                </div>
                            </div>
                        </div>
                        <div class="area" id="select-3-area">
                            <div class="mypage-board-table">
                                <div class="mypage-post-search">
                                    <form>
                                        <input type="text" placeholder="검색">
                                        <input type="submit" value="검색">
                                    </form>
                                </div>
                                <div class="mypage-post-list column">
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                </div>
                                <div class="mypage-pagination">
                                    1 2 3 4 5 6 7 8 9 10
                                </div>
                            </div>
                        </div>
                        <div class="area" id="select-4-area">
                            <div class="mypage-board-table">
                                <div class="mypage-post-search">
                                    <form>
                                        <input type="text" placeholder="검색">
                                        <input type="submit" value="검색">
                                    </form>
                                </div>
                                <div class="mypage-post-list column">
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="product column">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                </div>
                                <div class="mypage-pagination">
                                    1 2 3 4 5 6 7 8 9 10
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </article>

<jsp:include page="/template/footer.jsp"></jsp:include>
