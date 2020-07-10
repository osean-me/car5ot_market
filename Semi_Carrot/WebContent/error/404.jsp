<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	String path = request.getContextPath();
%>	
	
	
<jsp:include page="/template/header.jsp"></jsp:include>

	<article>
			<img src="<%=request.getContextPath()%>/img/404ERROR.png">
			 <h1><a href="<%=path%>">홈으로</a></h1>
	</article>
	
<jsp:include page="/template/footer.jsp"></jsp:include>




