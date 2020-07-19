
  
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
		var title = document.querySelector("input[name=post_title]").value;

		var regex= /^.{2,30}$/;

		var titleInfo = document.querySelector("#titleInfo");
		var titleInfoText = document.querySelector("#titleInfoText");

		var isValid = title.match(regex);
		if (isValid) {			
			var titleInfoText = document.createElement("div");
			titleInfoText.textContent = "⛔   제목은 2자 이상 입력해주세요.";
			titleInfoText.setAttribute("id", "titleInfoText");
			titleInfoText.setAttribute("style", "color: red; font-size: 15px;");
			titleInfo.appendChild(titleInfoText);
		} 
		else if (title.match(regex) != null && titleInfoText != null) {
				titleInfo.removeChild(titleInfo.childNodes[0]);
		}
	}
// 가격 숫자만 입력 검사 
   function checkPrice() {
		var price = document.querySelector("input[name=post_price]").value;

		var regex= /^[0-9]{1,10}$/;

		var priceInfo = document.querySelector("#priceInfo");
		var priceInfoText = document.querySelector("#priceInfoText");

		var isValid = price.match(regex) == null && priceInfoText == null;
		if (price.match(regex) == null && priceInfoText == null) {
				
			var priceInfoText = document.createElement("div");
			priceInfoText.textContent = "⛔   숫자만 입력하세요.";
			priceInfoText.setAttribute("id","priceInfoText");
			priceInfoText.setAttribute("style","color: red; font-size: 15px;");
			priceInfo.appendChild(priceInfoText);

		} 
		else if (price.match(regex) != null && priceInfoText != null) {
				priceInfo.removeChild(priceInfo.childNodes[0]);
		}
	}
   

   
</script>
<%
	String path = request.getContextPath();
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path%>/css/11.used_write.css" type="text/css" rel="stylesheet">

<form action="usedpostedit.do" method="post" enctype="multipart/form-data">
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
            <div class="used_title" style="list-style: none; margin-bottom:40px;">
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
            <div class="used_price" style="margin-bottom:40px;">
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