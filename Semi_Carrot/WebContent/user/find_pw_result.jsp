<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
	String member_pw = (String) session.getAttribute("member_pw");
	session.removeAttribute("member_pw");
	String path = request.getContextPath();
%>
 
<% //var str = "abcdefg";

//alert("substr : " + str.substring(2,4));  
%> 

<jsp:include page="/template/header.jsp"></jsp:include>

<link href="<%=path%>/css/12.find_pw_result.css" rel="stylesheet"
type="text/css">
<article id="full-article">
	<div class="main-form">
	<div style=height:250px;>
		<img src="<%=path%>/img/logo_icon.png" alt="logo_icon" id="logo_icon">
    </div>    
        <div id="find-form">
	        <div class="id-find">
	            <div class="title"><%=member_pw%> 잊지말라구 당근~!</div>
	            <form action="login.jsp" method="post">
	            	<div id="id-submit"> 
	            		<input class="submit" type ="submit"value="로그인">
	            	</div>
	            	</form>
	            	 <form action="find_id_pw.jsp" method="post">
	       <div>
	       <input class="submit" type ="submit"value="비밀번호가 기억나지 않습니다">
	       </div>
	   </form>
                    </div>  
                </div>
            </div>
    </article>
   
<jsp:include page="/template/footer.jsp"></jsp:include>