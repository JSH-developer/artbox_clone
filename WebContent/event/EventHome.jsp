<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.EventBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<%
// 	ArrayList<EventBean> articleList=(ArrayList<EventBean>)request.getAttribute("articleList");
//     PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
// 	int listCount=pageInfo.getListCount();
// 	int nowPage=pageInfo.getPage();
// 	int maxPage=pageInfo.getMaxPage();
// 	int startPage=pageInfo.getStartPage();
// 	int endPage=pageInfo.getEndPage();
%>

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
p{
text-align : center;
margin:0;
font-size: 18px;}

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

<div id="event_main">
		<ul>
			<li class="eventMiddle"><a href="EventCategoryList.event?event_category=sale_event" onclick="GA_event('HEAD', '최상단 메뉴', '인형/토이');">기획전</a></li>
			<li class="eventMiddle"><a href="EventCategoryList.event?event_category=coup_event" onclick="GA_event('HEAD', '최상단 메뉴', '문구');">쿠폰존</a></li>
			<li class="eventMiddle"><a href="${pageContext.request.contextPath}/event/basic.jsp" onclick="GA_event('HEAD', '최상단 메뉴', '패션');">타임이벤트</a></li>
		</ul>
</div>


<!-- Grid -->
 <div class="eventContainer">


		<%
// 		if(articleList != null && listCount > 0){
// 			// 오늘 날짜 구함
// 			Date nowDate = new Date();
// 			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
// 			int nowwDate = Integer.parseInt(sf.format(nowDate));
			
// 		for(int i=0;i<articleList.size();i++){
// 			// 저장된 이벤트 날짜 구해서 - 빼고 계산
// 			String startdate = articleList.get(i).getEvent_start().replaceAll("-","");
// 			String limitdate = articleList.get(i).getEvent_limit().replaceAll("-","");
// 			int startdate1 = Integer.parseInt(startdate);
// 			int limitdate1 = Integer.parseInt(limitdate);
// 			// 오늘 날짜와 이벤트 날짜 비교해서 이벤트 띄우기
// 			if( startdate1 <= nowwDate && limitdate1 >= nowwDate){
		%>
		<c:choose>
		<c:when test="${!empty articleList and listCount > 0 }"> 
<!-- 		현재 시간구하고, 진행중인 이벤트만 띄우기 -->
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<c:set var="nowwDate"><fmt:formatDate value="${now}" pattern="yyyyMMdd"/></c:set>
<!-- 		이벤트 리스트 불러오기 -->
		<c:forEach var="i" begin="0" end="${fn:length(articleList)}" step="1">
		
		<c:set var="startdate" value="${fn:replace(articleList[i].event_start, '-', '')}" />
		<c:set var="limitdate" value="${fn:replace(articleList[i].event_limit, '-', '')}" />
<!-- 		진행중인 이벤트 -->
		<c:if test="${startdate <= nowwDate and limitdate >= nowwDate }">
		
		
		<div class="event_content" onclick="location.href='EventDetail.event?board_num=${articleList[i].event_num}&page=${nowPage}&condition=${articleList[i].event_condition}'">
			<div style="margin: 0 auto;">
				<p><img src="${pageContext.request.contextPath}/Images/event/${articleList[i].event_img}" width="360px" height="250px"></p>
			<p><span style="font-weight: bold;color: #262729; ">${articleList[i].event_titie}</span>
				
				<c:if test="${'sale_event' == articleList[i].event_category}">
					<span style="color:red;">[${articleList[i].event_discount}%]</span>
				</c:if>
			</p>
				
		
				
				<p style="color: grey;font-size: 14px;">${articleList[i].event_start}~${articleList[i].event_limit}</p>
			</div>

		</div>
	</c:if>
<!-- 	종료된 이벤트, 클릭해도 들어가지지않음 -->
	<c:if test="${startdate > nowwDate and limitdate < nowwDate }">
		

				<div style="margin: 0 auto;">
				<p><img src="${pageContext.request.contextPath}/Images/event/${articleList[i].event_img}" width="360px" height="250px"
				style="color: grey;"></p>
				<p><span style="font-weight: bold;color: #262729; ">${articleList[i].event_titie}</span>
				<span style="color:red;">[${articleList[i].event_discount}%]</span></p>
				<p style="color: grey;font-size: 14px;">${articleList[i].event_start}~${articleList[i].event_limit}</p>
			</div>

			</c:if>
		</c:forEach>
		
		



	
	
	
	
	
	
	

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