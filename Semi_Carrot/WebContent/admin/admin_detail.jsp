<%@page import="carrot.bean.dto.MemberDTO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
    <%
	String member_id = request.getParameter("member_id");

	MemberDAO mdao = new MemberDAO();
	
	MemberDTO mdto = mdao.get(member_id);
    
    %>
    
<jsp:include page="/template/header.jsp"></jsp:include>


<div align="center" style="padding-top: 200px;">

<table style="padding-top:200px;"border="2" width=700">

		<tbody>
		<tr>
				
				<td colspan="3" align="center">회원 상세정보</td>
		</tr>
		
		<tr>
				<th>이메일</th>
				<td><%=mdto.getMember_id()%></td>
		</tr>
			<tr>
				<th>닉네임</th>
				<td><%=mdto.getMember_nick()%></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<%=mdto.getMember_addr_no()%> 
				
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><%=mdto.getMember_phone()%></td>
			</tr>
			<tr>
				<th>등급</th>
				<td><%=mdto.getMember_auth()%></td>
			</tr>
			<tr>
				<th>가입일</th>
				<td><%=mdto.getMember_join()%></td>
			</tr>
			<tr>
				<th>마지막 로그인</th>
				<td><%=mdto.getMember_login()%></td>
			</tr>
		</tbody>
	</table>

<!-- check.jsp 로 보낼 때에는 최종 목적지로 go 라는 이름의 파라미터로 추가해야 한다 -->	
	
	
	<h5><a href="admin_list.jsp">목록보기</a></h5>
	<h5><a href="check.jsp?go=exit.do">회원탈퇴</a></h5>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>

