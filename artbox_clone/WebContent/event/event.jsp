<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link href="../css/event.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
 
<h1 style="text-align: center; padding: 10px auto;">이벤트</h1> 

<div id="event_main">
		<ul>
			<li class="eventMiddle"><a href="../event/basic.jsp" onclick="GA_event('HEAD', '최상단 메뉴', '인형/토이');">기획전</a></li>
			<li class="eventMiddle"><a href="/Home/Shop/Category.asp?cdl=500&amp;cdm=256" onclick="GA_event('HEAD', '최상단 메뉴', '문구');">쇼핑이벤트</a></li>
			<li class="eventMiddle"><a href="/Home/Shop/Category.asp?cdl=500&amp;cdm=257" onclick="GA_event('HEAD', '최상단 메뉴', '패션');">쿠폰존</a></li>
		</ul>
</div>

<div id="event_category">
		<ul>
			<li class="CategoryMiddle"><b><a href="#"onclick="GA_event('HEAD', '최상단 메뉴', '전체');">전체</a></b></li>
			<li class="CategoryMiddle"><a href="#"onclick="GA_event('HEAD', '최상단 메뉴', '인형/토이');">인형/토이</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '문구');">문구</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '패션');">패션</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '주방/욕실');">주방/욕실</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '리빙/데코');">리빙/데코</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '디지털/가전');">디지털/가전</a></li>
			
		</ul>
</div>

<!-- Grid -->
 <div class="eventContainer">
<%for(int i =0;i<9;i++){ %>

<div class="event_content" onclick="location.href='#'">
<img src="../Images/event/18206_1.jpg" width="250" height="250">

<div>
<span>20주년 기념 대축제&#10094;이심전심&#10095;</span>
<p style="color: grey;">2020.05.01~2020.05.30</p> 

</div>

</div>
<%} %>
</div>
 <!-- Grid -->
 
 
 
 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>