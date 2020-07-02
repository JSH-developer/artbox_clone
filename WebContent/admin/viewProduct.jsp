<%@page import="vo.ProductBean"%>
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

<script>
function deleteProduct(){
	var del = confirm('상품을 삭제 하시겠습니까?');
	if(del){
		location.href = "ProductDeletePro.admin?num=${productBean.product_num}&page=${param.page}&option_code=${productBean.product_option_code}";
	}
	
}


</script>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin/adminView.css" rel="stylesheet" type="text/css">

</head>
<body>

 <!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->
 
 
<div class="pageContent">
<h1 class="viewTitle">상품상세보기</h1>
<div class="wrapView">
<table class="viewTable">
<tr><th>상품 번호</th><td><c:out value="${productBean.product_num}"/></td></tr>
<tr><th>상품 카테고리</th><td><c:out value="${productBean.product_category_code}"/></td></tr>
<tr><th>상품 옵션</th><td><c:out value="${productBean.product_option_code}"/></td></tr>
<tr><th>상품 이름</th><td><c:out value="${productBean.product_name}"/></td></tr>
<tr><th>상품 브랜드</th><td><c:out value="${productBean.product_brand}"/></td></tr>
<tr><th>상품 코드</th><td><c:out value="${productBean.product_code}"/></td></tr>
<tr><th>상품 대표 이미지</th><td><img src="${pageContext.request.contextPath}/upload/<c:out value="${productBean.product_image}"/>" width="200px" height="200px"/></td></tr>
<tr><th>상품 대표 이미지2</th><td><img src="${pageContext.request.contextPath}/upload/<c:out value="${productBean.product_image2}"/>" width="200px" height="200px"/></td></tr>
<tr><th>상품 상세 </th><td><c:out value="${productBean.product_description}" escapeXml="false"/></td></tr>
<tr><th>상품 가격</th><td><c:out value="${productBean.product_price}"/></td></tr>
<tr><th>상품 세일 가격</th><td><c:out value="${productBean.product_sale_price}"/></td></tr>
<tr><th>상품 재고수량</th><td><c:out value="${productBean.product_stock_count}"/></td></tr>
<tr><th>상품 키워드</th><td><c:out value="${productBean.product_keywords}"/></td></tr>
</table>
<br><br>
<button onclick="location.href='ProductList.admin?page=${param.page}&opt=${param.opt}&kwd=${param.kwd}'" class="viewBtn">목록가기</button>
<button onclick="location.href='ProductModifyForm.admin?num=${productBean.product_num}&page=${param.page}&opt=${param.opt}&kwd=${param.kwd}'"  class="viewBtn">수정하기</button>
<button onclick="deleteProduct()"  class="viewBtn deleteBtn">삭제하기</button>
</div>
</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>