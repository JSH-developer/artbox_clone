<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/event/myPage.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function onoff(s){

for(var i=1;i<=5;i++){
	var p = document.getElementById("grade_tab_in_"+i);
	
	if(i!=s){
		$("#btn"+i).removeClass("on");
		p.style.display = 'none';
	
	}else{
		$("#btn"+i).addClass("on");
		p.style.display = 'block';
		
	}
	
}
		
}

function cpClick(num){
	var moveCheck;
	var getId  = document.getElementById("loginId").value;
	
	if(getId == "null" || getId == ""){

		moveCheck = confirm("로그인하시겠습니까?"+getId);
		
		if(moveCheck){
			location.href = "loginForm.member";
		}else{}
		
	

} else {
		var url = "CouponIssued.coupon?getid=" + getId + "&couponNum="+ num;
		
		location.href = url;
		
	}
}




</script>
<style>
span.scoup { /*     쿠폰 팝업 창  */
	display: inline-block;
	width: 80px;
	height: 40px;
	line-height: 56px;
	background-color: #424242;
	text-align: center;
	color: #ffffff;
	font-size: 16px;
	border-radius: 5px;
}
#grade_tab_in_5 li{
	height: 45px;
}
</style>

</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
 
<div class="wrap">
	<div class="top_title">내 회원 등급</div>
	
	<div class="top_box">
		<div class="top_inner">
			<ul>
				<li>
					<input type="hidden" id="loginId" value="${id}" />
					<c:if test="${grade eq 'BRONZ' }">
					<p class="grade_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_bronze.jpg"></p>
					<p class="grade_ment"><span class="grade4">BRONZ</span></p>
<%-- 					<c:set var="myGrade" value="BRONZE"/> --%>
				</c:if>
				<c:if test="${grade eq 'SILVER' }">
				<p class="grade_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_silver.png"></p>
					<p class="grade_ment"><span class="grade3">SILVER</span></p>
				</c:if>
				<c:if test="${grade eq 'GOLD' }">
				<p class="grade_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_gold.png"></p>
					<p class="grade_ment"><span class="grade2">GOLD</span></p>
				</c:if>
				<c:if test="${grade eq 'DIAMOND' }">
				<p class="grade_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_diamond.png"></p>
					<p class="grade_ment"><span class="grade1">DIAMOND</span></p>
				</c:if>
				
				
					
					<p class="grade_me">${name }님의 통합멤버십 등급은 <span class="grade5">${grade }</span>입니다.</p>
					
					<p class="grade_etc">(등급적용기간 2020-06-01 ~ 2020-06-30)</p>
				</li>
				<li>
					<div class="grape_back">
						<div style="border-left:1px solid #b9b9b9; border-right:1px solid #b9b9b9; width:25%; height:6px; float:left;"></div>
						<div style="border-right:1px solid #b9b9b9; width:25%; height:6px; float:left;"></div>
						<div style="border-right:1px solid #b9b9b9; width:25%; height:6px; float:left;"></div>
						<div style="border-right:1px solid #b9b9b9; width:25%; height:6px; float:left;"></div>
						<div style="clear:both;"></div>
					</div>
					<div class="grade_bar"><div class="bar_in"><span class="blank">	<span class="range per0"></span></span><span class="blank">	<span class="range per0"></span></span><span class="blank">	<span class="range per0"></span></span></div></div>
					<div class="grade_icon_box">
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_bronze.jpg"></span>
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_silver.png"></span>
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_gold.png"></span>
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_diamond.png"></span>
<!-- 						<span class="grad_icon"><img src=""></span> -->
					</div>
					<div class="infor">	<span>등급선정</span>	<span>2019-12-01 ~ 2020-07-31</span></div><div class="infor">	<span>구매금액</span>	<span>0원 (온라인 0원, 오프라인 0원)</span></div><div class="infor">	<span>구매건수</span>	<span>0회 (온라인 0회, 오프라인 0회)</span></div><div class="infor">	<span>구매후기</span>	<span>0회</span></div>
				</li>
			</ul>
		</div>
		<div class="next_info">
			<p class="next_grade">8월에 <span class="grade4">실버</span> 회원이 되시려면?</p><p>구매금액 : <b>50,000</b>원 남음</p><p>구매건수 및 상품 후기작성 : <b>1</b>회 남음</p>
		</div>
	</div>

	<div class="warning_box">
		<span>최근 6개월 간의 구매건수/상품후기 작성건수와 구매금액을 기준으로 매월 1회 회원등급이 정해집니다. (2015년 6월부터 등급 산정 적용)</span>
		<span>아트박스/POOM 온라인 쇼핑몰 및 전국 직영매장의 구매건수를 통합적으로 적용하여 산출됩니다.</span>
		<span>구매건수/상품후기 작성건수와 구매금액이 모두 충족되어야 합니다.</span>
		<span>총 구매금액 중 꿈캔디 및 쿠폰 사용금액을 제외한 실 결제액으로 회원등급이 정해집니다.</span>
		<span>회원등급별 혜택 및 산정기준은 회원운영정책에 따라 변경될 수 있습니다.</span>
	</div>

	<div class="grade_bottom">
		<!-- grade_bottom_tab -->
		<div class="grade_tab">
			<ul class="pc" id="pc">
				<li id="btn1" class="btnGradeTab G1" onclick="onoff(1);"></li>
				<li id="btn2" class="btnGradeTab G2" onclick="onoff(2);"></li>
				<li id="btn3" class="btnGradeTab G3" onclick="onoff(3);"></li>
				<li id="btn4" class="btnGradeTab G4" onclick="onoff(4);"></li>
				<li id="btn5" class="btnGradeTab G5 on" onclick="onoff(5);"></li>
			</ul>
		</div>
		<!--// grade_bottom_tab -->
		<div id="grade_tab_in_1" class="grade_bottom_tab_in" style="display: none;">
			<dl>
				<dt>등급 산정기준</dt>
				<dd>
				   <ul>
						<li>구매금액 : 50만원 이상</li>
					</ul>
				</dd>
				<dt>혜택</dt>
				<dd>
					<ul>
						<li>5,000원 할인쿠폰 3장(금액상관없이)</li>
						<li>무료배송 쿠폰 2장</li>
					</ul>
				</dd>
				<dt class="text_mint">다이아몬드 회원 추가혜택</dt>
				<dd>
					<ul>
						<li>품절 상품 재입고 시 우선 발송</li>
						<li>서포터즈 및 품이안 우선 선정 기회 제공</li>
						<li>이벤트 응모 시 당첨 확률 증가</li>
						<li>고객 서비스 우선 처리</li>
					</ul>
				</dd>
				<dt>마일리지</dt>
				<dd>
					<ul>
						<li>온라인/오프라인 구매금액 적립비율 <span class="text_e72922">1.5%</span></li>
					</ul>
				</dd>
			</dl>
		</div>
		<div id="grade_tab_in_2" class="grade_bottom_tab_in" style="display: none;">
			<dl>
				<dt>등급 산정기준</dt>
				<dd>
				   <ul>
						<li>구매금액 : 20만원  이상 ~ 50만원 미만</li>
					</ul>
				</dd>
				<dt>혜택</dt>
				<dd>
					<ul>
						<li>5,000원 할인쿠폰 1장 (1만원 이상 구매 시)</li>
						<li>무료배송 쿠폰 2장</li>
					</ul>
				</dd>
				<dt>마일리지</dt>
				<dd>
					<ul>
						<li>온라인/오프라인 구매금액 적립비율 <span class="text_e72922">1.25%</span></li>
					</ul>
				</dd>
			</dl>
		</div>
		<div id="grade_tab_in_3" class="grade_bottom_tab_in" style="display: none;">
			<dl>
				<dt>등급 산정기준</dt>
				<dd>
				   <ul>
						<li>구매건수 : 1회 이상 ~ 3회 미만</li>
					</ul>
				</dd>
				<dt>혜택</dt>
				<dd>
					<ul>
						<li>3,000원 할인쿠폰 1장 (2만원 이상 구매 시)</li>
						<li>무료배송 쿠폰 1장</li>
					</ul>
				</dd>
				<dt>마일리지</dt>
				<dd>
					<ul>
						<li>온라인/오프라인 구매금액 적립비율 <span class="text_e72922">1%</span></li>
					</ul>
				</dd>
			</dl>
		</div>
		<div id="grade_tab_in_4" class="grade_bottom_tab_in" style="display: none;">
			<dl>
				<dt>등급 산정기준</dt>
				<dd>
				   <ul>
						<li>구매건수 또는 상품후기 : 신규가입회원/구매경험이 없는 회원</li>
						<li>구매금액 : 5만원 미만</li>
					</ul>
				</dd>
				<dt>혜택</dt>
				<dd>
					<ul>
						<li>2,000원 할인쿠폰 1장 (3만원 이상 구매 시)</li>
						<li>무료배송 쿠폰 1장</li>
					</ul>
				</dd>
				<dt>마일리지</dt>
				<dd>
					<ul>
						<li>온라인/오프라인 구매금액 적립비율 <span class="text_e72922">1%</span></li>
					</ul>
				</dd>
			</dl>
		</div>
		<div id="grade_tab_in_5" class="grade_bottom_tab_in" style="display: block;">
			<dl>
				<dt>회원님 혜택</dt>
				<dd>
					<ul>
				<c:if test="${grade eq 'BRONZ' }">
						<li>2,000원 할인쿠폰 1장 (3만원 이상 구매 시)&nbsp;&nbsp; <span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(4);">발급받기</span></li>
						<li>무료배송 쿠폰 1장&nbsp;<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(5);">발급받기</span></li>
				</c:if>
				<c:if test="${grade eq 'SILVER' }">
						<li>3,000원 할인쿠폰 1장 (2만원 이상 구매 시)&nbsp;&nbsp;<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(3);">발급받기</span></li>
						<li>무료배송 쿠폰 1장&nbsp;<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(5);">발급받기</span></li>
				</c:if>
				<c:if test="${grade eq 'GOLD' }">
						<li>5,000원 할인쿠폰 1장 (1만원 이상 구매 시)&nbsp;&nbsp;<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(2);">발급받기</span></li>
						<li>무료배송 쿠폰 2장 &nbsp;<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(6);">발급받기</span>
						<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(5);">발급받기</span></li>
				</c:if>
				<c:if test="${grade eq 'DIAMOND' }">
						<li>15,000원 할인쿠폰 1장(금액상관없이)&nbsp;&nbsp;<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(1);">발급받기</span></li>
						<li>무료배송 쿠폰 2장 &nbsp;<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(6);">발급받기</span>
						<span class="scoup" style="font-size: 15px;cursor: pointer; cursor: hand;" onClick="cpClick(5);">발급받기</span></li>
				</c:if>
						
						
						
						
						
						
						
						
					</ul>
				</dd>
				
				
				
				
				<dt>마일리지</dt>
				<dd>
					<ul>
						<li>온라인/오프라인 구매금액 적립비율 <span class="text_e72922">1%</span></li>
					</ul>
				</dd>
			</dl>
		</div>
	</div>

</div>
 
 
 
 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>