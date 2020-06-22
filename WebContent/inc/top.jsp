<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 헤더 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/js/home.js"></script>
<!-- <header> -->
<!-- 로고 -->
 <div class="pageHeader">
 
  <div class="logo">
 
<!--  <p style="text-align: center;margin-top: 50px;"> -->
    <a href="Home.home" id="orilogo" style="display: block;"><img  alt="logo" src="${pageContext.request.contextPath}/Images/common/logo.png"></a>
     <a href="Home.home" id="scrlogo" style="display: none;"><img  alt="logo" src="${pageContext.request.contextPath}/Images/common/logo.png"></a>
<!-- </p> -->

</div>
<!-- 로고 -->
<!-- 네비게이션바 -->
 <div class="pageNavigationBar" id="topBar">
		<nav id="top_menu">
		<ul>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=DT" onclick="GA_event('HEAD', '최상단 메뉴', '인형/토이');">인형/토이</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=FA" onclick="GA_event('HEAD', '최상단 메뉴', '문구');">문구</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=FS" onclick="GA_event('HEAD', '최상단 메뉴', '패션');">패션</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=KB" onclick="GA_event('HEAD', '최상단 메뉴', '주방/욕실');">주방/욕실</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=LD" onclick="GA_event('HEAD', '최상단 메뉴', '리빙/데코');">리빙/데코</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=DI" onclick="GA_event('HEAD', '최상단 메뉴', '디지털/가전');">디지털/가전</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=TR" onclick="GA_event('HEAD', '최상단 메뉴', '여행');">여행</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=BE" onclick="GA_event('HEAD', '최상단 메뉴', '뷰티');">뷰티</a></li>
			<li class="CategoryMiddle"><a href="index.event" onclick="GA_event('HEAD', '최상단 메뉴', '여행');">베스트</a></li>
			<li class="CategoryMiddle"><a href="EventList.event?event_category=sale_event" onclick="GA_event('HEAD', '최상단 메뉴', '뷰티');">이벤트</a></li>
			<li class="Cart">
				<a href="${pageContext.request.contextPath}/cart/Cart.jsp" title="장바구니" onclick="GA_event('HEAD', '최상단 메뉴 PC', '장바구니');">
						
					<img src="${pageContext.request.contextPath}/Images/common/top_icon_cart.png">
				</a>
			</li>
			
			
			<li class="MyPage">
				<c:if test="${!empty sessionScope.id }">
					<a href="myPageOrders.member" title="마이페이지" onclick="GA_event('HEAD', '최상단 메뉴', '마이페이지');"><img src="${pageContext.request.contextPath}/Images/common/top_icon_login.png" id="MyInfoSummaryIcon"></a>
				</c:if>
				<c:if test="${empty sessionScope.id }">
					<a href="loginForm.member" title="로그인" onclick="GA_event('HEAD', '최상단 메뉴', '로그인');"><img src="${pageContext.request.contextPath}/Images/common/top_icon_login.png" id="MyInfoSummaryIcon"></a>
				</c:if>
			</li>
			<li class="Search">
				<div id="CommonSearch">
					<input type="text" id="kwd" value="" onkeypress="if(event.keyCode==13){fnCommonSearch(1);}">
					<a href="javascript:fnCommonSearch(1);" title="검색" onclick="GA_event('HEAD', '최상단 메뉴 PC', '검색');">
					<img src="${pageContext.request.contextPath}/Images/common/top_icon_search.png"></a>
				</div>
			</li>
			
			</ul>
		<div class="clear"></div>
		
	</nav>
</div>
 
 </div>
 <!-- 네비게이션바 -->
<!--  </header> -->
 <!-- 헤더 -->