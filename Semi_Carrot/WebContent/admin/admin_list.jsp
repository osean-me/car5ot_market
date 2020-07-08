<%@page import="java.util.List"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String member_id=request.getParameter("member_id");
MemberDAO mdao = new MemberDAO();
List<MemberDTO>list=mdao.search(member_id);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div align="center" style="padding-top: 200px;">
	<h2>회원검색</h2>
	
	<form action="list.do" method="get">
	<%if(member_id==null){ %>
	<input type="text" name="member_id" required> 
	<%}else{ %>	
	<input type="text" name="member_id" required value="<%=member_id %>"> 			
	<%} %>
	<input type="submit" value="검색">
	</form>
	
	
	<br>	<br>
					
	<%if(list.isEmpty()){ %>
		<h5>검색 결과가 존재하지 않습니다</h5>			
	<%}else{ %>			
		<table border="1" width="650">
			<thead>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>				
				<th>권한</th>
				<th>관리메뉴</th>
				<tr>
			</thead>
			<tbody align="center">
			<%for(MemberDTO mdto:list){ %>
			<tr>
			<td><%=mdto.getMember_id() %></td>
			<td><%=mdto.getMember_nick() %></td>
			<td><%=mdto.getMember_auth() %></td>
		    <td>
		    <a href="detali.jsp">상세</a>
		    <a href="#">수정</a>
		    <a href="#">탈퇴</a>
		    </td>
			</tr>
						
			<%} %>
			</tbody>
			</table>
<%} %>

</div>

<jsp:include page="/template/footer.jsp"></jsp:include>




