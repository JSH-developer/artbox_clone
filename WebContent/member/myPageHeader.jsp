<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="css/member/myPage.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/member/myPage.js"></script>

<c:if test="${empty sessionScope.id }">
	<c:redirect url="loginForm.member"/>
</c:if>

<div class="whoes">
	<span class="MNmSpan">안녕하세요, <span class="MNm">${name}</span> 님	</span>
		<span class="MInfo">
			<span  style="cursor: pointer;">회원정보</span>
				<div class="Pop_Menu" id="Pop_Menu" style="display: none;">
					<ul>
						<li><a href="profileChange.member">회원정보 변경</a></li>
						<li><a href="delivery.member">나의 배송지 관리</a></li>
						<li><a href="logout.member">로그아웃</a></li>
					</ul>	
				</div>
		</span>
		<a href="#" onclick="GA_event('마이페이지_PC', '상단 메뉴', '이벤트 참여/당첨 내역');"><span class="MEvent">이벤트 참여/당첨 내역</span></a>
</div>		
<div class="three_box">
	<ul>

			<li class="Tbox1">
				<c:if test="${grade eq 'BRONZ' }">
				<a href="MypageGrade.event">
					<span class="GName grade1">BRONZ</span>
					<img class="GImg" src="${pageContext.request.contextPath}/Images/img/bronz.jpg" />
					<span class="GSee grade1">회원님의 등급입니다.</span></a>
				</c:if>
				<c:if test="${grade eq 'SILVER' }">
					<span class="GName grade2">SILVER</span>
					<img class="GImg" src="${pageContext.request.contextPath}/Images/img/silver.png" />
					<span class="GSee grade2">회원님의 등급입니다.</span>
				</c:if>
				<c:if test="${grade eq 'GOLD' }">
					<span class="GName grade3">GOLD</span>
					<img class="GImg" src="${pageContext.request.contextPath}/Images/img/gold.png" />
					<span class="GSee grade3">회원님의 등급입니다.</span>
				</c:if>
				<c:if test="${grade eq 'DIAMOND' }">
					<span class="GName grade4">DIAMOND</span>
					<img class="GImg" src="${pageContext.request.contextPath}/Images/img/diamond.png" />
					<span class="GSee grade4">회원님의 등급입니다.</span>
				</c:if>
			</li>


		<a href="MypagePointList.event" onclick="GA_event('마이페이지', '상단 메뉴', '꿈캔디 내역');"><li
			class="Tbox2"><img class="CImg" src="Images/img/point.png" /> <span
				class="CCandy">${point }</span></li></a>
		<li class="Tbox3">
			<ul>
				<a href="#" onclick="GA_event('마이페이지', '상단 메뉴', '주문/배송');"><li>
						<span>주문/배송</span><span>${orderCount }</span>
				</li></a>
				<a href="MypageCouponList.coupon" onclick="GA_event('마이페이지', '상단 메뉴', '쿠폰');"><li>
						<span>쿠폰</span><span>${coupCount }</span>
				</li></a>
				<a href="itemReview.item" onclick="GA_event('마이페이지', '상단 메뉴', '쿠매후기');"><li>
						<span>구매후기</span><span>${reviewCount }</span>
				</li></a>
			</ul>
		</li>
	</ul>
</div>

<div>
	<a href="#" onclick="GA_event('마이페이지_MO', '상단 메뉴', '이벤트 참여/당첨 내역');">
	</a>
</div>








