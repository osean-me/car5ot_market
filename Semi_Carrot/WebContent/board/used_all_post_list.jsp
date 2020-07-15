<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="carrot.bean.dto.DetailList3DTO"%>
<%@page import="carrot.bean.dto.BoardDTO"%>
<%@page import="carrot.bean.dto.DetailListDTO"%>
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

	List<DetailList3DTO> list = updao.getList3(); //전체목록
	
	// 시간 출력 수정 
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat time = new SimpleDateFormat("HH:mm:ss"); 
	
	String sysdate = date.format(cal.getTime()); // 현재 날짜
	String systime = time.format(cal.getTime()); // 현재 시간 
	
	int syshour = Integer.parseInt(systime.substring(0, 2)) * 60; // 현재 시 * 60분 
	int sysminute = Integer.parseInt(systime.substring(3, 5)) * 60; // 현재 분 * 60초
	int syssecound = Integer.parseInt(systime.substring(6, 8)); // 현재 초 
	
	// 현재 시간 > 초 단위 변환
	int systime_s = syshour + sysminute + syssecound;

	String path = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path %>/css/10.promotion&used_post_list.css" type="text/css" rel="stylesheet">


<article style="padding-top: 200px; margin: 0px 20%">

	<div align="left">
		<h2 style="font-size: 30px; margin: 15px;">
			<span style="color: orange">중고거래</span> 상품목록
		</h2>
		<div class="sort_list" align="right">
			<div class="popular">
				<a href="">인기순</a>
			</div>

			<div class="last">
				<a href="">최신순</a>
			</div>
		</div>
		<hr class="hr_style1">
	</div>

	<div align="left">
		<div class="box">
			<div class=detail>
				<%
					for (DetailList3DTO dldto : list) {
				%>
				<div class="product">

					<a class="move"
						href="used_post_content.jsp?board_no=<%=dldto.getBoard_no()%>&used_cate_num=<%=dldto.getUsed_cate_num()%>&post_no=<%=dldto.getPost_no()%>">
						
						<!-- 이미지 등록 -->
						<div class="product_photo">
							<img src="showImg.do?post_img_no=<%=dldto.getPost_img_no()%>">
						</div>
						<!-- 게시글 제목 -->
						<div class="product_title">
							<div class="hideText">
								<font color="black"><%=dldto.getPost_title()%>
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
								<%if((compareTime > 60 || compareTime < 0)) { %>
									<span>
									<%if(dldto.getPost_date().substring(0, 10).equals(sysdate)) { %>
										오늘
									<%} else { %>
										<%=dldto.getPost_date().substring(0, 10) %>
									<%} %>
									</span>
								<%
									}else { 
										int miniute = compareTime/60;
										int hour = miniute/60;
										int postResult = miniute-(hour*60);
								%>
									<span><%=postResult %>분전</span>
									<%} %>
								</div>
							</div>
							<hr class="hr_style">
							<div class="product_like">
								<img
									src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAjhJREFUWAnFl1uPKUEUhbdCxF2Iu7h78f9/ixdexANeSNxCkJnz1ZwSRncrM0OvhK6ufVmrdiu1O/DxD/INq9VKFouFbDYbOR6PEggEJBKJSDqdlkKhIKFQ6FvE1+3pdJL5fC7EHw4HIXU4HJZEIiHZbFZSqdRdXOBaAEHj8VjW6/Wdo5kIBoNSLBalVCppYcxDNJvNNPn5fDaud9dkMimNRkMvxhgvAna7nQyHQ2EVNmBV3W5Xu45GI10tmziq1+v1JBaLaXctANLBYKDLbZPE+MTjcT3cbrdmyurKY+n3+/pRKiImk8nT5MRB/Cw5cfyu4ARqv9/LcrnUN+/8ghNuxcBhI7xcC5xwK7aMX4BbsfX8AtzKa9++Whjcij8WvwC3Yk/6BbiV+TPxQwTcKpPJ+MGtOeFWHBB+PAY44VYctZxu7waccOuzIJ/Pv7UKrB5OoAUopfQ5/a4q0BPAeRHAgG4nl8vpyVd+wQGXwZeM/3f1el2i0aix/fmV3HBc40YAZel0Oq4933Xgs2M6IXKb0pv4GwFM0ny22+1Lv2ccf3Pl195qtW56QZPvTgAG9mez2fwTEZCTy6kjhstRAAba6FqtxvBXIAe53OAqgADeASqVilvsw3liyeEFTwEElstl/fFK4mSzjXsogOSshBcRW+BrWzkrARBXq1UrEZDjawtrAUYEpXXDs+TkeUoAAZTWScRPyMnn/JqLxQPm+U6nU+2FIDPnEeZourycOlofTF4LeODqav4EUxqvNxGf2nsAAAAASUVORK5CYII="
									width="16" height="16" alt="상품 상태 아이콘">
								<%=dldto.getPost_like()%>
							</div>
						</div>
					</a>
				</div>
				<%
					}
				%>

			</div>
			<div style="clear: both;"></div>
		</div>
	</div>
</article>


<jsp:include page="/template/footer.jsp"></jsp:include>

