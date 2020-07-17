<%@page import="carrot.bean.dao.AddrDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="carrot.bean.dto.DetailList3DTO"%>
<%@page import="carrot.bean.dto.BoardDTO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="carrot.bean.dto.AddrDTO"%>
<%@page import="carrot.bean.dto.UsedPostDTO"%>
<%@page import="java.util.List"%>
<%@page import="carrot.bean.dao.UsedPostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	UsedPostDAO updao = new UsedPostDAO();
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = (MemberDTO) session.getAttribute("memberinfo"); // 회원번호 불러오기
	

	// 시간 출력 수정 
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss");

	String sysdate = date.format(cal.getTime()); // 현재 날짜
	String systime = time.format(cal.getTime()); // 현재 시간 

	int syshour = (Integer.parseInt(systime.substring(0, 2)) * 60) * 60; // 현재 시 * 60분 
	int sysminute = Integer.parseInt(systime.substring(3, 5)) * 60; // 현재 분 * 60초
	int syssecound = Integer.parseInt(systime.substring(6, 8)); // 현재 초 

	// 현재 시간 > 초 단위 변환
	int systime_s = syshour + sysminute + syssecound;
	
	//검색인지 목록인지 검사 
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	
	boolean isSearch = type != null && keyword !=null;
	
	// 페이지 계산 코드 
	int pageSize=12; // 한 페이지에 16개의 데이터를 표시하겠다 
	
	String pageStr = request.getParameter("page");
	int pageNo;
	
	try {
		pageNo = Integer.parseInt(pageStr);
		if(pageNo <= 0){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageNo = 1;
	}
	
	int finish = pageNo * pageSize;
	int start = finish - (pageSize-1);

	// 페이지 네비게이터 계산 코드 
	int blockSize = 10; // 네비게이터 블록을 10개씩 배치하겠다 ! 
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int finishBlock = startBlock + blockSize - 1;
	

	int count; // 페이지 개수 출력하기 위함
	int pageCount;
	int searchCount;
	
	List<DetailList3DTO> list;
	
	if(mdto!=null){ // 회원인 경우(로그인이 되어있는 경우)
		MemberDTO member = mdao.get(mdto.getMember_no());
		
		AddrDAO adao = new AddrDAO();
		AddrDTO adto = adao.get(member.getMember_addr_no());
		
		
		if(isSearch){
			count = updao.getCount(type,keyword,member.getMember_addr_no());
			list = updao.getAreaList(type,keyword,start,finish,member.getMember_addr_no()); // (지역 상관O)지역 검색목록 출력 			
			
		}else {
			count = updao.getCount(member.getMember_addr_no());
			list = updao.getAreaList(start,finish,member.getMember_addr_no()); // (지역 상관O)지역 전체목록 출력 
		}
		//(** 다음 버튼의 경우 계산을 총하여 페이지 개수를 구해야 출력 여부 판단이 가능)
		pageCount = (count + pageSize - 1) / pageSize;
	 	if(finishBlock > pageCount){
	 		finishBlock = pageCount;
	 	}
	 	searchCount=count;
	} 
	else { // 비회원인 경우	
		if(isSearch){
			count = updao.getCount(type,keyword);
			list = updao.getList(type,keyword,start,finish); // (지역 상관X)검색목록
		}else {
			count = updao.getCount();
			list = updao.getList(start,finish); // (지역 상관X)전체목록
		}
		//(** 다음 버튼의 경우 계산을 총하여 페이지 개수를 구해야 출력 여부 판단이 가능)
		pageCount = (count + pageSize - 1) / pageSize;
	 	if(finishBlock > pageCount){
	 		finishBlock = pageCount;
	 	}
	 	searchCount=count;
	}
 	
	String path = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path%>/css/10.promotion&used_post_list.css"
	type="text/css" rel="stylesheet">


<article style="padding-top: 200px; margin: 0px 20%">

	<div align="left">
		<h2 style="font-size: 30px; margin: 15px;">
			<%if(!isSearch) { %>
			<span style="color: orange">중고거래</span> 상품목록
			<%} else { %>
			<span style="color: orange"><%=keyword %></span>의 검색결과
			<%} %>
		</h2>

		</div>
		<hr class="hr_style1">	
	</div>
	
<!-- 	검색어가 없는경우 -->
	<%if(count==0){%>
	<div align="center">
		<div class="noSearch"><span style="color: orange; font-size:30px;"><%=keyword %></span><br>
		에 대한 검색결과가 없습니다.</div>
		<hr class="search">
		<div class = "searchContent">
		- 단어의 철자가 정확한지 확인해 보세요<br>
		- 보다 일반적인 검색어로 다시 검색해 보세요<br>
		- 검색어의 띄어쓰기를 다르게 해보세요<br>
		- 유해/금지어가 아닌지 확인해주세요<br>	
		</div>	
	</div>
	<%} %>
	
	<div align="left">
		<div class="box">
			<div class=detail>
				<%
					for (DetailList3DTO dldto : list) {
				%>
				<div class="product">
						<!-- 이미지 등록 -->
						<div class="product_photo">
							<a class="move" href="used_post_content.jsp?board_no=<%=dldto.getBoard_no()%>&used_cate_num=<%=dldto.getUsed_cate_num()%>&post_no=<%=dldto.getPost_no()%>"><img src="showImg.do?post_img_no=<%=dldto.getPost_img_no()%>"></a>
						</div> 
						<!-- 게시글 제목 -->
							<div class="product_title">
							<div class="hideText">
								<a class="move" href="used_post_content.jsp?board_no=<%=dldto.getBoard_no()%>&used_cate_num=<%=dldto.getUsed_cate_num()%>&post_no=<%=dldto.getPost_no()%>"><%=dldto.getPost_title()%></a>
							</div>
						</div>
					<!-- 지역 등록 -->
					<div class="post_location">
						<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAiCAYAAABIiGl0AAAAAXNSR0IArs4c6QAAA6xJREFUWAm1l01IVFEUx51xNAtxIcEENuQIrqTxO8OEmj5IAncVUS2E2kS0axO4C5KiFi0lXIh9QBC1kKgwclNGjaNOSUEapVRiUSHoTOo4/c743vjem/vGp8xcuHPu+Z//Of9778y9740rz0EbGxsrjsViQait9JpEIuF1uVzbGCfo0/jT2GGwx6WlpQN+vz+Gn7G5MkXD4fAOil6C047dlImrxxCfg9tVUFBwtbq6ekbHrVYpzAoLo9FoJ+QL9AJrkkN/3u12d9bW1l5hMsvWnDTh4eHh8uXl5fvMutFK3qD/jLxTDQ0Nv4z5JuHR0VH/4uLiKwjy/WWtseJPLKTZKO7Wq4dCoa1LS0tP8bMqKvURrcT0TU1NbRZfWkqYWXVrhJVI9j+bZmZmbuplk1s9NDR0GNEnOpgrKz8ydBrZ8rBHRHCur0MsCvc1Pazl1GF301PbqOFpBh3Z4Rv0oIvVBgBG01hqYKCwsPBMIBD4bAxHIpGKhYWFbrB9RtxuzDEr9yB6zI5gwV/U19cfYLvktjI1mQh19rOI5wSCpqDC4bgelaXvUcRMEGJzAO0qUZ2oxdrx53XMzsI9KMJldgQDPsgPYtLgK4fCoeigMmgA2R2fCG83YMohxCFlQAHCDSlgE8Tkytx8yDZmbHCKMxIMQSdcJueWFU8Y8pRDiA3KgAJ0yJ1wJMwqGrlSWxQ6Jkg4wjWBamfCzQzfqmOrqGwNXo/c56uoeaTFejSuOWjxmNx7KXiHwYIlpnIr4I1xVo9TPF8nyFgwiYFV6LidhZfgJaFXv6vvUeCEHVmBy7UZ0fAAds3rUq+BcD8X0SFZcR5XWJcecGhFqEnrjkW12rfEJoV5PRlgJg+1QM4MGqG6uroHKWEZsNXnCfzNmWpe3iL1z9LjJmGuux+AF3MlTO1rrDb1FExutS5GQB5tj3Q/WxbRSElJyWVjPZOwBLxe70mI8sKXrTaZn59/pLKy8p+xYJqwz+eLFhUVtUH6aCRuZMwC/tBba2pqvlnz04SFUFVV9Zsj1krSd2vCOvwYNdo4sx9UOUphIfJ9f8XsRXxclbgGNiuiHNOXdjxbYUlgtuMINzN8Y1dAgU+BtTDxfkUsBWUUFhYFfmKCTKAvlWU/kDfPJo7mO3vKSiR5V69Fkrg8DPj32IHtwE2+FhvzmFivx+M5xz/ENV8sJM+xsC4yMjKyKx6P32YC8rdE2iz9HKu8m/QcfqxbWOry7N2CkRfznZzR0/yIvjBeV/sPFdozA8TD8zUAAAAASUVORK5CYII="
							width="15" height="17" alt="위치 아이콘">
						<%=dldto.getAddr_state()%>
						<%=dldto.getAddr_city()%>
						<%=dldto.getAddr_base()%>
					</div>
					<!-- 게시글 가격 -->
					<div class="product_info">
						<div class="product_price">
							<%
								long price = dldto.getPost_price();
									String commaNum = NumberFormat.getInstance().format(price);
							%>
							<%=commaNum%>원
							<!-- 게시글 등록 시간 -->
							<%
									String used_post_date=dldto.getPost_date().substring(11);
								
									int posthour = Integer.parseInt(used_post_date.substring(0, 2)) * 60;
									int postminute = Integer.parseInt(used_post_date.substring(3, 5)) * 60;
									int postsecound = Integer.parseInt(used_post_date.substring(6, 8));
									
									int posttime_s = posthour + postminute + postsecound;
									
									int compareTime = systime_s - posttime_s; 																	
								%>
								<div class="product_time">
									<span>
										<%if(dldto.getPost_date().substring(0, 10).equals(sysdate)) {%>
											<%if(compareTime < 3600) { %>
												<%int postResult = (compareTime / 60) % 60; %>
												<%=postResult %> 분 전
											<%} else {%>
												오늘
											<%} %>
										<%} else {%>
											<%=dldto.getPost_date().substring(0, 10) %>
										<%} %>
									</span>  
								</div>
						</div>
						<hr class="hr_style">
						<div class="product_like">
							♥	<%=dldto.getPost_like()%> &nbsp;
							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAaCAYAAADMp76xAAAAAXNSR0IArs4c6QAABAdJREFUWAm9mFtIFFEYx9tZ11UW1tLoaoGEPShqq3ahgogyIgnqQXqIgih6qKgEH4JIqCgIIoowIrSn6i0irOxCQdAN7wb2IiSlSUZuGJGyumu/b9lZZo8zs7ObdeBwvvNd/uc/53zznWFcs9Js7e3tczVNWzs1NbUKiErGfJfLNYcxVyCRg8g/GAeZdiC3eTyeN2VlZd/Enm5zpRLY09Pjm5yc3EnMbghUMbpTiYd8BP8X9Dt+v/9uYWHhz1TixdcR4YGBgezh4eFD+J+gz5XAGWijYFzKycm5nArxpIQ5+hqAr9AXzgBJM4ggqXWyvLz8uplR1VkShmgOR3iVo9+jBv2LOWs9pu+H+JAdvilhyC4j6AldxqSNhT7g1Oh2u59mZWV9loDx8fGl4XB4C+IBHrpIdA7ad7C2V1RUvLPynUa4u7s7wIvVQsB8qyCDfgK5jgUaWChs0MdFyLo7OjoOo7hI98QN1sJvsHaB+cDMJYFwV1fXCnblJY5+M2dFN8GOVgcCgWeK3nQKdhXYDzE6IR2GdA2k76lgmq7o7OxcBGAzcydkJazOKVlxjvnWieyguTmZ25y21PiEFt3h/v7+rJGRkddYyhOsFhOe/gMvR6lVGliEzZL0YGPep5DTw16vd2VJScmAjhnd4WAweBaFI7KxwEaVLCQyIHOafB2ULrLo9IVkjMU0GnVJ5PmhUOim0UejIqwGuNaoTCZLNVB9yNFTkUikHqzF0kUWnepnFqv6GOdgbWYDDuo6jaduYOLWFU5Gvgk+qX4A73ei08ue6ms3B/ui3LbiozExLUd2AOxSQnWx850h2+f8/PyQYGksfoRxMhVguRRUf06qyYnOLFaNM87BjdAP0KMbq1Fu2phcMDolk2M3WIIbOGf5JjgD1hfpIosuwYmJWazqo8yvGG++6NH29vZmjo2NPcdxveJsOoXQ/yprXcKpsrLyt04kWtaKi4tDPp9vB0T6dIPdSN4Xxa5bO7dpNomR2GkGEwVchjIyMrYbyYpbwstDGSqkHL0CdJ4Jhqr6l1ezfNhvhGynumj8ahYDOSc7vI7+UeZJmke+DajjR3lAy7IoNvERX/CcfEd8pRBsMCMrfBJ2WCdITi8gpx8xD+g6u1FyGvtff15KSlLjt5aWllpumClhIdfX1+cdHR09D0gtu2TpZ/cgKdqasrOzj/M+/bKLS0qEb4JN5PU1QJbbAaVrY0M+UQKPkY73nWAkJSwgkoe84fsQ6+lLRDcD7Stkz3FV35Aq5RTPEWEdLFavt7HQXnTVPEimbnM4ThDbQtytvLy85oKCgnGHcXG3lAjHoxAogbNJlTWIq6VDQn6k5DLmih+y/EgJMsqPlFaOvZW3/y0v1A+xp9v+ADhPuomDsZuZAAAAAElFTkSuQmCC" 
								width="17" height="12" alt="상품 상태 아이콘"> <%=dldto.getPost_view()%>  
						</div>
					</div>

				</div>
				<%
					}
				%>

			</div>
			<div style="clear: both;"></div>
			
			
			<!--  페이지 네비게이터  -->
			<div class="row center pagination">
				<%if(startBlock > 1){ %>
					<%if(!isSearch) { %>
						<a href = "used_all_post_list.jsp?page=<%=startBlock-1%>">&lt;</a>
					<%} else { %>
						<a href = "used_all_post_list.jsp?page=<%=startBlock-1%>&type=<%=type%>&keyword=<%=keyword%>">&lt;</a>
					<%} %>
				<%} %>
				
				<!-- 
					이동 숫자에 반복문을 적용 
					범위는 startBlock부터 finishBlock까지로 설정(상단에서 계산을 미리 해두었음)
				-->
				<%for(int i=startBlock; i<=finishBlock; i++) { %>
					<%
						String prop;
						if(i==pageNo) { //현재 페이지 번호면
							prop = "class='on'";
						}
						else { // 현재 페이지가 아니면
							prop="";
						}
					%>
					
					<% if(!isSearch) {%> <!-- 목록이면 -->
							<a href="used_all_post_list.jsp?page=<%=i%>" <%=prop%>><%=i %></a>
					<%} 
						else { %> <!-- 검색이면 -->
							<a href = "used_all_post_list.jsp?page=<%=i%>&type=<%=type%>&keyword=<%=keyword%>" <%=prop%>><%=i %></a>
					<%} %>	
				<%} %>
				
				<%if(pageCount > finishBlock){ %>
					<%if(!isSearch){ %> <!-- 목록이면 -->
						<a href="used_all_post_list.jsp?page=<%=finishBlock + 1%>">&gt;</a>
					<%}else{ %> <!-- 검색이면 -->
						<a href="used_all_post_list.jsp?page=<%=finishBlock + 1%>&type=<%=type%>&keyword=<%=keyword%>">&gt;</a>
					<%} %>
				<%} %>
			</div>
		</div>
	</div>
</article>


<jsp:include page="/template/footer.jsp"></jsp:include>

