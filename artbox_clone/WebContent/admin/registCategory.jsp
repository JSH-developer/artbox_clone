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
	<li><a href="adminHome.jsp">관리자 홈</a></li>
	<li><a href="#">카테고리 목록</a></li>
 	<li><a href="#">카테고리 등록</a></li>
 	<li><a href="#">카테고리 수정</a></li>
</ul>
</div>
<br>

<h1>카테고리 등록</h1>
<form>
<table class="reg_tab">
	<tr><th>카테고리 대분류</th><td><select style="padding-left:5px">
		<option value="DT">인형/토이</option>
		<option value="FA">문구</option>
		<option value="FS">패션</option>
		<option value="KB">주방/욕실</option>
		<option value="LD">리빙/데코</option>
		<option value="DI">디지털/가전</option>
		<option value="TR">여행</option>
		<option value="BE">뷰티</option>
		</select></td></tr>
	<tr><th>카테고리 소분류</th><td><input type="text" placeholder="소분류를 직접 입력해주세요" style="padding-left:5px "></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="submit" value="카테고리등록"></td></tr>
</table>
</center>
</form>

 <!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>