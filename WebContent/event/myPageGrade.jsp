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
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/event/myPage.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function onoff(s){
	
// 	var p = document.getElementById("grade_tab_in_1");
	
// 		$("#pc li").attr("class","on");

// 	$("#btn"+s).addClass("on");

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
	
		
		
		
		
// 		$("p").removeClass("hilite");
}


</script>


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
					<p class="grade_icon"><img src="${pageContext.request.contextPath}/Images/mypage/pc_top_grade5.png"></p><p class="grade_ment"><span class="grade5">SILVER</span></p><p class="grade_me">조해진님의 통합멤버십 등급은 <span class="grade5">실버</span>입니다.</p><p class="grade_etc">(등급적용기간 2020-06-01 ~ 2020-06-30)</p>
				</li>
				<li>
					<div class="grape_back">
						<div style="border-left:1px solid #b9b9b9; border-right:1px solid #b9b9b9; width:25%; height:6px; float:left;"></div>
						<div style="border-right:1px solid #b9b9b9; width:25%; height:6px; float:left;"></div>
						<div style="border-right:1px solid #b9b9b9; width:25%; height:6px; float:left;"></div>
						<div style="border-right:1px solid #b9b9b9; width:25%; height:6px; float:left;"></div>
						<div style="clear:both;"></div>
					</div>
					<div class="grade_bar"><div class="bar_in"><span class="blank">	<span class="range per0"></span></span><span class="blank">	<span class="range per0"></span></span><span class="blank">	<span class="range per0"></span></span><span class="blank">	<span class="range per0"></span></span></div></div>
					<div class="grade_icon_box">
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_silver.png"></span>
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_gold.png"></span>
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_sapphire.png"></span>
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_ruby.png"></span>
						<span class="grad_icon"><img src="${pageContext.request.contextPath}/Images/mypage/common_icon_diamond.png"></span>
					</div>
					<div class="infor">	<span>등급선정</span>	<span>2019-12-01 ~ 2020-05-31</span></div><div class="infor">	<span>구매금액</span>	<span>0원 (온라인 0원, 오프라인 0원)</span></div><div class="infor">	<span>구매건수</span>	<span>0회 (온라인 0회, 오프라인 0회)</span></div><div class="infor">	<span>구매후기</span>	<span>0회</span></div>
				</li>
			</ul>
		</div>
		<div class="next_info">
			<p class="next_grade">7월에 <span class="grade4">골드</span> 회원이 되시려면?</p><p>구매금액 : <b>50,000</b>원 남음</p><p>구매건수 및 상품 후기작성 : <b>1</b>회 남음</p>
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
						<li>구매건수 또는 상품후기 : 10회 이상</li>
						<li>구매금액 : 100만원 이상</li>
					</ul>
				</dd>
				<dt>혜택</dt>
				<dd>
					<ul>
						<li>아트박스/POOM 온라인 쇼핑몰 및 전국 직영매장</li>
						<li>상시 <span class="text_e72922">10% 할인</span> (행사 상품, 상품 쿠폰 중복할인 가능)</li>
						<li>아트박스/POOM 배송상품 상시 무료배송/무료반품</li>
						<li>업체 상품 무료배송 쿠폰 4장</li>
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
						<li>구매건수 또는 상품후기 : 5회 이상 ~ 10회 미만</li>
						<li>구매금액 : 50만원 이상 ~ 100만원 미만</li>
					</ul>
				</dd>
				<dt>혜택</dt>
				<dd>
					<ul>
						<li>아트박스/POOM 온라인 쇼핑몰 및 전국 직영매장</li>
						<li>상시 <span class="text_e72922">5% 할인</span> (행사 상품, 상품 쿠폰 중복할인 가능)</li>
						<li>아트박스/POOM 배송상품 조건부 무료배송</li>
						<li>(1만원 이상 구매시)</li>
						<li>업체 상품 무료배송 쿠폰 2장</li>
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
						<li>구매건수 또는 상품후기 : 3회 이상 ~ 5회 미만</li>
						<li>구매금액 : 20만원 이상 ~ 50만원 미만</li>
					</ul>
				</dd>
				<dt>혜택</dt>
				<dd>
					<ul>
						<li><span class="text_e72922">5% 할인</span>쿠폰 1장 (구매금액 무관)</li>
						<li>아트박스/POOM 배송상품 조건부 무료배송</li>
						<li>(2만원 이상 구매 시)</li>
						<li>업체 상품 무료배송 쿠폰 2장 (1만원 이상 구매 시)</li>
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
						<li>구매건수 또는 상품후기 : 1회 이상 ~ 3회 미만</li>
						<li>구매금액 : 5만원 이상 ~ 20만원 미만</li>
					</ul>
				</dd>
				<dt>혜택</dt>
				<dd>
					<ul>
						<li>2,000원 할인쿠폰 1장 (3만원 이상 구매 시)</li>
						<li>업체 상품 무료배송 쿠폰 2장 (2만원 이상 구매 시)</li>
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
						<li>업체 상품 무료배송 쿠폰 1장 (2만원 이상 구매시)</li>
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