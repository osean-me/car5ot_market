<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<link href="<%=path%>/css/13.admin.css" rel="stylesheet" type="text/css">


<article id="full-article">
	<div class="main-form">
		<div style="height: 200px;">
			<img src="<%=path%>/img/admin.png" alt="logo_icon" id="logo_icon"
				style="width: 500px; height: 300px;">
		</div>
		<div id="find-form">
			<div class="id-find">
				<div class="title">
					<div class="find-from-title">관리자화면</div>
					<div id="find-form">
						<div class="pw-find">
							<div>
								<form action="admin_list.jsp" method="get"
									style="margin-top: 0px">
									<input class="submit" type="submit" value="회원 검색"
										style="width: 345px; height: 55px margin-top:100px;">


								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</article>


<jsp:include page="/template/footer.jsp"></jsp:include>