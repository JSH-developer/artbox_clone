<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
 <!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->
 
 <div class="pageContent">
 <h1> 관리자 페이지</h1>
  <a href="#">회원관리</a><br>
 <a href="ProductList.admin">상품관리</a><br>
 <a href="CategoryWriteForm.admin">카테고리 관리</a><br>
 <a href="registOption.jsp">옵션 관리</a><br>
 </div>
 
<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>