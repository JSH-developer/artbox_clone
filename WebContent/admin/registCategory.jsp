<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/admin/adminRegist.css" rel="stylesheet" type="text/css">

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

<!-- <center> -->
<div class="pageContent">
<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="CategoryList.admin">카테고리 목록</a></li>
</ul>
</div>
<br>

<h1 class="registTitle">카테고리 등록</h1>
<form action="CategoryWritePro.admin" method="post">
<table class="reg_tab">
	<tr><th>카테고리 대분류</th><td><select style="padding-left:5px" name="category_sup">
		<option value="DT">인형/토이</option>
		<option value="FA">문구</option>
		<option value="FS">패션</option>
		<option value="KB">주방/욕실</option>
		<option value="LD">리빙/데코</option>
		<option value="DI">디지털/가전</option>
		<option value="TR">여행</option>
		<option value="BE">뷰티</option>
		</select></td></tr>
	<tr><th>카테고리 소분류</th><td><input type="text" placeholder="소분류를 직접 입력해주세요" name="category_sub" style="padding-left:5px "></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="submit" value="카테고리등록"></td></tr>
</table>

<!-- </center> -->
</form>
</div>

 <!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>