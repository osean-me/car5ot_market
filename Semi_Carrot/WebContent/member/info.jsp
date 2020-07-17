<%@page import="carrot.bean.dto.MannerDTO"%>
<%@page import="carrot.bean.dao.MannerDAO"%>
<%@page import="carrot.bean.dao.PromotionPostImgDAO"%>
<%@page import="carrot.bean.dto.PromotionPostImgDTO"%>
<%@page import="carrot.bean.dto.LikeDTO"%>
<%@page import="carrot.bean.dao.LikeDAO"%>
<%@page import="carrot.bean.dao.UsedPostImgDAO"%>
<%@page import="carrot.bean.dto.UsedPostImgDTO"%>
<%@page import="carrot.bean.dto.DetailList3DTO"%>
<%@page import="carrot.bean.dao.ProfileImgDAO"%>
<%@page import="carrot.bean.dto.ProfileImgDTO"%>
<%@page import="carrot.bean.dao.IntroDAO"%>
<%@page import="carrot.bean.dto.PromotionPostDTO"%>
<%@page import="carrot.bean.dao.BoardDAO"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="carrot.bean.dao.UsedPostDAO"%>
<%@page import="carrot.bean.dto.UsedPostDTO"%>
<%@page import="carrot.bean.dao.AddrDAO"%>
<%@page import="carrot.bean.dto.AddrDTO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();

	MemberDAO mdao = new MemberDAO();
	
	MemberDTO loginMember = (MemberDTO)session.getAttribute("memberinfo");
	
	long member_no = Long.parseLong(request.getParameter("no"));

	MemberDTO mdto = mdao.get(member_no);

	/*
		현재 회원번호 가지고 있음.
		회원번호를 가지고 있으면 회원의 주소 고유번호를 알 수 있어요.
		
		근데 나는 이 회원의 주소 고유번호를 이용해서 어드레스의 이 번호에 대한 주소(데이터) 를 보고 싶어요.
	*/
	
	long member_addr_no = mdto.getMember_addr_no();
	
	AddrDAO adao = new AddrDAO();
	
	AddrDTO adto = adao.get(member_addr_no);
	
	
	
	//////////////////////////
	///		회원 게시글	  ///
	////////////////////////
	
	UsedPostDAO updao = new UsedPostDAO();
	BoardDAO bdao = new BoardDAO();
	
	// 게시글 테이블 이름 얻기
	String[] name = bdao.getPostTableName();
	
	// 게시글 테이블 이름 + 회원 번호로 해당 게시판의 회원 게시물 불러오
	List<Object> used_post = bdao.getPostList(name[0], member_no);
	List<Object> promotion_post = bdao.getPostList(name[1], member_no);
	List<Object> community_post = bdao.getPostList(name[2], member_no);
	
	// 작성 게시글 개수
	int post_count = used_post.size() + promotion_post.size() + community_post.size();

	
	
	/////////////////////
	///		자기 소개 	 ///
	///////////////////
	
	IntroDAO idao = new IntroDAO();
	
	String intro = idao.getIntro(member_no);
	
	
	
	/////////////////////////
	/// 	회원 프로필 	 ///
	///////////////////////
	
	ProfileImgDAO pidao = new ProfileImgDAO();
	Long member_img_no = pidao.getProfileImgNo(member_no);
	
	UsedPostImgDAO uidao = new UsedPostImgDAO();
	PromotionPostImgDAO ppidao = new PromotionPostImgDAO();
	
	/////////////////////
	/// 	찜 목록 	 ///
	///////////////////
	LikeDAO ldao = new LikeDAO();
	List<UsedPostDTO> post_like = ldao.getMemberUsedPostLike(member_no);
	
	////////////////////////
	///		매너 지수		///
	//////////////////////
	MannerDAO mndao = new MannerDAO();
	MannerDTO mndto = mndao.getMannerCount(member_no);
	long manner_count = mndto.getManner_count();
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript" src="<%=path%>/js/mypage.js"></script>
    <link href="<%=path %>/css/8-1.mypage-top.css?ver=1" type="text/css" rel="stylesheet">
    <link href="<%=path %>/css/8-2.mypage-bottom.css?ver=1" type="text/css" rel="stylesheet">

        <article id="mypage-article">
            <div id="mypage-form">
                <div id="mypage-top">
                    <div id="mypage-top-left">
                        <div id="mypage-top-left-up">
                        	<%if(member_img_no != null) { %>
                       			<!-- 회원 이미지가 있을 경우 -->
                       			<img alt="<%=mdto.getMember_nick() %>" src="profile_img_down.do?member_img_no=<%=member_img_no%>">
                       		<%} else {%>
                       			<!-- 회원 이미지가 없을 경우 -->
                            	<img alt="user_profile_none" src="<%=path %>/img/user_profile.jpg">
                       		<%} %>
                           	<label id="profile-edit" for="profile-check">
                          		<input type="checkbox" id="profile-check" class="profile-check" onchange="profileImgButton();">
                           		<span class="profileimg-button">
	                           		<%if(member_no == loginMember.getMember_no()) { %>
	                           			<!-- 마이페이지 회원이 자신일 경우 -->
	                           		
	                           			<%if(member_img_no != null) { %>
	                           				<!-- 회원 이미지가 있을 경우 -->
	                           				<a href="profile_img_edit.jsp?no=<%=member_no %>&member_img_no=<%=member_img_no %>" onclick="window.open(this.href, '_blank', 'width=305px,height=400px,toolbars=no,scrollbars=no'); return false;" id="profile-img">수정</a>
	                           				<a href="delete_profile.do?member_img_no=<%=member_img_no%>">삭제</a>
	                           			<%} else { %>
	                           				<!-- 회원 이미지가 없을 경우 -->
	                           				<a href="profile_img_create.jsp?no=<%=member_no %>" onclick="window.open(this.href, '_blank', 'width=305px,height=400px,toolbars=no,scrollbars=no'); return false;" id="profile-img">추가</a>
	                           			<%} %>
	                           		<%} %>	
                           		</span>
                           	</label>
                        </div>
                        <div id="mypage-top-left-down">
                            <div>
                            	<%if(loginMember.getMember_no() == member_no) { %>
                                <a href="change_info.jsp?no=<%=member_no%>"><button>회원정보 수정</button></a>
                                <a href="check_exit.jsp?no=<%=member_no%>"><button>회원 탈퇴</button></a>
                                <%} %>
                            </div>
                        </div>
                    </div>
                    <div id="mypage-top-right">
                        <div id="mypage-top-right-up">
                            <div id="nickname">
                                <div>
                                    <%=mdto.getMember_nick() %>
                                    <%if(loginMember.getMember_no() != member_no) { %>
                                    <ul>
                                        <li>
                                        	<form action="manner.do" method="post">
                                        		<input type="hidden" name="this_member_no" value="<%=member_no%>"> <!-- 좋아요 누를 회원 -->
                                        		<input type="hidden" name="push_member_no" value="<%=loginMember.getMember_no() %>"> <!-- 좋아요를 누른 회원 -->
                                        		<input type="hidden" name="path" value="<%=request.getRequestURI() %>?<%=request.getQueryString()%>">
                                        		<input type="hidden" name="good" value="">
                                        		<input type="submit" value="좋아요" class="submit-button">
                                        	</form>
                                        </li>
                                        <li>
                                        	<form action="manner.do" method="post">
                                        		<input type="hidden" name="this_member_no" value="<%=member_no%>"> <!-- 좋아요 누를 회원 -->
                                        		<input type="hidden" name="push_member_no" value="<%=loginMember.getMember_no() %>"> <!-- 좋아요를 누른 회원 -->
                                        		<input type="hidden" name="path" value="<%=request.getRequestURI() %>?<%=request.getQueryString()%>">
                                        		<input type="hidden" name="bad" value="">
                                        		<input type="submit" value="싫어요" class="submit-button">
                                        	</form>
                                        </li>
                                        <li><a href="">신고하기</a></li>
                                    </ul>
                                    <%} %>
                                </div>
                            </div>
                            <div id="manner">
                                <div>
                                    <input type="range" value="<%=manner_count %>" readonly>
                                </div>
                            </div>
                        </div>
                        <div id="mypage-top-right-down">
                            <div id="mypage-top-right-down-in">
                                <div id="intro-top">
                                    <div id="post-count">
                                        게시글 수 : <%=post_count %>
                                    </div>
                                    <div id="reply-count">
                                        댓글 수 : 150
                                    </div>
                                </div>
                                <div id="intro-bottom">
                                <%if(request.getParameter("edit_intro") != null) { %>
                                    <form action="edit_intro.do" method="post">
                                    	<input type="hidden" name="member_no" value="<%=member_no %>">
                                        <textarea maxlength="800" name="intro">
											<%if(intro != null) { %>
												<%=intro %>
											<%} else {%>
												멋진 자기소개를 작성해주세요!
											<%} %>
                                        </textarea>
                                        <input type="submit" value="">
                                    </form>
                                 <%} else {%> 
                                 	<%if(intro != null) { %>
                                		<div id="intro-content">
                                			<%=intro %>
                                		</div>
                                		<div id="write-intro">
                                			<a href="info.jsp?no=<%=member_no%>&edit_intro"><button></button></a>
                                		</div>
                                	<%} else {%>
                                		<div id="intro-content">
                                			자기소개가 없어요! 
                                		</div>
                                		<div id="write-intro">
                                			<a href="info.jsp?no=<%=member_no%>&edit_intro"><button></button></a>
                                		</div>
                                	<%} %>
                                 <%} %>  
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
                                <span>댓글</span>
                            </label>
                        </div>
                        <div id="nav-5" onmouseover="radiusEdit(this);">
                            <label for="select-4">
                                <input type="radio" name="board" id="select-4" onchange="toggleTabAuto(this);">
                                <span>찜꽁</span>
                            </label>
                        </div>
                    </div>

                    <div id="mypage-board">
                    <!-- 중고 거래 게시판 -->
                        <div class="area on" id="select-1-area">
                            <div class="mypage-board-table">
                                <div class="mypage-post-search">
                                    <form>
                                        <input type="text" placeholder="검색">
                                        <input type="submit" value=" ">
                                    </form>
                                </div>
                                
                                <%if(used_post.isEmpty()) { %>
                                	<div style="flex: 9; width: 100%; heigth: 90%;">
                                		게시물이 없습니다.
                                	</div>
                                <%} else { %>
	                                <div class="mypage-post-list">
	                                <%
	                                	int count = 0;
	                                	for(Object used : used_post) {
	                                		
	                                		UsedPostDTO post = (UsedPostDTO) used;
	                                		
	                                		if(count == 5) {
	                         					break;
	                         				}
	                                		
	                                		UsedPostImgDTO uidto = uidao.getMember(post.getPost_no());
	                                		
	                                %>
	                                    <div class="product">
	                                        <div class="product-inner">
	                                        	<div class="photo">
	                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=post.getBoard_no()%>&used_cate_num=<%=post.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>&board_no=<%=post.getBoard_no()%>"><img src="<%=path%>/board/showImg.do?post_img_no=<%=uidto.getPost_img_no()%>"></a>
	                                        	</div>
	                                        	<div class="product-title">
	                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=post.getBoard_no()%>&used_cate_num=<%=post.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>&board_no=<%=post.getBoard_no()%>"><%=post.getPost_title() %>...</a>	
	                                        	</div>
	                                        	<div class="map">
	                                        		<div>
		                                        		<%=adto.getAddr_state().substring(0, 2) %>  
		                                        		<%=adto.getAddr_city() %>  
		                                        		<%=adto.getAddr_base() %>
	                                        		</div>
	                                        	</div>
	                                        	<div class="price-date">
	                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(post.getPost_price()) %></div>
	                                        		<div class="date"><%=post.getUsedPost_day() %></div>
	                                        	</div>
	                                        	<div class="post-like"><%=post.getPost_like() %></div>
	                                        </div>
	                                    </div>
	                                    <%
	                                	    count++;
	                                    } 
	                                    %>
	                                </div>
	                                <div class="mypage-post-list">
	                                <%
	                                	int count2 = 0;
	                                	for(Object used : used_post) {
	                                		
	                                		UsedPostDTO post = (UsedPostDTO) used;
	                                		
	                                		if(count2 == 10) {
	                         					break;
	                         				}
	                                		
	                                		UsedPostImgDTO uidto = uidao.getMember(post.getPost_no());
	                                		if(count2 > 4) {
	                                %>
	                                    <div class="product">
	                                        <div class="product-inner">
	                                        	<div class="photo">
	                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=post.getBoard_no()%>&used_cate_num=<%=post.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>"><img src="<%=path%>/board/showImg.do?post_img_no=<%=uidto.getPost_img_no()%>"></a>
	                                        	</div>
	                                        	<div class="product-title">
	                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=post.getBoard_no()%>&used_cate_num=<%=post.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>"><%=post.getPost_title() %>...</a>	
	                                        	</div>
	                                        	<div class="map">
	                                        		<div>
	                                        			<%=adto.getAddr_state() %>  
	                                        			<%=adto.getAddr_city() %>  
	                                        			<%=adto.getAddr_base() %>
	                                        		</div>
	                                        	</div>
	                                        	<div class="price-date">
	                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(post.getPost_price()) %></div>
	                                        		<div class="date"><%=post.getUsedPost_day() %></div>
	                                        	</div>
	                                        	<div class="post-like"><%=post.getPost_like() %></div>
	                                        </div>
	                                    </div>
	                                    <%
	                                		}    
	                                    	count2++;
	                                    } 
	                                    %>
	                                </div>
                                <%} %>
                            </div>
                        </div>
                        
                        <!--홍보 게시판 -->
                        <div class="area" id="select-2-area">
                            <div class="mypage-board-table">
                                <div class="mypage-post-search">
                                    <form>
                                        <input type="text" placeholder="검색">
                                        <input type="submit" value="">
                                    </form>
                                </div>
                                <%if(promotion_post.isEmpty()) { %>
                                	<div style="flex: 9; width: 100%; heigth: 90%;">
                                		게시물이 없습니다.
                                	</div>
                                <%} else { %>
	                                 <div class="mypage-post-list">
	                                <%
	                                	int count3 = 0;
	                                	for(Object promotion : promotion_post) {
	                                		
	                                		PromotionPostDTO post = (PromotionPostDTO) promotion;
	                                		
	                                		if(count3 == 5) {
	                         					break;
	                         				}
	                                		PromotionPostImgDTO ppidto = ppidao.getMember(post.getPost_no());
	                                		
	                                %>
	                                    <div class="product">
	                                        <div class="product-inner">
	                                        	<div class="photo"><a href="<%=path %>/board/promotion_post_content.jsp?board_no=<%=post.getBoard_no()%>&promotion_cate_num=<%=post.getPromotion_cate_num()%>&post_no=<%=post.getPost_no()%>"><img src="<%=path%>/board/showImg2.do?post_img_no=<%=ppidto.getPost_img_no()%>"></a></div>
	                                        	<div class="product-title"><a href="<%=path %>/board/promotion_post_content.jsp?board_no=<%=post.getBoard_no()%>&promotion_cate_num=<%=post.getPromotion_cate_num()%>&post_no=<%=post.getPost_no()%>"><%=post.getPost_title() %>...</a></div>
	                                        	<div class="map">
	                                        		<div>
		                                        		<%=adto.getAddr_state() %>  
		                                        		<%=adto.getAddr_city() %>  
		                                        		<%=adto.getAddr_base() %>
	                                        		</div>
	                                        	</div>
	                                        	<div class="price-date">
	                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(post.getPost_price()) %></div>
	                                        		<div class="date"><%=post.getPromotionPost_day() %></div>
	                                        	</div>
	                                        	<div class="post-like"><%=post.getPost_like() %></div>
	                                        </div>
	                                    </div>
	                                    <%
	                                	    count3++;
	                                    } 
	                                    %>
	                                </div>
	                                <div class="mypage-post-list">
	                                <%
	                                	int count4 = 0;
	                                	for(Object promotion : promotion_post) {
	                                		
	                                		PromotionPostDTO post = (PromotionPostDTO) promotion;
	                                		
	                                		if(count4 == 10) {
	                         					break;
	                         				}
	                                		if(count4 > 4) {
	                                		PromotionPostImgDTO ppidto = ppidao.getMember(post.getPost_no());
	                                %>
	                                    <div class="product">
	                                        <div class="product-inner">
	                                        	<div class="photo"><a href="<%=path %>/board/promotion_post_content.jsp?board_no=<%=post.getBoard_no()%>&promotion_cate_num=<%=post.getPromotion_cate_num()%>&post_no=<%=post.getPost_no()%>"><img src="<%=path%>/board/showImg2.do?post_img_no=<%=ppidto.getPost_img_no()%>"></a></div>
	                                        	<div class="product-title"><a href="<%=path %>/board/promotion_post_content.jsp?board_no=<%=post.getBoard_no()%>&promotion_cate_num=<%=post.getPromotion_cate_num()%>&post_no=<%=post.getPost_no()%>"><%=post.getPost_title()%>...</a></div>
	                                        	<div class="map">
	                                        		<div>
	                                        			<%=adto.getAddr_state() %>  
	                                        			<%=adto.getAddr_city() %>  
	                                        			<%=adto.getAddr_base() %>
	                                        		</div>
	                                        	</div>
	                                        	<div class="price-date">
	                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(post.getPost_price()) %></div>
	                                        		<div class="date"><%=post.getPromotionPost_day() %></div>
	                                        	</div>
	                                        	<div class="post-like"><%=post.getPost_like() %></div>
	                                        </div>
	                                    </div>
	                                    <%
	                                		}    
	                                    	count4++;
	                                    } 
	                                    %>
	                                </div>
                                <%} %>
                            </div>
                        </div>
                        <div class="area" id="select-3-area">
                            <div class="mypage-board-table">
                                <div class="mypage-post-search">
                                    <form>
                                        <input type="text" placeholder="검색">
                                        <input type="submit" value="">
                                    </form>
                                </div>
                                <div class="mypage-post-list column">
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                    <div class="commu-post">
                                        <div class="no">번호</div>
                                        <div class="cate">말머리</div>
                                        <div class="title">제목</div>
                                        <div class="view">조회수</div>
                                        <div class="date">작성일</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="area" id="select-4-area">
                            <div class="mypage-board-table">
                                <div class="mypage-post-search">
                                    <form>
                                        <input type="text" placeholder="검색">
                                        <input type="submit" value="">
                                    </form>
                                </div>
                                <div class="mypage-post-list column">
                                    <%if(post_like.isEmpty()) { %>
                                	<div style="flex: 9; width: 100%; heigth: 90%;">
                                		게시물이 없습니다.
                                	</div>
                                <%} else { %>
	                                 <div class="mypage-post-list">
	                                <%
	                                	int count5 = 0;
	                                	for(UsedPostDTO like : post_like) {
	                                		
	                                		if(count5 == 5) {
	                         					break;
	                         				}
	                                		UsedPostImgDTO uidto = uidao.getMember(like.getPost_no());
	                                		
	                                %>
	                                    <div class="product">
	                                        <div class="product-inner">
	                                        	<div class="photo">
	                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=like.getBoard_no()%>&used_cate_num=<%=like.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>"><img src="<%=path%>/board/showImg.do?post_img_no=<%=uidto.getPost_img_no()%>"></a>
	                                        	</div>
	                                        	<div class="product-title"><a href="<%=path %>/board/used_post_content.jsp?board_no=<%=like.getBoard_no()%>&used_cate_num=<%=like.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>"><%=like.getPost_title() %>...</a></div>
	                                        	<div class="map">
	                                        		<div>
		                                        		<%=adto.getAddr_state() %>  
		                                        		<%=adto.getAddr_city() %>  
		                                        		<%=adto.getAddr_base() %>
	                                        		</div>
	                                        	</div>
	                                        	<div class="price-date">
	                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(like.getPost_price()) %></div>
	                                        		<div class="date"><%=like.getUsedPost_day() %></div>
	                                        	</div>
	                                        	<div class="post-like"><%=like.getPost_like() %></div>
	                                        </div>
	                                    </div>
	                                    <%
	                                	    count5++;
	                                    } 
	                                    %>
	                                </div>
	                                <div class="mypage-post-list">
	                                <%
	                                	int count6 = 0;
	                                	for(UsedPostDTO like : post_like) {
	                                		
	                                		if(count6 == 10) {
	                         					break;
	                         				}
	                                		if(count6 > 4) {
	                                			UsedPostImgDTO uidto = uidao.getMember(like.getPost_no());
	                                %>
	                                    <div class="product">
	                                        <div class="product-inner">
	                                        	<div class="photo">
	                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=like.getBoard_no()%>&used_cate_num=<%=like.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>"><img src="<%=path%>/board/showImg.do?post_img_no=<%=uidto.getPost_img_no()%>"></a>
	                                        	</div>
	                                        	<div class="product-title"><a href="<%=path %>/board/used_post_content.jsp?board_no=<%=like.getBoard_no()%>&used_cate_num=<%=like.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>"><%=like.getPost_title()%>...</a></div>
	                                        	<div class="map">
	                                        		<div>
	                                        			<%=adto.getAddr_state() %>  
	                                        			<%=adto.getAddr_city() %>  
	                                        			<%=adto.getAddr_base() %>
	                                        		</div>
	                                        	</div>
	                                        	<div class="price-date">
	                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(like.getPost_price()) %></div>
	                                        		<div class="date"><%=like.getUsedPost_day() %></div>
	                                        	</div>
	                                        	<div class="post-like"><%=like.getPost_like() %></div>
	                                        </div>
	                                    </div>
	                                    <%
	                                		}    
	                                    	count6++;
	                                    } 
	                                    %>
	                                </div>
                                <%} %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </article>

<jsp:include page="/template/footer.jsp"></jsp:include>
