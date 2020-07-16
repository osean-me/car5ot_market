<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String member_id = (String)session.getAttribute("member_id");
	session.removeAttribute("member_id");
	String path = request.getContextPath();
	
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<link href="<%=path%>/css/11.find_id_result.css"rel="stylesheet"
	type="text/css">
<article id="full-article">
	<div class="main-form">
	<div style=height:250px;>
		<img src="<%=path%>/img/logo_icon.png" alt="logo_icon" id="logo_icon">
    </div>    
        <div id="find-form">
	        <div class="id-find">
	            <div class="title"><%=member_id%> 잊지말라구 당근~!</div>
	            <form action="login.jsp" method="post">
	            	<div id="id-submit"> 
	            		<input class="submit" type ="submit"value="로그인">
	            	</div>
	            	</form>
	            	 <form action="find_id_pw.jsp" method="post">
	       <div>
	       <input class="submit" type ="submit"value="비밀번호 찾으러 go~!">
	       </div>
	   </form>
                    </div>  
                </div>
            </div>
    </article>
<jsp:include page="/template/footer.jsp"></jsp:include>