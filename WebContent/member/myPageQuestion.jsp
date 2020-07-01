<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
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
				<li onclick="location.href='myPageWishlist.member'">위시리스트</li>
				<li onclick="location.href='myPageQ&A.member'">상품Q&A</li>
				<li onclick="location.href='myPageQuestion.member'" class="on">1:1 문의/상담</li>
			</ul>
		</div>


		<select class = "question_left_box">
			<option value="01" onclick="#">상담분류 전체</option>
			<option value="02" onclick="#">주문/결제</option>
			<option value="03" onclick="#">배송</option>
			<option value="03" onclick="#">취소/반품/교환</option>
			<option value="03" onclick="#">기타</option>
		</select>
		<select class = "question_left_box" style="margin-left: 7px;">
			<option value="01" onclick="#">진행 상태 전체</option>
			<option value="02" onclick="#">문의접수</option>
			<option value="03" onclick="#">답변완료</option>
		</select>
		<span class = "question_right_box"onclick="">문의하기</span>
		

		<div class="clear"></div>

		<div class="noData">주문내역이 없습니다.</div>
	</div>
</body>
</html>