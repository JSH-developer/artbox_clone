<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="vo.CartBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<!-- <link href="../css/order/Common.css" rel="stylesheet" type="text/css"> -->
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
// 		var TotalPriceMemberLevelDiscount = 0; //회원등급 할인금액
		var TotalPriceDelivery = 0; //총 배송비
		var TotalPriceAmount = 0; //총 합계금액
// 		var TotalPriceAmountTemp = 0; //총 상품금액(등급할인 적용 후)
// 		var MemLevelIdx = parseInt(document.Cart.MemLevelIdx.value,10);

		$("input[name=CartIdx]").each(function(){ //금액 계산
			if ($(this).prop("checked")) {
				TotalPriceSum = TotalPriceSum + parseInt($(this).attr("itemprice"),10) * parseInt($(this).attr("itemquantity"),10);
				TotalPriceDelivery = TotalPriceSum>30000?0:2500;
			}
		});

// 		switch(MemLevelIdx){
// 			case 1: PoomTermsPrice=0; break;
// 			case 2: PoomTermsPrice=10000; break;
// 			case 3: PoomTermsPrice=20000; break;
// 			default: PoomTermsPrice=30000;
// 		}

// 		TotalPriceDelivery = result;
		
		TotalPriceAmount = TotalPriceSum + TotalPriceDelivery;
// 		TotalPriceMemberLevelDiscount = TotalPriceSum-TotalPriceAmountTemp;

		$("#TotalPriceSum").text(comma(TotalPriceSum)); // 값변경
// 		$("#TotalPriceMemberLevelDiscount").text(setComma(TotalPriceMemberLevelDiscount));
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
<%
List cartList = (List)request.getAttribute("cartList");
List itemsList = (List)request.getAttribute("itemsList");
DecimalFormat comma = new DecimalFormat("###,###");
%>
<div class="CartWrap">
<%-- <c:set var="cartList" value="${requestScope.cartList }" /> --%>
<c:choose>
  <c:when test="${empty cartList }">
<!-- 장바구니가 비었을 때 -->
	<h1>장바구니 터엉~</h1>
	<div class="CartEmpty">
		<span class="EmptyImage"><img src="${pageContext.request.contextPath}/Images/order/cart_empty_pc.png"></span>
		장바구니에 담긴 상품이 없습니다.<br />
		관심있는 상품을 담아보세요.
		<a href="/cart/login.cart">쇼핑하러 가기</a>
	</div>
  </c:when>
  <c:otherwise>
<!-- 장바구니에 물건이 있을 때 -->
	<h1>장바구니</h1>
	
	<div class="CartCount">총 <b><%=cartList.size() %></b>개의 상품이 담겼어요!</div>
	<a class="CartButton" href="javascript:fnCheckAll();">전체선택</a>
<!-- 	<input type="hidden" name="MemLevelIdx" value="5"> 멤버등급 -->
	<div class="CartList">
	

<%
for(int i = 0; i < cartList.size(); i++) {
	CartBean cartBean = (CartBean)cartList.get(i);
	ProductBean productBean = (ProductBean)itemsList.get(i);
	int price = productBean.getProduct_price();
%>
		<div class="tableDiv CartRow">
			<dl class="trCart <%=cartBean.getCart_num() %>" >
				<dt class="tdCheck">
					<input type="checkbox" name="CartIdx" id="Item<%=cartBean.getCart_num() %>" value="<%=cartBean.getCart_num() %>" realitemprice="<%=productBean.getProduct_sale_price() %>" itemprice="<%=productBean.getProduct_price() %>" itemquantity="<%=cartBean.getCart_quantity() %>" >
<!-- 					<input type="hidden" name="jsItemName" id="jsItemName3318798" value="핑크 비숑 13인치 노트북파우치 (37002786)"> -->

<%-- 					<input type="hidden" name="cartidx" value="<%=cartBean.getCart_num() %>">	 --%>
<!-- 					<input type="hidden" name="GAitemnamekor" value="핑크 비숑 13인치 노트북파우치 (37002786)">	 -->
<!-- 					<input type="hidden" name="GAbrandnmkor" value="아트박스">	 -->
<!-- 					<input type="hidden" name="GAcatename" value="디지털>컴퓨터/노트북주변기기>노트북/태블릿 파우치">	 -->
<!-- 					<input type="hidden" name="GAitemprice" value="25000">	 -->
<!--  					<input type="hidden" name="GAqty" value="1">	 -->
<!-- 					<input type="hidden" name="GAitemcouponname" value="">	 -->
<!-- 					<input type="hidden" name="GAoptionmixname" value="">	 -->
<!-- 					<input type="hidden" name="GAdiscountrate" value="0">	 -->
				</dt>
				<dt class="tdImage"><a href="productDetail.cart?product_num=<%=cartBean.getCart_product_num()%>"><img src="cart/<%=productBean.getProduct_image() %>"></a></dt>
				<dt class="tdInner">
					<div class="tableDiv">
						<dl class="trInfo">
							<dd>
								<div class="CartListItemName"><%=productBean.getProduct_name() %> (<%=productBean.getProduct_code() %>)
								</div>
								<div class="CartListPrice">
								<%=comma.format(price) %>원 X <%=cartBean.getCart_quantity() %>개 = <%=comma.format(price*cartBean.getCart_quantity()) %>원
								</div>
							</dd>
							<dd class="tdDelete"><a class="CartButtonX" href="javascript:fnCartOne('QTY','<%=cartBean.getCart_num() %>',0,0);"><img src="${pageContext.request.contextPath}/Images/order/cart_x.png"></a></dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trInfo">
							
							<dd><a class="CartButton" href="javascript:fnChangeOption('<%=cartBean.getCart_num() %>');">옵션변경</a></dd>
							
							<dd class="tdBtn1"><a class="CartButton" href="javascript:fnCartOne('WISH','<%=cartBean.getCart_num() %>',0,0);">위시리스트</a></dd>
							<dd class="tdBtn2"><a class="CartButtonDark" href="javascript:fnCartOne('BUY','<%=cartBean.getCart_num() %>',0,0);">바로주문</a></dd>
						</dl>
					</div>
					<div class="ItemListChangeOption" id="ItemListChangeOption<%=cartBean.getCart_num() %>">
						<ul class="option">
						
							<li class="OptionIdx"><input type="hidden" name="OptionIdx" id="OptionIdx<%=cartBean.getCart_product_num() %>" value="<%=cartBean.getCart_product_num() %>"></li>
						
<%-- 							<li class="Qty"><p><a href="javascript:void(0);" onclick="del();">-</a><input type=hidden name="sell_price" value="<%=productBean.getProduct_price() %>"><input type="tel" name="Qty" id="Qty<%=cartBean.getCart_num() %>" value="<%=cartBean.getCart_quantity() %>" onchange="change();" readonly="readonly" ><a href="javascript:void(0);" onclick="add();">+</a></p></li> --%>
<!-- 							<li class="Btn"><a class="CartButton m0" href="javascript:void(0);" onclick="init();">변경완료</a></li> -->
							<li class="Qty"><p><a href="javascript:fnSetQty('<%=cartBean.getCart_num() %>',-1);">-</a><input type="tel" name="Qty" id="Qty<%=cartBean.getCart_num() %>" value="<%=cartBean.getCart_quantity() %>" readonly="readonly" /><a href="javascript:fnSetQty('<%=cartBean.getCart_num() %>',1);">+</a></p></li>
							<li class="Btn"><a class="CartButton m0" href="javascript:fnCartOne('QTY','<%=cartBean.getCart_num() %>',document.getElementById('Qty<%=cartBean.getCart_num() %>').value,document.getElementById('OptionIdx<%=cartBean.getCart_product_num() %>').value);">변경완료</a></li>
						</ul>
						<div class="clear"></div>
					</div>
				</dt>
			</dl>
		</div>
<%}%>
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

</div>

</form>
  </c:otherwise>
</c:choose> 

 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>