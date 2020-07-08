<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		String path = request.getContextPath();
	%>

<jsp:include page="/template/header.jsp"></jsp:include>


<div align ="center"style="padding-top:200px;">


<h2>변경이 완료되었습니 당근~!</h2>

<h4><a href="info.jsp">마이페이지 이동</a></h4>
	<h4><a href="<%=path%>">홈으로 이동</a></h4>

<!-- 동네 중고 링크 -->

<!-- 동네 홍보 링크 -->

<!-- 동네 텃밭 링크 -->


</div>


<jsp:include page="/template/footer.jsp"></jsp:include>