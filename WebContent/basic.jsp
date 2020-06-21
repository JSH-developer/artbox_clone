<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="/inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">

			<h2>
				<a href="CouponWriteForm.event">쿠폰 등록 페이지</a>
			</h2>
			<h2>
				<a href="MypageCouponList.event">마이페이지 - 쿠폰</a>
			</h2>
			<!--  <h2><a href="OrderPayForm.event">구매페이지 - 쿠폰</a></h2> -->
			<h2>
				<a href="productDetail.basket">장바구니</a>
			</h2>
			<h2>
				<a href="testSelectmain.event">select 테스트</a>
			</h2>
			<h2>
				<a href="EventWriteForm.event">이벤트 등록 페이지</a>
			</h2>
				<h2>
				<a href="EventList.event">이벤트 리스트 페이지</a>
			</h2>
				<h2>
				<a href="ProductWriteForm.admin">상품 등록 페이지</a>
			</h2>
							<h2>
				<a href="memberLoginForm.member">로그인</a>
			</h2>
										<h2>
				<a href="home.admin">관리자 화면</a>
			</h2>
			
			
			

 
 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>
