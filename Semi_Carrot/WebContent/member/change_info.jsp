<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
    String path = request.getContextPath();
    
    MemberDTO mdto=(MemberDTO)session.getAttribute("memberinfo");
    
    Long member_no = mdto.getMember_no();
    MemberDAO mdao= new MemberDAO();
    MemberDTO member = mdao.get(member_no);
    
    %>
 
<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=path %>/js/change_info.js"></script>
<div align="center">
 	<h2>회원 정보 수정</h2>
 	
 	<form action="change_info.do" method="get">
 		
 		<table style="padding-top:200px;"border="1" width=700">
 			<tbody>
 			<tr>
				
				<td colspan="10" align="center">회원 정보 수정</td>
		</tr>
		
 				<tr>
 					<th>닉네임</th>
 					<td colspan="10">
 						<input type="text" name="member_nick" value="<%=member.getMember_nick()%>">
 					</td>
 				</tr>
 				<tr>
 					<th>주소</th>
 					<td>
 						<input type="text" name="addr_state" placeholder="시 / 도" id="state" readonly required="required">
 					</td>
 					<th>구 / 시</th>
 					<td>
                    	<input type="text" name="addr_city" placeholder="구 / 시" id="city" readonly required="required">
                    </td>
                    <th>동 / 읍 / 면</th>
                    <td>
                    	<input type="text" name="addr_base" placeholder="동 / 읍 / 면" id="base" readonly required="required">
                    </td>
                    
                    <td>
                    	<input type="button" onclick="findAddr(); " value="주소검색">
                    </td>
 				</tr>
 				
 				<tr>
 					<th>전화번호</th>
 					<td colspan="10">
 						<input type="text" name="member_phone" required value="<%=member.getMember_phone()%>">
 					</td>
 				</tr>
 			</tbody>
 			<tfoot>
 				<tr>
 					<td colspan="10" align="center">
 						<input type="submit" value="수정하기">
 					</td>
 				</tr>
 			</tfoot>
 		</table>
 	</form>
 </div>
 
 <jsp:include page="/template/footer.jsp"></jsp:include>
 
 
 