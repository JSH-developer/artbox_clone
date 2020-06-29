<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX</title>
<link href="css/member/myPage.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="member/myPage.js"></script>
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 -->

	<div class = "body_box">
		<div class="top_box">
			<jsp:include page="../member/myPageHeader.jsp"></jsp:include>
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
		.myOrders{
			border: 1px solid green;
		}
		.myOrders span{
			display: block;
		}
		
		</style>
		
		<c:forEach var="details" items="${myDetailOrders}">
			<div class="myOrders">
				<span>상품 이미지 : ${details.image }</span>
				<span>상품 이름 : ${details.name }</span>
				<span>상품 코드 : ${details.code }</span>
				<span>상품 1개당 가격 : ${details.price }</span>
				<span>상품 수량 : ${details.quantity }</span>
				<span>상품 총 가격 : ${details.quantity * details.price}</span>
							
			</div>
			<br>
		
		</c:forEach>
		
		<button onclick="history.back();">목록가기</button>
		
		
		
	</div>
	
	
	<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>