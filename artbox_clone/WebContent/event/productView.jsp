<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<CouponBean> couponList= (ArrayList<CouponBean>)request.getAttribute("couponList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

$(document).ready(function(){

	function cpClick(){
		alert("click");
	}
	
});
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

	<%int realprice = 3800;
		String id = "jini";
		String item_category ="DT01";%>
		<input type="text" value="<%=realprice%>">
		<input type="text" value="<%=item_category%>">
	<% 
	if(couponList!=null){
	for(int i = 0;i<couponList.size();i++){%>
		<p> <%=couponList.get(i).getCoupon_condition() %></p>
		
	<% 
	String couponName = couponList.get(i).getCoupon_name();
	int couponNum = couponList.get(i).getCoupon_num();
	if(item_category.equals(couponList.get(i).getCoupon_condition())){ %>
	
	 <input type="button" id="coup_btn" value="<%=couponName%>" onclick= "cpClick()" >

	<% }
	 
	}
	}else{ %>
			일치하는 상품이 없습니다 
			<%}%>

		</div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>
