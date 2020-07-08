<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
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

<div align="center" style="padding-top: 200px">
	<h2>회원 검색</h2>

	<form action="admin_list.jsp" method="get">
		<select name="type">
			<option value="member_id">아이디</option>
			<option value="member_nick">닉네임</option>
			<option value="member_auth">권한</option>
		</select> 
		<%
			if (keyword == null) {
		%>
		<input type="text" name="keyword" required>
		<%
			} else {
		%>
		<input type="text" name="keyword" required value="<%=keyword%>">
		<%
			}
		%>
		<input type="submit" value="검색">
	</form>

	<hr>

	<h5>
		총
		<%=list.size()%>
		개의 데이터가 검색되었습니다
	</h5>


	<%
		if (list.isEmpty()) {
	%>

	<%
		} else {
	%>
	<table border="1" width="650">
		<thead>
			<tr>


				<th>아이디</th>
				<th>닉네임</th>
				<th>권한</th>
				<th>관리메뉴</th>
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
					href="admin_detail.jsp?member_id=<%=mdto.getMember_id()%>">상세</a> <a
					href="#">수정</a> <a
					href="drop.do?member_id=<%=mdto.getMember_id()%>">탈퇴</a></td>

				<%
					}
				%>
			
		</tbody>

	</table>
	<%
		}
	%>



</div>

<jsp:include page="/template/footer.jsp"></jsp:include>





