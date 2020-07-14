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
			
			long post_no = Long.parseLong(request.getParameter("post_no")); 

			UsedPostDAO updao = new UsedPostDAO();
			UsedPostDTO updto = updao.get(post_no);
			
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
			MemberDTO memberinfo = (MemberDTO)session.getAttribute("memberinfo");
			UsedPostDAO updaoo = new UsedPostDAO();
			updaoo.plusViewCount(post_no, 1);
			
			//내글
			boolean isMine= memberinfo.getMember_no() == updto.getMember_no();
			//관리자
			boolean isAdmin= memberinfo.getMember_auth().equals("관리자");
			
			
			////////////////////////////////
			///			댓글 기능			///
			//////////////////////////////
			// 댓글 등록
			
	%>
	
	
<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path %>/css/8.board_content.css" type="text/css" rel="stylesheet">

<article style="padding-top: 220px" id="used-post-content-form">
	<div class="padding50">
		<div class="float-box float-left">
			<div class="left-item40">
				<img src="https://placeimg.com/300/250/tech" width="100%">
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
					<!-- 수정 삭제 버튼은 "내 댓글" 또는 "관리자"인 경우만 표시 -->
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
		<p class="font20 padding15 padding-top40">연관상품<p>
		
		<div class="padding40">
			<div class="float-box float-left">
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/nature">
					<p class="font17">사진1</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/tech" >
					<p class="font17">사진2</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/people" >
					<p class="font17">사진3</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/animals" >
					<p class="font17">사진4</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/architecture" >
					<p class="font17">사진5</p>
				</div>
				<div class="left-item16">
					<img src="https://placeimg.com/150/150/architecture" >
					<p class="font17">사진6</p>
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
						<input type="hidden" name="no" value="<%=mdto.getMember_no() %>">
						<input type="hidden" name="post_no" value="<%=post_no %>">
						<input type="hidden" name="reply_table_name" value="USED_POST_REPLY">
						<input type="hidden" name="reply_seq_name" value="USED_POST_REPLY_SEQ">
						<input type="hidden" name="post_path" value="<%=request.getRequestURI()%>">
						<div class="reply-div-padding">
							<div class="reply-border">
							<textarea class="text-padding" name="reply_content" placeholder="댓글 입력" cols="116" rows="5"></textarea>
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
					<div class="float-box float-left reply-margin20">
						<div class="left-item10">
							<img class="reply-pic-circle" src="<%=path %>/img/manner_sample.jpg">
						</div>
						<div class="right-item90">
							<div class="reply-nick-font">
								<span>닉네임뭐할까</span>
								<span class="right-float gray-font">2분전</span>
							</div>
							<div class="font17 padding-top10">
								가방 구매하고싶은데 팔렸나요?
							</div>	
						</div>
					</div>
					<hr>
									<div class="float-box float-left reply-margin20">
						<div class="left-item10">
							<img class="reply-pic-circle" src="https://placeimg.com/300/250/tech" >
						</div>
						<div class="right-item90">
							<div class="reply-nick-font">
								<span>나는야부자</span>
								<span class="right-float gray-font">5분전</span>
							</div>
							<div class="font17 padding-top10">
								어머머 가방 너무 예쁘네요~^^
							</div>	
						</div>
					</div>
					<hr>
					<div class="float-box float-left reply-margin20">
						<div class="left-item10">
							<img class="reply-pic-circle" src="https://placeimg.com/300/250/tech" >
						</div>
						<div class="right-item90">
							<div class="reply-nick-font">
								<span>욜로롤로</span>
								<span class="right-float gray-font">15분전</span>
							</div>
							<div class="font17 padding-top10">
								아~~~ 사고싶다 ㅜㅜ
							</div>	
						</div>
					</div>
					<hr>
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
							<img class="reply-pic-circle" src="https://placeimg.com/300/250/tech" >
						</div>
						<div class="right-item75">
								<div class="top-margin10 left-font">
									<!-- 작성자 -->
									<%if(updto.getMember_no( ) != 0){ %>
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
