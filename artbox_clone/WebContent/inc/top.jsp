<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 헤더 -->
<script src="js/jquery-3.5.0.js"></script>
 <script type="text/javascript" src="js/home.js"></script>
<!-- <header> -->
<!-- 로고 -->
 <div class="pageHeader">
 
  <div class="logo">
 
 <p style="text-align: center;margin-top: 50px;">
    <a href="${pageContext.request.contextPath}/home/home.jsp"><img  alt="logo" src="${pageContext.request.contextPath}/Images/common/logo.png"></a>
</p>

</div>
<!-- 로고 -->
<!-- 네비게이션바 -->
 <div class="pageNavigationBar" id="topBar">
		<nav id="top_menu">
		<ul>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/item/itemList.jsp" onclick="GA_event('HEAD', '최상단 메뉴', '인형/토이');">인형/토이</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/item/itemDetail.jsp" onclick="GA_event('HEAD', '최상단 메뉴', '문구');">문구</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '패션');">패션</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '주방/욕실');">주방/욕실</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '리빙/데코');">리빙/데코</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '디지털/가전');">디지털/가전</a></li>
			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '여행');">베스트</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/event/eventMain.jsp" onclick="GA_event('HEAD', '최상단 메뉴', '뷰티');">이벤트</a></li>
			<li class="Cart">
				<a href="${pageContext.request.contextPath}/cart/Cart.jsp" title="장바구니" onclick="GA_event('HEAD', '최상단 메뉴 PC', '장바구니');">
						
					<img src="${pageContext.request.contextPath}/Images/common/top_icon_cart.png">
				</a>
			</li>
			
			
			<li class="MyPage">
			
				<a href="#" title="로그인" onclick="GA_event('HEAD', '최상단 메뉴', '로그인');"><img src="${pageContext.request.contextPath}/Images/common/top_icon_login.png" id="MyInfoSummaryIcon"></a>
				<a href="javascript:location.href='https://www.artboxmall.com:443/Home/Member/Login.asp?rtnURL=%2FHome%2Findex%2Easp';" id="LoginBalloon" onclick="GA_event('HEAD', '최상단 메뉴', '팝업로그인');" style="visibility: hidden;"><img src="/Images/common/login_balloon.png?v=2"></a>
				<a class="btnBallon" href="javascript:fnLoginBalloon();"></a>
			
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