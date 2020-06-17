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

		$("input[name=BasketIdx]").each(function(){
			if (!$(this).prop("checked")) {
				i = i + 1;
			}
		});

		if (i==0) { // 전부 체크되있으면 전체 체크해제
			$("input[name=BasketIdx]").prop("checked",false);
		} else { // 전체 체크
			$("input[name=BasketIdx]").prop("checked",true);
		}
		fnBasketCalculate();
	}
	
	$("input[name=BasketIdx]").change(function(){ // 체크버튼 클릭시 총합계 계산
		fnBasketCalculate();
	});

	fnChangeOption = function(basketidx){ // 옵션변경 창 나타나기
		if ($("#ItemListChangeOption"+basketidx).css("display")=="none") {
			$("#ItemListChangeOption"+basketidx).css("display","block");
		} else {
			$("#ItemListChangeOption"+basketidx).css("display","none");
		}
	}
	
	fnBasketArray = function(actiontype){
		var count = 0;
		var arrBasketidx = 0;

		$("input[name=BasketIdx]").each(function(){
			if ($(this).prop("checked")){
				count = count + 1;
				arrBasketidx = arrBasketidx + "," + $(this).val();
				var basketidx = $(this).parent().find("[name=BasketIdx]").val();
// 				var basketArr = $("input[name=BasketIdx]").get();
// 				var basketArr = new Array();
// 				basketidx = basketidx + "," + $(this).val()
				alert(actiontype+"\n"+basketidx+"\n"+arrBasketidx);

				if (actiontype == "ARRAYDEL") { // 선택삭제
// 					location.href = "deleteOne.basket?basketidx="+basketidx;
// 					alert('삭제되었습니다.');
				} else if (actiontype == "ARRAYBUY") { // 선택주문
					location.href = "orderAll.order?basketidx="+basketidx;
				}
			}
		});
		
		if (count<1) { // 체크된 상품 없이 버튼 클릭시
			alert("선택된 상품이 없습니다.");
			return;
		}

	}
	
	
	fnBasketOne = function(actiontype,basketidx,qty,optionidx){
// 		alert(actiontype+"\n"+basketidx+"\n"+qty+"\n"+optionidx);
		
		if (actiontype == "BUY") { // 바로주문하기 버튼 클릭시
			location.href = "orderOne.order?arrBasket=" + basketidx  + "&optionidx=" + optionidx;
		} else if (actiontype == "QTY" && optionidx == 0) { // X(특정 상품 삭제) 버튼 클릭시
			location.href = "deleteOne.basket?basketidx=" + basketidx;
			alert('삭제되었습니다.');
		} else if (actiontype == "QTY" && optionidx != 0) { // 옵션변경 버튼 클릭시
			location.href = "updateQuantity.basket?basketidx=" + basketidx + "&qty=" + qty;
			alert('변경되었습니다.');
		}

	}
	
	fnSetQty = function(basketidx,add){ // 수량 변경 옵션
		var qty = parseInt($("#Qty"+basketidx).val(),10)+parseInt(add,10);

		if (qty<0) {
			alert("0 이상의 값을 입력해야 합니다.");
			return;
		}
		$("#Qty"+basketidx).val(qty);
	}
	
	// 숫자 3자리 수마다 콤마찍기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	 
	// 콤마풀기(혹시 모를 계산을 위해)
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	
	fnBasketCalculate = function(){
		var TotalPriceSum = 0; //총 상품금액
		var TotalPriceDelivery = 0; //총 배송비
		var TotalPriceAmount = 0; //총 합계금액

		$("input[name=BasketIdx]").each(function(){ //금액 계산
			if ($(this).prop("checked")) {
				TotalPriceSum = TotalPriceSum + parseInt($(this).attr("itemprice"),10) * parseInt($(this).attr("itemquantity"),10);
				TotalPriceDelivery = TotalPriceSum>=30000?0:2500;
			}
		});
		
		TotalPriceAmount = TotalPriceSum + TotalPriceDelivery;

		$("#TotalPriceSum").text(comma(TotalPriceSum)); // 값변경
		$("#TotalPriceDelivery").text(comma(TotalPriceDelivery));
		$("#TotalPriceAmount").text(comma(TotalPriceAmount));

	}
	
		$(".btn-basketDelete").click(function(){
			var checkArr = new Array();

			$("input[name='BasketIdx']:checked").each(function(){
				checkArr.push($(this).attr("data-basketNum"));
			});

			alert('삭제되었습니다.');

			location.href = "deleteOne.basket?arrBasket=" + checkArr;
		});

		$(".btn-basket").click(function(){ // 주문버튼 클릭 시
			var checkArr = new Array();

			$("input[name='BasketIdx']:checked").each(function(){
				checkArr.push($(this).attr("data-basketNum"));
			});

			location.href = "orderOne.order?arrBasket="+checkArr;
		});
	
	

	fnBasketCalculate();
});
</script>
<style type="text/css">
.btn-basket {background-color:black; border: 1px solid #424242; color: white; font-size: 22px; font-weight: bold; padding: 15px 80px; border-radius: 5px;}
.btn-basketDelete {border: 1px solid #424242; background-color:white;  margin:0 7px 0 0; color: #424242; font-size: 15px; padding: 8.5px 25px 8.8px 25px; border-radius: 5px;}
</style>
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
	<h1>장바구니 터엉~</h1>
	<div class="BasketEmpty">
		<span class="EmptyImage"><img src="${pageContext.request.contextPath}/Images/order/basket_empty_pc.png"></span>
		장바구니에 담긴 상품이 없습니다.<br />
		관심있는 상품을 담아보세요.
		<a href="/artbox_clone/login.basket">쇼핑하러 가기</a>
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
		<div class="tableDiv BasketRow">
			<dl class="trBasket ${basketList.basket_num }" >
				<dt class="tdCheck">
					<input type="checkbox" name="BasketIdx" id="Item${basketList.basket_num }" value="${basketList.basket_num }" data-basketNum="${basketList.basket_num }" realitemprice="${itemsList[status.index].product_sale_price}" itemprice="${itemsList[status.index].product_price}" itemquantity="${basketList.basket_quantity }" >
				</dt>
				<dt class="tdImage"><a href="productDetail.basket?product_num=${basketList.basket_product_num }"><img src="basket/${itemsList[status.index].product_image }"></a></dt>
				<dt class="tdInner">
					<div class="tableDiv">
						<dl class="trInfo">
							<dd>
								<div class="BasketListItemName">${itemsList[status.index].product_name } (${itemsList[status.index].product_code })
								</div>
								<div class="BasketListPrice">
								<fmt:formatNumber value="${price }" pattern="#,###"/> 원 X ${basketList.basket_quantity }개 = <fmt:formatNumber value="${price*basketList.basket_quantity}" pattern="#,###"/>원
								</div>
							</dd>
							<dd class="tdDelete"><a class="BasketButtonX" href="javascript:fnBasketOne('QTY','${basketList.basket_num }',0,0);"><img src="${pageContext.request.contextPath}/Images/order/basket_x.png"></a></dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trInfo">
							
							<dd><a class="BasketButton" href="javascript:fnChangeOption('${basketList.basket_num }');">옵션변경</a></dd>
							
							<dd class="tdBtn1"><a class="BasketButton" href="javascript:fnBasketOne('WISH','${basketList.basket_num }',0,0);">위시리스트</a></dd>
							<dd class="tdBtn2"><a class="BasketButtonDark" href="javascript:fnBasketOne('BUY','${basketList.basket_num }',0,${basketList.basket_product_num });">바로주문</a></dd>
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
	<input type="button" value="선택삭제" class="btn-basketDelete">
	<a class="BasketButton" href="javascript:GA_event('장바구니', '하단', '위시리스트'); fnBasketArray('ARRAYWISH');">위시리스트</a>
	<div class="BasketPrice">
		<div class="PriceDetail">
			<div class="tableDiv">
				<dl class="trBasketPrice"> 
					<dt>총 상품금액</dt>
					<dd><span id="TotalPriceSum">0</span> 원</dd>
				</dl>
<!-- 				<dl class="trBasketPrice"  style="display:none;"> -->
<!-- 					<dt>회원등급 할인금액</dt> -->
<!-- 					<dd class="grade5"><span id="TotalPriceMemberLevelDiscount">0</span> 원 [<img src="../Images/Ver1/Common/pc_top_grade5.png">0%]</dd> -->
<!-- 				</dl> -->
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
		<div class="BasketBuyButton"><input type="button" value="주문버튼" class="btn-basket"></div>
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