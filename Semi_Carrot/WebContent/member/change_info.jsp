<%@page import="carrot.bean.dto.AddrDTO"%>
<%@page import="carrot.bean.dao.AddrDAO"%>
<%@page import="carrot.bean.dao.MemberDAO"%>
<%@page import="carrot.bean.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	String path = request.getContextPath();
	long member_no = Long.parseLong(request.getParameter("member_no"));
	// 회원 번호로 회원 정보 받아오기 
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = mdao.get(member_no);
	
	// .get() 메소드를 이용해 회원 주소 받아오기 
	AddrDAO adao = new AddrDAO();
	AddrDTO adto = adao.get(mdto.getMember_addr_no());
	
	String state = adto.getAddr_state();
	String city = adto.getAddr_city();
	String base = adto.getAddr_base();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<!-- 주소 JS -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 회원가입 폼과 동일  -->
<script src="<%=path %>/js/join.js" type="text/javascript"></script>
<!-- 회원정보 변경 JS -->
<script src="<%=path %>/js/change_info.js"></script>

<!-- 회원가입 CSS -->
<link href="<%=path %>/css/6.join.css" type="text/css" rel="stylesheet">

<!-- 비밀번호 비교 -->
<%if(request.getParameter("error_no") != null) { %>

	<%int error_no = Integer.parseInt(request.getParameter("error_no")); %>
	
	<%if(error_no == 1) { %>
		<script>
			alert("현재 비밀번호와 같습니다. 다시 입력해주세요.");
		</script>
	<%} else if(error_no == 2) { %>
		<script>
			alert("현재 비밀번호가 틀렸습니다. 다시 입력해주세요.");
		</script>
	<%} %>
<%} %>
        <article class="join-article">
            <form action="change_info.do" method="get" class="join-form" id="edit-form" onsubmit="return editSubmit();">
                <div>
            		<img src="<%=path %>/img/logo_icon.png" alt="logo_icon" id="logo_icon">
            	</div>
                <div class="email-form">
                    <input type="text" name="member_id" placeholder="이메일" id="email" value="<%=mdto.getMember_id()%>" readonly style="width: 500px;">
                </div>
                <div>
					<input type="password" name="member_pw" placeholder="현재 비밀번호" maxlength="15" oninput="checkPw();">
				</div>
				<div id="pwInfo"></div>
				 <div>
					<input type="password" name="check_pw" placeholder="비밀번호 수정" maxlength="15" oninput="editcheckPw();" style="color: #ff8900;">
				</div>
				<div id="editpwInfo"></div>
				 <div>
					<input type="password" name="check_member_pw" placeholder="비밀번호 확인" maxlength="15" oninput="doublecheckPw();" style="color: #ff8900;">
				</div>
				<div id="checkpwInfo"></div>
                <div>
                    <input type="text" name="member_nick" placeholder="닉네임" maxlength="10" value="<%=mdto.getMember_nick() %>" oninput="checkNick();" style="color: #ff8900;">
                </div>
                <div id="nickInfo"></div>
                <div id="addr">
                    <input type="text" name="addr_state" placeholder="시 / 도" id="state" value="<%=state %>" style="color: #ff8900;" readonly>
                    <input type="text" name="addr_city" placeholder="구 / 시" id="city" value="<%=city %>" style="color: #ff8900;" readonly>
                    <input type="text" name="addr_base" placeholder="동 / 읍 / 면" id="base" value="<%=base %>" style="color: #ff8900;" readonly>
                    <input type="button" onclick="findAddr(); " value="">
                </div>
                <div>
                    <input type="text" name="member_phone" placeholder="휴대전화" maxlength="11" value="<%=mdto.getMember_phone() %>" oninput="checkPhone();" style="color: #ff8900;">
                </div>
                <div id="phoneInfo"></div>
                <div>
                	<input type="submit" value="수정" id="join-submit">
                </div>
            </form>
        </article>

<jsp:include page="/template/footer.jsp"></jsp:include>


