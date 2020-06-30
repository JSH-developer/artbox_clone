<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="css/member/myPage.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="member/myPage.js"></script>

</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 -->
	<div class = "body_box">
		<div class="top_box">
			<jsp:include page="../member/myPageHeader.jsp"></jsp:include>
		</div>
		<div class="MenuBar_Box">
			<ul>
				<li onclick="location.href='myPageOrders.member'">주문/배송</li>
				<li onclick="location.href='myPageRe.member'" class="on">취소/반품/교환</li>
				<li onclick="location.href='myPageWishlist.member'">위시리스트</li>
				<li onclick="location.href='myPageQ&A.member'">상품Q&A</li>
				<li onclick="location.href='myPageQuestion.member'">1:1 문의/상담</li>
			</ul>
		</div>


		<div class="sel_box">
			<select name="Term">
				<option value="0">전체보기</option>
				<option value="1">최근 1개월</option>
				<option value="2">최근 2개월</option>
				<option value="3">최근 3개월</option>
				<option value="6">최근 6개월</option>

			</select>
		</div>


		<div class="clear"></div>
		<br>
		
		<style type="text/css">
		.myOrders{
 			border-top: 1px solid grey; 
 			border-bottom: 1px solid grey;
			height: auto;
			padding: 10px;
		}
		.myOrderstb{
			width: 100%;
		}
		
		.myOrderstb td{
			padding:10px;
		}
		
		.myOrders button{
			margin-top:5px;
			padding:3px;
		}
		
		.myOrderstb a:hover{
			font-size: 20px;
		}
		
		.state_box{
			width:300px;
			text-align: center;
		}
		
		.info_box{
			color:#eb5280;
		}
		
		</style>
		
		<c:if test="${!empty myRes}">
		<c:forEach var="res" items="${myRes}">
		<div class="myOrders">
		<table class="myOrderstb">
		<tr><td><span class="info_box">주문번호  </span>${res.orders_order_num}
		<a href="myPageOrdersDetail.member?num=${res.orders_num}&orders_num=${res.orders_order_num}"><strong>&nbsp;주문상세보기</strong></a></td><td rowspan="5" class="state_box">주문이 취소된 상품입니다.</td></tr>
		<tr><td colspan="2">※상품에 대한 자세한 정보는 <strong>'주문상세보기'</strong>를 클릭하면 확인하실수 있습니다.</td></tr>
		<tr><td colspan="2"><span class="info_box">총가격  </span>${res.orders_total_price}</td></tr>
		<tr><td colspan="2"><span class="info_box">주문날짜  </span><fmt:formatDate value="${res.orders_regdate}" pattern="yyyy.MM.dd" /></td></tr>
		</table>
		</div>
		<br>
		</c:forEach>
		</c:if>
		
		<c:if test="${empty myRes}">
		<div class="noData">주문내역이 없습니다.</div>
		</c:if>

		
	</div>
	
	
	<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>