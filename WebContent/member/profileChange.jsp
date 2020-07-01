<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="css/member/profile.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<link href="css/post.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../inc/top.jsp"></jsp:include>

	<div class="formbody">
		<div class="title">
			<p>회원정보 변경</p>
		</div>
		<form action="profile.member" method="post" onsubmit="return check()">
			<div>
				<input type="text" name="id" readonly="readonly" value=${id }>
			</div>
			<div>
				<input type="password" name="pw" id="pw" placeholder="비밀번호 입력">
			</div>
			<span>* 회원님의 개인 정보 보호를 위해 비밀번호를 입력해주세요.</span> <input type="submit"
				value="확인">
		</form>
	</div>

	<jsp:include page="../inc/bottom.jsp"></jsp:include>

	<script src="js/jquery-3.5.0.js"></script>
	<script type="text/javascript">
	function check() {
		if($('#pw').val() == ""){
			alert('비밀번호를 입력해주세요.')
		}
	}
	</script>
</body>
</html>