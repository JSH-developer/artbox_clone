<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link href="../css/slide.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="../js/home.js"></script>
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

<!-- 메인 콘텐츠  -->
 <div class="pageContent" id="fixNextTag">
 
<!--  슬라이드 -->
 <div id="autoslideshow">

<div class="mySlides fade">
  <img src="../Images/home/poom20413395995743153.jpg" style="width:1000px">
</div>

<div class="mySlides fade">
<img src="../Images/home/poom20427522132998608.jpg" style="width:1000px">
</div>

<div class="mySlides fade">
  <img src="../Images/home/poom20429622303176486.jpg" style="width:1000px">
</div>

<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
<a class="next" onclick="plusSlides(1)">&#10095;</a>


<div style="text-align:center">
  <span class="dot" onclick="currentSlide(1)"></span> 
  <span class="dot" onclick="currentSlide(2)"></span> 
  <span class="dot" onclick="currentSlide(3)"></span> 
</div>
    <script type="text/javascript" src="../js/slide.js"></script>
 </div>
<!-- 슬라이드 -->


<!-- 광고1 -->
<div class="Ad1">
	<div class="Ad1left">
		 <a href="#"><img  alt="ad1" src="../Images/home/ad1.JPG"></a>
	</div>
	
	<div class="Ad1right">
		 <a href="#"><img  alt="ad2" src="../Images/home/ad2.JPG"></a>	
	</div>
		
	<div class="clear"></div>
</div>
<!-- 광고 -->

<!-- Grid -->
 <div class="bestcontainer">
<%for(int i =0;i<10;i++){ %>

<div class="best_content" onclick="location.href='#'">
<img src="../Images/event/18206_1.jpg" width="180" height="180">

<div>
<span>빅슬롯 머신 (53009087)</span><br>
<span style="color: grey;">29,900 원</span> 

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
</body></html>