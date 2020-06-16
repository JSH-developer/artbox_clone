<%@page import="vo.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<script>
function deleteProduct(){
	var del = confirm('주문을 삭제 하시겠습니까?');
	if(del){
		location.href = "OrderDeletePro.admin?num=${productBean.product_num}&page=${page}";
	}
	
}


</script>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin/adminView.css" rel="stylesheet" type="text/css">

</head>
<body>

 <!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->
 
 <input type = "hidden" name = "page" value = "${page}"/>
 
 
<div class="pageContent">
<h1 class="viewTitle">주문상세보기</h1>
<div class="wrapView">
<table class="viewTable">
<tr><th>주문 인덱스</th><td><c:out value="${ordersBean.orders_num}"/></td></tr>
<tr><th>주문 번호</th><td><c:out value="${ordersBean.orders_order_num}"/></td></tr>
<tr><th>아이디</th><td><c:out value="${ordersBean.orders_member_id}"/></td></tr>
<tr><th>주문 이름</th><td><c:out value="${ordersBean.orders_order_name}"/></td></tr>
<tr><th>주문 이메일</th><td><c:out value="${ordersBean.orders_order_email}"/></td></tr>
<tr><th>주문 연락처</th><td><c:out value="${ordersBean.orders_order_phone}"/></td></tr>
<tr><th>포인트</th><td><c:out value="${ordersBean.orders_point}"/></td></tr>
<tr><th>주문 총금액</th><td><c:out value="${ordersBean.orders_total_price}"/></td></tr>
<tr><th>결제수단</th><td><c:out value="${ordersBean.orders_payMethod}"/></td></tr>
<tr><th>배송현황</th><td><c:out value="${ordersBean.orders_state}"/></td></tr>
<tr><th>주문날짜</th><td><c:out value="${ordersBean.orders_regdate}"/></td></tr>
</table>
<br><br>
<button onclick="location.href='OrderList.admin?page=${param.page}'" class="viewBtn">목록가기</button>
<button onclick="deleteProduct()"  class="viewBtn deleteBtn">주문삭제</button>
<br><br>

<h1 class="viewTitle">수신자 상세보기</h1>
<table class="viewTable">
<tr><th>수신자 인덱스</th><td><c:out value="${receiverBean.receiver_num}"/></td></tr>
<tr><th>수신자 이름</th><td><c:out value="${receiverBean.receiver_name}"/></td></tr>
<tr><th>수신자 연락처</th><td><c:out value="${receiverBean.receiver_phone}"/></td></tr>
<tr><th>수신자 우편번호</th><td><c:out value="${receiverBean.receiver_postcode}"/></td></tr>
<tr><th>수신자 기본주소</th><td><c:out value="${receiverBean.receiver_addr}"/></td></tr>
<tr><th>수신자 상세주소</th><td><c:out value="${receiverBean.receiver_addr_detail}"/></td></tr>
<tr><th>수신자 메세지</th><td><c:out value="${receiverBean.receiver_msg}"/></td></tr>
</table>

</div>
</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>