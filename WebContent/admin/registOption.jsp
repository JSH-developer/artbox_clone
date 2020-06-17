<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/admin/adminRegist.css" rel="stylesheet" type="text/css">


</head>
<body>

<!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->

<div class="pageContent">
<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="OptionList.admin">옵션 목록</a></li>
</ul>
</div>
<br>

<h1 class="registTitle">옵션 등록</h1>
<form action="OptionWritePro.admin" method="post">
<table class="reg_tab">
	<tr><th>상품 검색</th><td><select name="product_index" id="prod_list"><option value="">상품을 선택해주세요</option><c:out value="${productSelectList}" escapeXml="false"/></select></td></tr>
	<tr><th>옵션 이름</th><td><input name="option_name" type="text" placeholder="옵션명을 입력해주세요" style="padding-left:5px "></td></tr>
	<tr><th>추가 가격</th><td><input name="add_price" type="text" placeholder="금액을 입력해주세요" style="padding-left:5px "></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="submit" value="옵션 등록"></td></tr>
</table>
</form>
</div>

 <!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>