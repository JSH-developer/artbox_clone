<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href="../css/member/join.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
  <link href="../css/slide.css" rel="stylesheet" type="text/css">
  <link href="../css/post.css" rel="stylesheet" type="text/css">
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

				<!-- 			-------------------------------우편번호 API-----------------------------------          -->
				<div class="align">
				<div class="post_1">
					<input type="text" id="sample6_postcode" placeholder="우편번호"
						class="postNum"> <input type="button"
						onclick="sample6_execDaumPostcode()" value="우편번호 찾기"
						class="postbtn">
				</div>
				<div class="post">
					<input type="text" id="sample6_address" placeholder="주소"
						class="address">
				</div>
				<div class="post">
					<input type="text" id="sample6_detailAddress" placeholder="상세주소"
						class="detail" style="width: 90%;">
				</div>
			</div>
			<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
	
	
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