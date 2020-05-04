<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href="../css/member/join.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
  <link href="../css/slide.css" rel="stylesheet" type="text/css">
</head>
<body>

    <!-- 헤더 -->
    <jsp:include page="../inc/top.jsp"></jsp:include>
    <!-- 헤더 -->

<div class="JoinWrap">
	<h1>회원가입</h1>
	<div class="JoinForm">
		<div class="tableDiv">
			
			<dl class="trJoin">
				<dt>아이디</dt>
				<dd>
					<input type="text" id="i_memid" name="memid" maxlength="16" placeholder="4~16자 영문 숫자 조합" onkeyup="fnValid(this.id);" />
					<p class="null" id="r_memid"></p>
					<input type="hidden" id="i_memid_valid" name="memid_valid" />
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>비밀번호</dt>
				<dd>
					<input type="password" id="i_mempwd" name="mempwd" maxlength="16" placeholder="4~16자 영문 숫자 조합" onkeyup="fnValid(this.id);" />
					<p class="null" id="r_mempwd"></p>
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>비밀번호 확인</dt>
				<dd>
					<input type="password" id="i_mempwd2" name="mempwd2" maxlength="16" onkeyup="fnValid(this.id);" />
					<p class="null" id="r_mempwd2"></p>
				</dd>
			</dl>
			
			<dl class="trJoin">
				<dt>이름</dt>
				<dd>
					<input type="text" id="i_memname" name="memname" maxlength="16" />
					<p class="null" id="r_memname"></p>
				</dd>
			</dl>
			<dl class="trJoinSex">
				<dt>성별</dt>
				<dd>
					<input type="radio" id="i_memsexM" name="memsex" value="M" /> 남자
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" id="i_memsexW" name="memsex" value="W" /> 여자
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>생년월일</dt>
				<dd>
					<input type="tel" id="i_membirthday" name="membirthday" maxlength="8" placeholder="숫자 8자리" />
					<p class="null" id="r_membirthday"></p>
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>휴대전화</dt>
				<dd>
					<input type="tel" id="i_memcpnum1" name="memcpnum1" placeholder="예) 010-0000-0000" />
					<p class="null" id="r_memcpnum1"></p>
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>이메일</dt>
				<dd>
					<input class="conInput" type="text" id="i_mememail" name="mememail" maxlength="50" placeholder="예) example@artbox.co.kr" onblur="fnValid(this.id);" />
					<a class="conButton" href="#">인증번호</a>
					<p class="null" id="r_mememail"></p>
					<input type="hidden" id="i_mememail_valid" name="mememail_valid" />
				</dd>
			</dl>
		
		
		<dl class="trJoin">
			<dt>인증번호</dt>
			<dd>
				<input class="conInput" type="tel" id="i_sixnum" name="sixnum" maxlength="6" placeholder="인증번호 6자리" />
				<a class="conButton" href="#">인증확인</a>
				<p class="null" id="r_sixnum"></p>
				<input type="hidden" id="i_memcpnum_valid" name="memcpnum_valid" />
			</dd>
		</dl>
		
		
		</div>
	
		<a class="JoinButton" href="javascript:fnJoin();">가입하기</a>
		<input type="hidden" name="snslogin" id="i_snslogin" value="N" />
	</div>
</div>

</form>

<!--  푸터 -->
    <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>