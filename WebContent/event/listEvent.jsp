<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.CategoryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<script>

</script>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin/adminList.css" rel="stylesheet" type="text/css">

</head>
<body>

<!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
<!-- 헤더 -->

<div class="pageContent">

<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="listCoupon.coupon">쿠폰 관리</a></li>
 	<li><a href="listEvent.event">이벤트 관리</a></li>
</ul>
</div>

<h1 class="list_title">이벤트 리스트</h1> 
<button onclick="location.href='EventWriteForm.event'">이벤트 등록</button>
<!-- 쿠폰 리스트 -->
	<section class="table_content">
			<table>
				<c:if test="${!empty articleList and listCount > 0 }">

				<tr id="tr_top">
					<th>이벤트 번호</th>
					<th>이벤트 제목</th>
					<th>이벤트 조건</th>
					<th>이벤트 할인</th>
					<th>이벤트 시작일</th>
					<th>이벤트 마감일</th>
					<th>이벤트 카테고리</th>
					<th>이벤트 상태</th>
				</tr>
		<c:forEach var="i" begin="0" end="${fn:length(articleList) -1}" step="1">
			
				<tr>
					<td>${articleList[i].event_num}</td>
					<td>${articleList[i].event_titie}</td>
					<td>${articleList[i].event_condition}</td>
					<td>${articleList[i].event_discount}</td>
					<td>${articleList[i].event_start}</td> 
					<td>${articleList[i].event_limit}</td> 
					<td>${articleList[i].event_category}</td> 
					<td>${articleList[i].event_state}</td> 
					<td><button onclick="location.href='EventModifyForm.event?board_num=${articleList[i].event_num}'">수정</button></td>
					<td><button onclick="location.href='EventDeletePro.event?board_num=${articleList[i].event_num}&condition=${articleList[i].event_condition}'">삭제</button></td>
				</tr>
			</c:forEach>
			
			</c:if>
			<c:if test="${empty articleList}">
			 등록된 쿠폰이 없습니다.
			</c:if>
			
			</table>
		</section>
<!-- /쿠폰 리스트 -->

  		<section id="pageList" style="text-align: center;">
		<c:choose>
		<c:when test="${nowPage<=1 }">
		[이전]&nbsp;
		</c:when>
		<c:otherwise>
		<a href="listEvent.event?page=${nowPage-1 }">[이전]</a>&nbsp;
	</c:otherwise>
	</c:choose>
	
	<c:forEach var="a" begin="${startPage}" end="${endPage}" step="1">
		<c:choose>
		<c:when test="${a eq nowPage}">
		[${a}]
		</c:when>
		<c:otherwise>
		<a href="listEvent.event?page=${a}">[${a}]
		</a>&nbsp;
		</c:otherwise>
		
		
		</c:choose>
		</c:forEach>
		<c:choose>
		<c:when test="${nowPage>=maxPage }">
		[다음]
		</c:when>
		<c:otherwise>
		<a href="listEvent.event?page=${nowPage+1 }">[다음]</a>
		</c:otherwise>
		
		</c:choose>
		
		
		
	</section>


</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>