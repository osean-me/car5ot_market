<%@page import="carrot.bean.dto.UsedBoardDTO"%>
<%@page import="carrot.bean.dao.UsedBoardDAO"%>
<%@page import="carrot.bean.dto.UsedPostDTO"%>
<%@page import="carrot.bean.dao.UsedPostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
   <%
  	long post_no = Long.parseLong(request.getParameter("post_no"));   
  	UsedPostDAO updao = new UsedPostDAO();
  	UsedPostDTO updto = updao.get(post_no);
  	//카테고리 이름 뽑기
  	UsedBoardDAO ubdao = new UsedBoardDAO();
	UsedBoardDTO ubdto = ubdao.get(updto.getUsed_cate_num());
  	
  %>

<style>
* {
   box-sizing: border-box;
}

#used-write-form {
	margin:0px 20%;

}

.form-title {
   margin-top: 40px;
   margin-bottom: 40px;
   width: 1000px;
   padding: 0.9rem;
   outline: none; /* 선택 시 자동 부여되는 테두리 제거 */
   border: 1px solid lightgray;
   font-size: 19px;
   margin-left: 50px;
}
.form-title:focus {
   margin-top: 40px;
   margin-bottom: 40px;
   width: 1000px;
   padding: 0.9rem;
   outline: none; /* 선택 시 자동 부여되는 테두리 제거 */
   border: 1px solid lightgray;
   font-size: 19px;
   margin-left: 50px;
   outline:1px solid orange;
}

.used_cate_style {
   width: 300px; /* 너비설정 */
   border: 1px solid lightgray; /* 테두리 설정 */
   padding: 0.9rem;
   font-size: 19px;
   margin-top: 40px;
   margin-bottom: 40px;
   margin-left: 20px;
}
.used_cate_style:focus {
   width: 300px; /* 너비설정 */
   border: 1px solid lightgray; /* 테두리 설정 */
   padding: 0.9rem;
   font-size: 19px;
   margin-top: 40px;
   margin-bottom: 40px;
   margin-left: 20px;
      outline:1px solid orange;
}

.form-price {
   margin-top: 40px;
   margin-bottom: 40px;
   width: 300px;
   padding: 0.9rem;
   outline: none; /* 선택 시 자동 부여되는 테두리 제거 */
   border: 1px solid lightgray;
   font-size: 19px;
   margin-left: 50px;
}
.form-price:focus {
   margin-top: 40px;
   margin-bottom: 40px;
   width: 300px;
   padding: 0.9rem;
   outline: none; /* 선택 시 자동 부여되는 테두리 제거 */
   border: 1px solid lightgray;
   font-size: 19px;
   margin-left: 50px;
   outline:1px solid orange;
}

#free {
   margin-left: 80px;
}

#free:checked {
   color: orange;
}

#suggest {
   margin-left: 50px;
}

.first {
   width: 1000px;
   height: 200px;
   border-color: lightgray;
   font-size: 20px;
   font-weight: normal;
   margin-left: 50px;
}
.first:focus {
   width: 1000px;
   height: 200px;
   font-size: 20px;
   font-weight: normal;
   margin-left: 50px;
   outline:1px solid orange;
}
.menu {
   width: 300px;
   height: 40px;
   margin-bottom: 30px;
}
.used_content_text {

}

.main .used_content_text {
   float: left;
   width: 50px;
   height: 254px;
}

.main .content {
   float: left;
   width: 250px;
   height: 250px;
}

.countNum {
   margin-left: 990px;
   margin-top: 10px;
}

.form-btn {
   background-color: orange;
   color: white;
   cursor: pointer;
   padding: 1rem;
   outline: none; /* 선택 시 자동 부여되는 테두리 제거 */
   border: 1px solid orange;
   width: 180px;
   font-size: 27px;
   margin-top: 70px;
}

.must {
   font-size: 20px;
   font-weight: normal;
   color: red;
}
.used_container {
   font-size: 20px;
   text-align:left;
}

.used_photo, .used_title, .used_cate, .used_price, .used_content {
   list-style: none;
}

.used_photo_text {
   margin-bottom: 10px;
}

.used_photo_img {
   margin-bottom:45px;
}

.used_photo_explain {
   color: lightblue;
}

.used_text {
    display: inline-block;
}

.hr_style2 {
   border: 0;
   height: 3px;
   background:orange;
}

.preview-wrap > img {
   width:200px;
   height:200px;
   display:inline-block;
   margin-right:10px;
   margin:10px;
}

input+span {
	color:red;
}

</style>
<script>
   function calculateCount() {
      var text = document.querySelector(".first").value;
      var len = text.length;
      var countTag = document.querySelector(".letter-count");

      countTag.textContent = len;
   }
   
   // 이미지 미리보기 
   function preview() {
      var fileTag = document.querySelector("input[name=used_post_img]");
      var divTag = document.querySelector(".preview-wrap");
      
      if(fileTag.files.length > 0) {
         divTag.innerHTML = "";
         
         for(var i = 0; i < fileTag.files.length; i++){
            var reader = new FileReader();
            reader.onload = function(data){
               var imgTag = document.createElement("img");
               imgTag.setAttribute("src",data.target.result);
               divTag.appendChild(imgTag);
            };
            reader.readAsDataURL(fileTag.files[i])
         }
      }
      else {
         divTag.innerHTML ="";
      }
   }
   
   // 제목 2글자 이상 검사 
   function checkTitle() {
	   var title=document.querySelector(".post-title").value;
	   var len = title.length;
	   var isValid = len > 1;
	   
	   if(!isValid) {
		   var span = document.querySelector(".post-title + span");
		   span.textContent = "제목은 2글자 이상으로 작성하세요.";
	   }
   }
   
</script>

<jsp:include page="/template/header.jsp"></jsp:include>

<form action="usedpostedit.do" method="post">
	<input type="hidden" name="post_no" value="<%=post_no%>">
	<input type="hidden" name="board_no" value="1">
	
<article style="padding-top: 200px;" id="used-write-form">
   <div class="container" align="left">
      <h1 align="left" style="font-size: 30px; font-weight: normal;">
         중고거래 글 수정 &nbsp; <span class="must">   *필수항목 </span>
      </h1>
      <br><br>
      <hr class="hr_style2">
      <br><br>
      <!--  
          준비 : post_title(글제목), used_cate_num(카테고리 번호), used_price(가격), used_content(내용) 
       -->

      	
         <div class="used_container" >

            <!--  이미지 등록 -->
            <div class="used_photo">
               <div class="used_photo_text" >
                  상품이미지 <span class="must">*</span>
               </div>
               <div class="used_photo_img">
                 
                  <input class="form-input" type="file" name="used_post_img" multiple accept=".jpg, .png, .gif" onchange="preview();">
                  <div class="preview-wrap"></div>                
                  <div class="used_photo_explain" >
                     * 상품 이미지는 640x640에 최적화 되어 있습니다.<br> 
                     - 이미지는 상품등록 시 정사각형으로 짤려서 등록됩니다.<br> 
                     - 이미지를 클릭 할 경우 원본이미지를 확인할 수 있습니다. <br> 
                     - 큰 이미지일경우 이미지가 깨지는 경우가 발생할 수 있습니다. <br> 
                     - 이미지는 최대 5개까지 등록 가능합니다.<br>
                        
                        최대 지원 사이즈인 640 X 640 으로 리사이즈 해서 올려주세요.(개당 이미지 최대 10M)
                  </div>
               </div>
            </div>
            <hr>

            <!-- 제목 입력 -->
            <div class="used_title" style="list-style: none;">
               <div class="used_text">
                  제목 <span class="must">*</span> 
                  <input class="form-title" type="text" name="post_title" placeholder="상품 제목을 입력해주세요." onblur="checkTitle();" value="<%=updto.getPost_title()%>">
                  <span></span>
               </div>
            </div>
            <hr>


            <!-- 카테고리 선택 -->
            <div class="used_cate" >
               <div class="used_text">
                  카테고리 <span class="must">*</span>
                  <select class="used_cate_style" name="used_cate_num">
                     <option value="<%=updto.getUsed_cate_num()%>"> <%=ubdto.getUsed_cate_title() %></option>
                     <option value="1">디지털/가전</option>
                     <option value="2">가구/인테리어</option>
                     <option value="3">유아동/유아도서</option>
                     <option value="4">생활/가공식품</option>
                     <option value="5">스포츠/레저</option>
                     <option value="6">여성/잡화</option>
                     <option value="7">여성 의류</option>
                     <option value="8">남성패션/잡화</option>
                     <option value="9">게임/취미</option>
                     <option value="10">뷰티/미용</option>
                     <option value="11">반려동물</option>
                     <option value="12">도서/티켓/음반</option>
                     <option value="13">기타</option>                  
                  </select>
               </div>
            </div>
            <hr>
			
            <!-- 가격 입력 -->
            <div class="used_price">
               <div class="used_text">
                  가격 <span class="must">*</span> 
                  <input class="form-price" type="text" name="post_price" placeholder="숫자만 입력해주세요" value="<%=updto.getPost_price()%>">원
               </div>
               <div class="used_text">
                  <label for="freesShipping" id="free"> 
                     <input type="checkbox"> 무료배송
                  </label> 
                  <label for="priceSuggest" id="suggest"> 
                     <input type="checkbox"> 가격협의가능
                  </label>
               </div>
            </div>
            <hr><br><br>

            <!-- 상품 내용 입력 -->
            <div class="used_content">
               <div class="main">
                  <div class="used_content_text">
                     설명<span class="must">*</span>
                  </div>
                  <div class="content">
                     <div>
                        <textarea class="first" name="post_content" oninput="calculateCount();"><%=updto.getPost_content() %></textarea>
                        <div align="right" class="countNum">
                           <span class="letter-count">0</span>/2000
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div style="clear: both;"></div>
            <br><hr>

         </div>
         <!--  등록 버튼 -->
         <div align="right" class="form-input">
            <input class="form-btn" type="submit" value="수정완료">
         </div>

      
   </div>
</article>
</form>

<jsp:include page="/template/footer.jsp"></jsp:include>