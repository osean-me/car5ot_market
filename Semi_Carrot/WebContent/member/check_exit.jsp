<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 비밀번호 검사 -->
<!-- 목적지 정보 파라미터 이름 go -->

<%
	String go = request.getParameter("go");
	String path = request.getContextPath();
%>


<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path%>/css/9.check_exit.css" rel="stylesheet"
	type="text/css">


<div align="center" style="padding-top: 190px;">
	<img src="<%=path%>/img/logo_icon.png" alt="logo_icon" id="logo_icon">
	<h2>회원탈퇴</h2>

	<form action="check.do" method="post">

		<input type="hidden" name="go" value=<%=go%>> 
		<input id="pw"type="password" name="member_pw" placeholder="비밀번호 를 입력해 주세요">
</div>
<input id="nick" type="text" name="member_nick"placeholder="닉네임을 입력해 주세요">

       
            <tr>
               <div>
               
                <h2 > 탈퇴 사유 선택</h2>
                </div>
                <td>
                   <form>
                        <input type ="checkbox"name="select">이용 불편
                        <input type ="checkbox"name="select">사기
                <input type ="checkbox"name="select">원하는 서비스가 없음 
                <input type ="checkbox"name="select">서비스가 마음에 들지 않음
              <div>
              <h2>기타 사유</h2>
                <td> <textarea style= "resize:none;"rows="7" cols="60" name="intro">  </textarea></td></div>
                 </form>
                 </td>
            </tr>
         
       
           
            <tr>
               <div>
                <td colspan="2" align="center">
                  
                      <input id="submit" type ="submit"value="탈퇴하기">
                 
                    </div>
            </tr>
      
    </form>
 </body>
</html>


<%
	if (request.getParameter("error") != null) {
%>
<script>
	alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
</script>
<%
	}
%>




<jsp:include page="/template/footer.jsp"></jsp:include>