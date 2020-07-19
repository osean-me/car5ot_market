<%@page import="carrot.bean.dto.MannerDTO"%>
<%@page import="carrot.bean.dao.MannerDAO"%>
<%@page import="carrot.bean.dto.RecoPromotionPostDTO"%>
<%@page import="carrot.bean.dao.PromotionPostImgDAO"%>
<%@page import="carrot.bean.dto.PromotionPostImgDTO"%>
<%@page import="carrot.bean.dto.ReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="carrot.bean.dao.ProfileImgDAO"%>
<%@page import="carrot.bean.dao.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="carrot.bean.dto.PromotionBoardDTO"%>
<%@page import="carrot.bean.dao.PromotionBoardDAO"%>
<%@page import="carrot.bean.dto.PromotionPostDTO"%>
<%@page import="carrot.bean.dao.PromotionPostDAO"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="carrot.bean.dto.AddrDTO"%>
<%@page import="carrot.bean.dao.AddrDAO"%>
<%@page import="carrot.bean.dto.PromotionPostDTO"%>
<%@page import="carrot.bean.dao.PromotionPostDAO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dao.PromotionPostDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="carrot.bean.dto.UsedPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
			String path = request.getContextPath();
	
			long post_no = Long.parseLong(request.getParameter("post_no")); 
			long board_no = Long.parseLong(request.getParameter("board_no")); 
			long promotion_cate_num = Long.parseLong(request.getParameter("promotion_cate_num"));
		 
			PromotionPostDAO ppdao = new PromotionPostDAO();
			PromotionPostDTO ppdto = ppdao.get(post_no);
		
			// 현재 날짜 가지고 오기
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss"); 
			
			String sysdate = date.format(cal.getTime()); // 현재 날짜
			String systime = time.format(cal.getTime()); // 현재 시간 
			
/* 			System.out.println(systime) */;
			
			int syshour = (Integer.parseInt(systime.substring(0, 2)) * 60) * 60; // 현재 시 * 60분 
			int sysminute = Integer.parseInt(systime.substring(3, 5)) * 60; // 현재 분 * 60초
			int syssecound = Integer.parseInt(systime.substring(6, 8)); // 현재 초 
			
			// 현재 시간 > 초 단위 변환
			int systime_s = syshour + sysminute + syssecound;
			
/* 			System.out.println("시간 : " + syshour);
			System.out.println("분 : " + sysminute);
			System.out.println("초 : " + syssecound);
			System.out.println("초단위 현재 시간 : " + systime_s); */
			
			//"글작성자 닉네임"을 표시하기 위해 작성자 회원정보가 필요 
			MemberDAO mdao = new MemberDAO();
			MemberDTO mdto = mdao.get(ppdto.getMember_no());
			
			//"카테고리 이름" 뽑아내기위해
			PromotionBoardDAO pbdao = new PromotionBoardDAO();
			PromotionBoardDTO pbdto = pbdao.get(ppdto.getPromotion_cate_num());
			
			//"주소 시군구동" 뽑아내기위해
			AddrDAO addao = new AddrDAO();
			AddrDTO addto = addao.get(ppdto.getAddr_no());
			
			
			/////////게시글 조회수 중복 방지 코드////////////
			Set<Long> memoryP = (Set<Long>)session.getAttribute("memoryP");
			if(memoryP==null){
				memoryP=new HashSet<>();
			}
			boolean isFrist = memoryP.add(post_no);
			session.setAttribute("memoryP", memoryP);
			
			MemberDTO memberinfo = (MemberDTO) session.getAttribute("memberinfo");
			
			if(isFrist){
				ppdao.plusViewCount(post_no, memberinfo.getMember_no());
			}

			
			//내글
			boolean isMine= memberinfo.getMember_no() == ppdto.getMember_no();
			//관리자
			boolean isAdmin= memberinfo.getMember_auth().equals("관리자");
			
			//첨부파일 이미지
			PromotionPostImgDAO ppidao = new PromotionPostImgDAO();
			List<PromotionPostImgDTO>fileList=ppidao.getList(post_no);
			
			
			////////////////////////
			///		댓글 조회		///
			//////////////////////
			// 홍보 거래 게시글 테이블 이름
			String post_table = "PROMOTION_POST";
			// 홍보 거래 댓글 테이블 및 시퀀스
			String reply_table_name = "PROMOTION_POST_REPLY";
			String reply_seq_name = "PROMOTION_POST_REPLY_SEQ";
			
			// 해당 게시글 댓글 존재 여부 확인
			ReplyDAO rdao = new ReplyDAO();
			
			// 프로필 가지고 오기
			ProfileImgDAO pidao = new ProfileImgDAO();
			
			// 매너지수 가지고 오기
			MannerDAO mndao = new MannerDAO();
			MannerDTO mndto = mndao.getMannerCount(ppdto.getMember_no());
	%>
	
	
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript" src="<%=path%>/js/reply.js"></script>
<link href="<%=path %>/css/8.board_content.css" type="text/css" rel="stylesheet">
<link href="<%=path%>/css/swiper.min.css" type="text/css" rel="stylesheet">
    <script src="<%=path%>/js/swiper.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/post_content.js"></script>
    
<input type="hidden" value="<%=memberinfo.getMember_no()%>" id="login-member">
<input type="hidden" value="<%=ppdto.getMember_no() %>" id="post-member">
<article style="padding-top: 220px" id="post-content-form">
		<div class="padding50">
			<div class="float-box float-left">
				
				<div class="left-item40">
				<!-- 이미지 슬라이더 영역 -->
				<div class="swiper-container">
					<!-- 필수 영역 -->
	    		    <div class="swiper-wrapper">		
					<%if(!fileList.isEmpty()){ %>
						<%for(PromotionPostImgDTO ppidto : fileList){ %>
	    		    	<div class="swiper-slide">
							<!-- 이미지 미리보기 -->
								<img class="mainimg" src="showImg2.do?post_img_no=<%=ppidto.getPost_img_no()%>">
					</div>
						<%} %>
					<%} %>
				</div>
							        <!-- 이전/다음 버튼(선택) -->
	        	<div class="swiper-button-prev" ></div>
	       		 <div class="swiper-button-next"></div>
				</div>
	
				</div>
			
				<div class="right-item60 left-font padding-left35">
				<!-- 글 제목 -->
				<div class="font30 padding25">
					<span><%=ppdto.getPost_title() %></span>
				</div>
				<!-- 상품 금액 -->
				<div class="item padding25">
					<!-- 3자리마다 콤마 찍기 -->
					<%long price = ppdto.getPost_price();
					String commaNum = NumberFormat.getInstance().format(price);
					%>
					<span class="font50"><%=commaNum %></span> <span class=font20>원</span>
				</div>
				<div class="item padding25">
					<hr>
				</div>
				<div class="item font17 gray-font padding25">
					<span class="lightgray-font">♥</span> <span class="font15 padding-right05"><%=ppdto.getPost_like() %></span> <span
						class="short-border"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAaCAYAAADMp76xAAAAAXNSR0IArs4c6QAABAdJREFUWAm9mFtIFFEYx9tZ11UW1tLoaoGEPShqq3ahgogyIgnqQXqIgih6qKgEH4JIqCgIIoowIrSn6i0irOxCQdAN7wb2IiSlSUZuGJGyumu/b9lZZo8zs7ObdeBwvvNd/uc/53zznWFcs9Js7e3tczVNWzs1NbUKiErGfJfLNYcxVyCRg8g/GAeZdiC3eTyeN2VlZd/Enm5zpRLY09Pjm5yc3EnMbghUMbpTiYd8BP8X9Dt+v/9uYWHhz1TixdcR4YGBgezh4eFD+J+gz5XAGWijYFzKycm5nArxpIQ5+hqAr9AXzgBJM4ggqXWyvLz8uplR1VkShmgOR3iVo9+jBv2LOWs9pu+H+JAdvilhyC4j6AldxqSNhT7g1Oh2u59mZWV9loDx8fGl4XB4C+IBHrpIdA7ad7C2V1RUvLPynUa4u7s7wIvVQsB8qyCDfgK5jgUaWChs0MdFyLo7OjoOo7hI98QN1sJvsHaB+cDMJYFwV1fXCnblJY5+M2dFN8GOVgcCgWeK3nQKdhXYDzE6IR2GdA2k76lgmq7o7OxcBGAzcydkJazOKVlxjvnWieyguTmZ25y21PiEFt3h/v7+rJGRkddYyhOsFhOe/gMvR6lVGliEzZL0YGPep5DTw16vd2VJScmAjhnd4WAweBaFI7KxwEaVLCQyIHOafB2ULrLo9IVkjMU0GnVJ5PmhUOim0UejIqwGuNaoTCZLNVB9yNFTkUikHqzF0kUWnepnFqv6GOdgbWYDDuo6jaduYOLWFU5Gvgk+qX4A73ei08ue6ms3B/ui3LbiozExLUd2AOxSQnWx850h2+f8/PyQYGksfoRxMhVguRRUf06qyYnOLFaNM87BjdAP0KMbq1Fu2phcMDolk2M3WIIbOGf5JjgD1hfpIosuwYmJWazqo8yvGG++6NH29vZmjo2NPcdxveJsOoXQ/yprXcKpsrLyt04kWtaKi4tDPp9vB0T6dIPdSN4Xxa5bO7dpNomR2GkGEwVchjIyMrYbyYpbwstDGSqkHL0CdJ4Jhqr6l1ezfNhvhGynumj8ahYDOSc7vI7+UeZJmke+DajjR3lAy7IoNvERX/CcfEd8pRBsMCMrfBJ2WCdITi8gpx8xD+g6u1FyGvtff15KSlLjt5aWllpumClhIdfX1+cdHR09D0gtu2TpZ/cgKdqasrOzj/M+/bKLS0qEb4JN5PU1QJbbAaVrY0M+UQKPkY73nWAkJSwgkoe84fsQ6+lLRDcD7Stkz3FV35Aq5RTPEWEdLFavt7HQXnTVPEimbnM4ThDbQtytvLy85oKCgnGHcXG3lAjHoxAogbNJlTWIq6VDQn6k5DLmih+y/EgJMsqPlFaOvZW3/y0v1A+xp9v+ADhPuomDsZuZAAAAAElFTkSuQmCC" width="20" height="13" alt="조회수 아이콘"> <%=ppdto.getPost_view() %></span> 
						<span class="padding-left05"><%=ppdto.getPromotionPost_autotime()%></span> 
						<span class="right-float">☎신고하기</span>
				</div>
				<div class="item font15 padding15">
					<div class="padding15 ">
						<span class="gray-font">&middot; 카테고리</span><span>&emsp;<%=pbdto.getPromotion_cate_title() %></span>
					</div>

					<div class="padding15 padding-top30">
						<span class="gray-font">&middot; 거래지역</span><span
							class="green-font">&emsp;<%=addto.getAddr_state() %> <%=addto.getAddr_city() %> <%=addto.getAddr_base() %></span>
					</div>
				</div>
				<div>
				<div class="float-box float-left">
<%-- 					<%if(ppdto.getMember_no() != memberinfo.getMember_no()) {%>
						<div class="left-item33">
							<form action="<%=path %>/member/post_like.do" method="post">
								<input type="hidden" name="member_no" value="<%=mdto.getMember_no()%>">
								<input type="hidden" name="board_no" value="<%=board_no%>">
								<input type="hidden" name="post_no" value="<%=post_no%>">
								<input type="hidden" name="post_table" value="<%=post_table%>">
								<input type="hidden" name="post_path" value="<%=request.getRequestURI() %>?<%=request.getQueryString() %>">
								<input type="submit" class="like-button cursor" value="♥ 찜 <%=ppdto.getPost_like() %>">
							</form>
						</div>
						<%} %> --%>
					<%if(isAdmin || isMine){ %>
					<!-- 수정 삭제 버튼은 "내글" 또는 "관리자"인 경우만 표시 -->
					<div class="left-item33">
						<a href="promotion_post_content_edit.jsp?post_no=<%=post_no%>"><button class="edit-button cursor">수정</button></a>
					</div>
					<div class="left-item33">
						<a href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/board/promopostdelete.do?post_no=<%=post_no%>"><button class="delete-button cursor">삭제</button></a>
					</div>
					<%} %>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div>
				<p class="font27 padding25 padding-top40 left-font padding-left30 title-label">연관상품 <span class="swiper-pagination left-font" style="z-index:1;"></span><p>
				
				<div class="swiper-container padding40">
					<div class="swiper-wrapper float-box float-left">
						<div class=" swiper-slide left-item16" style="height:180px;">
							<%long recoCount = ppdao.getRecoCount(ppdto.getAddr_no(), ppdto.getPromotion_cate_num()); 
							
								for(int i = 1; i <= recoCount; i++) {  //18대신 count 를 넣어야 함.
									if(ppdao.getRecoList(ppdto.getAddr_no(), ppdto.getPromotion_cate_num(), i) == null) {
										return;
									}									
									RecoPromotionPostDTO rppdto = ppdao.getRecoList(ppdto.getAddr_no(), ppdto.getPromotion_cate_num(), i);						
							%>

								<div class="inline">
									<a href="promotion_post_content.jsp?board_no=<%=board_no%>&promotion_cate_num=<%=promotion_cate_num%>&post_no=<%=rppdto.getPost_no()%>"> <img class="image" src="showImg2.do?post_img_no=<%=rppdto.getImgno()%>"></a>
									<p class="font17 top-margin5 reco"><%=rppdto.getPost_title() %></p>	<!-- 제목출력 -->
								</div>
								<%if(i % 6 == 0&i<18) { %>
									</div><div class="swiper-slide left-item16">
								<%} %>
							<%} %> <!-- 연관상품 마지막 -->
						</div>
					</div>
					<div class="swiper-button-prev" ></div>
	       		 	<div class="swiper-button-next"></div>
				</div>
			</div>
	
	<div class="padding-top100">
		<div class="float-box float-left">
			<div class="left-item66 padding-right30 info-border left-font">
				<div class="padding15">
					<p class="font27">상품정보</p>
				</div>
				<hr>
				<div class="padding-top40 padding40 product-info-border ">
					<p class="font18"><%=ppdto.getPost_content() %></p>
				</div>
				<hr>
				<div class="padding-top40">
					<p class="font27">댓글</p>
					<form action="write_reply.do" method="post">
						<input type="hidden" name="no" value="<%=memberinfo.getMember_no() %>">
						<input type="hidden" name="post_no" value="<%=post_no %>">
						<input type="hidden" name="reply_table_name" value="<%=reply_table_name %>">
						<input type="hidden" name="reply_seq_name" value="<%=reply_seq_name %>">
						<input type="hidden" name="post_path" value="<%=request.getRequestURI()%>?<%=request.getQueryString()%>">
						<div class="reply-div-padding">
							<div class="reply-border">
							<textarea class="text-padding font15" name="reply_content" placeholder="댓글 입력" cols="116" rows="5"></textarea>
							</div>
						</div>
						<div class="reply-num-border">
							<div class="float-box float-left">
								<div class="left-item50">
									<p>　</p>
								</div>
								<div class="left-item50 text-padding10">
									<input type="submit" class="right-float reply-button" value="☜등록">
								</div>
							</div>
						</div>
					</form>
				</div>
				
			<div class="padding-top25 ">
				<%if(rdao.postReply(reply_table_name, post_no) != null) { 

					List<ReplyDTO> list = rdao.postReply(reply_table_name, post_no);
					for(int i=0; i < list.size(); i++) {
						
						ReplyDTO rdto = list.get(i);
						// 현재 시간과 댓글 작성일 계산
						String replyDATE = rdto.getReply_date().substring(11);
						System.out.println(replyDATE);
 						int replyhour = (Integer.parseInt(replyDATE.substring(0, 2)) * 60) * 60;
						int replyminute = Integer.parseInt(replyDATE.substring(3, 5)) * 60;
						int replysecound = Integer.parseInt(replyDATE.substring(6, 8));
						
						int replytime_s = replyhour + replyminute + replysecound;
						
						// 현재 시간과 작성 시간 비교 						
						int compareTime = systime_s - replytime_s; 
						
						MemberDTO replymember;
				%>
					<input type="hidden" value=<%=rdto.getMember_no() %> id="reply-member<%=rdto.getMember_no()%>">
					<div class="float-box float-left reply-margin20">
						<div class="left-item10">
						<!-- 프로필 이미지 영역 -->
							<%if(rdto.getMember_no() != 0) {
									if(pidao.getProfileImgNo(rdto.getMember_no()) != null) { %>
										<img class="reply-pic-circle" src="<%=path %>/member/profile_img_down.do?member_img_no=<%=pidao.getProfileImgNo(rdto.getMember_no())%>">
									<%} else {%>
										<img class="reply-pic-circle" src="<%=path %>/img/user_icon.png">
								<%} %>
							<%} else { %>
									<img class="reply-pic-circle" src="<%=path %>/img/user_icon.png">
							<%} %>		
						</div>
						<div class="right-item90">
							<!-- 프로필 닉네임 / 댓글 내용 영역 -->
							<div class="reply-nick-font">
								<%if(rdto.getMember_no() == 0) { %>						
									<span>탈퇴한 회원</span>
								<%
									} else { 
										replymember = mdao.get(rdto.getMember_no());
								%>
									<label id="reply-member-form" for="<%=rdto.getMember_no()%><%=rdto.getReply_no()%>"><input type="checkbox" id="<%=rdto.getMember_no() %><%=rdto.getReply_no() %>" value="<%=rdto.getMember_no() %>" onchange="viewReplyMemberInfo(this);"><%=replymember.getMember_nick() %></label>
									<div class="info<%=rdto.getMember_no() %><%=rdto.getReply_no() %> reply-tab-design">
										<div><a href="<%=path%>/member/info.jsp?no=<%=replymember.getMember_no()%>">회원 페이지</a></div>
											<form action="<%=path %>/member/manner.do" method="post">
		                                       	<input type="hidden" name="this_member_no" value="<%=replymember.getMember_no()%>"> <!-- 좋아요 누를 회원 -->
		                                   		<input type="hidden" name="push_member_no" value="<%=memberinfo.getMember_no() %>"> <!-- 좋아요를 누른 회원 -->
		                                  		<input type="hidden" name="path" value="<%=request.getRequestURI() %>?<%=request.getQueryString()%>">
		                                  		<input type="hidden" name="good" value="">
		                                   		<input type="submit" value="좋아요" class="submit-button">
	                                   		</form>
											<form action="<%=path %>/member/manner.do" method="post">
		                                  		<input type="hidden" name="this_member_no" value="<%=replymember.getMember_no()%>"> <!-- 싫어요 누를 회원 -->
		                                   		<input type="hidden" name="push_member_no" value="<%=memberinfo.getMember_no() %>"> <!-- 싫어요를 누른 회원 -->
		                                   		<input type="hidden" name="path" value="<%=request.getRequestURI() %>?<%=request.getQueryString()%>">
		                                   		<input type="hidden" name="bad" value="">
		                                   		<input type="submit" value="싫어요" class="submit-button">
	                                   		</form>
										<div><a href="">신고하기</a></div>
									</div>
								<%} %>
									<span class="right-float gray-font">
										<%if(rdto.getReply_date().substring(0, 10).equals(sysdate)) {%>
											<%if(compareTime < 3600) { %>
												<%int replyResult = (compareTime / 60) % 60; %>
												<%=replyResult %> 분 전
											<%} else {%>
												오늘
											<%} %>
										<%} else {%>
											<%=rdto.getReply_date().substring(0, 10) %>
										<%} %>
									</span>
							</div>
							<div class="font17 padding-top10 reply-content-form">
								<div class="reply-content">
									<%if(request.getParameter(String.valueOf(rdto.getReply_no())) != null) { %>
										<form action="edit_reply.do" method="post" id="edit-reply-form">
											<input type="hidden" name="reply_no" value="<%=rdto.getReply_no() %>">
											<input type="hidden" name="reply_table_name" value="<%=reply_table_name %>">
											<input type="hidden" name="post_path" value="<%=request.getRequestURI()%>?board_no=<%=board_no %>&promotion_cate_num=<%=promotion_cate_num %>&post_no=<%=post_no%>">
											<textarea class="font15" name="reply_content" placeholder="<%=rdto.getReply_content()%>"><%=rdto.getReply_content() %></textarea>
											<input type="submit" class="right-float reply-button" value="☜수정">
										</form>
									<%} else {%>
										<%if(rdto.getSuper_no() != 0) { 
											String MotherReply_member = rdao.getMotherReplyNick(reply_table_name, rdto.getSuper_no(), post_no);
										%>
											<span class="mother-reply">@<%=MotherReply_member %> > </span>
										<%} %>
										<%=rdto.getReply_content() %>
								</div>
								<div class="reply-control">
											<div>
												<label for="re-reply<%=i%>">
													<input type="checkbox" id="re-reply<%=i%>" style="display: none;" value="<%=i %>" onchange="reReply(this);">
															답글
												</label>
											</div>
										<%if(memberinfo.getMember_no() == rdto.getMember_no() || memberinfo.getMember_auth().equals("관리자")) { %>
											<div><a href="<%=request.getRequestURI()%>?<%=request.getQueryString()%>&<%=rdto.getReply_no() %>=<%=rdto.getReply_no()%>">수정</a></div>
											<div>
												<form action="delete_reply.do" method="post" id="delete-reply-form">
													<input type="hidden" name="reply_table_name" value="<%=reply_table_name %>">
													<input type="hidden" name="reply_no" value="<%=rdto.getReply_no()%>">
													<input type="hidden" name="post_path" value="<%=request.getRequestURI()%>?<%=request.getQueryString()%>">
													<input type="submit" value="삭제" class="font15">	
												</form>
											</div>
										<%} %>
									<%} %>	
								</div>
							</div>	
						</div>
					</div>
					<div class="padding-top20 rereply-off" id="rereply-form<%=i%>">
					<p class="font20">대댓글</p>
					<form action="write_reply.do" method="post">
						<input type="hidden" name="no" value="<%=memberinfo.getMember_no() %>">
						<input type="hidden" name="reply_no" value="<%=rdto.getReply_no()%>">
						<input type="hidden" name="post_no" value="<%=post_no %>">
						<input type="hidden" name="reply_table_name" value="<%=reply_table_name %>">
						<input type="hidden" name="reply_seq_name" value="<%=reply_seq_name %>">
						<input type="hidden" name="post_path" value="<%=request.getRequestURI()%>?<%=request.getQueryString()%>">
						<div class="reply-div-padding">
							<div class="reply-border">
							<textarea class="text-padding font15" name="reply_content" placeholder="대댓글 입력" cols="116" rows="5"></textarea>
							</div>
						</div>
						<div class="reply-num-border">
							<div class="float-box float-left">
								<div class="left-item50">
									<p class="font12 gray-font text-padding10">30 / 100</p>
								</div>
								<div class="left-item50 text-padding10">
									<input type="submit" class="right-float reply-button" value="☜등록">
								</div>
							</div>
						</div>
					</form>
				</div>
					<%
						boolean lineInsertable = false;
						//뒤의 데이터가 남아있다면 불러온다
						if(i < list.size() - 1){//뒤 데이터가 차수가 0일 때는 라인을 넣는다
							ReplyDTO next = list.get(i+1);
							lineInsertable = next.getDepth() == 0;
						}
						else {//마지막 데이터라면 라인을 넣어
							lineInsertable = true;
						}
						
						
					%>
				
						<%if(lineInsertable) { %>
							<hr>
						<%} %>
					<%} %>
				<%} %>	
				</div>
			</div>
			
			<div class="right-item34  padding-right30 padding-left30 ">
				<div class="padding15 left-font ">
					<p class=" font27">상점정보</p>
				</div>
				<hr>
				<div class="padding-top30">
					<div class="float-box float-left">
						<div class="left-item25  pic-align left-font">
							<%if(ppdto.getMember_no() != 0) { 
									if(pidao.getProfileImgNo(ppdto.getMember_no()) != null) {%>
										<img class="reply-pic-circle" src="<%=path %>/member/profile_img_down.do?member_img_no=<%=pidao.getProfileImgNo(ppdto.getMember_no())%>" >
									<%} else {%>
										<img class="reply-pic-circle" src="<%=path %>/img/user_icon.png" >
									<%} %>	
							<% 	} else { %>
								<img class="reply-pic-circle" src="<%=path %>/img/user_icon.png" >
							<%} %>
						</div>
						<div class="right-item75">
								<div class="top-margin10 left-font">
									<!-- 작성자 -->
									<div>
									<%if(ppdto.getMember_no( ) != 0){ %>
										<div id="member-form">
											<label class="font20" for="member-nick"> <input type="checkbox" id="member-nick" onchange="viewMemberInfo(this);"><%=mdto.getMember_nick() %></label>
											<div class="info-member-nick">
												<div><a href="<%=path%>/member/info.jsp?no=<%=mdto.getMember_no()%>">회원 페이지</a></div>
												<form action="<%=path%>/member/manner.do" method="post">
	                                	       		<input type="hidden" name="this_member_no" value="<%=ppdto.getMember_no()%>"> <!-- 좋아요 누를 회원 -->
	                                	   			<input type="hidden" name="push_member_no" value="<%=memberinfo.getMember_no() %>"> <!-- 좋아요를 누른 회원 -->
	                                		  		<input type="hidden" name="path" value="<%=request.getRequestURI() %>?<%=request.getQueryString()%>">
	                                  				<input type="hidden" name="good" value="">
	                                  	 			<input type="submit" value="좋아요" class="submit-button">
                                   				</form>
												<form action="<%=path%>/member/manner.do" method="post">
	                                	  			<input type="hidden" name="this_member_no" value="<%=ppdto.getMember_no()%>"> <!-- 좋아요 누를 회원 -->
	                                	   			<input type="hidden" name="push_member_no" value="<%=memberinfo.getMember_no() %>"> <!-- 좋아요를 누른 회원 -->
	                                	   			<input type="hidden" name="path" value="<%=request.getRequestURI() %>?<%=request.getQueryString()%>">
	                                	   			<input type="hidden" name="bad" value="">
	                                	   			<input type="submit" value="싫어요" class="submit-button">
                                   				</form>
												<div><a href="">신고하기</a></div>
											</div>
										</div>
									<%} else{%>
											<p class="gray-font font20">탈퇴한 회원</p>
									<%} %>
									</div>
									<div class="dimgray-font">
										<span>☎</span>
										<span><%=ppdto.getPost_phone() %></span>
									</div>
								</div>

						</div>
					</div>
					
				</div>
					<div class="left-font manner-margin ">
						<p class="manner-color">매너지수</p>
						<input type="range" value="<%=mndto.getManner_count() %>" style="width: 100%; position: relative; z-index: -1;">
					</div>
			</div>
			
		</div>
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>
