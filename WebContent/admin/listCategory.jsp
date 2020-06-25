<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.CategoryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<script>
function deleteCategory(num){
	var del = confirm('카테고리를 삭제 하시겠습니까?');
	if(del){
		location.href = "CategoryDeletePro.admin?num="+num+"&page=${pageInfo.page}";
	}
	
}

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
	<li><a href="ProductList.admin">상품 목록</a></li>
 	<li><a href="CategoryList.admin">카테고리 목록</a></li>
	<li><a href="OptionList.admin">옵션 목록</a></li>
</ul>
</div>

<h1 class="list_title">카테고리 리스트</h1>
<table class="table_content">
<tr><th>번호</th><th>코드</th><th>대분류</th><th>소분류</th><th>삭제버튼</th></tr>

<c:forEach var="i" begin="0" end="${fn:length(categoryList)-1}" step="1">
	<tr>
	<td>${categoryList[i].category_num}</td>
	<td>${categoryList[i].category_code}</td>
	<td>${categoryList[i].category_sup}</td>
	<td>${categoryList[i].category_sub}</td>
	<td><button onclick='deleteCategory(${categoryList[i].category_num})'>카테고리삭제</button></td>	
	</tr>
</c:forEach>

</table>
<a href="CategoryWriteForm.admin"><button class="table_btn">카테고리 등록</button></a>

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