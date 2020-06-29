<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX</title>
<link href="css/member/myPage.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.5.0.js"></script>
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
				<li onclick="location.href='myPageOrders.member'">주문/배송</li>
				<li onclick="location.href='myPageRe.member'">취소/반품/교환</li>
				<li onclick="location.href='myPageWishlist.member'" class="on">위시리스트</li>
				<li onclick="location.href='myPageQ&A.member'">상품Q&A</li>
				<li onclick="location.href='myPageQuestion.member'">1:1 문의/상담</li>
			</ul>
		</div>

		<div class="sel_box">
			<ul>
				<li>
					전체선택
				</li>
			</ul>
		</div>
		<div class = "sel_box" style="float: right;">
			<ul>
				<li style="margin-right: 5px;">
					선택삭제
				</li>
				<li>
					장바구니
				</li>
			</ul>
		</div>


		<div class="clear"></div>

		<div class="noData">위시리스트가 없습니다.</div>
	</div>
	<!--  푸터 -->
<%-- 	<jsp:include page="../inc/bottom.jsp"></jsp:include> --%>
	<!--  푸터 -->
</body>
</html>