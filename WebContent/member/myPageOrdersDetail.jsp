<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/member/myPage.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/member/myPageOrdersDetail.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/slide.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/member/myPage.js"></script>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/inc/top.jsp"></jsp:include>
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

		<br>
		
<%-- 		<a href="./itemDetail.item?product_num=${bestItems[0].product_num}"> --%>
		<h1>주문 리스트</h1>
		<c:set var="each_total" value="0" />
		<c:forEach var="details" items="${myDetailOrders}">
			<div class="myOrders">
			<table class="myOrderstb">
			<tr><th>상품 이미지</th><th>상품명  ${details.name}</th><th>개당 가격</th><th>주문 수량</th><th>총가격</th></tr>
			<tr><td><a href="./itemDetail.item?product_num=${details.product_num}"><img src="${pageContext.request.contextPath}/upload/${details.image}" width="90" height="90"/></a></td>
			<td>${details.name}</td><td><fmt:formatNumber value="${details.price }" pattern="#,###원" /></td><td>${details.quantity }</td>
			<td><fmt:formatNumber value="${details.quantity * details.price}" pattern="#,###원" /></td></tr>
			</table>
			</div>
			<br>
			<c:set var="each_total" value="${each_total + details.quantity * details.price }" />
		</c:forEach>
		
		
	
		<c:choose>
		<c:when test="${each_total}>= 30000"><c:set var="ship" value="0" /></c:when>
		<c:otherwise><c:set var="ship" value="2500" /></c:otherwise>
		</c:choose>
		
		<h1>결제 정보</h1>
		<table class="myPaytb" >
		<tr><td colspan="2">주문번호&nbsp;${param.orders_num}</td></tr>
		<tr><th>주문 금액</th><td><fmt:formatNumber value="${each_total}" pattern="#,###원" /></td></tr>
		<tr><th>배송비</th><td><fmt:formatNumber value="${ship}" pattern="#,###원" /></td></tr>
		<tr><th>할인금액</th><td><fmt:formatNumber value="${each_total + ship - ordersBean.orders_total_price }" pattern="#,###원" /></td></tr>
		<tr><th>결제수단</th><td>${ordersBean.orders_payMethod}</td></tr>
		<tr><th>결제 금액</th><td><span class="total_price"><fmt:formatNumber value="${ordersBean.orders_total_price}" pattern="#,###원" /></span></td></tr>
		</table>
		<br>
		
		<h1>배송정보</h1>
		<table class="myReceivertb">
		<tr><th>성명</th><td>${receiverBean.receiver_name}</td><th>연락처</th><td>${receiverBean.receiver_phone }</td></tr>
		<tr><th>배송지</th><td colspan="3">${receiverBean.receiver_postcode }<br>
		${receiverBean.receiver_addr }<br>
		${receiverBean.receiver_addr_detail }</td></tr>
		<tr><th>요청사항</th><td colspan="3">${ordersBean.orders_msg }</td></tr>
		</table>
		<button onclick="history.back();">목록가기</button>
		
	</div>
	
	
	<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>