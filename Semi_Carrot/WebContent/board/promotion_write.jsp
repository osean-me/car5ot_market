<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<script>
   function calculateCount() {
      var text = document.querySelector(".first").value;
      var len = text.length;
      var countTag = document.querySelector(".letter-count");

      countTag.textContent = len;
   }
   function changeValue() {
      var cb = document.querySelector("input[type=checkbox]").checked;
      var se = document.querySelector("select").value;
   }
   
   // 이미지 미리보기 
   function preview() {
      var fileTag = document.querySelector("input[name=promotion_post_img]");
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

		if (title.match(regex) == null && titleInfoText == null) {
				
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

		if (price.match(regex) == null && priceInfoText == null) {
				
			var priceInfoText = document.createElement("div");
			priceInfoText.textContent = "⛔   숫자만 입력하세요.";
			priceInfoText.setAttribute("id", "priceInfoText");
			priceInfoText.setAttribute("style", "color: red; font-size: 15px;");
			priceInfo.appendChild(priceInfoText);

		} 
		else if (price.match(regex) != null && priceInfoText != null) {
				priceInfo.removeChild(priceInfo.childNodes[0]);
		}
	}
	
// 전화번호 숫자만 입력 검사 
   function checkPhone() {
		var phone = document.querySelector("input[name=post_phone]").value;

		var regex= /^[0-9]{1,11}$/;

		var phoneInfo = document.querySelector("#phoneInfo");
		var phoneInfoText = document.querySelector("#phoneInfoText");

		if (phone.match(regex) == null && phoneInfoText == null) {
				
			var phoneInfoText = document.createElement("div");
			phoneInfoText.textContent = "⛔   -를 제외한 올바른 전화번호를 입력하세요.";
			phoneInfoText.setAttribute("id", "phoneInfoText");
			phoneInfoText.setAttribute("style", "color: red; font-size: 15px;");
			phoneInfo.appendChild(phoneInfoText);

		} 
		else if (phone.match(regex) != null && phoneInfoText != null) {
				phoneInfo.removeChild(phoneInfo.childNodes[0]);
		}
	}
   
</script>

<%
	String path = request.getContextPath();
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<link href="<%=path%>/css/12.promotion_write.css" type="text/css" rel="stylesheet">
<%if(request.getParameter("img_error") != null) { %>
	<script>
		alert("이미지를 1개 이상 추가해주세요.");
	</script>
<%} %>
<%if(request.getParameter("content_error") != null) { %>
	<script>	
		alert("모든 내용을 입력해주세요.");
	</script>	
<%} %>
<article style="padding-top: 200px;" id="used-write-form">
   <div class="container" align="left">
      <h1 align="left" style="font-size: 30px; font-weight: normal;">
         동네홍보 글쓰기 &nbsp; <span class="must">   *필수항목 </span>
      </h1>
      <br><br>
      <hr class="hr_style2">
      <br><br>
 
      <!--  
          준비 : post_title(글제목), used_cate_num(카테고리 번호), used_price(가격), used_content(내용) 
      -->

      <form action="promotion_post_write.do" method="post" enctype="multipart/form-data">
         <input type="hidden" name="board_no" value="2">
         
         <div class="used_container" >

            <!--  이미지 등록 -->
            <div class="used_photo">
               <div class="used_photo_text" >
                  상품이미지 <span class="must">*</span>
               </div>
               <div class="used_photo_img">
                 
                  <input class="form-input" type="file" name="promotion_post_img" multiple accept=".jpg, .png, .gif" onchange="preview();">
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
                  <input class="form-title" type="text" name="post_title" placeholder="상품 제목을 입력해주세요." oninput="checkTitle();">
                  <div id="titleInfo"></div>
                  <div class="titleHeight"></div>
               </div>
            </div>
            <hr>


            <!-- 카테고리 선택 -->
            <div class="used_cate" >
               <div class="used_text">
                  카테고리 <span class="must">*</span>
                  <select class="promotion_cate_style" name="promotion_cate_num">
                     <option value="">카테고리 선택</option>
                     <option value="1">중고차/오토바이</option>
                     <option value="2">동네 구인구직</option>
                     <option value="3">부동산</option>
                     <option value="4">농수산물</option>
                     <option value="5">지역업체</option>
                     <option value="6">과외/클래스 모집</option>   
                     <option value="7">전시/공연</option>               
                  </select>
               </div>
            </div>
            <hr>
			
			 <!-- 전화번호 입력 -->
            <div class="used_phone" style="list-style: none;">
               <div class="used_text">
                  전화번호 <span class="must">*</span> 
                  <input class="form-phone" type="text" name="post_phone" placeholder="전화번호를 입력해주세요."  oninput="checkPhone();">
              	  <div id="phoneInfo"></div>
                  <div class="titleHeight"></div>
               </div>
            </div>
            <hr>
			
            <!-- 가격 입력 -->
            <div class="used_price">
               <div class="used_text">
                  가격 <span class="must">*</span> 
                  <input class="form-price" type="text" name="post_price" placeholder="숫자만 입력해주세요" oninput="checkPrice();">원
                  <div id="priceInfo"></div>
                  <div class="titleHeight"></div>
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
                        <textarea class="first" name="post_content" oninput="calculateCount();"></textarea>
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
            <input class="form-btn" type="submit" value="등록하기">
         </div>

      </form>
   </div>
</article>

<jsp:include page="/template/footer.jsp"></jsp:include>