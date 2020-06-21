<%@page import="vo.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if(${ordersBean.orders_state} == 0){
		$("#order_state").text('배송준비중');
	}else if(${ordersBean.orders_state} == 1){
		$("#order_state").text('배송진행중');
	}else if(${ordersBean.orders_state} == 2){
		$("#order_state").text('배송완료');
	}else if(${ordersBean.orders_state} == -1){
		$("#order_state").text('배송취소');
	}
})

function deleteProduct(){
	var del = confirm('주문을 삭제 하시겠습니까?');
	if(del){
		location.href = "OrderDeletePro.admin?num=${productBean.product_num}&page=${page}";
	}
}

function changeStatus(){
	var statusWindow = window.open("./changeState.admin?num="+${ordersBean.orders_num}+"&status="+${ordersBean.orders_state}, "", "width=700,height=250,left=250,top=250");
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

<div class="wrapView">

<div class="wrapTbl">
<img class="admin_deco" src="${pageContext.request.contextPath}/Images/admin/otto.png" />
<table class="viewTable vt_child1">
<tr><td colspan="2"><h1 class="viewTitle">주문 상세보기</h1></td></tr>
<tr><th>주문 인덱스</th><td><c:out value="${ordersBean.orders_num}"/></td></tr>
<tr><th>주문 번호</th><td><c:out value="${ordersBean.orders_order_num}"/></td></tr>
<tr><th>아이디</th><td><c:out value="${ordersBean.orders_member_id}"/></td></tr>
<tr><th>주문 이름</th><td><c:out value="${ordersBean.orders_order_name}"/></td></tr>
<tr><th>주문 이메일</th><td><c:out value="${ordersBean.orders_order_email}"/></td></tr>
<tr><th>주문 연락처</th><td><c:out value="${ordersBean.orders_order_phone}"/></td></tr>
<tr><th>포인트</th><td><c:out value="${ordersBean.orders_point}"/></td></tr>
<tr><th>주문 총금액</th><td><c:out value="${ordersBean.orders_total_price}"/></td></tr>
<tr><th>결제수단</th><td><c:out value="${ordersBean.orders_payMethod}"/></td></tr>
<tr><th>배송현황</th><td><span id="order_state"></span><br><button onclick="changeStatus()">배송상태 변경</button></td></tr>
<tr><th>주문날짜</th><td><c:out value="${ordersBean.orders_regdate}"/></td></tr>
</table>

<img class="admin_deco" src="${pageContext.request.contextPath}/Images/admin/october.png" />
<table class="viewTable vt_child2">
<tr><td colspan="2"><h1 class="viewTitle">수신자 상세보기</h1></td></tr>
<tr><th>수신자 인덱스</th><td><c:out value="${receiverBean.receiver_num}"/></td></tr>
<tr><th>수신자 이름</th><td><c:out value="${receiverBean.receiver_name}"/></td></tr>
<tr><th>수신자 연락처</th><td><c:out value="${receiverBean.receiver_phone}"/></td></tr>
<tr><th>수신자 우편번호</th><td><c:out value="${receiverBean.receiver_postcode}"/></td></tr>
<tr><th>수신자 기본주소</th><td><c:out value="${receiverBean.receiver_addr}"/></td></tr>
<tr><th>수신자 상세주소</th><td><c:out value="${receiverBean.receiver_addr_detail}"/></td></tr>
<%-- <tr><th>수신자 메세지</th><td><c:out value="${receiverBean.receiver_msg}"/></td></tr> --%>
</table>

</div>
<br><br>

<h1 class="viewTitle">주문상품 상세보기</h1>

<table class="viewDetailTable">
<tr><th>상품 인덱스</th><th>상품 코드</th><th>상품 이름</th><th>상품 이미지</th><th>상품 수량</th><th>상품 낱개 가격</th><th>상품 총가격</th></tr>
<c:forEach var="i" begin="0" end="${fn:length(ordersDetailBeans)-1}" step="1">
<tr><td><c:out value="${ordersDetailBeans[i].ordersDetail_num}"/></td><td><c:out value="${ordersDetailBeans[i].ordersDetail_code}"/></td>
<td><c:out value="${ordersDetailBeans[i].ordersDetail_name}"/></td><td><img src="${pageContext.request.contextPath}/upload/<c:out value="${ordersDetailBeans[i].ordersDetail_image}"/>" width="100px" height="100px"/></td>
<td><c:out value="${ordersDetailBeans[i].ordersDetail_quantity}"/>개</td><td><c:out value="${ordersDetailBeans[i].ordersDetail_price}"/>원</td>
<td>${ordersDetailBeans[i].ordersDetail_quantity * ordersDetailBeans[i].ordersDetail_price}원</td></tr>
</c:forEach>
</table>
<br><br>
<button onclick="location.href='OrderList.admin?page=${param.page}&state=${param.state}'" class="viewBtn">목록가기</button>
<button onclick="deleteProduct()"  class="viewBtn deleteBtn">주문삭제</button>
<br><br>

</div>
</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>