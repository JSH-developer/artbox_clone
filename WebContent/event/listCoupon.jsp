<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin/adminRegist.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin/adminList.css" rel="stylesheet" type="text/css">

</head>
<script type="text/javascript">
$(document).ready(function(){
	$("#coupon_codition option").each(function() {
		var text = $(this).text();
		
		if(text.indexOf('DT') != -1) {
			$(this).html(text.replace('DT', '인형/토이'));
		}else if(text.indexOf('FA') != -1) {
			$(this).html(text.replace('FA', '문구'));	
		}else if(text.indexOf('FS') != -1){
			$(this).html(text.replace('FS', '패션'));
		}else if(text.indexOf('KB') != -1){
			$(this).html(text.replace('KB', '주방/욕실'));
		}else if(text.indexOf('LD') != -1){
			$(this).html(text.replace('LD', '리빙/데코'));
		}else if(text.indexOf('DI') != -1){
			$(this).html(text.replace('DI', '디지털/가전'));
		}else if(text.indexOf('TR') != -1){
			$(this).html(text.replace('TR', '여행'));
		}else if(text.indexOf('BE') != -1){
			$(this).html(text.replace('BE', '뷰티'));	
		}
		
		});
	
})
</script>
<body>

<!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->



<div class="pageContent">
 
<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="CouponWriteForm.coupon">쿠폰 관리</a></li>
 	<li><a href="listEvent.event">이벤트 관리</a></li>
</ul>
</div>

<br>

<!-- 쿠폰 등록 -->
<h1 class="list_title">쿠폰 등록</h1>
<!-- 나중에 admin으로 바꿔야하는 부분 -->
<form action="CouponWritePro.coupon" method="post" >
<table class="reg_tab">
	<tr><th>쿠폰이름</th><td><input type="text" name="coupon_name"></td></tr>
	<tr><th>할인가격</th><td><input type="text" name="coupon_price"></td></tr>
	<tr><th>조건</th><td><select id="coupon_condition" name="coupon_condition"><option>카테고리를 선택해주세요</option>${categorySelectList}<option>직접입력</option></select></td></tr>
	<tr ><th id="hid_price" style="display: none;">가격 조건</th><td id="hid_price" style="display: none;"><input type="number" name="coupon_p_condition"></td></tr>
	<tr><th>지급일</th><td><input type="date" name="coupon_start"></td></tr>
	<tr><th>유효기간</th><td><input type="date" name="coupon_limit"></td></tr>
	<tr><th>사유</th><td><input type="text" name="coupon_reason"></td></tr>
	<tr><th>쿠폰종류(카테고리)</th>
		<td><select name="coupon_category">
    	<option value="">쿠폰종류 선택</option>
    	<option value="bonuscoupon">보너스 쿠폰</option>
    	<option value="goodscoupon">상품 쿠폰</option>
   		<option value="freecoupon">무료배송 쿠폰</option></select></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="submit" value="쿠폰등록"></td></tr>
</table>
</form>
<p><% out.print(request.getRealPath("/upload")); %></p> <br>
<!-- /쿠폰 등록 -->

<!-- 쿠폰 리스트 -->
<h1 class="list_title">쿠폰 리스트</h1>
<!-- 쿠폰 리스트 -->
	<section class="table_content">
			<table>
				<c:if test="${!empty couponList}">

				<tr id="tr_top">
					<th>쿠폰 이름</th>
					<th>쿠폰 할인가격</th>
					<th>쿠폰 조건</th>
					<th>쿠폰 지급일</th>
					<th>쿠폰 유효기간</th>
					<th>쿠폰 사유</th>
					<th>쿠폰 카테고리</th>
				</tr>
		<c:forEach var="i" begin="0" end="${fn:length(couponList) -1}" step="1">
			
				<tr>
					<td>${couponList[i].coupon_name}</td>
					<td>${couponList[i].coupon_price}</td>
					<td>${couponList[i].coupon_condition}</td>
					<td>${couponList[i].coupon_start}</td>
					<td>${couponList[i].coupon_limit}</td> 
					<td>${couponList[i].coupon_reason}</td> 
					<td>${couponList[i].coupon_category}</td> 
					<td><button onclick="location.href='CouponDeletePro.coupon?coupon_num=${couponList[i].coupon_num}'">쿠폰 삭제</button></td>	
				</tr>
			</c:forEach>
			
			</c:if>
			<c:if test="${empty couponList}">
			 등록된 쿠폰이 없습니다.
			</c:if>
			
			</table>
		</section>
<!-- /쿠폰 리스트 -->


</div>
 <!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>