<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>


<!-- jQuery UI toolTip 사용 CSS-->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jQuery UI toolTip 사용 JS-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

 <!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300;1,300&display=swap" rel="stylesheet">

<style>


body>div.container {
	padding-top: 200px;
	font-family: 'Nanum Myeongjo', serif;
}

</style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	

		//============= "구매"  Event 연결 =============
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#iamportPayment" ).on("click" , function() {
				console.log('구매');
				fncAddPurchase();
			});
		});	
		
		
		//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				history.go(-1);
			});
		});	
	
		//============= 주소값 표시 =============
		 $(function() {	
			var addr = $("input:hidden[name='divyAddr']").val();
			console.log(addr);
			///*
			if(addr.indexOf('/',0) != -1){
				var list = addr.split('/');
				
				$("#sample6_postcode").val(list[0]);
				$("#sample6_address").val(list[1]);
				$("#sample6_detailAddress").val(list[2]);
				$("#sample6_extraAddress").val(list[3]);
				
			}else{
				$("#sample6_address").val(addr);
			}
			//*/
		 });	

		//====================================================
		function fncAddPurchase() {
			
			var addr = $("#sample6_postcode").val() + "/" +  $("#sample6_address").val() + "/" +  $("#sample6_detailAddress").val() + "/" + $("#sample6_extraAddress").val();
			console.log('submit');
			console.log(addr);
			$("input:hidden[name='divyAddr']").val( addr );
			
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseByCart").submit();

			
		}
		
		
		//====================================================
		
			
		$(function() {
			var price = 0;
			var quantity = 0;
			var totalProdPrice =0;
			var num =0;
			
	   		<c:forEach var="cart" items="${cartlist }" >
	   		num += 1;
	   		price = Number(${cart.cartProd.prodDisPrice});
	   		quantity = Number(${cart.quantity});
	   		totalProdPrice+=(price*quantity);
	   		</c:forEach>
		   	
	   		
			console.log("상품수: "+num);
			console.log("price: "+price);
			console.log("quantity: "+quantity);
			console.log("totalProdPrice: "+totalProdPrice);
			
			
			var earnpoint = Math.round(totalProdPrice*0.05);
			console.log("earnpoint: "+earnpoint);
			
			$( "#earnPoint" ).val(earnpoint);
			$("#totalProdPrice").val(totalProdPrice);
			$("#totalDivyFee").val(num*3000);
			$("#totalPrice").val(totalProdPrice+(num*3000));
			
		});	
	
		 
</script>	
		
<!-- 주소록 --> 
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script> 
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
        <jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	<br>
		<h1 class="bg-defualt text-center" style="color:#bc8f8f">결제하기</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="text-center">		  
		  <hr/>
		  <h4 align="center">주문상품</h4>
		  <hr/>

<c:forEach var="cart" items="${cartlist}">

		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      ${cart.cartProd.prodName}
		    </div>
		  </div>
		  
		
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      ${cart.cartProd.prodDisPrice} 원
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">배송비</label>
		    <div class="col-sm-4">
		      3000 원
		      <input type="hidden" class="form-control" value="3000">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="purchaseQuantity" class="col-sm-offset-1 col-sm-3 control-label">구매수량</label>
		    <div class="col-sm-4">
		    ${cart.quantity} 개
		      <input type="hidden" min="0" class="form-control"value="${cart.quantity}">
		    </div>
		  </div>
		  
		  <c:if test="${cart.cartProd.couponApply == 'N' }">
			  <div class="form-group">
			    *쿠폰적용불가
			  </div>
		  </c:if>
		  
		  <input type="hidden" class="cartNo" name="cartNo" value="${cart.cartNo}">
		  
		  <hr>
		  
</c:forEach>		 
 
		  

		  
		  <div class="form-group">
		  <label for="purchaseQuantity" class="col-sm-offset-1 col-sm-3 control-label">총 상품금액</label>
		    <div class="col-sm-4">
		      <input type="text" id="totalProdPrice" name="totalProdPrice" value=""  style="border:none;width:50px"> 원
		    </div>
		  </div>
		  
		  <div class="form-group">
		  <label for="purchaseQuantity" class="col-sm-offset-1 col-sm-3 control-label">총 배송비</label>
		    <div class="col-sm-4">
		      + <input type="text" id="totalDivyFee" name="totalDivyFee" value=""  style="border:none;width:50px"> 원 <hr>
		      <input type="hidden" class="divyFee" name="divyFee" value="3000">
		    </div>
		  </div>
		  
		  <div class="form-group">
		  <label for="purchaseQuantity" class="col-sm-offset-1 col-sm-3 control-label">총 결제금액</label>
		    <div class="col-sm-4">
		     <input type="text" id="totalPrice" name="totalPrice" value=""  style="border:none;width:50px"> 원
		    </div>
		  </div>
		  
		   <div class="form-group">
		  <label for="purchaseQuantity" class="col-sm-offset-1 col-sm-3 control-label">적립 포인트</label>
		    <div class="col-sm-4">+
		      <input type="text" id="earnPoint" name="earnPoint" value=""  style="border:none;width:50px">P
		    </div>
		  </div>
		 
		  </div>
		  
		   <div class="text-center">	
		   		  
		  <hr/>
		  <h4 align="center">배송정보</h4>
		  <hr/>
		  
		  <input type="hidden" name="userId" value="${user.userId }" />
		  	  
		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">받는분 이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}"> 
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">배송지</label>
		    <div class="col-sm-4">
		        <input type="text" id="sample6_postcode" name="postcode" placeholder="우편번호" value="">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="sample6_address" name="address" placeholder="주소" value=""><br>
				<input type="text" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소" value=""><br>
				<input type="text" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목" value="">
		    </div>
		    <input type="hidden" name="divyAddr" value="${user.addr}">
		  </div>
		  
		    <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
		    </div>
		  </div>
		  
		  <c:if test="${!empty user}">
		      <input type="hidden" class="form-control" id="receiverEmail" name="receiverEmail" value="${user.userId}">
		  </c:if>
		  <c:if test="${empty user}">
		  <div class="form-group">
		    <label for="receiverEmail" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverEmail" name="receiverEmail" placeholder="비회원 구매" >
		    </div>
		  </div>
		  </c:if>
		  
		  
		   <div class="form-group">
		    <label for="divyMessage" class="col-sm-offset-1 col-sm-3 control-label">배송메시지</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyMessage" name="divyMessage" placeholder="요청사항을 적어주세요."  >
		    </div>
		  </div>

		
		</div>
		 <div class="text-center">	  
		  <hr/>
		  <h4 align="center">쿠폰 / 포인트</h4>
		  <hr/>
		  
		  
		  <div class="form-group">
		    <label for="usedCoupon" class="col-sm-offset-1 col-sm-3 control-label">쿠폰 사용</label>
		    <div class="col-sm-4">
		    <c:forEach var="cart" items="${cartlist}">
		   	  <c:if test="${cart.cartProd.couponApply == 'Y' }">
		      		<select name="coupon" class="form-control" id="usedCoupon">
		      			<option value=""> 사용할 쿠폰을 선택해주세요 </option>
				      		<c:forEach var="couponlist" items="${coupon}">
				      			<option value="${couponlist.issueNo}">${couponlist.couponName}</option>
				      		</c:forEach>
		      		</select>
		      </c:if>
		      <c:if test="${cart.cartProd.couponApply == 'N' }">
		      	<input type="text" class="form-control" name="coupon" placeholder="쿠폰적용이 불가한 상품입니다." readonly >
		      </c:if>
		      </c:forEach>
		    </div>
		  </div>


		  
		  <div class="form-group">
		    <label for="usedPoint" class="col-sm-offset-1 col-sm-3 control-label">포인트 사용</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="usedPoint" name="usedPoint" value="0">
		      <button type="button" class="point" id="point">모두 사용</button>
		      <h5>보유 포인트 ${user.holdpoint } P</h5>	
		    </div>
		  </div>
		  
		  </div>
		  
		  <input type="hidden" name="paymentOpt" id="paymentOpt" value="KA">
		  
		</form>
		<!-- form Start /////////////////////////////////////-->
		<div class="text-center">
			<button type="button" class="btn btn-default btn-block iamportPayment" id="iamportPayment">결제하기</button>	
			<a class="btn btn-default btn-block" href="#" role="button">취 소</a>
		</div>
		
		<br/>
 	</div>
	
</body>

</html>