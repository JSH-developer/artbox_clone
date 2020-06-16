<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

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
	<li><a href="MemberList.admin">회원 목록</a></li>
</ul>
</div>

<h1 class="list_title">회원리스트</h1>
<table class="table_content">
<tr><th>번호</th><th>아이디</th><th>등급</th><th>상태</th></tr>
<c:forEach var="i" begin="0" end="${fn:length(memberList)-1}" step="1">
	<tr>
	<td>${memberList[i].num}</td>
	<td><a href='MemberView.admin?num=${memberList[i].num}&page=${pageInfo.page}'>${memberList[i].id}</a></td>
	<td>${memberList[i].grade}</td>
	<td>${memberList[i].status}</td>
	</tr>
</c:forEach>
</table>


<section id="pageList">
	<c:choose>
	<c:when test="${pageInfo.page <= 1}">
	◁&nbsp;
	</c:when>
	<c:when test="${pageInfo.page > 1}">
	<a href="CategoryList.admin?page=${pageInfo.page-1}">◁</a>&nbsp;
	</c:when>
	</c:choose>
	<c:forEach var="a" begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1">
		<c:choose>
		<c:when test="${a == pageInfo.page}">
			[${a}]
		</c:when>
		<c:otherwise>
			<a href="CategoryList.admin?page=${a}">[${a}]
			</a>&nbsp;
		</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>
	<c:when test="${ pageInfo.page >= pageInfo.maxPage }">
		▷
	</c:when>
	<c:otherwise>
		<a href="CategoryList.admin?page=${pageInfo.page+1}">▷</a>
	</c:otherwise>
	</c:choose>
</section>
</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>