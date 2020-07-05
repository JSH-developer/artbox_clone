<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/order/Order.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>

<script type="text/javascript">
$(document).ready(function(){

	// 체크 제어
	fnCheckAll = function(){
		var i = 0
		$("input[name=BasketIdx]").each(function(){
			if (!$(this).prop("checked")) {
				i = i + 1;
			}
		});
		if (i == 0) { // 전부 체크되있으면 전체 체크해제
			$("input[name=BasketIdx]").prop("checked",false);
		} else { // 전체 체크
			$("input[name=BasketIdx]").prop("checked",true);
		}
		fnBasketCalculate();
	}
	
	// 상품 체크버튼(추가) 클릭 시 총금액 다시 계산(fnBasketCalculate() 메서드 호출)
	$("input[name=BasketIdx]").change(function(){
		fnBasketCalculate();
	});

	// 옵션변경 창 나타내기 및 숨기기
	fnChangeOption = function(basketIdx){
		if ($("#ItemListChangeOption"+basketIdx).css("display")=="none") {
			$("#ItemListChangeOption"+basketIdx).css("display","block");
		} else {
			$("#ItemListChangeOption"+basketIdx).css("display","none");
		}
	}
	
	// '바로주문하기' 및 'X버튼(삭제)' 및 '옵션변경' 버튼 클릭 이벤트
	fnBasketOne = function(actiontype, basketIdx, qty, product_num){
// 		alert(actiontype+"\n"+basketIdx+"\n"+qty+"\n"+product_num); // 값 확인용
		if (actiontype == "BUY") { // '바로주문하기' 버튼 클릭 => 특정 상품만 주문
			location.href = "order.order?basketIdx="+basketIdx+"&product_num="+product_num+"&stockqty="+qty;
		} else if (actiontype == "QTY" && qty == 0) { // 'X' 버튼 클릭 => 특정 상품만 삭제
			location.href = "deleteBasket.basket?basketIdx="+basketIdx+"&product_num="+product_num;
			alert('삭제되었습니다.');
		} else if (actiontype == "QTY" && qty != 0) { // '옵션변경' 버튼 클릭 => 수량 변경
			location.href = "updateQuantity.basket?basketIdx="+basketIdx+"&stockqty="+qty;
			alert('변경되었습니다.');
		}
	}
	
	// 상품 수량 변경 옵션
	fnSetQty = function(basketIdx, add){
		var qty = parseInt($("#Qty"+basketIdx).val(), 10) + parseInt(add, 10);
		if (qty <= 0) {
			alert("0 이상의 값을 입력해야 합니다.");
			return;
		}
		$("#Qty"+basketIdx).val(qty);
	}
	
	// 숫자 3자리 수마다 콤마찍기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	 
// 	// 콤마풀기(혹시 모를 계산을 위해)
// 	function uncomma(str) {
// 	    str = String(str);
// 	    return str.replace(/[^\d]+/g, '');
// 	}
	
	// 장바구니 금액 계산
	fnBasketCalculate = function(){
		var TotalPriceSum = 0; //총 상품금액
		var TotalPriceDelivery = 0; //총 배송비
		var TotalPriceAmount = 0; //총 합계금액


		$("input[name=BasketIdx]").each(function(){ //금액 계산
			if ($(this).prop("checked")) {
				
				TotalPriceSum = TotalPriceSum + parseInt($(this).attr("itemprice"),10) * parseInt($(this).attr("data-itemquantity"),10);
				TotalPriceDelivery = TotalPriceSum>=30000?0:2500;
			}
		});
		
		TotalPriceAmount = TotalPriceSum + TotalPriceDelivery;

		// 값 변경
		$("#TotalPriceSum").text(comma(TotalPriceSum));
		$("#TotalPriceDelivery").text(comma(TotalPriceDelivery));
		$("#TotalPriceAmount").text(comma(TotalPriceAmount));
	}

	fnBasketCalculate(); // 금액계산
});

// '주문하기' 및 '선택삭제' 버튼 클릭 이벤트
function Select(id) {
		var arrBasket = new Array(); // 장바구니 번호들을 담을 배열 생성
		var arrOption = new Array(); // 상품 번호들을 담을 배열 생성
		var arrQty = new Array();
		$("input[name='BasketIdx']:checked").each(function(){
			arrBasket.push($(this).attr("data-basketIdx")); // 체크된 장바구니 번호들을 배열에 담음
			arrQty.push($(this).attr("data-itemquantity")); // 체크된 장바구니 수량들을 배열에 담음
			arrOption.push($(this).attr("data-product_num")); // 체크된 상품 번호들을 배열에 담음
		});
		if(arrBasket=="") { // 체크된 상품이 하나도 없을 경우 (공통부분)
			alert("선택된 상품이 없습니다.");
			return;
		}
		if(id=='btn_basketDelete') { // '선택삭제' 버튼 클릭 시(체크된 상품 장바구니에서 삭제)
			alert('삭제되었습니다.');
			location.href = "deleteBasket.basket?basketIdx="+arrBasket+"&product_num="+arrOption;
		} else if (id=='btn_basketOrder') { // '주문하기' 버튼 클릭 시(체크된 상품 주문)
			location.href = "order.order?basketIdx="+arrBasket+"&stockqty="+arrQty+"&product_num="+arrOption;
		}
}
</script>
</head>
<body>

<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <form name="Basket" method="post">
<div class="BasketWrap">
<c:choose>
  <c:when test="${empty basketList }">
<!-- 장바구니가 비었을 때 -->
	<h1>장바구니 터엉~</h1><br><br>
	<div class="BasketEmpty">
		<span class="EmptyImage"><img src="${pageContext.request.contextPath}/Images/order/basket_empty_pc.png"></span><br>
		장바구니에 담긴 상품이 없습니다.<br>
		관심있는 상품을 담아보세요.
		<a href="/artbox_clone/Home.home">쇼핑하러 가기</a>
	</div>
  </c:when>

  <c:otherwise>
<!-- 장바구니에 물건이 있을 때 -->
	<h1>장바구니</h1>
	
	<div class="BasketCount">총 <b>${fn:length(basketList) }</b>개의 상품이 담겼어요!</div>
	<a class="BasketButton" href="javascript:fnCheckAll();">전체선택</a>
<!-- 	<input type="hidden" name="MemLevelIdx" value="5"> 멤버등급 -->
	<div class="BasketList">
	
<c:forEach var="basketList" items="${basketList }" varStatus="status">
	<c:set var="price" value="${itemsList[status.index].product_price }"/>
	<c:set var="sale_price" value="${itemsList[status.index].product_sale_price }"/>
	<c:set var="result_price" value="${price}"/>
	
<!-- 	할인없을때 -->
	<c:if test="${itemsList[status.index].product_sale_price == 0 }">
	<c:set var="result_price" value="${price}"/>
	</c:if>
	
<!-- 	할인 있을때 -->
	<c:if test="${itemsList[status.index].product_sale_price > 0 }">	
	
<%-- 	<c:forEach var="itembean" items="${itemcoupon}"> --%>
	 <c:if test="${!fn:contains(itemcoupon , itemsList[status.index].product_category_code)}"><!--쿠폰 있을때 -->
	 	<c:set var="result_price" value="${price - sale_price}"/>
	 	<c:set var="item_event" value="coupon"/>
	 	
	 </c:if>

<%-- 	 </c:forEach> --%>
	 
	</c:if>
	
	
	
		<div class="tableDiv BasketRow">
			<dl class="trBasket ${basketList.basket_num }" >
				<dt class="tdCheck">
					<input type="checkbox" name="BasketIdx" id="Item${basketList.basket_num }" value="${basketList.basket_num }" data-product_num="${basketList.basket_product_num }" data-basketIdx="${basketList.basket_num }" realitemprice="${itemsList[status.index].product_sale_price}" itemprice="${result_price}" data-itemquantity="${basketList.basket_quantity }" >
				</dt>
				<dt class="tdImage"><a href="itemDetail.item?product_num=${basketList.basket_product_num }"><img src="${pageContext.request.contextPath}/upload/${itemsList[status.index].product_image }"></a></dt>
				<dt class="tdInner">
					<div class="tableDiv">
						<dl class="trInfo">
							<dd>
								<div class="BasketListItemName">${itemsList[status.index].product_name } (${itemsList[status.index].product_code })
								</div>
								<div class="BasketListPrice">
								
<!-- 								할인가격이 없을때 -->
								<c:if test="${itemsList[status.index].product_sale_price == 0}">
								<fmt:formatNumber value="${price }" pattern="#,###"/> 원 X ${basketList.basket_quantity }개 = <fmt:formatNumber value="${price*basketList.basket_quantity}" pattern="#,###"/>원
								</c:if>
<!-- 								할인가격이 있을때 -->
								<c:if test="${itemsList[status.index].product_sale_price > 0}">
								<c:choose>
								 <c:when test="${fn:contains(itemcoupon, itemsList[status.index].product_category_code)}"><!--쿠폰 있을때 -->
									<fmt:formatNumber value="${price }" pattern="#,###"/> 원 X ${basketList.basket_quantity }개 = <fmt:formatNumber value="${price*basketList.basket_quantity}" pattern="#,###"/>원
								</c:when>
								
								<c:otherwise><!--쿠폰 없을때 -->
								<span style="color:grey;text-decoration: line-through;"><fmt:formatNumber value="${price }" pattern="#,###"/> 원 </span>&nbsp;
								<span style="color: red;"><fmt:formatNumber value="${price - sale_price}" pattern="#,###"/> 원 </span>
								X ${basketList.basket_quantity }개 = <fmt:formatNumber value="${(price - sale_price) *basketList.basket_quantity}" pattern="#,###"/>원
								
								</c:otherwise>
								
								</c:choose>
<%-- 								</c:if> --%>
<%-- 								</c:forEach> --%>
<%-- 								<input type="hidden" id="result_price" value="${result_price}"/> --%>
								</c:if>
								
								</div>
							</dd>
							<dd class="tdDelete"><a class="BasketButtonX" href="javascript:fnBasketOne('QTY','${basketList.basket_num }',0,'${basketList.basket_product_num }');"><img src="${pageContext.request.contextPath}/Images/order/basket_x.png"></a></dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trInfo">
							
							<dd><a class="BasketButton" href="javascript:fnChangeOption('${basketList.basket_num }');">옵션변경</a></dd>
							
							<dd class="tdBtn1"><a class="BasketButton" href="javascript:fnBasketOne('WISH','${basketList.basket_num }',0,0);">위시리스트</a></dd>
							<dd class="tdBtn2"><a class="BasketButtonDark" href="javascript:fnBasketOne('BUY','${basketList.basket_num }',${basketList.basket_quantity },${basketList.basket_product_num });">바로주문</a></dd>
						</dl>
					</div>
					<div class="ItemListChangeOption" id="ItemListChangeOption${basketList.basket_num }">
						<ul class="option">
						
							<li class="OptionIdx"><input type="hidden" name="OptionIdx" id="OptionIdx${basketList.basket_product_num }" value="${basketList.basket_product_num }"></li>
							<li class="Qty"><p><a href="javascript:fnSetQty('${basketList.basket_num }',-1);">-</a><input type="tel" name="Qty" id="Qty${basketList.basket_num }" value="${basketList.basket_quantity }" readonly="readonly" /><a href="javascript:fnSetQty('${basketList.basket_num }',1);">+</a></p></li>
							<li class="Btn"><a class="BasketButton m0" href="javascript:fnBasketOne('QTY','${basketList.basket_num }',document.getElementById('Qty${basketList.basket_num }').value,document.getElementById('OptionIdx${basketList.basket_product_num }').value);">변경완료</a></li>
						</ul>
						<div class="clear"></div>
					</div>
				</dt>
			</dl>
		</div>
</c:forEach>
	</div>
	<a class="BasketButton" href="javascript:fnCheckAll();">전체선택</a>
<!-- 	<a class="BasketButton" href="javascript:fnBasketArray('ARRAYDEL');">선택삭제</a> -->
	<input type="button" value="선택삭제" id="btn_basketDelete" onclick="Select(this.id)">
	<a class="BasketButton" href="javascript:GA_event('장바구니', '하단', '위시리스트'); fnBasketArray('ARRAYWISH');">위시리스트</a>
	<div class="BasketPrice">
		<div class="PriceDetail">
			<div class="tableDiv">
				<dl class="trBasketPrice"> 
					<dt>총 상품금액</dt>
					<dd><span id="TotalPriceSum">0</span> 원</dd>
				</dl>
				<dl class="trBasketPrice">
					<dt>배송비</dt>
					<dd><span id="TotalPriceDelivery">0</span> 원</dd>
				</dl>
			</div>
		</div>
		<div class="PriceTotal">
			총 주문금액 <span id="TotalPriceAmount">0</span> 원
		</div>
		<div class="clear"></div>
	</div>
	<div class="BasketBottom">
		<div class="BasketBuyButton"><input type="button" value="주문하기" id="btn_basketOrder" onclick="Select(this.id)"></div>
<!-- 		<a href="javascript:fnBasketArray('ARRAYBUY');">주문하기</a> -->
		<div class="BasketComment">
			장바구니에 담긴 상품은 30일 이후 자동으로 위시리스트로 이동됩니다.<br>
			단, 판매가 종료된 상품은 장바구니에서 삭제될 수 있습니다.<br>
			쿠폰은 <b>[주문 결제]</b> 페이지에서 적용됩니다.
		</div>
		<div class="clear"></div>
	</div>
  </c:otherwise>
</c:choose> 

</div>

</form>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>