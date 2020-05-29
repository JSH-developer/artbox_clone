<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX</title>
<link href="../css/member/Login.css" rel="stylesheet">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link href="../css/slide.css" rel="stylesheet" type="text/css">
<link href="../css/post.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-3.5.0.js"></script>
<script type="text/javascript">
// 	$(document).ready(function() {
// 		$.ajax('LoginAjax.jsp'{
			
// 		});
// 	});
</script>
</head>
<body>

 	<!-- 헤더 -->
    <jsp:include page="../inc/top.jsp"></jsp:include>
    <!-- 헤더 -->

<div class="loginBody">
	<div class="topLogin">
		<h2>로그인</h2>
	</div>
	<div class="top_font">
		아트박스 통합 멤버십 회원은 한 아이디로 모든 쇼핑몰 로그인이 가능합니다.
	</div>
	
	<form action="loginPro.member" method="post"  class="IdPass">
		<div>
			<input type="text" name="id" placeholder="아이디를 입력해주세요.">
			<input type="hidden">
		</div>
		<div>
			<input type="text" name="pw" placeholder="비밀번호를 입력해주세요.">
		</div>
		
	
	<div class="joinLink">
		<span class="leftWrap">
				<input type="checkbox">아이디 저장하기
		</span>
		<div class="rightWrap">
				<a href="" >아이디/비밀번호 찾기</a>  |  <a href="" >회원가입</a>
		</div>
	</div>	
		<input type="submit" value="로그인" class="loginButton">
		</form>
		
		
<!-- 		<a href="#" class="loginButton">로그인</a> -->
	<div>
	<a href="#" style="text-decoration: none;">간편 로그인</a>
	</div>
	<div class="img">
		<a href=""><img alt="네이버" src="../Images/img/naver.png" style="padding-left: 50px;"></a>
		<a href=""><img alt="카카오" src="../Images/img/kakao.png"></a>
		<a href=""><img alt="페이스북" src="../Images/img/facebook.png"></a>
		<a href=""><img alt="구글" src="../Images/img/google.png"></a>
	</div>
	<form action="" method="post">
		<a href="#" class="nonMemberButton">비회원 주문/배송 조회하기</a>
	</form>
</div>
<!--  푸터 -->
    <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>