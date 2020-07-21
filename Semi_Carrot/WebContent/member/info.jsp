<%@page import="carrot.bean.dao.PromotionPostDAO"%>
<%@page import="carrot.bean.dao.ReplyDAO"%>
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
	
	
	//////////////////////////
	///		회원 게시글	  ///
	////////////////////////
	
	UsedPostDAO updao = new UsedPostDAO();
	PromotionPostDAO ppdao = new PromotionPostDAO();
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
	
	////////////////////////
	///		댓글 게시글	///
	//////////////////////
	ReplyDAO rdao = new ReplyDAO();
	List<Long> used_post_no = rdao.getMemberReplyList_used(member_no);
	List<Long> promotion_post_no = rdao.getMemberReplyList_promotion(member_no);
	
	// 총 댓글 갯수
	long reply_count = 0;
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
	                        <%if(loginMember.getMember_no() == member_no) { %>
                           	<label id="profile-edit" for="profile-check">
                          		<input type="checkbox" id="profile-check" class="profile-check" onchange="profileImgButton();">
                           				<span class="profileimg-button">
	                           			<!-- 마이페이지 회원이 자신일 경우 -->
	                           		
	                           			<%if(member_img_no != null) { %>
	                           				<!-- 회원 이미지가 있을 경우 -->
	                           				<a href="profile_img_edit.jsp?no=<%=member_no %>&member_img_no=<%=member_img_no %>" onclick="window.open(this.href, '_blank', 'width=305px,height=400px,toolbars=no,scrollbars=no'); return false;" id="profile-img">수정</a>
	                           				<a href="delete_profile.do?member_img_no=<%=member_img_no%>">삭제</a>
	                           			<%} else { %>
	                           				<!-- 회원 이미지가 없을 경우 -->
	                           				<a href="profile_img_create.jsp?no=<%=member_no %>" onclick="window.open(this.href, '_blank', 'width=305px,height=400px,toolbars=no,scrollbars=no'); return false;" id="profile-img">추가</a>
	                           			<%} %>
                           		</span>
                           	</label>
	                    <%} %>	
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
                                   <span id="manner-count"><img src="<%=path %>/img/manner.png" style="width: 25px; height: auto;"></span><input type="range" value="<%=manner_count %>" readonly>
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
                                        댓글 수 : 
                                        <%
                                        	if(rdao.getReplyCount_used(member_no) > 0 || rdao.getReplyCount_promotion(member_no) > 0) {
                                        		reply_count = rdao.getReplyCount_used(member_no) + rdao.getReplyCount_promotion(member_no);
                                        %>
                                        	<%=reply_count%>
                                        <%}  else {%>
                                        	0
                                        <%} %>
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
                                		<div id="intro-content">
                                 	<%if(intro != null) { %>
                                			<%=intro %>
                                	<%} else {%>
                                			자기소개가 없어요! 
                                	<%} %>
                                		</div>
                                	<%if(loginMember.getMember_no() == member_no) { %>	
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
                        <div id="nav-1" class="back-color"  onmouseover="radiusEdit(this);" onchange="changeBackcolor(this);">
                            <label for="select-1">
                                <input type="radio" name="board" id="select-1" onchange="toggleTabAuto(this);" checked>
                                <span>중고</span>
                            </label>
                        </div>
	                        <div id="nav-2" onmouseover="radiusEdit(this);" onchange="changeBackcolor(this);">
	                            <label for="select-2">
	                                <input type="radio" name="board" id="select-2" onchange="toggleTabAuto(this);">
	                                <span>홍보</span>
	                            </label>
	                        </div>
                        <div id="nav-3" onmouseover="radiusEdit(this);" onchange="changeBackcolor(this);">
                            <label for="select-3">
                                <input type="radio" name="board" id="select-3" onchange="toggleTabAuto(this);">
                                <span>댓글</span>
                            </label>
                        </div>
                        <div id="nav-5" onmouseover="radiusEdit(this);" onchange="changeBackcolor(this);">
                            <label for="select-4">
                                <input type="radio" name="board" id="select-4" onchange="toggleTabAuto(this);">
                                <span>찜꽁</span>
                            </label>
                        </div>
                    </div>

                    <div id="mypage-board">
                    <!-- 중고 거래 게시판 -->
                        <div class="area on" id="select-1-area">
                        <div class="empty"></div>
                            <div class="mypage-board-table">
                                <div class="mypage-post-list">
                                <%if(used_post.isEmpty()) { %>
                                	<div style="flex: 9; width: 100%; heigth: 90%;">
                                		게시물이 없습니다.
                                	</div>
                                <%} else { %>
	                                <%
	                                	for(int i = 0; i < used_post.size(); i++) {
	                                		
	                                		Object used = used_post.get(i);
	                                		UsedPostDTO post = (UsedPostDTO) used;
	                                		
	                                		UsedPostImgDTO uidto = uidao.getMember(post.getPost_no());
	                                		AddrDTO used_addr = adao.get(post.getAddr_no());
	                                		
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
		                                        		<%=used_addr.getAddr_state().substring(0, 2) %>  
		                                        		<%=used_addr.getAddr_city() %>  
		                                        		<%=used_addr.getAddr_base() %>
	                                        		</div>
	                                        	</div>
	                                        	<div class="price-date">
	                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(post.getPost_price()) %></div>
	                                        		<div class="date"><%=post.getUsedPost_day() %></div>
	                                        	</div>
	                                        	<div class="post-like"><%=post.getPost_like() %></div>
	                                        </div>
	                                    </div>
	                                <%if((i+1) % 5 == 0) { %>
	                                	</div><div style="height: 100px; padding: 40px 0px;"><hr></div><div class="mypage-post-list">
	                               	<%} %>
                                <%} %>
                              <%} %>  
	                       		</div>
                            </div>
                        </div>
                        
                        <!--홍보 게시판 -->
                        <div class="area" id="select-2-area">
                        <div class="empty"></div>
                            <div class="mypage-board-table">
                                <div class="mypage-post-list">
		                                <%if(promotion_post.isEmpty()) { %>
		                                	<div style="flex: 9; width: 100%; heigth: 90%;">
		                                		게시물이 없습니다.
		                                	</div>
		                                <%} else { %>
			                                <%
			                                	for(int i = 0; i < promotion_post.size(); i++) {
			                                		
			                                		Object promotion = promotion_post.get(i);
			                                		PromotionPostDTO post = (PromotionPostDTO) promotion;
			                                		
			                                		PromotionPostImgDTO ppidto = ppidao.getMember(post.getPost_no());
			                                		AddrDTO promotion_addr = adao.get(post.getAddr_no());
			                                		
			                                %>
			                                    <div class="product">
			                                        <div class="product-inner">
			                                        	<div class="photo"><a href="<%=path %>/board/promotion_post_content.jsp?board_no=<%=post.getBoard_no()%>&promotion_cate_num=<%=post.getPromotion_cate_num()%>&post_no=<%=post.getPost_no()%>"><img src="<%=path%>/board/showImg2.do?post_img_no=<%=ppidto.getPost_img_no()%>"></a></div>
			                                        	<div class="product-title"><a href="<%=path %>/board/promotion_post_content.jsp?board_no=<%=post.getBoard_no()%>&promotion_cate_num=<%=post.getPromotion_cate_num()%>&post_no=<%=post.getPost_no()%>"><%=post.getPost_title() %>...</a></div>
			                                        	<div class="map">
			                                        		<div>
				                                        		<%=promotion_addr.getAddr_state() %>  
				                                        		<%=promotion_addr.getAddr_city() %>  
				                                        		<%=promotion_addr.getAddr_base() %>
			                                        		</div>
			                                        	</div>
			                                        	<div class="price-date">
			                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(post.getPost_price()) %></div>
			                                        		<div class="date"><%=post.getPromotionPost_day() %></div>
			                                        	</div>
			                                        	<div class="post-like"><%=post.getPost_like() %></div>
			                                        </div>
			                                    </div>
			                                <%if((i+1) % 5 == 0) { %>
			                                	</div><div style="height: 100px; padding: 40px 0px;"><hr></div><div class="mypage-post-list">
			                               	<%} %>
		                                <%} %>
		                              <%} %>  
	                       			</div>
                            	</div>
                        	</div>
                        
                        <!-- 댓글 -->
                        <div class="area" id="select-3-area">
                            <div id="reply-nav" class="empty">
                            	<label for="1-reply">
                            		<input type="radio" id="1-reply" name="reply-package" onchange="replyNav(this);" checked>
                            		중고
                            	</label>
                            	<label for="2-reply">
                            		<input type="radio" id="2-reply" name="reply-package" onchange="replyNav(this);">
                            		홍보
                            	</label>
                            </div>
                            <div id="1-reply-area" class="area2 on">
                            	<div class="mypage-board-table">
	                                <div class="mypage-post-list">
	                                <%if(used_post_no.isEmpty()) { %>
	                                	<div style="flex: 9; width: 100%; heigth: 90%;">
	                                		게시물이 없습니다.
	                                	</div>
	                                <%} else { %>
		                                <%
		                                	long count = 0;
		                                	for(int i = 0; i < used_post_no.size(); i++) {
		                                		UsedPostDTO reply_used_post = updao.get(used_post_no.get(i));
		                                		
		                                		if(count != reply_used_post.getPost_no()) {
		                                			count = reply_used_post.getPost_no();
			                                		UsedPostImgDTO uidto = uidao.getMember(reply_used_post.getPost_no());
			                                		AddrDTO used_addr = adao.get(reply_used_post.getAddr_no());
		                                		
		                                %>
			                                    <div class="product">
			                                        <div class="product-inner">
			                                        	<div class="photo">
			                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=reply_used_post.getBoard_no()%>&used_cate_num=<%=reply_used_post.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>&board_no=<%=reply_used_post.getBoard_no()%>"><img src="<%=path%>/board/showImg.do?post_img_no=<%=uidto.getPost_img_no()%>"></a>
			                                        	</div>
			                                        	<div class="product-title">
			                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=reply_used_post.getBoard_no()%>&used_cate_num=<%=reply_used_post.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>&board_no=<%=reply_used_post.getBoard_no()%>"><%=reply_used_post.getPost_title() %>...</a>	
			                                        	</div>
			                                        	<div class="map">
			                                        		<div>
				                                        		<%=used_addr.getAddr_state().substring(0, 2) %>  
				                                        		<%=used_addr.getAddr_city() %>  
				                                        		<%=used_addr.getAddr_base() %>
			                                        		</div>
			                                        	</div>
			                                        	<div class="price-date">
			                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(reply_used_post.getPost_price()) %></div>
			                                        		<div class="date"><%=reply_used_post.getUsedPost_day() %></div>
			                                        	</div>
			                                        	<div class="post-like"><%=reply_used_post.getPost_like() %></div>
			                                        </div>
			                                    </div>
				                                <%if((i+1) % 5 == 0) { %>
				                                	</div><div style="height: 100px; padding: 40px 0px;"><hr></div><div class="mypage-post-list">
				                               	<%} %>
			                               	<%} %>
		                                <%} %>
		                              <%} %>  
		                       		</div>
	                            </div>
                            </div>
                            <div id="2-reply-area" class="area2">
                            	<div class="mypage-board-table">
	                                <div class="mypage-post-list">
			                                <%if(promotion_post_no.isEmpty()) { %>
			                                	<div style="flex: 9; width: 100%; heigth: 90%;">
			                                		게시물이 없습니다.
			                                	</div>
			                                <%} else { %>
				                                <%
				                                	long count2 = 0;
				                                	for(int i = 0; i < promotion_post_no.size(); i++) {
				                                		
				                                		PromotionPostDTO reply_promotion_post = ppdao.get(promotion_post_no.get(i));
				                                		
				                                		if(count2 != reply_promotion_post.getPost_no()) {
				                                			count2 = reply_promotion_post.getPost_no();
				                                			PromotionPostImgDTO ppidto = ppidao.getMember(reply_promotion_post.getPost_no());
				                                			AddrDTO promotion_addr = adao.get(reply_promotion_post.getAddr_no());
				                                		
				                                %>
					                                    <div class="product">
					                                        <div class="product-inner">
					                                        	<div class="photo"><a href="<%=path %>/board/promotion_post_content.jsp?board_no=<%=reply_promotion_post.getBoard_no()%>&promotion_cate_num=<%=reply_promotion_post.getPromotion_cate_num()%>&post_no=<%=reply_promotion_post.getPost_no()%>"><img src="<%=path%>/board/showImg2.do?post_img_no=<%=ppidto.getPost_img_no()%>"></a></div>
					                                        	<div class="product-title"><a href="<%=path %>/board/promotion_post_content.jsp?board_no=<%=reply_promotion_post.getBoard_no()%>&promotion_cate_num=<%=reply_promotion_post.getPromotion_cate_num()%>&post_no=<%=reply_promotion_post.getPost_no()%>"><%=reply_promotion_post.getPost_title() %>...</a></div>
					                                        	<div class="map">
					                                        		<div>
						                                        		<%=promotion_addr.getAddr_state() %>  
						                                        		<%=promotion_addr.getAddr_city() %>  
						                                        		<%=promotion_addr.getAddr_base() %>
					                                        		</div>
					                                        	</div>
					                                        	<div class="price-date">
					                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(reply_promotion_post.getPost_price()) %></div>
					                                        		<div class="date"><%=reply_promotion_post.getPromotionPost_day() %></div>
					                                        	</div>
					                                        	<div class="post-like"><%=reply_promotion_post.getPost_like() %></div>
					                                        </div>
					                                    </div>
					                                <%if((i+1) % 5 == 0) { %>
					                                	</div><div style="height: 100px; padding: 40px 0px;"><hr></div><div class="mypage-post-list">
					                               	<%} %>
				                               	<%} %>
			                                <%} %>
			                              <%} %>  
		                       			</div>
	                            	</div>
	                        	</div>
                            </div>
                        
                        <!-- 찜꽁 -->
                        <div class="area" id="select-4-area">
                        	<div class="empty"></div>
                            <div class="mypage-board-table">
                                <div class="mypage-post-list">
                                <%if(post_like.isEmpty()) { %>
                                	<div style="flex: 9; width: 100%; heigth: 90%;">
                                		게시물이 없습니다.
                                	</div>
                                <%} else { %>
	                                <%
	                                	for(int i = 0; i < post_like.size(); i++) {
	                                		
	                                		UsedPostDTO like = post_like.get(i);
	                                		UsedPostImgDTO uidto = uidao.getMember(like.getPost_no());
	                                		AddrDTO like_addr = adao.get(like.getAddr_no());
	                                		
	                                %>
	                                    <div class="product">
	                                        <div class="product-inner">
	                                        	<div class="photo">
	                                        		<a href="<%=path %>/board/used_post_content.jsp?board_no=<%=like.getBoard_no()%>&used_cate_num=<%=like.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>"><img src="<%=path%>/board/showImg.do?post_img_no=<%=uidto.getPost_img_no()%>"></a>
	                                        	</div>
	                                        	<div class="product-title"><a href="<%=path %>/board/used_post_content.jsp?board_no=<%=like.getBoard_no()%>&used_cate_num=<%=like.getUsed_cate_num()%>&post_no=<%=uidto.getPost_no()%>"><%=like.getPost_title() %>...</a></div>
	                                        	<div class="map">
	                                        		<div>
		                                        		<%=like_addr.getAddr_state() %>  
		                                        		<%=like_addr.getAddr_city() %>  
		                                        		<%=like_addr.getAddr_base() %>
	                                        		</div>
	                                        	</div>
	                                        	<div class="price-date">
	                                        		<div class="price"><%=NumberFormat.getCurrencyInstance(Locale.KOREA).format(like.getPost_price()) %></div>
	                                        		<div class="date"><%=like.getUsedPost_day() %></div>
	                                        	</div>
	                                        	<div class="post-like"><%=like.getPost_like() %></div>
	                                        </div>
	                                    </div>
	                                <%if((i+1) % 5 == 0) { %>
	                                	</div><div style="height: 100px; padding: 40px 0px;"><hr></div><div class="mypage-post-list">
	                               	<%} %>
                                <%} %>
                              <%} %>  
	                       		</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </article>

<jsp:include page="/template/footer.jsp"></jsp:include>
