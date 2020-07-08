<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin/adminList.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#status_select").val(${param.state});

});

function change_state(){
	var state = document.getElementById("status_select").value;
	location.href="./OrderList.admin?state="+state;
}
</script>


</head>
<body>

<!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
<!-- 헤더 -->
<c:choose>
<c:when test="${empty grade}">
	<script>
		alert("관리자만 접근이 가능한 페이지입니다.");
		location.href="Home.home";
	</script>
</c:when>
<c:otherwise>
	<c:if test="${grade ne 'ADMIN'}">
	<script>
		alert("관리자만 접근이 가능한 페이지입니다.");
		location.href="Home.home";
	</script>
	</c:if>
</c:otherwise>
</c:choose> 

<div class="pageContent">

<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="OrderList.admin">주문 목록</a></li>
</ul>
</div>

<select id="status_select" class="chooseOpt" onchange="change_state()">
<option value="-10">전체보기</option><option value="0">배송준비중</option>
<option value="1">배송진행중</option><option value="2">배송완료</option>
<option value="-1">배송취소</option><option value="3">구매확정</option></select>

<h1 class="list_title">주문리스트</h1>

<c:catch var="e">
<table class="table_content">
<tr><th>번호</th><th>아이디</th><th>주문번호</th><th>승인날짜</th><th>배송상태</th></tr>
	<c:forEach var="i" begin="0" end="${fn:length(orderList)-1}" step="1">
		<tr>
		<td>${orderList[i].orders_num}</td>
		<td>${orderList[i].orders_member_id}</td>
		<td><a href='OrderView.admin?num=${orderList[i].orders_num}&page=${pageInfo.page}&state=${param.state}'>${orderList[i].orders_order_num}</a></td>
		<td><fmt:formatDate value="${orderList[i].orders_regdate}" pattern="yyyy-MM-dd"/> </td>
		<td><span class="orders_state">
		<c:if test="${orderList[i].orders_state eq 0}">
		배송준비중
		</c:if>
		<c:if test="${orderList[i].orders_state eq 1}">
		배송진행중
		</c:if>
		<c:if test="${orderList[i].orders_state eq 2}">
		배송완료
		</c:if>
		<c:if test="${orderList[i].orders_state eq -1}">
		배송취소
		</c:if>
		<c:if test="${orderList[i].orders_state eq 3}">
		구매확정
		</c:if>
		</span><br><button onclick="window.open('./changeState.admin?num='+${orderList[i].orders_num}+'&status='+${orderList[i].orders_state}, '', 'width=700,height=250,left=250,top=250');">배송상태 변경</button></td></tr>
	</c:forEach>
	</table>
	
	<section id="pageList">
		<c:choose>
		<c:when test="${pageInfo.page <= 1}">
		◁&nbsp;
		</c:when>
		<c:when test="${pageInfo.page > 1}">
		<a href="OrderList.admin?page=${pageInfo.page-1}&state=${param.state}">◁</a>&nbsp;
		</c:when>
		</c:choose>
		<c:forEach var="a" begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1">
			<c:choose>
			<c:when test="${a == pageInfo.page}">
				${a}
			</c:when>
			<c:otherwise>
				<a href="OrderList.admin?page=${a}&state=${param.state}">${a}
				</a>&nbsp;
			</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:choose>
		<c:when test="${ pageInfo.page >= pageInfo.maxPage }">
			▷
		</c:when>
		<c:otherwise>
			<a href="OrderList.admin?page=${pageInfo.page+1}&state=${param.state}">▷</a>
		</c:otherwise>
		</c:choose>
	</section>
	
	</div>
</c:catch>

<c:if test="${e != null}">
<table class="table_content">
<tr><td colspan="5">표시할 항목이 없습니다.</td></tr>
</table>
<br><br>
</c:if>











<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>