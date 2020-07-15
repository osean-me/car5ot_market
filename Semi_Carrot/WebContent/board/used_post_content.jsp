<%@page import="carrot.bean.dto.ReplyDTO"%>
<%@page import="carrot.bean.dao.ReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="carrot.bean.dto.UsedPostImgDTO"%>
<%@page import="java.util.List"%>
<%@page import="carrot.bean.dao.UsedPostImgDAO"%>
<%@page import="carrot.bean.dto.ProfileImgDTO"%>
<%@page import="carrot.bean.dao.ProfileImgDAO"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="carrot.bean.dto.AddrDTO"%>
<%@page import="carrot.bean.dao.AddrDAO"%>
<%@page import="carrot.bean.dto.UsedBoardDTO"%>
<%@page import="carrot.bean.dao.UsedBoardDAO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dao.UsedPostDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="carrot.bean.dto.UsedPostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		String path = request.getContextPath();
	
			MemberDTO login = (MemberDTO) session.getAttribute("memberinfo");
			long login_member = login.getMember_no();
	
			long post_no = Long.parseLong(request.getParameter("post_no")); 
	        //long board_no = Long.parseLong(request.getParameter("board_no")); 
	        //long used_cate_num = Long.parseLong(request.getParameter("used_cate_num")); 
	         
			UsedPostDAO updao = new UsedPostDAO();
			UsedPostDTO updto = updao.get(post_no);
			
			// 현재 날짜 가지고 오기
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss"); 
			
			String sysdate = date.format(cal.getTime()); // 현재 날짜
			String systime = time.format(cal.getTime()); // 현재 시간 
			
			System.out.println(systime);
			
			int syshour = Integer.parseInt(systime.substring(0, 2)) * 60; // 현재 시 * 60분 
			int sysminute = Integer.parseInt(systime.substring(3, 5)) * 60; // 현재 분 * 60초
			int syssecound = Integer.parseInt(systime.substring(6, 8)); // 현재 초 
			
			// 현재 시간 > 초 단위 변환
			int systime_s = syshour + sysminute + syssecound;
			
			System.out.println("시간 : " + syshour);
			System.out.println("분 : " + sysminute);
			System.out.println("초 : " + syssecound);
			System.out.println("초단위 현재 시간 : " + systime_s);
			
			//"글작성자 닉네임"을 표시하기 위해 작성자 회원정보가 필요 
			MemberDAO mdao = new MemberDAO();
			MemberDTO mdto = mdao.get(updto.getMember_no());

			//"카테고리 이름" 뽑아내기위해
			UsedBoardDAO ubdao = new UsedBoardDAO();
			UsedBoardDTO ubdto = ubdao.get(updto.getUsed_cate_num());

			//"주소 시군구동" 뽑아내기위해
			AddrDAO addao = new AddrDAO();
			AddrDTO addto = addao.get(updto.getAddr_no());

			//게시글 조회수 중복 방지 코드 만들어야함 ★★★★★★
			MemberDTO memberinfo = (MemberDTO) session.getAttribute("memberinfo");
			UsedPostDAO updaoo = new UsedPostDAO();
			updaoo.plusViewCount(post_no, 1);

			//내글
			boolean isMine = memberinfo.getMember_no() == updto.getMember_no();
			//관리자
			boolean isAdmin = memberinfo.getMember_auth().equals("관리자");
			
			//첨부파일 이미지
			UsedPostImgDAO upidao = new UsedPostImgDAO();
			List<UsedPostImgDTO>fileList=upidao.getList(post_no);

			////////////////////////
			///		댓글 조회		///
			//////////////////////

			// 중고 거래 댓글 테이블 및 시퀀스
			String reply_table_name = "USED_POST_REPLY";
			String reply_seq_name = "USED_POST_REPLY_SEQ";

			// 해당 게시글 댓글 존재 여부 확인
			ReplyDAO rdao = new ReplyDAO();
			
			// 프로필 가지고 오기
			ProfileImgDAO pidao = new ProfileImgDAO();
	%>
	
	
<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path %>/css/8.board_content.css" type="text/css" rel="stylesheet">
<link href="<%=path%>/css/swiper.min.css" type="text/css" rel="stylesheet">
    <style>
        .swiper-container {
            width: 100%;
            height: 100%;
        }
        .swiper-container .swiper-slide,
        .swiper-container .swiper-slide > img{
            width:100%;
            min-height: 380px;
            height: auto;
            max-height: 380px;
        }
        
    </style>
<script src="<%=path%>/js/swiper.min.js"></script>
    <script>
        //창의 로딩이 완료되었을 때 실행할 코드를 예약
        window.onload = function(){
            //var mySwiper = new Swiper(선택자, 옵션);
            var mySwiper = new Swiper ('.swiper-container', {
                //swiper에 적용할 옵션들을 작성
                
                direction: 'horizontal'   //표시방식(수직:vertical, 수평:horizontal)
                ,loop: false //순환 모드 여부
                

                //페이지 네비게이터 옵션그룹
                ,pagination: {
                    el: '.swiper-pagination', //적용 대상의 선택자
                    type: 'bullets',//네비게이터 모양(bullets/fraction/...)
                },
                
                // auto
                autoplay: {
        			delay: 3000,
        		},

                //이전/다음 이동버튼 설정그룹
              navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                }

                //커서 모양을 손모양으로 변경
                ,grabCursor:true
                
                //슬라이드 전환 효과(effect)
                //,effect:'coverflow'
                //,effect:'cube'
                //,effect:'fade'
                //,effect:'flip'
                ,effect:'slide'//기본값
            });
        };
    </script>


<article style="padding-top: 220px" id="post-content-form">
	<div class="padding50">
		<div class="float-box float-left">
			
			<div class="left-item40">
			<!-- 이미지 슬라이더 영역 -->
			<div class="swiper-container">
				<!-- 필수 영역 -->
    		    <div class="swiper-wrapper">		
				<%if(!fileList.isEmpty()){ %>
					<%for(UsedPostImgDTO upidto : fileList){ %>
    		    	<div class="swiper-slide">
						<!-- 이미지 미리보기 -->
							<img src="showImg.do?post_img_no=<%=upidto.getPost_img_no()%>">
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
				<div class="font23 padding25">
					<span><%=updto.getPost_title() %></span>
				</div>
				<!-- 상품 금액 -->
				<div class="item padding25">
					<!-- 3자리마다 콤마 찍기 -->
					<%long price = updto.getPost_price();
					String commaNum = NumberFormat.getInstance().format(price);
					%>
					<span class="font45"><%=commaNum %></span> <span class=font20>원</span>
				</div>
				<div class="item padding25">
					<hr>
				</div>
				<div class="item font17 gray-font padding25">
					<span class="padding-right05">♥ <%=updto.getPost_like() %></span> <span
						class="short-border">조회수 <%=updto.getPost_view() %></span> 
						<span class="padding-left05"><%=updto.getUsedPost_autotime()%></span> 
						<span class="right-float">☎신고하기</span>
				</div>
				<div class="item font15 padding15">
					<div class="padding15">
						<span class="gray-font">&middot; 카테고리</span><span>&emsp;<%=ubdto.getUsed_cate_title() %></span>
					</div>
					<div class="padding15">
						<span class="gray-font">&middot; 상품상태</span><span
							class="purple-font">&emsp;<%=updto.getPost_state() %></span>
					</div>
					<div class="padding15">
						<span class="gray-font">&middot; 거래지역</span><span
							class="green-font">&emsp;<%=addto.getAddr_state() %> <%=addto.getAddr_city() %> <%=addto.getAddr_base() %></span>
					</div>
				</div>
				<div>
				<div class="float-box float-left">
					<div class="left-item33">
						<button class="like-button cursor">♥ 찜 <%=updto.getPost_like() %></button>
					</div>
					<%if(isAdmin || isMine){ %>
					<!-- 수정 삭제 버튼은 "내글" 또는 "관리자"인 경우만 표시 -->
					<div class="left-item33">
						<a href="used_post_edit.jsp?post_no=<%=post_no%>"></a>
						<a href="used_post_content_edit.jsp?post_no=<%=post_no%>"><button class="edit-button cursor">수정</button></a>
					</div>
					<div class="left-item33">
						<a href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/board/usedpostdelete.do?post_no=<%=post_no%>"><button class="delete-button cursor">삭제</button></a>
					</div>
					<%} %>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div>
		<p class="font20 padding25 padding-top40 left-font padding-left30">연관상품<p>
		
		<div class="padding40">
			<div class="float-box float-left">
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/nature">
					<p class="font17 top-margin10">.....></p>	<!-- 제목출력 -->
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/tech" >
					<p class="font17 top-margin10">사진2</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/people" >
					<p class="font17 top-margin10">사진3</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/animals" >
					<p class="font17 top-margin10">사진4</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/architecture" >
					<p class="font17 top-margin10">사진5</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/architecture" >
					<p class="font17 top-margin10">사진6</p>
				</div>
			</div>
		</div>
	</div>
	
		<div class="padding-top50">
		<div class="float-box float-left">
			<div class="left-item66 padding-right30 info-border left-font">
				<div class="padding15">
					<p class="font23">상품정보</p>
				</div>
				<hr>
				<div class="padding-top40 padding40 product-info-border ">
					<p class="font18"><%=updto.getPost_content() %></p>
				</div>
				<hr>
				<div class="padding-top40">
					<p class="font20">댓글</p>
					<form action="write_reply.do" method="post">
						<input type="hidden" name="no" value="<%=login_member %>">
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
									<p class="font12 gray-font text-padding10">30 / 100</p>
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
 						int replyhour = Integer.parseInt(replyDATE.substring(0, 2)) * 60;
						int replyminute = Integer.parseInt(replyDATE.substring(3, 5)) * 60;
						int replysecound = Integer.parseInt(replyDATE.substring(6, 8));
						
						int replytime_s = replyhour + replyminute + replysecound;
						
						// 현재 시간과 작성 시간 비교 						
						int compareTime = systime_s - replytime_s; 
						
						MemberDTO replymember;
				%>
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

									<span><%=replymember.getMember_nick() %></span>
								<%} %>
								<%if((compareTime > 60 || compareTime < 0)) { %>
									<span class="right-float gray-font">
										<%if(rdto.getReply_date().substring(0, 10).equals(sysdate)) { %>
											오늘
										<%} else { %>
											<%=rdto.getReply_date().substring(0, 10) %>
										<%} %>
									</span>
								<%
									} else { 
										System.out.println(compareTime);
										int miniute = compareTime/60;
										int hour = miniute/60;
										int replyResult = miniute-(hour*60);
								%>
									<span class="right-float gray-font"><%=replyResult %> 분 전</span>
								<%} %>
							</div>
							<div class="font17 padding-top10 reply-content-form">
								<div class="reply-content">
									<%if(request.getParameter(String.valueOf(rdto.getReply_no())) != null) { %>
										<form action="edit_reply.do" method="post" id="edit-reply-form">
											<input type="hidden" name="reply_no" value="<%=rdto.getReply_no() %>">
											<input type="hidden" name="reply_table_name" value="<%=reply_table_name %>">
											<input type="hidden" name="post_path" value="<%=request.getRequestURI()%>?post_no=<%=rdto.getPost_no()%>">
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
										<%if(login_member == rdto.getMember_no() || login.getMember_auth().equals("관리자")) { %>
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
						<input type="hidden" name="no" value="<%=login_member %>">
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
				<div class="padding15 left-font">
					<p class=" font23">상점정보</p>
				</div>
				<hr>
				<div class="padding-top30">
					<div class="float-box float-left">
						<div class="left-item25  pic-align left-font">
							<%if(updto.getMember_no() != 0) { 
									if(pidao.getProfileImgNo(updto.getMember_no()) != null) {%>
										<img class="reply-pic-circle" src="<%=path %>/member/profile_img_down.do?member_img_no=<%=pidao.getProfileImgNo(updto.getMember_no())%>" >
									<%} else {%>
										<img class="reply-pic-circle" src="<%=path %>/img/user_icon.png" >
									<%} %>
							<% 	} else { %>
								<img class="reply-pic-circle" src="<%=path %>/img/user_icon.png" >
							<%} %>
						</div>
						<div class="right-item75">
								<div class="top-margin10 left-font seller">
									<!-- 작성자 -->
									<%if(updto.getMember_no() != 0){ %>
										<p class="font20"> <%=mdto.getMember_nick() %></p>
									<%} else{%>
											<p class="gray-font font20">탈퇴한 회원</p>
									<%} %>
								</div>

						</div>
					</div>
			
				</div>
					<div class="left-font manner-margin ">
						<img src="<%=path %>/img/manner_sample.jpg" width="200" height="50">
					</div>
			</div>
			
		</div>
	</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>
