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
            height: 400px;
            top:200px;
            background-color: white;
            position: relative;
        }


        .img {
            background-color: white;
            width: 70%;
            height: 200px;
            
            
            display: flex;
            align-items: center;
            justify-content: center;
            
            position: absolute;
            
          
        }


        .guide {
            width: 30%;
            height: 100px;
            right: 210px;
            background-color: none;
            
            display: flex;
            align-items: center;
            
            
           
            position: absolute;
          
            
            }
      
        .guide h1 {     
            font-size: 100px;
            color:orange;
            padding:20px;
           
           
            }
        
        .guide h2 {  
              color:orangered;
        }
        
        .gohome {
            width:30%;
            height: 100px;
            right:150px;
            top:100px;
            background-color:none;
            
            display: flex;
            align-items: center;
          
            
            position: absolute;
        }
        
          .gohome h1{
            
            text-decoration: none;
            background-color:orange;
            color:white;
            top: 200px;
            padding:12px 24px;
            border-radius: 25px;
            display: inline-block;
            
        }
        
        .gohome h1:hover  {
          background-color:orangered;
        }
        
        
        
        
    </style>
    
</head>

<body>

    <article>

        <div class="img">
           <img src="<%=request.getContextPath()%>/img/error.PNG" width="250px" height="150px" >
        </div>

        <div class="guide">
            <h2>  Oops! </h2>
           <h1> 404</h1>
            <h2>  Page not found  </h2>
        </div>

        <div class="gohome">
            <a href="<%=path%>/index.jsp"><h1>Go back home </h1></a>
        </div>

   
    </article>


</body></html>







<jsp:include page="/template/footer.jsp"></jsp:include>

