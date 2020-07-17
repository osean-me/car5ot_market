<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	String path = request.getContextPath();
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");

	MemberDAO mdao = new MemberDAO();
	List<MemberDTO> list;
	if (type == null || keyword == null) {
		list = new ArrayList<>();
	} else {
		list = mdao.search(type, keyword);
	}
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path%>/css/admin_list.css" rel="stylesheet"
	type="text/css">

<article id="full-article">
	<div class="main-form">
		<div style="height: 200px;">
			<img src="<%=path%>/img/admin.png" alt="logo_icon" id="logo_icon"
				style="width: 500px; height: 300px;">
		</div>
		<div id="find-form">
			<div class="id-find">
				<div class="title">
					<div class="find-from-title">회원검색</div>
					<div class=title;>
						<form action="admin_list.jsp" method="get">
							<select id="search" name="type">
								<option value="member_id">아이디</option>
								<option value="member_nick">닉네임</option>
								<option value="member_auth">권한</option>
							</select>
							<%
								if (keyword == null) {
							%>
							<input id="search" type="text" name="keyword" required>
							<%
								} else {
							%>
							<input id="search" type="text" name="keyword" required value="<%=keyword%>">
							<%
								}
							%>
							<div>
								<input class="submit" type="submit" value="검색"
									style="width: 500px; height: 55px margin-top:100px;">




								<div>
									총
									<%=list.size()%>
									개의 데이터가 검색되었습니다

									<%
									if (list.isEmpty()) {
								%>

									<%
										} else {
									%>
									<table border="1" width="1330" align="center;">
										<thead>
											<tr>
												<th>아이디</th>
												<th>닉네임</th>
												<th>권한</th>
												<th>관리메뉴</th>
											</tr>
										</thead>


										<tbody align="center">
											<%
												for (MemberDTO mdto : list) {
											%>
											<tr>
												<td><%=mdto.getMember_id()%></td>
												<td><%=mdto.getMember_nick()%></td>
												<td><%=mdto.getMember_auth()%></td>
												<td><a
													href="admin_detail.jsp?member_no=<%=mdto.getMember_no()%>">상세</a>
													<a href="admin_edit.jsp?member_no=<%=mdto.getMember_no()%>">수정</a>
													<a
													href="<%=request.getContextPath()%>/member/check.jsp?go=<%=request.getContextPath()%>/admin/drop.do?member_id=<%=mdto.getMember_id()%>">탈퇴</a></td>

												<%
													}
												%>
											
										</tbody>
									</table>
									<%
										}
									%>

								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</article>

<jsp:include page="/template/footer.jsp"></jsp:include>





