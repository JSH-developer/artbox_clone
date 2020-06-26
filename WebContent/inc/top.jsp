<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=DT&page=1">인형/토이</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=FA&page=1">문구</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=FS&page=1">패션</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=KB&page=1">주방/욕실</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=LD&page=1">리빙/데코</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=DI&page=1">디지털/가전</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=TR&page=1">여행</a></li>
			<li class="CategoryMiddle"><a href="${pageContext.request.contextPath}/itemList.item?major=BE&page=1">뷰티</a></li>
			<li class="CategoryMiddle"><a href="index.event">베스트</a></li>
			<li class="CategoryMiddle"><a href="EventList.event?event_category=sale_event">이벤트</a></li>
			<li class="Cart">
				<a href="${pageContext.request.contextPath}/cart/Cart.jsp" title="장바구니">
						
					<img src="${pageContext.request.contextPath}/Images/common/top_icon_cart.png">
				</a>
			</li>
			
			
			<li class="MyPage">
			
				<a href="#" title="로그인"><img src="${pageContext.request.contextPath}/Images/common/top_icon_login.png" id="MyInfoSummaryIcon"></a>
<!-- 				<a href="javascript:location.href='https://www.artboxmall.com:443/Home/Member/Login.asp?rtnURL=%2FHome%2Findex%2Easp';" id="LoginBalloon" onclick="GA_event('HEAD', '최상단 메뉴', '팝업로그인');" style="visibility: hidden;"><img src="/Images/common/login_balloon.png?v=2"></a> -->
				<a class="btnBallon" href="javascript:fnLoginBalloon();"></a>
			
			</li>
			<li class="Search">
				<div id="CommonSearch">
				<form action="${pageContext.request.contextPath}/itemList.item" method="get">
					<input type="hidden" name="page" value="1">					
					<input style="border: 0;outline: 0;font-size: 20px;vertical-align: top;height: 30px;" type="text" name="kwd">
					<button style="border: 0;outline: 0;background-color: white;" type="submit">
						<img src="${pageContext.request.contextPath}/Images/common/top_icon_search.png">
					</button>
				</form>
				</div>
			</li>
			
			</ul>
		<div class="clear"></div>
		
	</nav>
</div>
 
 </div>