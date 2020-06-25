<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/member/modify.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">


</head>
<body>

 <!-- 헤더 -->
    <jsp:include page="../inc/top.jsp"></jsp:include>
 <!-- 헤더 -->

<div class="memModify">
	<p class="title1">회원정보 변경</p>
	<form action="modifySuccess.member" method="post">
	<div class="modifywrap">
		<div class="modify">
		<div class="modify_top">
			<table>
				<tr>
					<td class="left">아이디</td><td>${id }</td>
				</tr>
				<tr>
					<td class="left">비밀번호</td>
					<td><span class="pwclick">비밀번호 변경</span></td>
				</tr>
			</table>
			<script type="text/javascript">
				$('.pwclick').click(function() {
				$('.memModify').toggle();
				$('.pwModify').toggle();
			});
			</script>
			<table>
				<tr>
					<td class="left">이름</td><td>${name }</td>
				</tr>
				<tr>
					<td class="left">성별</td>
					<td><input type="radio" name="gender" id="box1"><label for="box1">남</label>
						<input type="radio" name="gender" id="box2"><label for="box2">여</label>
				</tr>
				<tr>
					<td class="left">생년월일</td><td><input type="text" name="birth" placeholder="숫자8자리"></td>
				</tr>
			</table>
				<p>* 등록한 생일에 축하쿠폰을 드립니다.</p>
				
			</div>
				
				
                   <!-- 			  	주소찾기                     -->
                   <!-- 			-------------------------------우편번호 API-----------------------------------          -->
<div class="post">
<table>
<tr>
	<td rowspan="3" style="width: 263px;">주소</td>
	<td><input type="text" id="sample6_postcode" placeholder="우편번호" readonly="readonly"></td>
	<td><input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기" ></td>
</tr>
<tr>
	<td colspan="2"><input type="text" id="sample6_address" placeholder="주소" readonly="readonly"></td>
</tr>
<tr>
	<td colspan="2"><input type="text" id="sample6_detailAddress" placeholder="상세주소"></td>
</tr>
<tr>
	<td colspan="2"><input type="text" id="sample6_extraAddress" placeholder="참고항목" style="display: none;"></td>
</tr>
</table>
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
					<!-- 						우편번호 API 끝                           -->

			<div class="modify_bottom">
				<table>
					<tr>
						<td class="left">이메일</td>
						<td><input type="text" placeholder="예) example@artbox.co.kr"></td>
					</tr>
					<tr>
						<td class="left">휴대전화</td>
						<td><input type="text"></td>
					</tr>
				</table>
			</div>

			</div>
		<div class="button">
			<input type="button" value="회원 탈퇴">
			<input type="button" value="취소" >
			<span class="success">
			<input class="submit1" type="submit" name="submit" value="정보 변경">
			</span>
		</div>
	</div>
	</form>
</div>

		<!-- -------------------------------     전환      ---------------------------------------- -->
		<!--                 비밀번호 변경                 -->
<div class="pwModify" style="display: none;">
		<p class="title2">비밀번호 변경</p>
	<div class="main">
		<form action="pwProModify.member" method="post" onsubmit="return check()">
		<input type="hidden" name=id value="${id }">
		<div class="middle">
			<span class="left">현재 사용중인 비밀번호</span><input type="password" id="nowpw" name="nowpw">
			<div id="nowpwcheck"></div>
			<span class="left">새로운 비밀번호</span><input type="password" id="newpw" name="newpw">
			<div id="newpwcheck"></div>
			<span class="left">새로운 비밀번호 확인</span><input type="password" id="newrepw" name="newrepw">
			<div id="newrepwcheck"></div>
			
<!--                 			패스워드 체크                        	-->
<script src="../js/jquery-3.5.0.js"></script>
<script type="text/javascript">

			var pwcheck = /^(?!(?:[0-9]+)$)([a-zA-Z]|[0-9a-zA-Z]){4,16}$/;
			
			function check() {
				var flag = true;
				var nowpw = $('#nowpw').val();
				var newpw = $('#newpw').val();
				var newrepw = $('#newrepw').val();
				var pw = $('#nowpw').val();
				
				
				if(newpw == ''){
					alert('비밀번호를 입력해주세요.');
					flag = false;
				}else if(newrepw == ''){
					alert('비밀번호확인을 입력해주세요.');
					flag = false;
				}else if(!pwcheck.test($('#newpw').val())) {
					alert('비밀번호 확인해주세요');
					$.trim($('#newpw').focus());
					flag = false;
				}else if($('#newpw').val() != $('#newrepw').val()){
					alert('비밀번호 일치하지 않습니다');
					$.trim($('#newrepw').focus());
					flag = false;
				}
				return flag;
			}
// 		----------------------------------	ajax  --------------------------
			$(document).ready(function() {
				
				$('#newpw').blur(function(event) {
					if ($('#newpw').val() == "") {
						$('#newpwcheck').html('비밀번호 입력하세요.');
						$('#newpwcheck').css("color", "red");
					} else if (!pwcheck.test($('#newpw').val())) {
						$('#newpwcheck').html('4~16자 영문 또는 영문숫자 조합해주세요.');
						$('#newpwcheck').css("color", "red");
					} else {
						$('#newpwcheck').html('사용가능한 비밀번호입니다.');
						$('#newpwcheck').css("color", "blue");
					}
				});
				
				$('#newrepw').blur(function(event) {
					if ($('#newrepw').val() == "") {
						$('#newrepwcheck').html('비밀번호 입력하세요.');
						$('#newrepwcheck').css("color", "red");
					} else if($('#newpw').val() != $('#newrepw').val()) {
						$('#newrepwcheck').html('비밀번호가 일치하지않습니다.');
						$('#newrepwcheck').css("color", "red");
					} else {
						$('#newrepwcheck').html('비밀번호 일치');
						$('#newrepwcheck').css("color", "blue");
					}
				});
			});

</script>
			
<!--                 			패스워드 체크 끝                       	-->
			
			
			<div class="memberModify">
			- 비밀번호는 4~16자 영문과 숫자를 조합해야 합니다.
			</div>
			<div class="memberModify">
			 - 주민등록번호, 전화번호, 생일, 아이디, 연속된 알파벳이나 숫자 등 타인에게 노출되기 쉬운 정보는 비밀번호로 사용하지 않을 것을 권장합니다.
			</div>
		</div>
		<div class="modifybtn">
			<span class="leftbtn"><input type="button" value="취소"></span>
			<span><input type="submit" name="submit" value="확인" class="temp1"></span>
		</div>
			<script type="text/javascript">
				$('.leftbtn').click(function() {
				$('.memModify').toggle();
				$('.pwModify').toggle();
			});
			</script>
		</form>
	</div>		
</div>

	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->

</body>
</html>