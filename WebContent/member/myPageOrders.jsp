<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/member/myPage.js"></script>
<script>

function cancel(orders_order_num,point){
	cancel = confirm("구매취소 또는 반품 하시겠습니까?\n※취소 후 금액은 포인트로 환불됩니다.");
	if(cancel){
		location.href="cancel.member?orders_order_num="+orders_order_num+"&point="+point;
	}
}

function buy(orders_order_num,point){
	buy = confirm("구매확정 하시겠습니까?\n※구매확정이후 교환/환불 이 불가능합니다.");
	if(buy){
		location.href="buy.member?orders_order_num="+orders_order_num+"&point="+point;
	}
	
}

</script>
<link href="${pageContext.request.contextPath}/css/member/myPage.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<%-- <link href="${pageContext.request.contextPath}/css/slide.css" rel="stylesheet" type="text/css"> --%>
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="/inc/top.jsp"></jsp:include>
	<!-- 헤더 -->

	<div class = "body_box">
		<div class="top_box">
			<jsp:include page="/member/myPageHeader.jsp"></jsp:include>
		</div>
		
		
		<div class="MenuBar_Box">
			<ul>
				<li onclick="location.href='myPageOrders.member'" class="on">주문/배송</li>
				<li onclick="location.href='myPageRe.member'">취소/반품/교환</li>
				<li onclick="location.href='myPageWishlist.member'">위시리스트</li>
				<li onclick="location.href='myPageQ&A.member'">상품Q&A</li>
				<li onclick="location.href='myPageQuestion.member'">1:1 문의/상담</li>
			</ul>
		</div>


		<div class="sel_box">
			<select name="Term" id="term" onchange="select()">
				<option value="0">전체보기</option>
				<option value="1" >최근 1개월</option>
				<option value="2" >최근 2개월</option>
				<option value="3" >최근 3개월</option>
				<option value="6" >최근 6개월</option>
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
			margin-top:7px;
			padding:8px;
			color:white;
			background: #f58495;
			border: 1px solid #f58495;
		}
		
		.myOrders button.confirm_btn{
			background: grey;
			border: 1px solid grey;
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
		
		<c:if test="${!empty myOrders }">
		<c:forEach var="orders" items="${myOrders}">
		<div class="myOrders">
		<table class="myOrderstb">
		<tr><td><span class="info_box">주문번호  </span>${orders.orders_order_num}
		<a href="myPageOrdersDetail.member?num=${orders.orders_num}&orders_num=${orders.orders_order_num}"><strong>&nbsp;주문상세보기</strong></a></td><td rowspan="5" class="state_box">
		<c:if test="${orders.orders_state eq 0 }">
		배송준비중<br><button onclick="cancel(${orders.orders_order_num},${orders.orders_total_price})">주문취소</button>
		</c:if>
		<c:if test="${orders.orders_state eq 1 }">
		배송진행중<br><button onclick="cancel(${orders.orders_order_num},${orders.orders_total_price})">주문취소</button>
		</c:if>
		<c:if test="${orders.orders_state eq 2 }">
		배송완료<br><button class="confirm_btn" onclick="buy(${orders.orders_order_num},${orders.orders_point})">구매확정</button>
		<br><button onclick="cancel(${orders.orders_order_num},${orders.orders_total_price})">반품하기</button>
		</c:if>
		<c:if test="${orders.orders_state eq 3 }">
		구매확정이 된 상품입니다.
		</c:if>
		<c:if test="${orders.orders_state eq -1 }">
		배송취소
		</c:if>
		</td></tr>
		<tr><td colspan="2">※상품에 대한 자세한 정보는 <strong>'주문상세보기'</strong>를 클릭하면 확인하실수 있습니다.</td></tr>
		<tr><td colspan="2"><span class="info_box">총가격  </span>${orders.orders_total_price}</td></tr>
		<tr><td colspan="2"><span class="info_box">주문날짜  </span><fmt:formatDate value="${orders.orders_regdate}" pattern="yyyy.MM.dd" /></td></tr>
		</table>
		</div>
		<br>
		</c:forEach>
		</c:if>

		<c:if test="${empty myOrders}">
		<div class="noData">주문내역이 없습니다.</div>
		</c:if>
	</div>
	
	
	<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>