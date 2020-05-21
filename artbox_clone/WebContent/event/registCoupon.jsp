<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/event/coupon.css" rel="stylesheet" type="text/css">

</head>
<body>

<!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->



 <div class="pageContent">
 

 
<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="Home.admin">관리자 홈</a></li>
	<li><a href="#">상품 목록</a></li>
 	<li><a href="#">상품 등록</a></li>
 	<li><a href="#">상품 수정</a></li>
 	<li><a href="#">쿠폰 등록</a></li>
</ul>
</div>
<br>

<!-- 쿠폰 등록 -->
<h1>쿠폰 등록</h1>
<!-- 나중에 admin으로 바꿔야하는 부분 -->
<form action="CouponWritePro.event" method="post" enctype="multipart/form-data">
<table class="reg_tab">
	<tr><th>상품옵션</th><td><select name="product_option_num"><option>1</option></select></td></tr>
	<tr><th>쿠폰이름</th><td><input type="text" name="coupon_name"></td></tr>
	<tr><th>할인가격</th><td><input type="text" name="coupon_price"></td></tr>
	<tr><th>조건</th><td><input type="text" name="coupon_condition"></td></tr>
	<tr><th>지급일</th><td><input type="date" name="coupon_start"></td></tr>
	<tr><th>유효기간</th><td><input type="date" name="coupon_limit"></td></tr>
	<tr><th>사유</th><td><input type="text" name="coupon_reason"></td></tr>
	<tr><th>사용자</th><td><input type="text" value="user" name="coupon_member_id"></td></tr>
	<tr><th>쿠폰이미지</th><td><input type="file" name="coupon_img" accept="image/*"></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="submit" value="쿠폰등록"></td></tr>
</table>
</form>
<p><% out.print(request.getRealPath("/upload")); %></p>
<!-- /쿠폰 등록 -->

<!-- 쿠폰 리스트 -->
	<div class="coupon_tab on">온라인 전용 쿠폰 (2장)</div>
				<div class="coupon_box">
					<div class="detail_tab">보너스 쿠폰 (1장)</div>
					<div class="CouponList">
						<ul>
							<li>
								<div class="CouponImage">
									<img
										src="http://www.poom.co.kr/Images/Ver2/Mypoom/sale2000.jpg">
								</div>
								<div class="CouponName" title="가입회원 2000원 할인 쿠폰">가입회원
									2000원 할인 쿠폰</div>
								<div class="CouponInfo">
									<span>2020-05-14 ~ 2020-06-30</span><span>30,000원 이상 구매 시</span>
								</div>
							</li>
						</ul>
					</div>
					
				</div>
<!-- /쿠폰 리스트 -->

</div>
 <!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>