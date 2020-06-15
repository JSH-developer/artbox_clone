<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!--  푸터 -->
<!--  <footer> -->
 <div class="pageFooter">
<div class="FooterMenu">
		<ul>
			<li class="FooterLink"><a href="http://www.artboxmall.com/Home/Company/" target="_blank" onclick="GA_event('FOOT', '최하단 메뉴 PC', '회사소개');">회사소개</a></li>
			<li class="FooterLink"><a href="http://recruit.artbox.co.kr" target="_blank" onclick="GA_event('FOOT', '최하단 메뉴 PC', '인재채용');">인재채용</a></li>
			<li class="FooterLink"><a href="/Home/Company/UserAgreement.asp" onclick="GA_event('FOOT', '최하단 메뉴 PC', '이용약관');">이용약관</a></li>
			<li class="FooterLink"><a href="/Home/Company/Privacy.asp" class="privacy" onclick="GA_event('FOOT', '최하단 메뉴 PC', '개인정보취급방침');">개인정보취급방침</a></li>
			<li class="FooterLink"><a href="/Home/Company/EmailDeny.asp" onclick="GA_event('FOOT', '최하단 메뉴 PC', '이메일주소무단수집거부');">이메일주소무단수집거부</a></li>
			<li class="FooterLink"><a href="/Home/Company/OpenBiz.asp" onclick="GA_event('FOOT', '최하단 메뉴 PC', '입점문의');">입점문의</a></li>
			<li class="FooterLink"><a href="/Home/Company/LargeBuy.asp" onclick="GA_event('FOOT', '최하단 메뉴 PC', '대량구매');">대량구매</a></li>
			<li class="FamilySite">
				<select title="패밀리 사이트" onchange="if(this.value){window.open(this.value,'_blank');this[0].selected=true;}">
					<option value="">FAMILY SITE</option>
					<option value="http://www.poom.co.kr">POOM</option>
				</select>
			</li>
			<li class="Facebook">
				<a href="https://www.facebook.com/artbox.kr.official/" target="_blank" title="페이스북" onclick="GA_event('FOOT', '최하단 메뉴 PC', '페이스북');">
				<img src="${pageContext.request.contextPath}/Images/common/facebook.png"></a>
			</li>
			<li class="Instagram">
				<a href="https://www.instagram.com/artbox_kr_official/" target="_blank" title="인스타그램" onclick="GA_event('FOOT', '최하단 메뉴 PC', '인스타그램');">
				<img src="${pageContext.request.contextPath}/Images/common/instagram.png"></a>
			</li>
		</ul>
		<div class="clear"></div>
	</div>
	
	
	<div class="FooterInfo">
	<div class="Customer">
		<ul>
			<li class="CallCenter">
				<b class="string">고객감동센터</b>
				<b class="number">1577-9081</b><br>
				운영시간 09:00 - 18:00, 점심시간 12:30 - 13:30<br>
				<small>*주말 및 공휴일은 1:1 문의/상담을 이용해주세요.</small>
			</li>
			<li class="TwoButton">
				<a href="/Home/Cscenter/FaqList.asp" onclick="GA_event('FOOT', '최하단 메뉴 PC', '자주하는 질문');">
				<img src="${pageContext.request.contextPath}/Images/common/footer_btn1.png">자주하는 질문</a>
				<a href="/Home/Cscenter/Enquiry.asp" onclick="GA_event('FOOT', '최하단 메뉴 PC', '1:1 문의/상담');">
				<img src="${pageContext.request.contextPath}/Images/common/footer_btn2.png">1:1 문의/상담</a>
			</li>

		<li class="Infomation">
			(주)아트박스포트폴리오<br>
			이 사이트는 포트폴리오용으로 제작되었습니다.<br>
			 이 사이트의 운영은 어떠한 영리적 목적도 없음을 밝힙니다.<br>
			COPYRIGHT © 2011 ARTBOX CO., LTD ALL RIGHTS RESERVED.
		</li>
	</ul>
		<div class="clear"></div>
	</div>
 
 </div>
 
 </div>
<!-- </footer> -->
 
 <!--  푸터 -->