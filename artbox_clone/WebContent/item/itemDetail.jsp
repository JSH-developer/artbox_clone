<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ARTBOX(포트폴리오)</title>
    <link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/item/itemDetail.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/item/swiper.min.css" rel="stylesheet" type="text/css">
	<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
	<c:set var="price" value="8500"/>
	<script type="text/javascript">
	// 후기,qna 테이블 클릭시 토글 오픈
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
	// 버튼 클릭시 수량 변동
	$(document).on("click", ".btnStockQty", function(){
		var obj = $(this).parent().find("input[type=tel]");
		if ($(this).hasClass("Minus")) {
			if (parseInt(obj.val(),10)-1 <= 0) {
				alert("주문수량은 1 이상이어야 합니다.");
				obj.val("1");
			} else {
				obj.val(parseInt(obj.val(),10)-1);
			}
		}
		if ($(this).hasClass("Plus")) {
			obj.val(parseInt(obj.val(),10)+1);
		}

		fnCheckPriseSum();
	});
	//수량 변동시 가격 변동
	$(document).on("blur", "[name=stockqty]", function(){//포커스 없어졌을때
		if ($.isNumeric($(this).val()) == false){
			$(this).val(1);
		}
		fnCheckPriseSum();
	});
	$(document).on("keyup", "[name=stockqty]", function(){//키 눌렀을때
		if ($.isNumeric($(this).val()) == false){
			$(this).val(1);
		}
		fnCheckPriseSum();
	});
	function fnCheckPriseSum(){
		var returnValue = parseInt(${price},10)* parseInt($("[name=stockqty]").val(),10);
		$(".pdt-totalprice").html(commas(returnValue) + " 원");
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
				alert('상품이 위시리스트에서 제거되었습니다.');
			} else {
				$(this).removeClass("off");
				$(this).addClass("on");
				alert('상품이 위시리스트에 추가되었습니다.');
			}
		}
	});
	</script>
</head>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- /헤더 -->

	<!-- 메인 콘텐츠  -->
	<div class="wrap">
		<section class="item-info">
			<form action="#" method="post">
				<input type="hidden" name="pdt-price" value="8500">
				<div class="img-info">
					<div class="mainslide swiper-container">
						<ul class="swiper-wrapper">
							<li class="swiper-slide"><img src="http://www.poom.co.kr/Upload2/Product/201805/1805300288_detail1.jpg"></li>
							<li class="swiper-slide"><img src="http://www.poom.co.kr/Upload2/Product/201805/1805300305_detail1.jpg"></li>
							<li class="swiper-slide"><img src="http://www.poom.co.kr/Upload2/Product/201805/1805300332_detail1.jpg"></li>
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
					<div class="pdt-name">클래식 캔디머신 (베이비핑크)(53008340)</div>
					<div class="pdt-category"><a href="#">인형/토이</a> > <a href="#">FUN/TOY</a></div>
					<div class="pdt-right pdt-price">${price}원</div>
					<div class="pdt-right pdt-delivery">2,500원
						<input type="button" class="btn-delivery modal" value="배송비 안내">
					</div>
					<div class="pdt-right pdt-candy">58개</div>
					<div class="pdt-right pdt-code">1805300328</div>
					<div class="pdt-right pdt-ok">1% 적립</div>
					<div class="pdt-right pdt-count">
						<span class="ipt_layer">
							<input type="button" class="btnStockQty Minus" value="-">
							<input type="button" class="btnStockQty Plus" value="+">
							<input type="tel" name="stockqty" value="1" maxlength="3">
						</span>
					</div>
					<div class="pdt-right pdt-totalprice"><c:out value="${price}" />원</div>
					<div class="pdt-btnlist">
						<span class="btnCart"><input type="button" value="장바구니 담기"></span>
						<span class="btnOrder"><input type="button" value="바로 구매하기"></span>
						<span class="btn-share modal"></span>
						<span class="btn-wish off"></span>
					</div>
				</div>
			</form>
		</section>
		<div class="clear"></div>
		<section class="item-another">
			<div class="another-text">이 상품의 다른 옵션</div>
			<div class="another-list swiper-container">
				<ul class="swiper-wrapper">
					<li class="swiper-slide" onclick='location.href="#"'>
						<img src="http://www.poom.co.kr/Upload2/Product/201805/1805300288_detail1.jpg">
						<div class="another-info">
							<span class="another-name">베이비 캔디머신 (레드)(53008338)</span>
							<span class="another-price">4,900원</span>
						</div>
					</li>
					<li class="swiper-slide" onclick='location.href="#"'>
						<img src="http://www.poom.co.kr/Upload2/Product/201805/1805300305_detail1.jpg">
						<div class="another-info">
							<span class="another-name">베이비 캔디머신 (네이비)(53008339)</span>
							<span class="another-price">4,900원</span>
						</div>
					</li>
					<li class="swiper-slide" onclick='location.href="#"'>
						<img src="http://www.poom.co.kr/Upload2/Product/201805/1805300332_detail1.jpg">
						<div class="another-info">
							<span class="another-name">클래식 캔디머신 (베이비블루)(53008341)</span>
							<span class="another-price">4,900원</span>
						</div>
					</li>
					<li class="swiper-slide" onclick='location.href="#"'>
						<img src="http://www.poom.co.kr/Upload2/Product/201805/1805300332_detail1.jpg">
						<div class="another-info">
							<span class="another-name">클래식 캔디머신 (베이비블루)(53008341)</span>
							<span class="another-price">4,900원</span>
						</div>
					</li>
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
		<div class="clear"></div>
		<section class="item_content_bar">
			<div class="tabBar">
				<span>상품상세</span> <span>상품후기(2)</span> <span>상품Q&amp;A(2)</span>
			</div>
		</section>
		<div class="clear"></div>
		<!-- <article class="warp_content"> -->
		<section class="item_content">
			<div class="contentsTopTop">클래식 캔디머신 (베이비핑크)(53008340)</div>
			<div style="margin: 0 auto; width: 37px; height: 3px; background-color: #000000;"></div>
			<div class="contentsTopBottom">
				사탕이나 초코볼 등을 가득 담아놓고 뽑아 먹는 재미가 쏠쏠한 베이비 캔디머신입니다.<br>
				연인, 친구, 가족 등 사랑하는 사람들에게 사탕, 초코볼, 젤리 등 달콤함을 가득 담아 선물해보세요!<br>
			</div>
			<div class="content">
				<img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503601355265.jpg">
				<img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503602276476.jpg">
				<img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503600209719.jpg">
				<img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503599165375.jpg">
				<img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503597933043.jpg">
				<img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503595754264.jpg">
				<img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503596887597.jpg">
				<span>Copyright ⓒ ARTBOX ALL rights reserved.</span>
			</div>
		</section>
		<section class="item_content">
			<div class="item_review">
			<input class="btn-review" type="button" value="후기작성" onclick="location.href='itemReview.jsp'">
		<div class="table">
				<div class="tr">
					<span class="td">★★★★★</span>
					<span class="td type2">평소에 캔디머신을 구매할까하고 생각했었는데, 대부분 컬러가 원색만 있어...</span>
					<span class="td">2019-12-28</span>
					<span class="td">besi**</span>
				</div>
				<div class="ps">
					<span class="ps_score">10</span>
					<div class="ps_sub1">
						<span>기능 ★★★★★</span> <span>디자인 ★★★★★</span> <span>가격 ★★★★★</span> <span>품질 ★★★★★</span>
					</div>
					<div class="ps_sub2">평소에 캔디머신을 구매할까 하고 생각했었는데, 대부분 컬러가 원색만
						있어서 좀 망설여졌었어요. 근데 아트박스에서 너무 예쁜 베이비핑크 컬러로 캔디머신이 나왔기에 냉큼 구입했습니다.
						생각했던 컬러 그대로라 너무 만족합니다ㅎㅎ 크기도 너무 작지 않아서 좋아요. 그리고 위 아래로 통이 분리된다는게 최대
						장점입니다. 세척하기도 편하고 용이해서 더 좋아요.
					</div>
					<div class="ps_sub3">
						<img src="http://www.poom.co.kr/Upload2/PostScript/201912/1805300328_0_123034_1.jpg">
					</div>
				</div>
			</div>
		</div>
			
			<div class="paging">
				<span class="box">
					<a href="#"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
					<a href="#" class="btn_pageon">1</a>
					<a href="#">2</a>
					<a href="#"> <img class="paging_pc" src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
				</span>
			</div>
		</section>
		<section class="item_content">
			<input class="btn-QnA modal" type="button" value="Q&amp;A작성">
			<div class="table">
				<div class="tr">
					<span class="td">답변완료</span>
					<span class="td type2">배송 언제 되나요?</span>
					<span class="td">2020-04-28</span>
					<span class="td">saemi03**</span>
				</div>
				<div class="ps">
					<div class="qna">
						<span>Q</span> 운송장번호 조회하면 배송이 완료되었다고 하는데..물건이 오지 않았습니다. 아직 택배가 오지
						않은 건지, 혹은 오배송인지 걱정이 되네요.
					</div>
					<div class="qna">
						<span>A</span> 고객님 안녕하세요. 문의하신 내용 관련하여 [1:1 문의/상담]란에 글 남겨주시어 답변으로
						자세한 안내를 드렸습니다. 안내드린 답변 참조를 부탁드립니다. 감사합니다.
					</div>
				</div>
			</div>
			<div class="table">
				<div class="tr">
					<span class="td">답변완료</span>
					<span class="td type2">상품문의</span>
					<span class="td">2020-04-21</span>
					<span class="td">gmark**</span>
				</div>
				<div class="ps">
					<div class="qna">
						<span>Q</span> 안녕하세요. 저번에 구매했다 작동 불량으로 반품하고 재구매입니다. 상태 정상적인 제품으로
						부탁드립니다.
					</div>
					<div class="qna">
						<span>A</span> 고객님 안녕하세요, 상품 출고시 최대한 하자없는 상품으로 출고를 도와드리고는 있으나 수많은
						주문량으로 인해 개별 검수 확인은 어려울 수 있는 점 참조 부탁드리며~ 상품 수령 후 문제가 있는 경우 구매처 혹은
						[고객감동센터 1577-9081]로 문의를 부탁드리겠습니다. 감사합니다.
					</div>
				</div>
			</div>
			<div class="paging">
				<span class="box">
					<a href="#"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
					<a href="#" class="btn_pageon">1</a>
					<a href="#">2</a>
					<a href="#"> <img class="paging_pc" src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
				</span>
			</div>
		</section>
		<!-- </article> -->
		<section class="full-screen">
			<div class="qna-overlay">
			<form action="#" method="post">
				<input type="hidden" name="product_code" value="xxxxxxxx">
				<div class="overlay-header">상품문의하기<input class="overlay-close" type="button" value=""></div>
				<span class="input">
					<span class="tt">아이디</span>
					&nbsp;&nbsp;&nbsp;guest<input type="hidden" name="Id" value="guest"></span>
				<span class="input">
					<span class="tt">이메일 주소</span>
					<input type="text" name="Email" value="" maxlength="30">
				</span>
				<span class="input">
					<span class="tt">문의분야</span>
					<select name="qnaType">
						<option value="" selected="selected">선택하세요</option>
						<option value="01">입고</option>
						<option value="02">재고</option>
						<option value="03">기타</option>
					</select>
				</span>
				<span class="input">
					<span class="tt">제목</span>
					<input type="text" name="Title" value="" maxlength="30">
				</span>
				<span class="input">
					<span class="tt">문의내용</span>
					<textarea name="strContents"></textarea>
					<span class="etc">*주문/배송/반품 등 일반 문의는 '고객감동센터 &gt; 1:1 문의/상담'으로 해주시기 바랍니다.</span>
				</span>
				<div class="PrivacyCheck">
					<b>개인정보 수집 및 이용에 동의합니다. <input type="checkbox" name="privacycheck1"></b>
					<p>(주)아트박스에서는 고객상담을 목적으로 개인정보(이름, 휴대폰번호, 이메일)를 수집하며, 수집한 개인정보는 전자상거래 등에서의 소비자보호에 관한 법률에 의거 상담 접수일로부터 3년 또는 5년간 보관 후 파기 합니다. 동의 거부 시 상담이 제한되거나 거부될 수 있습니다.</p>
					<b>제 3자 정보 제공에 동의합니다. <input type="checkbox" name="privacycheck2"></b>
					<p>(주)아트박스에서 고객상담을 목적으로 (주)웅진에 개인정보(이름, 휴대폰번호, 이메일)를 제공하며, 제공한 개인정보는 전자상거래 등에서의 소비자보호에 관한 법률에 의거 상담 접수일로 부터 3년 또는 5년간 보관 후 파기 합니다. 동의 거부 시 상담이 제한되거나 거부될 수 있습니다.</p>
				</div>
				<span class="button">
					<input class="btnRegProductQna" type="button" value="등록하기">
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
					<img src="${pageContext.request.contextPath}/Images/item/sns_fb.png">
					<img src="${pageContext.request.contextPath}/Images/item/sns_tw.png">
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
    
    
    //---------------이미지 슬라이더----------------------------
    /*console.log(window.getComputedStyle(document.querySelector(".slideimg")).width);
    console.log(window.getComputedStyle(document.querySelector(".slideimg")).height);
    var slider = document.querySelector(".slideimg");
    var left_btn = document.querySelector(".img_left_btn");
    var right_btn = document.querySelector(".img_right_btn");
    var img_count = 0;
    var left_point = document.querySelector(".img_left_point");
    var right_point = document.querySelector(".img_right_point");
    
    function side_right(){
    	console.log(img_count);
    	left_point.style.opacity="0.3";
    	right_point.style.opacity="1.0";
    	
    	right_point.style.right="400px";
    	left_point.style.right="420px";
    	if(img_count<1){
    		img_count++;
    		slider.style.top = "-552px";
    	}
    	if(img_count===1){
    		right_btn.style.display="none";
    	}else{
    		left_btn.style.display="inline-block";
    	}
    };
    
    right_btn.addEventListener("click",side_right);
   	
    function slide_left(){
    	console.log(img_count);
    	left_point.style.opacity="1.0";
    	right_point.style.opacity="0.3";
    	
    	right_point.style.right="500px";
    	left_point.style.right="520px";
    	if(img_count>0){
    		img_count--;
    		slider.style.top = "0px";
    	}
    	if(img_count===0){
    		right_btn.style.display="inline-block";
    	}else{
    		left_btn.style.display="none";
    	}
    };
    
    left_btn.addEventListener("click",slide_left);
    */
  //---------------이미지 슬라이더----------------------------
    
    </script>
</body>

</html>