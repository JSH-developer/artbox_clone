<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>ARTBOX(포트폴리오)</title>
 
 
 <!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>*{font-family: 'Noto Sans KR', sans-serif;}</style>
 
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin/adminHome.css" rel="stylesheet" type="text/css">

</head>
<body>
 <!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->
 
 <div class="pageContent">
 <h1 class="homeTitle"> 관리자 페이지</h1>

<div class="wrapAdhome">
 <span class="adhome_menu">
 <a href="MemberList.admin"><img src="${pageContext.request.contextPath}/Images/admin/member.png" width="100"/><br>
 <h3>회원관리</h3></a>
 </span>
 
 <span class="adhome_menu">
 <a href="ProductList.admin"><img src="${pageContext.request.contextPath}/Images/admin/product.png" width="100"/>
 <h3>상품관리</h3></a>
 </span>
 
 <span class="adhome_menu">
 <a href="OrderList.admin"><img src="${pageContext.request.contextPath}/Images/admin/order.png" width="100"/>
 <h3>주문관리</h3></a>
 </span>
 
 <span class="adhome_menu">
 <img src="${pageContext.request.contextPath}/Images/admin/event.png" width="100"/>
 <h3>이벤트관리</h3>
 </span>
 </div>
 </div>
 
<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>