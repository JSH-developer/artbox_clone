<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/member/findId.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<link href="css/post.css" rel="stylesheet" type="text/css">
<title>ARTBOX</title>
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
					<h2>- 개인 정보 보호를 위해 아이디 뒷자리는 *로 표시됩니다.</h2>
			</div>
		</div>
		
		
		<div>
			<div>
				<input type="radio" name="pmail">휴대전화 <input type="radio"
					name="pmail">이메일
			</div>
			<div>
				<input type="text" placeholder="이름을 입력해주세요.">
				<div>
					<input type="text">-<input type="text">-<input
						type="text">
				</div>
			</div>
			<div>
				<ul>
					<li>확인</li>
				</ul>
			</div>
		</div>
	</div>








	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->

</body>
</html>