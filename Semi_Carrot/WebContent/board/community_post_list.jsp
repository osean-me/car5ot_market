<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.container {
	margin-right: 3px;
	margin-left: 3px;
	margin-bottom: 12px;
}

.top {
	width: 1200px;
	height: 150px;
	border: 1px solid lightgray;
	padding: 20px;
	padding-left: 50px;
	padding-right: 50px;
}

.bottom {
	width: 1200px;
	height: 40px;
	border: 1px solid lightgray;
	padding: 10px;
	padding-left: 50px;
	font-family: '돋움';
}

.last {
	font-size: 18px;
}

.popular {
	float: right;
	margin-left: 10px;
	font-size: 18px;
}

.sort_list {
	margin-right: 5px;
}

.hr_style1 {
	margin-bottom: 30px;
	margin-top: 30px;
	color: lightgray;
}

.userImg2 {
	width: 60px;
	height: 60px;
	border-radius: 30px;
}

.userName {
	color: orange;
}

.userAddr {
	color: gray;
}

.userName, .userImg {
	list-style: none;
}

.float-box:after {
	content: "";
	display: block;
	clear: both;
}

.float-box.float-left>.userImg {
	float: left;
}

.float-box.float-left>.like {
	float: left;
}

.userImg {
	width: 9%;
}

.date {
	
}

.list {
	padding: 10px;
}

.content {
	padding-top: 20px;
}

.like {
	font-size: 19px;
	font-weight: normal;
}

.reply {
	margin-left: 70px;
}

.date {
	float: right;
	color: gray;
}
</style>

<jsp:include page="/template/header.jsp"></jsp:include>

<article style="padding-top: 200px; margin:0px 15%">
	<div align="left">
		<h2 style="font-size: 30px; margin: 15px;">
			<span style="color: orange">우리동네</span> 커뮤니티
		</h2>
		<div class="sort_list" align="right">
			<div class="popular">
				<a href="">인기순</a>
			</div>

			<div class="last">
				<a href="">최신순</a>
			</div>
		</div>
		<hr class="hr_style1">

		<!-- 커뮤니티 글 목록 -->
		<div class="container">
			<div class="top">
				<div class="float-box float-left">
					<div class="userImg">
						<img class="userImg2" src="../img/ㅎㅎ.jpg">
					</div>
					<div class="list">
						<div class="date">5시간전</div>
						<div class="userAddr">서초구 방배동</div>
						<div class="userName">닉네임다</div>
					</div>
				</div>
				<div class="content">Q. 서초구 쪽에 옷수선 잘하는 곳 추천해주세yo~~~!</div>

			</div>


</div>
		</div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>