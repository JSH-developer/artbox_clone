<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="vo.CartBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/order/Order.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>

<script type="text/javascript">
$(document).ready(function(){

	fnCheckAll = function(){ // 체크
		var i = 0

		$("input[name=CartIdx]").each(function(){
			if (!$(this).prop("checked")) {
				i = i + 1;
			}
		});

		if (i==0) { // 전부 체크되있으면 전체 체크해제
			$("input[name=CartIdx]").prop("checked",false);
		} else { // 전체 체크
			$("input[name=CartIdx]").prop("checked",true);
		}
		fnCartCalculate();
	}
	
	$("input[name=CartIdx]").change(function(){ // 체크버튼 클릭시 총합계 계산
		fnCartCalculate();
	});

	fnChangeOption = function(cartidx){ // 옵션변경 창 나타나기
		if ($("#ItemListChangeOption"+cartidx).css("display")=="none") {
			$("#ItemListChangeOption"+cartidx).css("display","block");
		} else {
			$("#ItemListChangeOption"+cartidx).css("display","none");
		}
	}
	
	fnCartArray = function(actiontype){ // 선택삭제
		var count = 0;

		$("input[name=CartIdx]").each(function(){
			if ($(this).prop("checked")){
				count = count + 1;
				var cartidx = $(this).parent().find("[name=CartIdx]").val();

				if (actiontype == "ARRAYDEL") {
					location.href = "deleteOne.cart?cartidx="+cartidx;
					alert('삭제되었습니다.');
				}
			}
		});
		
		if (count<1) { // 체크된 상품 없이 선택 삭제 클릭시
			alert("선택된 상품이 없습니다.");
			return;
		}

	}
	
	
	fnCartOne = function(actiontype,cartidx,qty,optionidx){
// 		alert(actiontype+"\n"+cartidx+"\n"+qty+"\n"+optionidx);
		
		if (actiontype == "BUY") { // 바로주문하기 버튼 클릭시
			
		} else if (actiontype == "QTY" && optionidx == 0) { // X(특정 상품 삭제) 버튼 클릭시
			location.href = "deleteOne.cart?cartidx=" + cartidx;
			alert('삭제되었습니다.');
		} else if (actiontype == "QTY" && optionidx != 0) { // 옵션변경 버튼 클릭시
			location.href = "updateQuantity.cart?cartidx=" + cartidx + "&qty=" + qty;
			alert('변경되었습니다.');
		}

	}
	
	fnSetQty = function(cartidx,add){ // 수량 변경 옵션
		var qty = parseInt($("#Qty"+cartidx).val(),10)+parseInt(add,10);

		if (qty<0) {
			alert("0 이상의 값을 입력해야 합니다.");
			return;
		}
		$("#Qty"+cartidx).val(qty);
	}
	
	// 콤마찍기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	 
	// 콤마풀기
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	
	fnCartCalculate = function(){
		var TotalPriceSum = 0; //총 상품금액
		var TotalPriceDelivery = 0; //총 배송비
		var TotalPriceAmount = 0; //총 합계금액

		$("input[name=CartIdx]").each(function(){ //금액 계산
			if ($(this).prop("checked")) {
				TotalPriceSum = TotalPriceSum + parseInt($(this).attr("itemprice"),10) * parseInt($(this).attr("itemquantity"),10);
				TotalPriceDelivery = TotalPriceSum>30000?0:2500;
			}
		});
		
		TotalPriceAmount = TotalPriceSum + TotalPriceDelivery;

		$("#TotalPriceSum").text(comma(TotalPriceSum)); // 값변경
		$("#TotalPriceDelivery").text(comma(TotalPriceDelivery));
		$("#TotalPriceAmount").text(comma(TotalPriceAmount));

	}

	fnCartCalculate();
});
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
<c:choose>
  <c:when test="${empty cartList }">
<!-- 장바구니가 비었을 때 -->
	<h1>장바구니 터엉~</h1>
	<div class="CartEmpty">
		<span class="EmptyImage"><img src="${pageContext.request.contextPath}/Images/order/cart_empty_pc.png"></span>
		장바구니에 담긴 상품이 없습니다.<br />
		관심있는 상품을 담아보세요.
		<a href="/artbox_clone/login.cart">쇼핑하러 가기</a>
	</div>
  </c:when>

  <c:otherwise>
<!-- 장바구니에 물건이 있을 때 -->
	<h1>장바구니</h1>
	
	<div class="CartCount">총 <b>${fn:length(cartList) }</b>개의 상품이 담겼어요!</div>
	<a class="CartButton" href="javascript:fnCheckAll();">전체선택</a>
<!-- 	<input type="hidden" name="MemLevelIdx" value="5"> 멤버등급 -->
	<div class="CartList">
	
<c:forEach var="cartList" items="${cartList }" varStatus="status">
	<c:set var="price" value="${itemsList[status.index].product_price }"/>
		<div class="tableDiv CartRow">
			<dl class="trCart ${cartList.cart_num }" >
				<dt class="tdCheck">
					<input type="checkbox" name="CartIdx" id="Item${cartList.cart_num }" value="${cartList.cart_num }" realitemprice="${itemsList[status.index].product_sale_price}" itemprice="${itemsList[status.index].product_price}" itemquantity="${cartList.cart_quantity }" >
				</dt>
				<dt class="tdImage"><a href="productDetail.cart?product_num=${cartList.cart_product_num }"><img src="cart/${itemsList[status.index].product_image }"></a></dt>
				<dt class="tdInner">
					<div class="tableDiv">
						<dl class="trInfo">
							<dd>
								<div class="CartListItemName">${itemsList[status.index].product_name } (${itemsList[status.index].product_code })
								</div>
								<div class="CartListPrice">
								<fmt:formatNumber value="${price }" pattern="#,###"/> 원 X ${cartList.cart_quantity }개 = <fmt:formatNumber value="${price*cartList.cart_quantity}" pattern="#,###"/>원
								</div>
							</dd>
							<dd class="tdDelete"><a class="CartButtonX" href="javascript:fnCartOne('QTY','${cartList.cart_num }',0,0);"><img src="${pageContext.request.contextPath}/Images/order/cart_x.png"></a></dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trInfo">
							
							<dd><a class="CartButton" href="javascript:fnChangeOption('${cartList.cart_num }');">옵션변경</a></dd>
							
							<dd class="tdBtn1"><a class="CartButton" href="javascript:fnCartOne('WISH','${cartList.cart_num }',0,0);">위시리스트</a></dd>
							<dd class="tdBtn2"><a class="CartButtonDark" href="javascript:fnCartOne('BUY','${cartList.cart_num }',0,0);">바로주문</a></dd>
						</dl>
					</div>
					<div class="ItemListChangeOption" id="ItemListChangeOption${cartList.cart_num }">
						<ul class="option">
						
							<li class="OptionIdx"><input type="hidden" name="OptionIdx" id="OptionIdx${cartList.cart_product_num }" value="${cartList.cart_product_num }"></li>
							<li class="Qty"><p><a href="javascript:fnSetQty('${cartList.cart_num }',-1);">-</a><input type="tel" name="Qty" id="Qty${cartList.cart_num }" value="${cartList.cart_quantity }" readonly="readonly" /><a href="javascript:fnSetQty('${cartList.cart_num }',1);">+</a></p></li>
							<li class="Btn"><a class="CartButton m0" href="javascript:fnCartOne('QTY','${cartList.cart_num }',document.getElementById('Qty${cartList.cart_num }').value,document.getElementById('OptionIdx${cartList.cart_product_num }').value);">변경완료</a></li>
						</ul>
						<div class="clear"></div>
					</div>
				</dt>
			</dl>
		</div>
</c:forEach>
	</div>
	<a class="CartButton" href="javascript:fnCheckAll();">전체선택</a><a class="CartButton" href="javascript:fnCartArray('ARRAYDEL');">선택삭제</a><a class="CartButton" href="javascript:GA_event('장바구니', '하단', '위시리스트'); fnCartArray('ARRAYWISH');">위시리스트</a>
	<div class="CartPrice">
		<div class="PriceDetail">
			<div class="tableDiv">
				<dl class="trCartPrice">
					<dt>총 상품금액</dt>
					<dd><span id="TotalPriceSum">0</span> 원</dd>
				</dl>
<!-- 				<dl class="trCartPrice"  style="display:none;"> -->
<!-- 					<dt>회원등급 할인금액</dt> -->
<!-- 					<dd class="grade5"><span id="TotalPriceMemberLevelDiscount">0</span> 원 [<img src="../Images/Ver1/Common/pc_top_grade5.png">0%]</dd> -->
<!-- 				</dl> -->
				<dl class="trCartPrice">
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
	<div class="CartBottom">
		<div class="CartBuyButton"><a href="OrderPay.jsp">주문하기</a></div>
		<div class="CartComment">
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