<%@page import="vo.ProductBean"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.EventBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="listCount" value="${pageInfo.listCount}"></c:set>
<c:set var="nowPage" value="${pageInfo.page}"></c:set>
<c:set var="maxPage" value="${pageInfo.maxPage}"></c:set>
<c:set var="startPage" value="${pageInfo.startPage}"></c:set>
<c:set var="endPage" value="${pageInfo.endPage}"></c:set>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/event/event.css" rel="stylesheet" type="text/css">

<style>
.eventcontent{
width:1200px;height: auto;
text-align: center;}

</style>

</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
 
<h1 style="text-align: center; padding: 10px auto;">이벤트</h1> 

<!-- Grid -->

 <div  class="eventdescription">
<div>
기간 : ${eventArticle.event_start} ~ ${eventArticle.event_limit}
</div>
<div class="eventcontent">
${eventArticle.event_content }

</div>



 </div>
 <div class="eventContainer">


	<c:choose>
		<c:when test="${listCount > 0 and not empty eventArticle}"> 
			<c:if test="${ eventArticle.event_category eq 'coup_event' or  eventArticle.event_category eq 'sale_event' }" > 
				
		<c:forEach var="i" begin="0" end="${fn:length(itemList) -1}" step="1">
		
		 	<c:set var="realprice" value="${itemList[i].product_price}" />
		 	<c:set var="saleprice" value="${itemList[i].product_sale_price}" />
		 	
<%-- 		 		<c:if test="${ eventArticle.event_category eq 'coup_event'}" >  --%>
<%-- 				<c:set var="coup_price" value="${itemcoupon.coupon_price}" /> --%>
<%-- 				<c:set var="saleprice" value="${ realprice - coup_price}" /> --%>
<%-- 				</c:if> --%>
		 	
<%-- 				<c:if test="${ eventArticle.event_category eq 'sale_event'}" >  --%>
<%-- 				<c:set var="eventprice" value="${eventArticle.event_discount}" /> --%>
<%-- 				<c:set var="saleprice" value="${ realprice - ((realprice * eventprice)/100)}" /> --%>
<%-- 				</c:if> --%>
				
		
		<fmt:parseNumber var="saleprice" value="${saleprice }" integerOnly="true" />

<!-- 		상품불러오는코드		 -->
<!-- itemDetail.item?product_num=6 -->
<%-- 		<div class="event_content" onclick="location.href='itemDetail.item?product_num=${itemList[i].product_num}&page=${nowpage}&condition=${itemList[i].product_category_code}'"> --%>
	<div class="event_content" onclick="location.href='itemDetail.item?product_num=${itemList[i].product_num}'">
	<div>
				<img src="${pageContext.request.contextPath}/upload/${itemList[i].product_image}" width="215px" height="215px">
			
				<b style="padding:0;">${itemList[i].product_name}</b>
<%-- 				<p style="color:red;">${itemList[i].product_category_code}</p> --%>
				<p>
<%-- 				<span id="rprice" >${realprice}원</span> --%>
				
<%-- 				<c:if test="${ eventArticle.event_category eq 'coup_event' or  eventArticle.event_category eq 'sale_event'}" >  --%>
<!-- 				<style> -->
<!-- /* 				span#rprice{text-decoration: line-through;color: grey;} */ -->
<!-- 				</style> -->
<%-- 				&nbsp; <span style="color: black;">${realprice - saleprice}원</span> --%>
<%-- 				</c:if> --%>
				
	<c:if test="${itemList[i].product_sale_price == 0 }">
		<span ><fmt:formatNumber value="${item.product_price}" pattern="#,###원" /></span>
	</c:if>
	<c:if test="${itemList[i].product_sale_price > 0 }">
<fmt:parseNumber integerOnly="true" var="persent" value="${itemList[i].product_sale_price/itemList[i].product_price *100 }" />
<span style="color:red;"><fmt:formatNumber value="${itemList[i].product_price - itemList[i].product_sale_price }" pattern="#,###"/>원 [ ${persent}% ]</span>
			
		</c:if>
				
				
				</p>
		</div>		
	</div>
		</c:forEach>

		</c:if>
		
		
		
		
		</c:when>
		<c:otherwise>
		<section id="emptyArea">등록된 글이 없습니다.</section>
		</c:otherwise>
		</c:choose>
	</div>



 <!-- Grid -->
  		<section id="pageList" style="text-align: center;">
		<c:choose>
		<c:when test="${nowPage<=1 }">
		[이전]&nbsp;
		</c:when>
		<c:otherwise>
		<a href="EventList.event?page=${nowPage-1 }">[이전]</a>&nbsp;
	</c:otherwise>
	</c:choose>
	
	<c:forEach var="a" begin="${startPage}" end="${endPage}" step="1">
		<c:choose>
		<c:when test="${a eq nowPage}">
		[${a}]
		</c:when>
		<c:otherwise>
		<a href="EventList.event?page=${a}">[${a}]
		</a>&nbsp;
		</c:otherwise>
		
		
		</c:choose>
		</c:forEach>
		<c:choose>
		<c:when test="${nowPage>=maxPage }">
		[다음]
		</c:when>
		<c:otherwise>
		<a href="EventList.event?page=${nowPage+1 }">[다음]</a>
		</c:otherwise>
		
		</c:choose>
		
		
		
	</section>
 
 
 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>