<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="../css/front.css" rel="stylesheet" type="text/css">
<!-- <link href="../css/order/Common.css" rel="stylesheet" type="text/css"> -->
<link href="../css/order/Order.css" rel="stylesheet" type="text/css">
<link href="../css/order/PopZipCode.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../js/PopZipCodeJson.js"></script>
<script type="text/javascript" src="../js/jquery-3.5.0.js"></script>

<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-125049262-1');
</script>
 
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
		<b>주문번호 20200502000049</b>
		
		은행 : 국민은행<br />
		계좌번호 : 00159071270692 (아트박스)<br />
		입금기한 : 2020-05-09<br />
		입금하실 금액 : 16,900원<br />
		&nbsp;<br />
		&nbsp;<br />
		
		<a class="btn1" href="#">주문내역 확인</a>&nbsp;&nbsp;<a class="btn2" href="../home/home.jsp">쇼핑하러 가기</a>
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