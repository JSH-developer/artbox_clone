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

<script type="text/javascript" src="../js/jquery-3.5.0.js"></script>

</head>
<body>

<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
 
<div class="OrderWrap">
	<h1>주문 완료!</h1>
	<div class="OrderComplete">
		<span class="CompleteImage"></span>
		<b>주문번호 : ${list[0].orders_order_num}</b>
<!-- 	확인용 -->
<%-- 	번호 : ${list[0].num}<br> --%>
<%-- 	주문번호 : ${list[0].orders_order_num}<br> --%>
<%-- 	product 테이블의 num(인덱스) : ${list[0].product_num}<br> --%>
<%-- 	receiver 테이블의 num(인덱스) : ${list[0].receiver_num}<br> --%>
<%-- 	<c:forEach var="orderList" items="${list}" varStatus="status"> --%>
<%-- 	상품코드 : ${orderList.code}<br> --%>
<%-- 	상품이름 : ${orderList.name}<br> --%>
<%-- 	대표이미지 파일명 : ${orderList.image} <br> --%>
<%-- 	상품가격 : ${orderList.price}<br> --%>
<%-- 	수량 : ${orderList.quantity}<br> --%>
<%-- 	</c:forEach> --%>
<%-- 	승인(결제)날짜 : ${list[0].orders_regdate}<br> --%>
<%-- 	결제(최종)금액 : ${list[0].orders_total_price}<br> --%>
<%-- 	결제수단 : ${list[0].orders_payMethod}<br> --%>
<%-- 	수신자 이름 : ${list[0].receiver_name}<br> --%>
<%-- 	수신자 폰번호 : ${list[0].receiver_phone}<br> --%>
<%-- 	수신자 우편번호 : ${list[0].receiver_postcode}<br> --%>
<%-- 	수신자 기본주소 : ${list[0].receiver_addr}<br> --%>
<%-- 	수신자 상세주소 : ${list[0].receiver_addr_detail}<br> --%>
<%-- 	배송메세지 : ${list[0].orders_msg} --%>
		&nbsp;<br />
		&nbsp;<br />
		
		<a class="btn1" href="#">주문내역 확인</a>&nbsp;&nbsp;<a class="btn2" href="/artbox_clone/Home.home">쇼핑하러 가기</a>
	</div>
</div>


 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>