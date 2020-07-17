<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<%
	String path = request.getContextPath();
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <title> 홈페이지</title>

    <style>
        /* 에러페이지  */


        article {
            margin: 0px auto;
            width: 60%;
            text-align: center;
            min-width: 1000px;
            height: 1400px;
            background-color: gray;
            position: relative;
        }


        .img {
            background-color: white;
            width: 70%;
            height: 1400px;
            position: absolute;
            display: flex;
            align-items: center;
            justify-content: center;

        }


        .guide {
            width: 30%;
            height: 50%;
            right: 0px;
            background-color: white;
            position: absolute;
            display: flex;
            align-items: center;
            justify-content: center;


        }

        .gohome {
            width: 30%;
            height: 50%;
            position: absolute;
            bottom: 0px;
            right: 0px;
            background-color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
    
</head>

<body>

    <article>

        <div class="img">
           <img src="<%=request.getContextPath()%>/img/error.PNG">
        </div>

        <div class="guide">
            <h1>  당근알리미: 500 Error 발생! </h1>
        </div>

        <div class="gohome">
            <h1><a href="<%=path%>/index.jsp">당근마켓 홈으로 GO! </a></h1>
        </div>

   
    </article>


</body></html>







<jsp:include page="/template/footer.jsp"></jsp:include>

