<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="css/member/myPage.css" rel="stylesheet">
<script src="../js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="member/myPage.js"></script>

<c:if test="${empty sessionScope.id }">
	<c:redirect url="loginForm.member"/>
</c:if>

<div class="whoes">
	<span class="MNmSpan">안녕하세요, <span class="MNm">${name}</span> 님
	</span> <span class="MInfo" onclick="Pop_Menu()"><label
		style="cursor: pointer;">회원정보</label>
		<div class="Pop_Menu" id="Pop_Menu" style="display: none;">
			<ul>
				<li><a href="profileChange.member">회원정보 변경</a></li>
				<li><a href="delivery.member">나의 배송지 관리</a></li>
				<li><a href="refund.member">나의 환불계좌 관리</a></li>
				<li><a href="logout.member">로그아웃</a></li>
			</ul>
		</div> </span><a href="#" onclick="GA_event('마이페이지_PC', '상단 메뉴', '이벤트 참여/당첨 내역');"><span
		class="MEvent">이벤트 참여/당첨 내역</span></a>

</div>
<div class="three_box">
	<ul>
		<a href="#" onclick="GA_event('마이페이지', '상단 메뉴', '등급혜택보기');"><li
			class="Tbox1"><span class="GName grade5">SILVER</span> <img
				class="GImg" src="Images/img/등급.png" /> <span class="GSee grade5">[등급혜택보기]</span>
		</li></a>
		<a href="#" onclick="GA_event('마이페이지', '상단 메뉴', '꿈캔디 내역');"><li
			class="Tbox2"><img class="CImg" src="Images/img/포인트.png" /> <span
				class="CCandy">0</span></li></a>
		<li class="Tbox3">
			<ul>
				<a href="#" onclick="GA_event('마이페이지', '상단 메뉴', '주문/배송');"><li>
						<span>주문/배송</span><span>0</span>
				</li></a>
				<a href="#" onclick="GA_event('마이페이지', '상단 메뉴', '쿠폰');"><li>
						<span>쿠폰</span><span>4</span>
				</li></a>
				<a href="#" onclick="GA_event('마이페이지', '상단 메뉴', '쿠매후기');"><li>
						<span>구매후기</span><span>0</span>
				</li></a>
			</ul>
		</li>
	</ul>
</div>
<div>
	<a href="#" onclick="GA_event('마이페이지_MO', '상단 메뉴', '이벤트 참여/당첨 내역');">
	</a>
</div>








