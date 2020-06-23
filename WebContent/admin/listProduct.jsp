<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$(".search_btn").on("click",function(){
		location.href="./ProductList.admin?opt="+$("#searchOpt").val()+"&kwd="+$("#searchKwd").val();
	});
	
	$("#searchKwd").keydown(function(key) {
		if (key.keyCode == 13) {
			location.href="./ProductList.admin?opt="+$("#searchOpt").val()+"&kwd="+$("#searchKwd").val();
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


<div class="pageContent">

<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
 	<li><a href="CategoryList.admin">카테고리 목록</a></li>
	<li><a href="OptionList.admin">옵션 목록</a></li>
</ul>
</div>
<br>

<select class="chooseOpt2" id="searchOpt"><option value="name">상품명</option><option value="code">상품코드</option><option value="keywords">키워드</option></select>
<input type="text" class="chooseOpt" id="searchKwd" placeholder="검색어를 입력하세요"><button class="search_btn">검색</button>

<h1 class="list_title">상품리스트</h1>

<c:catch var="e">

<table class="table_content">
<tr><th>번호</th><th>코드</th><th>이름</th><th>재고수량</th><th>카테고리</th><th>옵션</th></tr>
<c:forEach var="i" begin="0" end="${fn:length(productList)-1}" step="1">
	<tr>
	<td>${productList[i].product_num}</td>
	<td>${productList[i].product_code}</td>
	<td><a href='ProductView.admin?num=${productList[i].product_num}&page=${pageInfo.page}&opt=${param.opt}&kwd=${param.kwd}'>${productList[i].product_name}</a></td>
	<td>${productList[i].product_stock_count}</td>
	<td>${productList[i].product_category_code}</td>
	<td>${productList[i].product_option_code}</td>
	</tr>
</c:forEach>
</table>
<a href="ProductWriteForm.admin"><button class="table_btn">기본상품 등록</button></a>
<a href="OptionWriteForm.admin"><button class="table_btn">옵션상품 등록</button></a>
<section id="pageList">
	<c:choose>
	<c:when test="${pageInfo.page <= 1}">
	◁&nbsp;
	</c:when>
	<c:when test="${pageInfo.page > 1}">
	<a href="CategoryList.admin?page=${pageInfo.page-1}&opt=${param.opt}&kwd=${param.kwd}">◁</a>&nbsp;
	</c:when>
	</c:choose>
	<c:forEach var="a" begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1">
		<c:choose>
		<c:when test="${a == pageInfo.page}">
			[${a}]
		</c:when>
		<c:otherwise>
			<a href="CategoryList.admin?page=${a}&opt=${param.opt}&kwd=${param.kwd}">[${a}]
			</a>&nbsp;
		</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>
	<c:when test="${ pageInfo.page >= pageInfo.maxPage }">
		▷
	</c:when>
	<c:otherwise>
		<a href="CategoryList.admin?page=${pageInfo.page+1}&opt=${param.opt}&kwd=${param.kwd}">▷</a>
	</c:otherwise>
	</c:choose>
</section>

</div>
</c:catch>

<c:if test="${e != null}">
<table class="table_content">
<tr><td colspan="6">표시할 항목이 없습니다.</td></tr>
</table>
<br><br>
</c:if>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>