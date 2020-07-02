<%@page import="vo.ProductBean"%>
<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
// ArrayList<CouponBean> couponList= (ArrayList<CouponBean>)request.getAttribute("couponList");
// ProductBean item= (ProductBean)request.getAttribute("item");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<script type="text/javascript">


	function cpClick(){
		var moveCheck;
		var getId  = document.getElementById("loginId").value;
		var coup_Num  = document.getElementById("coupNum").value;

		alert(getId+" : "+coup_Num);
		
		if(getId == "null" || getId == ""){

			moveCheck = confirm("로그인하시겠습니까?"+getId);
			
			if(moveCheck){
				alert("로그인창으로 이동");
			}else{
				alert("그대로 유지");
			}
			
		

	} else {
			var url = "CouponIssued.coupon?getid=" + getId + "&couponNum="+ coup_Num;
			
			location.href = url;
			
		}
	}
	
	
	
</script>
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="/inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
 <h1>상품 페이지</h1>

			<c:set var="sessionId" value="${sessionScope.id}"/>
			<c:set var="loginId" value="jini"/>
			<c:set var="item_category" value="${item.product_category_code }"/>
			<c:set var="realprice" value="${item.product_price}"/>
			<c:set var="saleprice" value="${item.product_sale_price}"/>
			<c:set var="couponName" value="${itemcoupon.coupon_name }"/>
			<c:set var="couponNum" value="${itemcoupon.coupon_num }"/>
		
			<c:out value="${itemcoupon.coupon_name  }"/>
		<span>카테고리 : ${item_category}</span>
		
		<input type="hidden" id="loginId" value="${sessionId}">


		<span id="rprice">실가격 :${realprice }</span>
		
		
	
	<!-- 			할인 있거나 쿠폰 있을때    || item.product_sale_price > 0-->
		<c:if test="${item.product_sale_price > 0}"> 
		<!-- 			realprice 스타일바꿈 -->
			<style>span#rprice {text-decoration: line-through;color:grey;}</style>
			
<!-- 			할인 있을때 -->
				<c:if test="${empty itemcoupon.coupon_name}">
						<span>이벤트 할인가격 :  ${realprice - saleprice }</span> 
				</c:if>
				
<!-- 				쿠폰 있을때 -->
			<c:if test="${not empty itemcoupon.coupon_name}">
<%-- 			<c:set var="coup_discount" value="${itemcoupon.coupon_price }"/> --%>
<%-- 			<c:set var="c_sale_price" value="${realprice - itemcoupon.coupon_price }"/> --%>
				<span>쿠폰 할인가격 :  ${realprice - saleprice }</span> 
					<input type="hidden" id="coupNum" value="${couponNum }">
					<input type="button" id="coup_btn" value="${couponName }" onclick= "cpClick();" ><br>
				</c:if>
					
			</c:if>
					
				
			<c:if test="${empty item}"> 
			<section id="emptyArea">등록된 글이 없습니다.</section>
			</c:if>

		</div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>
