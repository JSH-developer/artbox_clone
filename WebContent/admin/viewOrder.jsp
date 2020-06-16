<%@page import="vo.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<script>
function deleteProduct(){
	var del = confirm('주문을 삭제 하시겠습니까?');
	if(del){
		location.href = "OrderDeletePro.admin?num=${productBean.product_num}&page=${page}";
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
 
 <input type = "hidden" name = "page" value = "${page}"/>
 
 
<div class="pageContent">
<h1 class="viewTitle">주문상세보기</h1>
<div class="wrapView">
<table class="viewTable">
<tr><th>주문 번호</th><td><c:out value="${orderBean.orders_num}"/></td></tr>
</table>
<br><br>
<button onclick="location.href='OrderList.admin?page=${param.page}'" class="viewBtn">목록가기</button>
<button onclick="deleteProduct()"  class="viewBtn deleteBtn">주문삭제</button>
</div>
</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>