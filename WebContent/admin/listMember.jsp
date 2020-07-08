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
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$(".search_btn").on("click",function(){
		location.href="./MemberList.admin?opt="+$("#searchOpt").val()+"&kwd="+$("#searchKwd").val();
	});
	
	$("#searchKwd").keydown(function(key) {
		if (key.keyCode == 13) {
			location.href="./MemberList.admin?opt="+$("#searchOpt").val()+"&kwd="+$("#searchKwd").val();
		}
	});
	
});

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
<c:choose>
<c:when test="${empty grade}">
	<script>
		alert("관리자만 접근이 가능한 페이지입니다.");
		location.href="Home.home";
	</script>
</c:when>
<c:otherwise>
	<c:if test="${grade ne 'ADMIN'}">
	<script>
		alert("관리자만 접근이 가능한 페이지입니다.");
		location.href="Home.home";
	</script>
	</c:if>
</c:otherwise>
</c:choose> 


<div class="pageContent">

<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="MemberList.admin">회원 목록</a></li>
</ul>
</div>
<select class="chooseOpt2" id="searchOpt"><option value="id">아이디</option><option value="name">이름</option></select>
<input type="text" class="chooseOpt" id="searchKwd" placeholder="검색어를 입력하세요"><button class="search_btn">검색</button>
<h1 class="list_title">회원리스트</h1>

<c:catch var="e">
<table class="table_content">
<tr><th>번호</th><th>아이디</th><th>등급</th><th>상태</th></tr>
<c:forEach var="i" begin="0" end="${fn:length(memberList)-1}" step="1">
	<tr>
	<td>${memberList[i].num}</td>
	<td><a href='MemberView.admin?num=${memberList[i].num}&page=${pageInfo.page}&opt=${param.opt}&kwd=${param.kwd}'>${memberList[i].id}</a></td>
	<td>${memberList[i].grade}</td>
	<td>
	<span class="member_state">
		<c:if test="${memberList[i].status eq 0}">
		비활성
		</c:if>
		<c:if test="${memberList[i].status eq 1}">
		활성
		</c:if>
		</span>
	<br><button onclick="window.open('./changeMemState.admin?num='+${memberList[i].num}+'&status='+${memberList[i].status}, '', 'width=700,height=250,left=250,top=250');">회원상태 변경</button></td>
	</tr>
</c:forEach>
</table>


<section id="pageList">
	<c:choose>
	<c:when test="${pageInfo.page <= 1}">
	◁&nbsp;
	</c:when>
	<c:when test="${pageInfo.page > 1}">
	<a href="MemberList.admin?page=${pageInfo.page-1}&opt=${param.opt}&kwd=${param.kwd}">◁</a>&nbsp;
	</c:when>
	</c:choose>
	<c:forEach var="a" begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1">
		<c:choose>
		<c:when test="${a == pageInfo.page}">
			${a}
		</c:when>
		<c:otherwise>
			<a href="MemberList.admin?page=${a}&opt=${param.opt}&kwd=${param.kwd}">${a}
			</a>&nbsp;
		</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>
	<c:when test="${ pageInfo.page >= pageInfo.maxPage }">
		▷
	</c:when>
	<c:otherwise>
		<a href="MemberList.admin?page=${pageInfo.page+1}&opt=${param.opt}&kwd=${param.kwd}">▷</a>
	</c:otherwise>
	</c:choose>
</section>
</div>

</c:catch>

<c:if test="${e != null}">
<table class="table_content">
<tr><td colspan="4">표시할 항목이 없습니다.</td></tr>
</table>
<br><br>
</c:if>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>