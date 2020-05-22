<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<link href="../css/admin/registProduct.css" rel="stylesheet" type="text/css">

</head>
<body>

<!-- 헤더 -->
    <jsp:include page="../inc/top.jsp"></jsp:include>
 <!-- 헤더 -->

<center>
<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="#">옵션 목록</a></li>
 	<li><a href="#">옵션 등록</a></li>
 	<li><a href="#">옵션 수정</a></li>
</ul>
</div>
<br>

<h1>옵션 등록</h1>
<form>
<table class="reg_tab">
	<tr><th>상품 검색</th><td><select><option>1</option></select></td></tr>
	<tr><th>옵션 번호</th><td><input type="text" placeholder="두자리 숫자를 입력해주세요. ex)01" maxlength="2" style="padding-left:5px "></td></tr>
	<tr><th>옵션 이름</th><td><input type="text" placeholder="옵션명을 입력해주세요" style="padding-left:5px "></td></tr>
	<tr><th>추가 가격</th><td><input type="text" placeholder="금액을 입력해주세요" style="padding-left:5px "></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="submit" value="옵션 등록"></td></tr>
</table>
</form>
</center>


 <!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>