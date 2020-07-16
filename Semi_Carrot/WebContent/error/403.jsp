<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<%
	String path = request.getContextPath();
%>


<article>
<div align="center">
<img src="<%=request.getContextPath()%>/img/403carrot.png">
 <h1><a href="<%=path%>">홈으로</a></h1>
</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>

