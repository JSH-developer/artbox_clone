<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="../css/front.css" rel="stylesheet" type="text/css">
<!-- <link href="../css/order/Common.css" rel="stylesheet" type="text/css"> -->
<link href="../css/order/Order.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-3.5.0.js"></script>

<script type="text/javascript">
$(document).ready(function(){

	fnCheckAll = function(){
		var i = 0

		$("input[name=CartIdx]").each(function(){
			if (!$(this).prop("checked")) {
				i = i + 1;
			}
		});

		if (i==0) { //전부 체크되있으면 전체 체크해제
			$("input[name=CartIdx]").prop("checked",false);
		} else { //전체 체크
			$("input[name=CartIdx]").prop("checked",true);
		}
		
	}


	fnChangeOption = function(cartidx){
		if ($("#ItemListChangeOption"+cartidx).css("display")=="none") {
			$("#ItemListChangeOption"+cartidx).css("display","block");
		} else {
			$("#ItemListChangeOption"+cartidx).css("display","none");
		}
	}

});
</script>

<script type="text/javascript">
var sell_price;
var Qty;

function init () {
	sell_price = document.Cart.sell_price.value;
	Qty = document.Cart.Qty.value;
	document.Cart.sum.value = sell_price;
	change();
}

function add () {
	hm = document.Cart.Qty;
	sum = document.Cart.sum;
	hm.value ++ ;
}

function del () {
	hm = document.Cart.Qty;
	sum = document.Cart.sum;
		if (hm.value > 1) {
			hm.value -- ;
		}
}

function change () {
	hm = document.Cart.Qty;
	sum = document.Cart.sum;

		if (hm.value < 0) {
			hm.value = 0;
		}
	sum.value = parseInt(hm.value) * sell_price;
}  
</script>
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 
 <form name="Cart" method="post">

<div class="CartWrap">

<!-- 장바구니가 비었을 때 -->
<!-- 	<h1>장바구니 터엉~</h1> -->
<!-- 	<div class="CartEmpty"> -->
<!-- 		<span class="EmptyImage"><img src="../Images/order/cart_empty_pc.png"></span> -->
<!-- 		장바구니에 담긴 상품이 없습니다.<br /> -->
<!-- 		관심있는 상품을 담아보세요. -->
<!-- 		<a href="../home/home">쇼핑하러 가기</a> -->
<!-- 	</div> -->

<!-- 장바구니에 물건이 있을 때 -->
	<h1>장바구니</h1>
	
	<div class="CartCount">총 <b>1</b>개의 상품이 담겼어요!</div>
	<a class="CartButton" href="javascript:fnCheckAll();">전체선택</a>
	<input type="hidden" name="MemLevelIdx" value="5">
	<div class="CartList">
	
		<div class="tableDiv CartRow">
			<dl class="trCart 3318798" >
				<dt class="tdCheck">
					<input type="checkbox" name="CartIdx" id="Item3318798" value="3318798" realitemprice="25000" itemprice="25000" freedeliyn="N" >
<!-- 					<input type="hidden" name="jsItemName" id="jsItemName3318798" value="핑크 비숑 13인치 노트북파우치 (37002786)"> -->

<!-- 					<input type="hidden" name="GAitemidx" value="2002200265">	 -->
<!-- 					<input type="hidden" name="GAitemnamekor" value="핑크 비숑 13인치 노트북파우치 (37002786)">	 -->
<!-- 					<input type="hidden" name="GAbrandnmkor" value="아트박스">	 -->
<!-- 					<input type="hidden" name="GAcatename" value="디지털>컴퓨터/노트북주변기기>노트북/태블릿 파우치">	 -->
<!-- 					<input type="hidden" name="GAitemprice" value="25000">	 -->
<!--  					<input type="hidden" name="GAqty" value="1">	 -->
<!-- 					<input type="hidden" name="GAitemcouponname" value="">	 -->
<!-- 					<input type="hidden" name="GAoptionmixname" value="">	 -->
<!-- 					<input type="hidden" name="GAdiscountrate" value="0">	 -->


				</dt>
				<dt class="tdImage"><a href="/Home/Shop/ItemDetail.asp?itemidx=2002200265"><img src="http://www.poom.co.kr/Upload2/Product/202002/2002200265_list.jpg"></a></dt>
				<dt class="tdInner">
					<div class="tableDiv">
						<dl class="trInfo">
							<dd>
								<div class="CartListItemName">핑크 비숑 13인치 노트북파우치 (37002786)
								</div>
								<div class="CartListPrice">
								25,000원 X 1개 = 25,000원
								</div>
							</dd>
							<dd class="tdDelete"><a class="CartButtonX" href="javascript:fnCartOne('QTY','3318798',0,0);"><img src="../Images/order/cart_x.png"></a></dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trInfo">
							
							<dd><a class="CartButton" href="javascript:fnChangeOption('3318798');">옵션변경</a></dd>
							
							<dd class="tdBtn1"><a class="CartButton" href="javascript:fnCartOne('WISH','3318798',0,0);">위시리스트</a></dd>
							<dd class="tdBtn2"><a class="CartButtonDark" href="javascript:fnCartOne('BUY','3318798',0,0);">바로주문</a></dd>
						</dl>
					</div>
					<div class="ItemListChangeOption" id="ItemListChangeOption3318798">
						<ul class="option">
						
							<li class="OptionIdx"><input type="hidden" name="OptionIdx" id="OptionIdx3318798" value=""></li>
						
							<li class="Qty"><p><a href="javascript:void(0);" onclick="del();">-</a><input type=hidden name="sell_price" value="25000"><input type="tel" name="Qty" id="Qty3318798" value="1" onchange="change();" readonly="readonly" ><a href="javascript:void(0);" onclick="add();">+</a></p></li>
							<li class="Btn"><a class="CartButton m0" href="javascript:void(0);" onclick="init();">변경완료</a></li>
						</ul>
						<div class="clear"></div>
					</div>
				</dt>
			</dl>
		</div>
	
	</div>
	<a class="CartButton" href="javascript:fnCheckAll();">전체선택</a><a class="CartButton" href="javascript:fnCartArray('ARRAYDEL');">선택삭제</a><a class="CartButton" href="javascript:GA_event('장바구니', '하단', '위시리스트'); fnCartArray('ARRAYWISH');">위시리스트</a>
	<div class="CartPrice">
		<div class="PriceDetail">
			<div class="tableDiv">
				<dl class="trCartPrice">
					<dt>총 상품금액</dt>
					<dd><span id="TotalPriceSum">25,000</span> 원</dd>
				</dl>
<!-- 				<dl class="trCartPrice"  style="display:none;"> -->
<!-- 					<dt>회원등급 할인금액</dt> -->
<!-- 					<dd class="grade5"><span id="TotalPriceMemberLevelDiscount">0</span> 원 [<img src="../Images/Ver1/Common/pc_top_grade5.png">0%]</dd> -->
<!-- 				</dl> -->
				<dl class="trCartPrice">
					<dt>배송비</dt>
					<dd><span id="TotalPriceDelivery">2,500</span> 원</dd>
				</dl>
			</div>
		</div>
		<div class="PriceTotal">
			총 주문금액 <span id="TotalPriceAmount">27,500</span> 원
			<input type="text" id="order" name="sum" readonly>
		</div>
		<div class="clear"></div>
	</div>
	<div class="CartBottom">
		<div class="CartBuyButton"><a href="OrderPay.jsp">주문하기</a></div>
		<div class="CartComment">
			장바구니에 담긴 상품은 30일 이후 자동으로 위시리스트로 이동됩니다.<br>
			단, 판매가 종료된 상품은 장바구니에서 삭제될 수 있습니다.<br>
			쿠폰은 <b>[주문 결제]</b> 페이지에서 적용됩니다.
		</div>
		<div class="clear"></div>
	</div>

</div>

</form>
 
 
 
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>