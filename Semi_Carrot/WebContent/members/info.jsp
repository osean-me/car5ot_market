<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberDTO mdto = (MemberDTO) session.getAttribute("userinfo");
%>

<!-- header -->


<h2>마이페이지</h2>



<table border="1" width=500></table>
<tobody>

<h5><a href="">작성 글</a></h5>
<h5><a href=""></a>작성 댓글</h5>
<h5><a href=""></a>정보 수정</h5>
<h5><a href="check.jsp?go=exit.do"></a>회원 탈퇴</h5>
<h5><a href=""></a>구매내역 조회</h5>
<h5><a href=""></a>판매 내역 조회</h5>
<h5><a href=""></a>찜 목록</h5>

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
	<td><%=mdto.getMember_addr_no()%></td>
</tr>
<tr>
	<th>전화번호</th>
	<td><%=mdto.getMember_phone()%></td>
</tr>
<tr>
	<th>가입일</th>
	<td><%=mdto.getMember_join()%></td>
</tr>
<th>마지막 로그인</th>
<td><%=mdto.getMember_login()%></td>
</tr>
</tbody>
</table>




<!-- footer -->

