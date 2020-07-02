<%@page import="vo.ProductBean"%>
<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

	
	
</script>
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="/inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">

<div class="wrap">
	<div class="top_title">꿈캔디</div>
	
	<div class="top_box">
		<div class="whoes">
			<span>${Mypointrecode[0].member_id}</span> 님의 꿈캔디 현황 
			<div class="guide_box pc">
				꿈캔디는 현금처럼 쓰실 수 있는 마일리지로,<br>
				아트박스/POOM 온라인 쇼핑몰 및 전국 직영매장에서 적립 및 사용하실 수 있습니다.
			</div>
		</div>
		<div class="three_box">
			<ul>
				<li>
					<div class="inner_box">
						<div class="subj pc">사용가능 꿈캔디</div>
						<div class="cont type1">${Mypointrecode[0].mypoint }</div>
					</div>
				</li>
				<li>
					<div class="inner_box">
						<div class="subj pc">등급별 적립률</div>
						<div class="cont type2">1%</div>
					</div>
				</li>
				<li>
					<div class="inner_box">
						<div class="subj pc">소멸예정 꿈캔디</div>
						<div class="cont type3">0</div>
						<div class="bottom_cont">2020-06-30 소멸예정</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="guide_box mobile">
			꿈캔디는 현금처럼 쓰실 수 있는 마일리지로,<br>
			아트박스/POOM 온라인 쇼핑몰 및 전국 직영매장에서 적립 및 사용하실 수 있습니다.
		</div>
	</div>
	<div class="warning_box">
		<span>꿈캔디는 상품 구매, 구매후기 작성, 이벤트 참여 시에 회원 등급에 따라 최고 1.5%까지 적립되며, 쿠폰과 함께 중복 사용이 가능합니다.</span>
		<span>꿈캔디 100개는 현금 100원과 같으며, 아트박스/POOM 온라인 쇼핑몰 및 전국 직영매장에서 상품 구매 시 사용하실 수 있습니다.</span>
		<span>꿈캔디는 적립 월로부터 1년 이내에 사용하셔야 합니다.</span>
		<span>이벤트를 통해 적립된 꿈캔디는 유효기간이 다를 수 있으니 사용기간을 별도로 확인해 주세요.</span>
	</div>
	<div class="sel_box">
		<select name="Term">
			<option value="1">최근 1개월</option>
			<option value="2">최근 2개월</option>
			<option value="3">최근 3개월</option>
			<option value="6">최근 6개월</option>
		</select>
	</div>
				<div class="CandyTable">
					<table cellspacing="0">
						<tbody>
							<tr>
								<th>날짜</th>
								<th>구분</th>
								<th>내용</th>
								<th>사용/적립</th>
							</tr>
						</tbody>
					</table>
					<c:if test="${empty Mypointrecode }">
					<div class="noData">적립/사용 내역이 없습니다.</div>
					</c:if>
					
					<c:if test="${!empty Mypointrecode }">
					<table cellspacing="0">
						<tbody>
						<c:forEach var="i" begin="0" end="${fn:length(Mypointrecode) -1}" step="1">
						
							<tr>
								<td>${Mypointrecode[i].reg_date }</td>
								<td>${Mypointrecode[i].title }</td>
								<td>${Mypointrecode[i].content }</td>
								<td>${Mypointrecode[i].type }</td>
							</tr>
							
							</c:forEach>
						</tbody>
					</table>
					
					</c:if>



				</div>

			</div>



</div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>
