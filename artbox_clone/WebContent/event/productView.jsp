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


	function cpClick(){
		var moveCheck;
		var getId  = document.getElementById("loginId").value;
		var coup_Num  = document.getElementById("coupNum").value;

		alert(getId+" : "+coup_Num);
		
		if(getId == "null"){

			moveCheck = confirm("로그인하시겠습니까?"+getId);
			
			if(moveCheck){
				alert("로그인창으로 이동");
			}else{
				alert("그대로 유지");
			}
			
		
	}else{
		var url = "CouponIssued.event?getid="+getId+"&couponNum="+coup_Num;
		alert("쿠폰 저장함"+url);
		location.href=url;
		
	}
		alert("끝");
		
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

	<%int realprice = 3800;
		String sessionId = (String)session.getAttribute("id");
		System.out.println("sessionId"+sessionId);
		String loginId = "jini";	// 로그인한 아이디
		String nullId = "";
		String item_category ="DT01";// 불러온 상품의 카테고리  %> 
		<input type="text" value="<%=realprice%>">
		<input type="text" value="<%=item_category%>">
		<input type="hidden" id="loginId" value="<%=sessionId%>">
		
	<% 
	if(couponList!=null){
	for(int i = 0;i<couponList.size();i++){ %>
		<p> <%=couponList.get(i).getCoupon_condition() %></p>

		
	<% 
	String couponName = couponList.get(i).getCoupon_name();
	int couponNum = couponList.get(i).getCoupon_num();
	if(item_category.equals(couponList.get(i).getCoupon_condition())){ %>
		<input type="hidden" id="coupNum" value="<%=couponNum%>">
	 <input type="button" id="coup_btn" value="<%=couponName%>" onclick= "cpClick();" >

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
