<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/member/findId.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<link rel=" shortcut icon"
	href="${pageContext.request.contextPath}/Images/common/tab.ico"
	type="image/x-icon">
<link rel="icon"
	href="${pageContext.request.contextPath}/Images/common/tab.ico"
	type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
</head>
<body>

	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 -->

	<div class="find_box">

		<div class="sub_box1">
			<div>
				<h1 class="font">아이디/비밀번호 찾기</h1>
			</div>
			<div class="MenuBar_Box">
				<ul>
					<li onclick="location.href='findId.member'" class="on">아이디 찾기</li>
					<li onclick="location.href='findpw.member'">비밀번호 찾기</li>
				</ul>
			</div>
			<div>
				<h2>- 회원정보에 입력한 휴대전화 번호/이메일 주소로 아이디를 찾을 수 있습니다.</h2>
			</div>
		</div>
		<c:if test="${empty id }">
			<form action="findIdForm.member" method="post"
				onsubmit="return check()">
				<div class="form">
					<div class="radioMargin">
						<input type="radio" id="phoneCheck" name="pmail" checked="checked"><span
							class="radioName">휴대전화</span> <input type="radio" id="emailCheck"
							name="pmail"><span class="radioName">이메일</span>
					</div>
					<div>
						<input type="text" id="name" name="name" placeholder="이름을 입력해주세요.">

						<input type="text" id="phone" name="phone"
							placeholder="핸드폰 번호를 입력해주세요."> <input type="text"
							id="email" name="email" placeholder="예)example@artfox.co.kr"
							style="display: none">
					</div>
					<div>
						<input type="submit" name="submit" value="확인">
					</div>
				</div>
			</form>
		</c:if>
		<c:if test="${!empty id }">
			<p style="text-align: center;">
				고객님께서 사용중이신 아이디는<br>
				<span class="myId">[${id }]</span>입니다.
			</p>
		</c:if>
	</div>

	<script src="js/jquery-3.5.0.js"></script>
	<script type="text/javascript">
		$('#phoneCheck').click(function() {
			$('#email').hide();
			$('#phone').show();
		});

		$('#emailCheck').click(function() {
			$('#email').show();
			$('#phone').hide();
		});
	</script>

	<script type="text/javascript">
		var phonecheck = /^01([0|1|6|7|8|9]?)([-]{1})([0-9]{3,4})([-]{1})([0-9]{4})$/; // 핸드폰번호 유효성 검사

		function check() {

			if ($('#name').val() == '') {
				alert('이름을 입력해주세요.');
				$.trim($('#name').focus());
				return false;
			} else if ($('#phone').val() == '') {
				alert('핸드폰번호를 입력해주세요.');
				$.trim($('#phone').focus());
				return false;
			} else if (!phonecheck.test($('#phone').val())) {
				alert('핸드폰번호 형식에 맞춰주세요');
				$.trim($('#phone').focus());
				return false;
			}
		}
	</script>


	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->

</body>
</html>