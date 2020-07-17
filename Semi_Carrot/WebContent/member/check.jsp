<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- 비밀번호 검사 -->
    <!-- 목적지 정보 파라미터 이름 go -->
    
    <%String go = request.getParameter("go");
    String path = request.getContextPath();
    %>
    
      
<jsp:include page="/template/header.jsp"></jsp:include>
  	<img src="<%=path%>/img/shoping.png" alt="logo_icon" id="logo_icon">
  
<link href="<%=path%>/css/check.css" rel="stylesheet"
	type="text/css">
    <div align ="center"style="padding-top:0px;">
  
    <div id=subject> 비밀번호 를 입력 해 주세요</div>

    <form action="checks.do"method="get">
    
    <input type="hidden"name="go"value=<%=go %>>
    <input id="pw" type="password"name="member_pw"required>
    <div>
    <input id="submit" type="submit"value="확인"style="width:356px; height:46px">
   </div>
    </form>
    <%if(request.getParameter("error")!=null) { %>
    <!-- 비번이 틀릴경우 메시지 송출 -->
   <script> alert("비밀번호가 다릅니다");</script>   
    <%} %>
 
   
    </div>
    
    
    
<jsp:include page="/template/footer.jsp"></jsp:include>