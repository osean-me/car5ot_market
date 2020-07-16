<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>


<jsp:include page="/template/header.jsp"></jsp:include>

	<article>

<div align="center">
	<img src="<%=request.getContextPath()%>/img/500carrot.png">
	 <h1><a href="<%=path%>">홈으로</a></h1>
</div>
	</article>

<jsp:include page="/template/footer.jsp"></jsp:include>




