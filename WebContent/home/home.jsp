<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <title>ARTBOX(포트폴리오)</title>
  <link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/css/slide.css" rel="stylesheet" type="text/css">
  <script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/home.js"></script>
</head>

<body>
  <div class="page">
    <!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
    <!-- 헤더 -->
    <!-- 메인 콘텐츠  -->
    <div class="pageContent" id="fixNextTag">

      <!--  슬라이드 -->
      <div id="autoslideshow">

        <div class="mySlides fade">
          <img src="${pageContext.request.contextPath}/Images/home/poom20413395995743153.jpg" style="width:1200px">
        </div>

        <div class="mySlides fade">
          <img src="${pageContext.request.contextPath}/Images/home/poom20427522132998608.jpg" style="width:1200px">
        </div>

        <div class="mySlides fade">
          <img src="${pageContext.request.contextPath}/Images/home/poom20429622303176486.jpg" style="width:1200px">
        </div>

        <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
        <a class="next" onclick="plusSlides(1)">&#10095;</a>


        <div style="text-align:center">
          <span class="dot" onclick="currentSlide(1)"></span>
          <span class="dot" onclick="currentSlide(2)"></span>
          <span class="dot" onclick="currentSlide(3)"></span>
        </div>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/slide.js"></script>
      </div>
      <!-- 슬라이드 -->


      <!-- 광고1 -->
      <div class="Ad1">
        <div class="Ad1left">
          <a href="#"><img alt="ad1" src="${pageContext.request.contextPath}/Images/home/ad1.JPG" style="width:590px"></a>
        </div>

        <div class="Ad1right">
          <a href="#"><img alt="ad2" src="${pageContext.request.contextPath}/Images/home/ad2.JPG" style="width:590px"></a>
        </div>

        <div class="clear"></div>
      </div>
      <!-- 광고 -->
      
     <!--  best item -->
      <div class="BestItemWrap">
	<a class="BestItemTitle" href="/home/shop/bestaward.asp">BEST ITEM<span class="more"></span></a>
	<div class="BestItemList">
		<ul>
		
		
		<c:forEach var="i" begin="0" end="9" step="1">
			<li>
				<a href="./itemDetail.item?product_num=${bestItems[i].product_num}">
				
					<span class="ImageNumber num${i+1}">${i+1}</span>
					<span class="ImageBackGround"></span>
					<img class="ItemImage" src="${pageContext.request.contextPath}/upload/${bestItems[i].product_image}">
					<span class="ItemName">${bestItems[i].product_name}</span>
					

					<c:if test="${bestItems[i].product_sale_price == 0}"> <!-- 할인 안할때 -->
					<span class="ItemPrice"><fmt:formatNumber value="${bestItems[i].product_price}" pattern="#,###원" /></span>
					</c:if>
					<c:if test="${bestItems[i].product_sale_price > 0}"><!-- 할인할때 -->
					<span class="ItemPrice red">
					<fmt:parseNumber integerOnly="true" var="persent" value="${bestItems[i].product_sale_price/bestItems[i].product_price *100 }"/>
					<fmt:formatNumber value="${bestItems[i].product_price -bestItems[i].product_sale_price}" pattern="#,###원" />[${persent}%]</span>
					</c:if>
					
					<div class="stampicongroup"><span class="stampicon sale"></span></div>
				</a>
			</li>
			
			</c:forEach>
		
		</ul>
		<div class="clear"></div>
	</div>
</div>
	 <!--  best item -->
      
      
      
      
      
<!--       NEW ARRIVAL -->

<div class="NewArrivalWrap">
	<a class="NewArrivalTitle" >NEW ARRIVAL
<!-- 	<span class="more"></span> -->
	</a>
	<div class="NewArrivalList">
	
	<c:forEach var="i" begin="0" end="2" step="1">
	<a class="NewArrival${i+1}" href="./itemDetail.item?product_num=${newItems[i].product_num}" target="_self" style=" 
		background-image:url(${pageContext.request.contextPath}/upload/${newItems[i].product_image});" >
		</a>
		</c:forEach>
		
		<div class="clear"></div>
		
	</div>
</div>


<!-- EVENT -->

<div class="EventWrap">
	<a class="EventTitle" >진행중인 이벤트
	<span class="more"></span>
	</a>
	<div class="EventList">
	
	
			<c:set var="now" value="<%=new java.util.Date()%>" />
		<c:set var="nowwDate"><fmt:formatDate value="${now}" pattern="yyyyMMdd"/></c:set>
<!-- 		이벤트 리스트 불러오기 -->
		<c:forEach var="i" begin="0" end="${fn:length(eventList)}" step="1">
		
		<c:set var="startdate" value="${fn:replace(eventList[i].event_start, '-', '')}" />
		<c:set var="limitdate" value="${fn:replace(eventList[i].event_limit, '-', '')}" />
<!-- 		진행중인 이벤트 -->
		<c:if test="${startdate <= nowwDate and limitdate >= nowwDate }">
	<a class="Event${i+1}" href="EventDetail.event?board_num=${eventList[i].event_num}&page=1&condition=${eventList[i].event_condition}" target="_self" style=" 
		background-image:url(${pageContext.request.contextPath}/upload/${eventList[i].event_img});" >
		</a>
		
		
		</c:if>
		
		
		
		</c:forEach>
		
		
		<div class="clear"></div>
		
	</div>
</div>







    </div>
    <!-- 메인 콘텐츠  -->

    <!--  푸터 -->
    <jsp:include page="/inc/bottom.jsp"></jsp:include>
    <!--  푸터 -->
  </div>
</body>

</html>