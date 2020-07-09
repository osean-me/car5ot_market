<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- 비밀번호 검사 -->
    <!-- 목적지 정보 파라미터 이름 go -->
    
    <%String go = request.getParameter("go");
    %>
    
      
<jsp:include page="/template/header.jsp"></jsp:include>
    
    <div align ="center"style="padding-top:200px;">
    <h2> 비밀번호 를 입력 해 주세요</h2>

    <form action="check.do"method="post">
    
    <input type="hidden"name="go"value=<%=go %>>
    <input type="password"name="member_pw"required>
    <input type="submit"value="확인">
   
    </form>
   <%if(request.getParameter("error")!=null) {%>
		<script>
			alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
		</script>
    <%} %>
    
    </div>
    
    
    
<jsp:include page="/template/footer.jsp"></jsp:include>