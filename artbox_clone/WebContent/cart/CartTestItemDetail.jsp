<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ARTBOX(포트폴리오)</title>
    <link href="${pageContext.request.contextPath}/css/item/itemDetail.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
	<script type="text/javascript">
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
		$(document).on('click','.btnProductQnA',function(){
			$(".fullscreen").addClass("on");
		})
		$(document).on('click','.overlay_close',function(){
			$(".fullscreen").removeClass("on");
		})
		
		function cartCheck() { // 확인/취소 선택 시 장바구니 상품 담음
			var result = confirm("선택하신 상품이 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?");
			// result(확인/취소) 값을 넘겨줘서 Action 클래스에서 장바구니 페이지로 이동할지 안할지 판별
			document.gfr.action = "addCart.cart?result=" + result;
			document.gfr.submit();
		}

	</script>
</head>

<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- /헤더 -->

	<!-- 메인 콘텐츠  -->
	<div class="wrap">
		<section class="iteminfo">
			<form action="" method="post" name="gfr">
			<input type="hidden" name="num" value=1>
				<div class="slideimg">
					<ul>
						<li><img src=detail1.jpg></li>
					</ul>
				</div>
				<div class="inner">
					<div class="pdtName">클래식 캔디머신 (베이비핑크)(53008340)</div>
					<div class="pdtCategory line">
						<a href="#">인형/토이</a><a href="#">FUN/TOY</a>
					</div>
					<div class="pdtInfo">
						<span>판매가</span>8500원
					</div>
					<div class="pdtInfo">
						<span>배송비</span>2500원
					</div>
					<div class="pdtInfo">
						<span>꿈캔디</span>58개
					</div>
					<div class="pdtInfo">
						<span>상품코드</span>1805300328
					</div>
					<div class="pdtInfo line">
						<span>OK캐쉬백</span>1% 적립
					</div>
					<div class="pdtInfo line">
						<span>주문수량</span>
						<span class="ipt_layer">
							<input type="button" class="btnStockQty Minus" value="-">
							<input type="button" class="btnStockQty Plus" value="+">
							<input type="tel" name="stockqty" value="1" maxlength="3">
						</span>
					</div>
					<div class="pdtInfototal">
						총 합계금액<b>5,800 원</b>
					</div>
					<div class="pdtBtnList">
					<span class="btnCart"><input type="button" value="장바구니 담기" onclick="cartCheck()"></span>
						<span class="btnOrder"><input type="button" value="바로 구매하기"></span>
						<span class="btnWish off"></span>
						<span class="btnOverlay btnShare" data="btnShare"></span>
					</div>
				</div>
			</form>
		</section>
		<div class="clear"></div>
		<section class="item_another">
			<span class="text">이 상품의 다른 옵션</span>
			<div class="another">
				<ul>
					<li onclick='location.href="#"'>
						<img src="http://www.poom.co.kr/Upload2/Product/201805/1805300288_detail1.jpg">
						<span class="itemname">베이비 캔디머신 (레드)(53008338)</span>
						<span class="itemprice">4,900원</span>
					</li>
					<li onclick='location.href="#"'>
						<img src="http://www.poom.co.kr/Upload2/Product/201805/1805300305_detail1.jpg">
						<span class="itemname">베이비 캔디머신 (네이비)(53008339)</span>
						<span class="itemprice">4,900원</span>
					</li>
					<li onclick='location.href="#"'>
						<img src="http://www.poom.co.kr/Upload2/Product/201805/1805300332_detail1.jpg">
						<span class="itemname">클래식 캔디머신 (베이비블루)(53008341)</span>
						<span class="itemprice">4,900원</span>
					</li>
				</ul>
			</div>
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
			<input class="btnProductReview" type="button" value="후기작성" onclick="location.href='itemReview.jsp'">
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
			<div class="paging">
				<span class="box">
					<a href="#"> <img class="opacity" src="../Images/order/btn_board_prev.gif"> </a>
					<a href="#" class="btn_pageon">1</a>
					<a href="#">2</a>
					<a href="#"> <img class="paging_pc" src="../Images/order/btn_board_next.gif"> </a>
				</span>
			</div>
		</section>
		<section class="item_content">
			<input class="btnProductQnA" type="button" value="Q&amp;A작성">
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
					<a href="#"> <img class="opacity" src="../Images/order/btn_board_prev.gif"> </a>
					<a href="#" class="btn_pageon">1</a>
					<a href="#">2</a>
					<a href="#"> <img class="paging_pc" src="../Images/order/btn_board_next.gif"> </a>
				</span>
			</div>
		</section>
		<!-- </article> -->
		<section class="fullscreen">
			<form action="#" method="post">
			<div class="qna_overlay">
				<input type="hidden" name="product_code" value="xxxxxxxx">
				<span class="overlay_header">상품문의하기<input class="overlay_close" type="button" value=""></span>
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
			</div>
			</form>
		</section>
	</div>
	<!-- /메인 콘텐츠  -->

	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  /푸터 -->
	<script type="text/javascript">
    var currentMenu;
    var menuIcon = document.querySelector('.tabBar');
    var warp = document.querySelectorAll('.item_content');
	var arrayIcon = document.querySelectorAll('.tabBar span');
	var currentWarp;
   
   
    function inactivate(){
   		currentMenu.classList.remove('on');
   		currentWarp.classList.remove('on');
    };
    
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
		if(currentMenu){
			inactivate();   
		};
		activate(e.target);
	};
    
 
    menuIcon.addEventListener('click',clickManuHandler);
    
    
    activate(arrayIcon[0]);
    
    </script>
</body>

</html>