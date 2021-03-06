<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
      <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
      <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
    <title>ARTBOX(포트폴리오)</title>
    <link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/item/itemDetail.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/item/swiper.min.css" rel="stylesheet" type="text/css">
	<script src="${pageContext.request.contextPath}/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
	
	<script type="text/javascript">
	// 시작시
	window.onload = function (){
		//대분류 카테고리 replace
// 		replaceMajor();
		//문의 불러옴
		goQuestionPage("${questionPageInfo.pageNum}");
		//리뷰 불러옴
		goReviewPage(1);
		//합계금액
		fnCheckPriseSum();
	}
	//대분류 카테고리 replace
// 	function replaceMajor(){
// 		var major = '${categoryBean.category_sup }';		
// 		if(major == 'DT') {$('.major').html('인형/토이');}
// 		else if(major == 'FA') {$('.major').html('문구');}
// 		else if(major == 'FS') {$('.major').html('패션');}
// 		else if(major == 'KB') {$('.major').html('주방/욕실');}
// 		else if(major == 'LD') {$('.major').html('리빙/데코');}
// 		else if(major == 'DI') {$('.major').html('디지털/가전');}
// 		else if(major == 'TR') {$('.major').html('여행');}
// 		else if(major == 'BE') {$('.major').html('뷰티');}
// 	}
	// 후기,문의 테이블 클릭시 토글 오픈
	$(document).on('click','.tr',function(){
		if ($(this).parent().find(".ps").hasClass("on"))
		{
			$(this).parent().find(".ps").removeClass("on");
		}
		else
		{
			$(this).parent().find(".ps").addClass("on");
		}
	})
	// modal버튼 클릭시 팝업
	$(document).on('click','.modal',function(){
		$('.full-screen').css('display','block');
		if($(this).hasClass('btn-QnA')){
			$('.qna-overlay').css('display','block');
		}else if($(this).hasClass('btn-delivery')){
			$('.delivery-overlay').css('display','block');
		}else if($(this).hasClass('btn-share')){
			$('.share-overlay').css('display','block');
		}
	})
	// 닫기버튼 클릭시 종료
	$(document).on('click','.overlay-close',function(){
		$('.full-screen').css('display','none');
		$('.qna-overlay').css('display','none');
		$('.delivery-overlay').css('display','none');
		$('.share-overlay').css('display','none');
	})
	$(document).on('click','.full-screen-close',function(){
		$('.full-screen').css('display','none');
		$('.qna-overlay').css('display','none');
		$('.delivery-overlay').css('display','none');
		$('.share-overlay').css('display','none');
	})
	// 버튼 클릭시 수량 변동
	$(document).on("click", ".btnStockQty", function(){
		var obj = $(this).parent().find("input[type=tel]");
		if ($(this).hasClass("Minus")) {
			obj.val(parseInt(obj.val(),10)-1);
		}
		if ($(this).hasClass("Plus")) {
			if(parseInt(obj.val(),10)+1 < 10000){
				obj.val(parseInt(obj.val(),10)+1);
			}
		}
		fnCheckStock();
		fnCheckPriseSum();
	});
	$(document).on("keyup", "[name=stockqty]", function(){//키 눌렀을때
		if ($.isNumeric($(this).val()) == false){
			$("[name=stockqty]").val(1);
		}
		fnCheckStock();
		fnCheckPriseSum();
	});
	//현재 재고 반영하여 수량 조정
	function fnCheckStock(){
		var stock_count = Number('${productBean.product_stock_count}');
		var stockqty = Number($("[name=stockqty]").val());
		if(stock_count <= 0){
			$("[name=stockqty]").val(0);
			alert('현재 재고량이 0개 입니다.');
		}else if(stockqty < 1){
			$("[name=stockqty]").val(1);
			alert('주문수량은 1 이상이어야 합니다.');
		}else if(stockqty > stock_count){
			$("[name=stockqty]").val(stock_count);
			alert('현재 재고량이 '+stock_count+'개 입니다.');
		}else{
			$("[name=stockqty]").val(parseInt(stockqty,10));
		}
	}
	//포커스 이탈 방지
	$(document).on("blur", "[name=stockqty]", function(){//포커스 없어졌을때
		var stock_count = Number('${productBean.product_stock_count}');
		var stockqty = Number($(this).val());
		if(stock_count <= 0){
			$(this).val(0);
		}else if ($.isNumeric($(this).val()) == false){
			$(this).val(1);
		}else if (stockqty < 1){
			$(this).val(1);
		}else if (stockqty > stock_count){
			$(this).val(stock_count);
		}else{
			$(this).val(parseInt(stockqty,10));
		}
		fnCheckPriseSum();
	});
	//수량 변동시 가격 변동
	function fnCheckPriseSum(){
		var returnValue;
		if('${empty itemcoupon.coupon_name}'){
			returnValue = parseInt('${productBean.product_price - productBean.product_sale_price }',10)* parseInt($("[name=stockqty]").val(),10);		
		}else{
			returnValue = parseInt('${productBean.product_price }',10)* parseInt($("[name=stockqty]").val(),10);		
		}
		if(returnValue < 0){
			$(".pdt-totalprice").html(commas(0) + " 원");
		}else{		
			$(".pdt-totalprice").html(commas(returnValue) + " 원");
		}
	}
	function commas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	// 위시 버튼 눌렀을때
	$(document).on("click",".btn-wish", function(){
		var isId = false;
		if(isId){
			alert("회원 전용 서비스입니다.");
			location.href='#';
		}else{
			if ($(this).hasClass("on")){
				$(this).removeClass("on");
				$(this).addClass("off");
// 				alert('상품이 위시리스트에서 제거되었습니다.');
			} else {
				$(this).removeClass("off");
				$(this).addClass("on");
// 				alert('상품이 위시리스트에 추가되었습니다.');
			}
		}
	});
	//문의 등록하기버튼 클릭시
	function qnacheck() {
		var result = false;
		
		if($('input[name=email]').val() == ""){
			alert("이메일을 입력하세요.");
			$('input[name=email]').focus();
		}else if($('select[name=fild]').val() == ""){
			alert("문의분야를 선택하세요.");
			$('select[name=fild]').focus();
		}else if($('input[name=title]').val() == ""){
			alert("제목 선택하세요.");
			$('input[name=title]').focus();
		}else if($('textarea[name=content]').val() == ""){
			alert("문의내용을 입력하세요.");
			$('textarea[name=content]').focus();
		}else if(!$('input[name=privacycheck1]').is(':checked')){
			alert("개인정보 수집 및 이용에 동의해 주세요.");
			$('input[name=privacycheck1]').focus();
		}else if(!$('input[name=privacycheck2]').is(':checked')){
			alert("제 3자 정보 제공에 동의해 주세요.");
			$('input[name=privacycheck2]').focus();
		}else{
			result = confirm("상품문의를 등록 하시겠습니까?");
		}
		return result;
	}
	//페이징 처리
	function prev(){
		alert("첫 페이지 입니다");
	}
	function next(){
		alert("마지막 페이지 입니다");
	}
	function goQuestionPage(pageNum){
		$.ajax({
			url:'questionList.item',
			type:"POST",
			dataType : 'html',
			data:{
				product_num:"${productBean.product_num}",
				pageNum:pageNum,
				pageSize:"${questionPageInfo.pageSize}",
				pageBlock:"${questionPageInfo.pageBlock}",
			},
			success:function(rdata){
				$('.question_content').html("");
				$('.question_content').html(rdata);
			}
		});
	}
	function goReviewPage(page){
		$.ajax({
			url:'reviewList.item',
			type:"POST",
			dataType : 'html',
			data:{
				page:page,
				product_num:'${productBean.product_num}',
			},
			success:function(rdata){
				$('.review_content').html("");
				$('.review_content').html(rdata);
			}
		});
	}
	
	// '장바구니 담기' 및 '바로 구매하기' 버튼 클릭 이벤트
	function Order(id) {
		if(${empty sessionScope.id}) {
			var result = confirm("로그인 후 이용가능합니다.\n로그인 페이지로 이동하시겠습니까?");
			if(result==true) {
				location.href = "loginForm.member";
			}
			return false;
		}
		var product_num = $("input[name=product_num]").val();
		var stockqty = $("input[name=stockqty]").val();
		
		if('${productBean.product_stock_count }' == 0){
			alert("현재 재고량이 0개 입니다.");
		}else{
			if(id=='AddBasket') { // '장바구니 담기' 버튼 클릭 시
				var result = confirm("선택하신 상품이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?");
				// 확인/취소 선택 시 장바구니 상품 담음
				// result(확인/취소) 값을 넘겨줘서 Action 클래스에서 장바구니 페이지 이동여부 판별
				document.gfr.action = "insertBasket.basket?result="+result+"&product_num="+product_num;
				document.gfr.submit();
			} else if(id=='DirectOrder') { // '바로 구매하기' 버튼 클릭 시
					document.gfr.action = "orderDirect.order?product_num="+product_num+"&stockqty="+stockqty;
					document.gfr.submit();
			}
			
		}
	}
	
	// 쿠폰 중복 발급 x
		function cpClick(){
		var moveCheck;
		var getId  = document.getElementById("loginId").value;
		var coup_Num  = document.getElementById("coupNum").value;
		
		
		if(getId == "null" || getId == ""){
			moveCheck = confirm("로그인하시겠습니까?"+getId);
			
			if(moveCheck){
				location.href = "loginForm.member";
			}else{
// 				alert("그대로 유지");
			}
	} else {
		var url = "CouponIssued.coupon?getid=" + getId + "&couponNum="+ coup_Num;
		location.href = url;
			
		}
	}
	</script>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- /헤더 -->

	<!-- 메인 콘텐츠  -->
	<div class="wrap">
		<section class="item-info">
			<form action="" method="post" name="gfr">
				<input type="hidden" name="pdt-price" value="8500">
				<input type="hidden" name="product_code" value="${productBean.product_code}">
				<input type="hidden" name="product_name" value="${productBean.product_name}">
				<input type="hidden" name="product_image" value="${productBean.product_image}">
				<input type="hidden" name="product_price" value="${productBean.product_price}">
				<input type="hidden" name="product_category_code" value="${productBean.product_category_code}">
				
				<div class="img-info">
					<div class="mainslide swiper-container">
						<ul class="swiper-wrapper">
							<li class="swiper-slide"><img src="${pageContext.request.contextPath}/upload/${productBean.product_image}"></li>
							<li class="swiper-slide"><img src="${pageContext.request.contextPath}/upload/${productBean.product_image2}"></li>
						</ul>
						<div class="swiper-pagination"></div>
					</div>
					<script type="text/javascript">
						var mainSwiper = new Swiper(".mainslide.swiper-container", {
							autoplay : {delay : 4000,},
							pagination : {el : '.swiper-pagination',clickable : true,},
							autoplayDisableOnInteraction : false,
							loop : true,
							followFinger : true,
							preventClicks : false
						});
					</script>
				</div>
				<div class="text-info">
					<div class="pdt-name">${productBean.product_name } (${productBean.product_code})</div>
					<div class="pdt-category">
						<a href="${pageContext.request.contextPath}/itemList.item?major=${fn:substring(productBean.product_code,0,2)}&minor=&page=1&kwd=&doOrder=&src=" class="major">${category_sup }</a>
						&gt;
						<a href="${pageContext.request.contextPath}/itemList.item?major=${fn:substring(productBean.product_code,0,2)}&minor=${productBean.product_category_code}&page=1&kwd=&doOrder=&src=" class="minor">${category_sub }</a>
					</div>
					<div class="pdt-right pdt-price">
						<span id="rprice">
							<fmt:formatNumber value="${productBean.product_price}" type="number" />원
						</span>
					
						<!-- 			할인 있거나 쿠폰 있을때    || item.product_sale_price > 0-->
						<c:if test="${productBean.product_sale_price > 0}"> 
							<!-- 			realprice 스타일바꿈 -->
							<style>span#rprice {text-decoration: line-through;color:grey;}</style>
			
							<!-- 			할인 있을때 -->
							<c:if test="${empty itemcoupon.coupon_name}">
								<fmt:parseNumber integerOnly="true" var="persent" value="${productBean.product_sale_price/productBean.product_price *100 }" />
								<span style="color:red;"><fmt:formatNumber value="${productBean.product_price - productBean.product_sale_price }" pattern="#,###"/>원 [ ${persent}% ]</span>
							</c:if>
							<!-- 				쿠폰 있을때 -->
							<c:if test="${not empty itemcoupon.coupon_name}">
								<fmt:parseNumber integerOnly="true" var="persent" value="${productBean.product_sale_price/productBean.product_price *100 }" />
								<span style="color:red;"><fmt:formatNumber value="${productBean.product_price - productBean.product_sale_price }" pattern="#,###"/>원  [ ${persent}% ]</span>
								<input type="hidden" id="loginId" value="${sessionScope.id}">
								<input type="hidden" id="coupNum" value="${itemcoupon.coupon_num}">
								<input type="button" id="coup_btn" value="쿠폰받기" onclick= "cpClick();" ><br>
							</c:if>
						</c:if>
					</div>
					<div class="pdt-right pdt-delivery">2,500원
						<input type="button" class="btn-delivery modal" value="배송비 안내">
					</div>
					<div class="pdt-right pdt-candy">
						<c:choose>
							<c:when test="${(productBean.product_price - productBean.product_sale_price) < 0}">
								0 개
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${(productBean.product_price - productBean.product_sale_price) / 100}" type="number" pattern="0" />개
							</c:otherwise>
						</c:choose>
					</div>
					<div class="pdt-right pdt-code">${productBean.product_code}</div>
					<div class="pdt-right pdt-ok">1% 적립</div>
					<div class="pdt-right pdt-count">
						<span class="ipt_layer">
							<input type="button" class="btnStockQty Minus" value="-">
							<input type="button" class="btnStockQty Plus" value="+">
							<c:choose>
								<c:when test="${productBean.product_stock_count == 0 }">
									<input type="tel" name="stockqty" id="stockqty" value="0" maxlength="4">
								</c:when>
								<c:otherwise>
									<input type="tel" name="stockqty" id="stockqty" value="1" maxlength="4">
								</c:otherwise>
							</c:choose>
						</span>
					</div>
					<div class="pdt-right pdt-totalprice">
						<c:choose>
							<c:when test="${productBean.product_stock_count == 0 }">
								0 원
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="" type="number" /> 원
							</c:otherwise>
						</c:choose>
					</div>
					<div class="pdt-btnlist">
						<span class="btnCart"><input type="button" value="장바구니 담기" id="AddBasket" onclick="Order(this.id)"></span>
						<span class="btnOrder"><input type="button" value="바로 구매하기" id="DirectOrder" onclick="Order(this.id)"></span>
						<span class="btn-share modal"></span>
						<span class="btn-wish off"></span>
					</div>
				</div>
			</form>
		</section>
		<div class="clear"></div>
		<c:if test="${!empty otherOptionList }">
			<section class="item-another">
				<div class="another-text">이 상품의 다른 옵션</div>
				<div class="another-list swiper-container">
					<ul class="swiper-wrapper">
						<c:forEach var="ool" items="${otherOptionList }">
							<li class="swiper-slide" onclick="location.href='itemDetail.item?product_num=${ool.product_num}'">
								<img src="${pageContext.request.contextPath}/upload/${ool.product_image}">
								<div class="another-info">
									<span class="another-name">${ool.product_name}</span>
									<span class="another-price"><fmt:formatNumber value="${ool.product_price}" type="number" />원</span>
								</div>
							</li>
						</c:forEach>
					</ul>
					<div class="swiper-button-next"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
					<div class="swiper-button-prev"></div><!-- 이전 버튼 -->
				</div>
				<script type="text/javascript">
					var subSwiper = new Swiper(".another-list.swiper-container", { 
						slidesPerView:3,
						navigation : {
							nextEl : '.swiper-button-next', // 다음 버튼 클래스명
							prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
						},
					});
				</script>
			</section>
		</c:if>
		<div class="clear"></div>
		<section class="item_content_bar">
			<div class="tabBar">
				<span>상품상세</span> <span>상품후기(${reviewCount })</span> <span>상품Q&amp;A(${questionPageInfo.boardCount})</span>
			</div>
		</section>
		<div class="clear"></div>
		<!-- <article class="warp_content"> -->
		<section class="item_content">
			<div class="content">
				${productBean.product_description}
				<span class="copyright">Copyright ⓒ ARTBOX ALL rights reserved.</span>
			</div>
		</section>
		<section class="item_content">
			<c:if test="${!empty id}">
				<input class="btn-review" type="button" value="후기작성" onclick="location.href='${pageContext.request.contextPath}/itemReview.item'">
			</c:if>
			<div class="review_content">
				<!--review목록 -->
				<!--/review목록 -->
			</div>
		</section>
		<section class="item_content">
			<c:if test="${!empty id}">
				<input class="btn-QnA modal" type="button" value="Q&amp;A작성">
			</c:if>
			<div class="question_content">
				<!--question목록 -->
				<!--/question목록 -->
			</div>
		</section>
		<!-- </article> -->
		<section class="full-screen">
			<div class="full-screen-close"></div>
			<div class="qna-overlay">
			<form action="questionWrite.item" name="questionForm" method="post" onsubmit="return qnacheck()">
				<input type="hidden" name="product_num" value="${productBean.product_num}">
				<div class="overlay-header">상품문의하기<input class="overlay-close" type="button" value=""></div>
				<span class="input">
					<span class="tt">아이디</span>&nbsp;&nbsp;&nbsp;${sessionScope.id }
					<input type="hidden" name="id" value="${sessionScope.id }"></span>
				<span class="input">
					<span class="tt">이메일 주소</span>
					<input type="text" name="email" value="" maxlength="30">
				</span>
				<span class="input">
					<span class="tt">문의분야</span>
					<select name="fild">
						<option value="" selected="selected">선택하세요</option>
						<option value="입고">입고</option>
						<option value="재고">재고</option>
						<option value="기타">기타</option>
					</select>
				</span>
				<span class="input">
					<span class="tt">제목</span>
					<input type="text" name="title" value="" maxlength="30">
				</span>
				<span class="input">
					<span class="tt">문의내용</span>
					<textarea name="content"></textarea>
					<span class="etc">*주문/배송/반품 등 일반 문의는 '고객감동센터 &gt; 1:1 문의/상담'으로 해주시기 바랍니다.</span>
				</span>
				<div class="PrivacyCheck">
					<b>개인정보 수집 및 이용에 동의합니다. <input type="checkbox" name="privacycheck1"></b>
					<p>(주)아트박스에서는 고객상담을 목적으로 개인정보(이름, 휴대폰번호, 이메일)를 수집하며, 수집한 개인정보는 전자상거래 등에서의 소비자보호에 관한 법률에 의거 상담 접수일로부터 3년 또는 5년간 보관 후 파기 합니다. 동의 거부 시 상담이 제한되거나 거부될 수 있습니다.</p>
					<b>제 3자 정보 제공에 동의합니다. <input type="checkbox" name="privacycheck2"></b>
					<p>(주)아트박스에서 고객상담을 목적으로 (주)웅진에 개인정보(이름, 휴대폰번호, 이메일)를 제공하며, 제공한 개인정보는 전자상거래 등에서의 소비자보호에 관한 법률에 의거 상담 접수일로 부터 3년 또는 5년간 보관 후 파기 합니다. 동의 거부 시 상담이 제한되거나 거부될 수 있습니다.</p>
				</div>
				<span class="button">
					<input class="btnRegProductQna" type="submit" value="등록하기">
				</span>
				<div class="clear"></div>
			</form>
			</div>
			<div class="delivery-overlay">
				<div class="overlay-header">배송비 안내<input class="overlay-close" type="button" value=""></div>
				<div class="delivery-contents">30,000원 이상 구매시 무료배송 됩니다.</div>
			</div>
			<div class="share-overlay">
				<div class="overlay-header">공유하기<input class="overlay-close" type="button" value=""></div>
				<div class="share-contents">
					<a href="http://www.facebook.com/"><img src="${pageContext.request.contextPath}/Images/item/sns_fb.png"></a>
					<a href="http://twitter.com/"><img src="${pageContext.request.contextPath}/Images/item/sns_tw.png"></a>
				</div>
			</div>
		</section>
	</div>
	<!-- /메인 콘텐츠  -->

	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  /푸터 -->
	<script type="text/javascript">
	
	//----------------탭바-------------------------
    var currentMenu;
    var menuIcon = document.querySelector('.tabBar');
    var warp = document.querySelectorAll('.item_content');
	var arrayIcon = document.querySelectorAll('.tabBar span');
	var currentWarp;
   
   // .on 제거 
    function inactivate(){
   		currentMenu.classList.remove('on');
   		currentWarp.classList.remove('on');
    };
    // .on 추가 
	function activate(param){
		param.classList.add('on');
		currentMenu = param;
		for(var i = 0 ; i < arrayIcon.length ; i++){
			if(param === arrayIcon[i]){
				warp[i].classList.add('on');
				currentWarp = warp[i];
			}
		}
	}
    
	function clickManuHandler(e){
		if(currentMenu){ //기존 .on 제거 
			inactivate();   
		};
		activate(e.target); //해당 클릭 태그 .on 추가 
	};
    
    menuIcon.addEventListener('click',clickManuHandler);
    
    //메뉴버튼 초기화 
    activate(arrayIcon[0]);
  //----------------탭바-------------------------
    
    </script>
</body>

</html>