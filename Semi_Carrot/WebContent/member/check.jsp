<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- 비밀번호 검사 -->
    <!-- 목적지 정보 파라미터 이름 go -->
    
    <%
    	String go = request.getParameter("go");
    	String path = request.getContextPath();

    %>
    
      
<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path %>/css/9.check.css" rel="stylesheet" type="text/css">


    <div align ="center"style="padding-top:190px;">
            		<img src="<%=path %>/img/logo_icon.png" alt="logo_icon" id="logo_icon">
    <h2> 비밀번호 체크</h2>

    <form action="check.do"method="post">

    <input type="hidden"name="go"value=<%=go %>>
    <input id="pw"type ="password"name="member_pw"placeholder="비밀번호 를 입력해 주세요">
    <div>
   <input id="submit" type ="submit"value="확인">
   </div>  
    </form>
   <%if(request.getParameter("error")!=null) {%>
		<script>
			alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
		</script>
    <%} %>
    
    </div>
    
    
    
<jsp:include page="/template/footer.jsp"></jsp:include>