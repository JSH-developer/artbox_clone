<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX</title>
<link href="${pageContext.request.contextPath}/css/member/myPage.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/slide.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/member/myPage.js"></script>
<script>

function cancel(orders_order_num,point){
	cancel = confirm("구매취소 또는 반품 하시겠습니까?\n※취소 후 금액은 포인트로 환불됩니다.");
	if(cancel){
		location.href="cancel.member?orders_order_num="+orders_order_num+"&point="+point;
	}
}

function buy(orders_order_num,point){
	buy = confirm("구매확정 하시겠습니까?\n※구매확정이후 교환/환불 이 불가능합니다.");
	if(buy){
		location.href="buy.member?orders_order_num="+orders_order_num+"&point="+point;
	}
	
}

</script>
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 -->

	<div class = "body_box">
		<div class="top_box">
			<jsp:include page="/member/myPageHeader.jsp"></jsp:include>
		</div>
		
		
		<div class="MenuBar_Box">
			<ul>
				<li onclick="location.href='myPageOrders.member'" class="on">주문/배송</li>
				<li onclick="location.href='myPageRe.member'">취소/반품/교환</li>
				<li onclick="location.href='myPageWishlist.member'">위시리스트</li>
				<li onclick="location.href='myPageQ&A.member'">상품Q&A</li>
				<li onclick="location.href='myPageQuestion.member'">1:1 문의/상담</li>
			</ul>
		</div>


		<div class="sel_box">
			<select name="Term" id="term" onchange="select()">
				<option value="1" >최근 1개월</option>
				<option value="2" >최근 2개월</option>
				<option value="3" >최근 3개월</option>
				<option value="6" >최근 6개월</option>
				<option value="0" >직접 입력</option>

			</select>
		</div>

		<div class="clear"></div>
		<br>
		
		<style type="text/css">
		.myOrders{
			border: 1px solid green;
		}
		.myOrders span{
			display: block;
		}
		
		</style>
		
		<c:if test="${!empty myOrders }">
		<c:forEach var="orders" items="${myOrders}">
		<div class="myOrders">
		<span>주문번호 : ${orders.orders_order_num}</span>
		<span><a href="myPageOrdersDetail.member?orders_num=${orders.orders_order_num}">주문상세보기</a></span>
		<span>총가격 : ${orders.orders_total_price}</span>
		<span>날짜 : ${orders.orders_regdate}</span>
		<c:if test="${orders.orders_state eq 0 }">
		<span>배송준비중</span>
		<span><button onclick="cancel(${orders.orders_order_num},${orders.orders_point})">주문취소</button></span>
		</c:if>
		<c:if test="${orders.orders_state eq 1 }">
		<span>배송진행중</span>
		<span><button onclick="cancel(${orders.orders_order_num},${orders.orders_point})">주문취소</button></span>
		</c:if>
		<c:if test="${orders.orders_state eq 2 }">
		<span>배송완료</span>
		<span><button onclick="buy(${orders.orders_order_num},${orders.orders_point})">구매확정</button></span>
		<span><button onclick="cancel(${orders.orders_order_num},${orders.orders_point})">반품하기</button></span>
		</c:if>
		<c:if test="${orders.orders_state eq 3 }">
		<span>구매확정이 된 상품입니다.</span>
		</c:if>
		<c:if test="${orders.orders_state eq -1 }">
		<span>배송취소</span>
		</c:if>
		</div>
		<br>
		</c:forEach>
		</c:if>

		<c:if test="${empty myOrders}">
		<div class="noData">주문내역이 없습니다.</div>
		</c:if>
	</div>
	
	
	<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>