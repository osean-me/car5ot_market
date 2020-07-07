<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
    MemberDTO mdto=(MemberDTO)session.getAttribute("memberinfo");
    
    Long member_no = mdto.getMember_no();
    MemberDAO mdao= new MemberDAO();
    MemberDTO member = mdao.get(member_no);
    
    %>
 
<jsp:include page="/template/header.jsp"></jsp:include>
 
<div align="center">
 	<h2>회원 정보 수정</h2>
 	
 	<form action="change_info.do" method="post">
 		
 		<table style="padding-top:200px;"border="1" width=700">
 			<tbody>
 			<tr>
				
				<td colspan="3" align="center">회원 정보 수정</td>
		</tr>
		
 				<tr>
 					<th>닉네임</th>
 					<td>
 						<input type="text" name="member_nick" value="<%=member.getMember_nick()%>" required>
 					</td>
 				</tr>
 				<tr>
 					<th rowspan="3">주소</th>
 					<td>
 						<input type="text" name="addr_no" size="7" maxlength="6" value="<%=member.getMember_addr_no()%>"placeholder="주소">
 					</td>
 				</tr>
 				<tr>
 					<td>
					<input type="text" name="addr_city"size="10" maxlength="6" value="<%=member.getMember_addr_no()%>" placeholder="시 / 군 / 구">
 					</td>
 				</tr>
 				<tr>
 					<td>
						<input type="text" name="addr_base"size="10" maxlength="6" value="<%=member.getMember_addr_no()%>" placeholder="읍 / 면 / 동">
 					</td>
 				</tr>
 				<tr>
 					<th>전화번호</th>
 					<td>
 						<input type="text" name="member_phone" required value="<%=member.getMember_phone()%>">
 					</td>
 				</tr>
 			</tbody>
 			<tfoot>
 				<tr>
 					<td colspan="2" align="center">
 						<input type="submit" value="수정하기">
 					</td>
 				</tr>
 			</tfoot>
 		</table>
 	</form>
 </div>
 
 <jsp:include page="/template/footer.jsp"></jsp:include>
 
 
 