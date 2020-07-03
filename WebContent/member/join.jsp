<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link href="css/member/join.css" rel="stylesheet" type="text/css">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<link href="css/post.css" rel="stylesheet" type="text/css">
    <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
</head>
<body>

    <!-- 헤더 -->
    <jsp:include page="../inc/top.jsp"></jsp:include>
    <!-- 헤더 -->

<form action="joinPro.member" method="post" onsubmit="return check()">
<div class="JoinWrap">
	<h1>회원가입</h1>
	<div class="JoinForm">
		<div class="tableDiv">
			
			<dl class="trJoin">
				<dt>아이디</dt>
				<dd>
					<input type="text" id="id" name="id" maxlength="16" placeholder="4~16자 영문 숫자 조합"
					style="width: 345px;">
					<a class="conButton" id="checkid" href="#">중복체크</a>
				<div id="removeid"></div>
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>비밀번호</dt>
				<dd>
					<input type="password" id="pw" name="pw" maxlength="16" placeholder="4~16자 영문 숫자 조합" />
				<div id="pwcheck"></div>
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>비밀번호 확인</dt>
				<dd>
					<input type="password" id="rpw" name="rpw" maxlength="16" />
					<div id="rpwcheck"></div>
				</dd>
			</dl>
			
			<dl class="trJoin">
				<dt>이름</dt>
				<dd>
					<input type="text" id="name" name="name" maxlength="16" />
					<div id="namecheck"></div>
				</dd>
			</dl>
			<dl class="trJoinSex">
				<dt>성별</dt>
				<dd>
					<input type="radio" class="gender" name="gender" value="남" /> 남자
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" class="gender" name="gender" value="여" /> 여자
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>생년월일</dt>
				<dd>
					<input type="text" id="birth" name="birth" maxlength="8" placeholder="숫자 8자리" />
					<div id="birthcheck"></div>
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>휴대전화</dt>
				<dd>
					<input type="text" id="phone" name="phone" placeholder="예) 010-0000-0000" />
					<div id="phonecheck"></div>
				</dd>
			</dl>
			<dl class="trJoin">
				<dt>이메일</dt>
				<dd>
					<input class="conInput" type="text" id="email" name="email" maxlength="50" placeholder="예) example@artbox.co.kr"/>
					<div id="emailcheck"></div>
				</dd>
			</dl>
		
		
		
		</div>
<!-- 							------------------------------- 정규표현식 -----------------------------------          -->
<script src="js/jquery-3.5.0.js"></script>
<script type="text/javascript">

		
		var idcheck = /^(?!(?:[0-9]+)$)([a-zA-Z]|[0-9a-zA-Z]){4,16}$/;
		var pwcheck = /^(?!(?:[0-9]+)$)([a-zA-Z]|[0-9a-zA-Z]){4,16}$/;
		var birthcheck = /^[0-9]{8}$/;
		var phonecheck = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var emailcheck = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		var id = $('#id').val();
		var pw = $('#pw').val();
		var rpw = $('#rpw').val();
		
		

		function check(){	
			if (!idcheck.test($('#id').val())) {
				alert('아이디 확인해주세요');
				$.trim($('#id').focus());
				 return false;
			}
			
			if (!pwcheck.test($('#pw').val())) {
				alert('비밀번호 확인해주세요');
				$.trim($('#pw').focus());
				 return false;
			}
			
			if ($('#pw').val() != $('#rpw').val()) {
				alert('비밀번호 일치하지 않습니다');
				$.trim($('#rpw').focus());
				 return false;
			}
			
			if ($('#name').val()=="") {
				alert('이름을 입력해주세요');
				$.trim($('#name').focus());
				 return false;
			}
			
			if(!$('input:radio[name=gender]').is(':checked')){
				alert('성별 체크해주세요')
				return false;
			}
			
			if (!birthcheck.test($('#birth').val())) {
				alert('생년월일 형식에 맞춰주세요');
				$.trim($('#birth').focus());
				 return false;
			}
			
			if (!phonecheck.test($('#phone').val())) {
				alert('핸드폰번호 형식에 맞춰주세요');
				$.trim($('#phone').focus());
				 return false;
			}
			
			if (!emailcheck.test($('#email').val())) {
				alert('이메일 형식에 맞춰주세요');
				$.trim($('#email').focus());
				 return false;
			}
			
			if ($('#removeid').html()!="사용할 수 있는 아이디 입니다.") {
				alert('중복체크 확인하여주세요.');
				$.trim($('#id').focus());
				 return false;
			}
			
		}
	
	
	
	
	
	
	
	
	$(document).ready(function() {
		
		$('#pw').blur(function(event) {
			if ($('#pw').val() == "") {
				$('#pwcheck').html('비밀번호 입력하세요.')
				$('#pwcheck').css("color", "red");
			} else if (!pwcheck.test($('#pw').val())) {
				$('#pwcheck').html('4~16자 영문 또는 영문숫자 조합해주세요.')
				$('#pwcheck').css("color", "red");
			} else {
				$('#pwcheck').html('사용가능한 비밀번호입니다.')
				$('#pwcheck').css("color", "blue");
			}
		});

		$('#rpw').blur(function(event) {

			if ($('#rpw').val() == "") {
				$('#rpwcheck').html('비밀번호 입력하세요.')
				$('#rpwcheck').css("color", "red");
			} else if ($('#pw').val() != $('#rpw').val()) {
				$('#rpwcheck').html('비밀번호가 일치하지않습니다.')
				$('#rpwcheck').css("color", "red");
			} else {
				$('#rpwcheck').html('비밀번호 일치')
				$('#rpwcheck').css("color", "blue");
			}
		});

		$('#name').blur(function(event) {
			if ($('#name').val() == '') {
				$('#namecheck').show();
				$('#namecheck').html('이름을 입력해주세요.')
				$('#namecheck').css("color", "red");
			} else {
				$('#namecheck').hide();
			}
		});

		$('#birth').blur(function(event) {
			if (!birthcheck.test($('#birth').val())) {
				$('#birthcheck').show();
				$('#birthcheck').html('숫자 8자리 입력해주세요.')
				$('#birthcheck').css("color", "red");
			} else {
				$('#birthcheck').hide();
			}
		});

		$('#phone').blur(function(event) {
			if (!phonecheck.test($('#phone').val())) {
				$('#phonecheck').show();
				$('#phonecheck').html('형식에 맞게 입력해주세요.');
				$('#phonecheck').css("color", "red");
			} else {
				$('#phonecheck').hide();
			}
		});

		$('#email').blur(function(event) {
			if (!emailcheck.test($('#email').val())) {
				$('#emailcheck').show();
				$('#emailcheck').html('형식에 맞게 입력해주세요.');
				$('#emailcheck').css("color", "red");
			} else {
				$('#emailcheck').hide();
			}
		});
		

		
		 // --------------------------- 아이디 중복 체크 ------------------------------------
		$('#checkid').click(function() {
			var id = $('#id').val();

			$.ajax({
				type : 'POST',
				data : {
					id : id
				},
				url : "reidCheck.member",
				success : function(data) { // 아이디 같으면 true
					var a = JSON.parse(data);
					console.log(a.data);

					if (!a.data) { // 아이디 중복 아닐때
						if ($('#id').val() == "") { // 아이디 안넣음
							$('#removeid').show();
							$('#removeid').html('아이디를 넣어주세요.')
							$('#removeid').css("color", "red");
						} else if (!idcheck.test($('#id').val())) { //정규표현식 틀림
							$('#removeid').show();
							$('#removeid').html('4~16자 영문 또는 영문숫자 조합해주세요.')
							$('#removeid').css("color", "red");
						} else {
							$('#removeid').show();
							$('#removeid').html('사용할 수 있는 아이디 입니다.');
							$('#removeid').css("color", "blue");
						}
					} else { // 아이디 중복
						$('#removeid').show();
						$('#removeid').html('사용할 수 없는 아이디 입니다.');
						$('#removeid').css("color", "red");
						$('#id').focus();
					}
				}
			});
		});
	});
</script>




				<!-- 			-------------------------------우편번호 API-----------------------------------          -->
				<div class="align">
				<div class="post_1">
					<input type="text" id="sample6_postcode" placeholder="우편번호" name="postcode"
						class="postNum"> <input type="button"
						onclick="sample6_execDaumPostcode()" value="우편번호 찾기"
						class="postbtn">
				</div>
				<div class="post">
					<input type="text" id="sample6_address" placeholder="주소" name="addr_basic"
						class="address">
				</div>
				<div class="post">
					<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="addr_detail"
						class="detail" style="width: 90%;">
					<input type="text" id="sample6_extraAddress" placeholder="참고항목" style="display: none;">
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
	
<!-- 		<a class="JoinButton" href="javascript:fnJoin();">가입하기</a> -->
		<div class="JoinButton">
		<input type="submit" name="submit"value="가입하기">
		</div>
	</div>
</div>
		</form>

<!--  푸터 -->
    <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>