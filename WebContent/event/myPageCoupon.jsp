<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
ArrayList<CouponBean> myCouponList= (ArrayList<CouponBean>)request.getAttribute("mycouponList");
%>

<%-- ${CouponBean.couponList} --%>

<%-- <c:out value="${CouponBean.couponList}" default="hi" /> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/event/myPage.css" rel="stylesheet" type="text/css">

</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
 
<div class="wrap">
	<div class="top_title">쿠폰</div>
	
	<div class="top_box">
		<div class="whoes">
		<%String id = "jini"; %>
		<c:set var="id" value="jini"/>
		<input type="hidden" id="loginid">
			<span>${id}</span> 님이 지금 사용하실 수 있는 쿠폰
		</div>
		<div class="three_box">
			
			<ul>
				
				<li class="bonus_coupon">
					<div class="inner_box">
						<p>1</p>
					</div>
				</li>
				
				<li class="free_coupon">
					<div class="inner_box">
						<p>1</p>
					</div>
				</li>
				
			</ul>
			
		</div>
	</div>
	<div class="warning_box">
		<span>본 쿠폰은 아트박스 통합 멤버십 쿠폰으로, 아트박스 매장/아트박스 온라인몰/POOM 에서 사용 가능합니다.</span>
		<span>매장 쿠폰은 중복 할인이 불가합니다.</span>
		<span>발행되는 쿠폰마다 사용조건(주문금액 및 사용기간)이 다릅니다. 쿠폰 사용 전 사용조건을 꼭 확인해 주세요.</span>
		<span>쿠폰 사용이 가능한 주문금액은, 배송비와 할인금액을 제외한 금액입니다.</span>
		<span>결제가 완료된 주문 건에는 쿠폰을 사용하실 수 없습니다.</span>
		<span>사용기간이 지난 쿠폰은 자동으로 삭제됩니다.</span>
		<span>주문취소 시 사용한 쿠폰은 자동으로 재발급 됩니다.(사용 가능 기간이 남아있을 경우에만 재발급)</span>
		<span>보너스 쿠폰과 상품 쿠폰은 중복 사용이 불가합니다.</span>
	</div>
	<div class="enroll_coupon_tab">
		<span>이벤트 쿠폰</span><span>* 오프라인 매장이나 제휴사 이벤트를 통해 발급받으신 쿠폰번호를 등록하시면 쿠폰이 발급됩니다.</span>
		<span id="couponissue">쿠폰 등록하기</span>
	</div>

<div>

</div>

<c:set var="bonusCouponCount" value="0"/>
<c:set var="freeCouponCount" value="0"/>
<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
<c:set var="Coupon" value="${mycouponList[i].coupon_category}" />
<c:if test="${Coupon eq 'bonuscoupon' }">
<c:set var="bonusCouponCount" value="${bonusCouponCount+1 }"/>
</c:if>

<c:if test="${Coupon eq 'freecoupon' }">
<c:set var="freeCouponCount" value="${freeCouponCount+1 }"/>
</c:if>

</c:forEach>



<!-- 가지고 있는 쿠폰 목록 -->
				<div class="coupon_tab on">온라인 전용 쿠폰 (2장)</div>
		
				<div class="coupon_box">
					<div class="detail_tab">보너스 쿠폰 (${bonusCouponCount }장)</div>
					<div class="CouponList">
						<ul>
		<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
		<c:set var="myCoupon" value="${mycouponList[i].coupon_category}" />
		<c:if test="${myCoupon eq 'bonuscoupon' }">
							<li>
								<div class="CouponImage">
									<img
										src="http://www.poom.co.kr/Images/Ver2/Mypoom/sale2000.jpg">
								</div>
									<div class="CouponName" title= "${ mycouponList[i].coupon_name}">
								${mycouponList[i].coupon_name}</div>
								<div class="CouponInfo">
									<span>${mycouponList[i].coupon_start} ~ ${mycouponList[i].coupon_limit}</span>
									<span>${mycouponList[i].coupon_reason}</span>
								</div>
							</li>
						</c:if>
						</c:forEach>
						</ul>
					</div>


					<div class="detail_tab">
						무료배송 쿠폰 (${freeCouponCount }장)
					</div>
					<div class="CouponList">
						<ul>
							<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
								<c:set var="myCoupon" value="${mycouponList[i].coupon_category}" />
								<c:if test="${myCoupon eq 'freecoupon' }">
									<li>
										<div class="CouponImage"> <img src="http://www.poom.co.kr/Images/Ver2/Mypoom/sale2000.jpg"></div>
										<div class="CouponName" title="${ mycouponList[i].coupon_name}">${mycouponList[i].coupon_name}</div>
										<div class="CouponInfo">
											<span>${mycouponList[i].coupon_start} ~${mycouponList[i].coupon_limit}</span> 
											<span>${mycouponList[i].coupon_reason}</span>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>

				<div class="coupon_tab on">매장 전용 쿠폰 (0장)</div>
	
	<div class="coupon_box nocoupon">보유한 쿠폰이 없습니다.</div>


	<div class="bMargin"></div>




</div>
 
 
 
 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>