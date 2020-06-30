<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="css/member/myPage.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
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
		
		<style type="text/css">
		.body_box{
			height:auto;
		}
		.myOrders{
			text-align: center;
		}
		
		.myOrderstb{
			width: 100%;
		
		}
		.myOrderstb td{
			padding:10px;
		}
		.myOrderstb th{
			padding:10px;
			border-bottom: 0.5px solid grey;
			
		}
		.body_box button{
			display:block;
			margin: 10px 0 10px 500px;
			padding:10px 0px 10px 0px;
			width: 300px;
			border: 1px solid pink;
			background: pink;
			
		}
		</style>
		<h1>주문상품정보</h1>
		<c:set var="each_total" value="0" />
		<c:forEach var="details" items="${myDetailOrders}">
			<div class="myOrders">
			<table class="myOrderstb">
			<tr><th>상품 이미지</th><th>상품명  ${details.name}</th><th>개당 가격</th><th>주문 수량</th><th>총가격</th></tr>
			<tr><td><img src="${pageContext.request.contextPath}/upload/${details.image}" width="90" height="90"/></td>
			<td>${details.name}</td><td>${details.price }</td><td>${details.quantity }</td><td>${details.quantity * details.price}</td></tr>
			</table>
			</div>
			<br>
			<c:set var="each_total" value="${each_total + details.quantity * details.price }" />
		</c:forEach>
	
		<h1>주문가격정보</h1>
		${each_total} - ${each_total - ordersBean.orders_total_price} = ${ordersBean.orders_total_price}
		<br>
		
		<h1>배송정보</h1>
		${receiverBean.receiver }<br>
		${receiverBean.receiver_name }<br>
		${receiverBean.receiver_phone }<br>
		${receiverBean.receiver_postcode }<br>
		${receiverBean.receiver_addr }<br>
		${receiverBean.receiver_addr_detail }<br>
		${receiverBean.receiver_date }<br>
		
		<button onclick="history.back();">목록가기</button>
		
	</div>
	
	
	<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>