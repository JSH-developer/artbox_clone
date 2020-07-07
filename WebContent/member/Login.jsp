<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="css/member/Login.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<link href="css/post.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>

</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 -->

	<div class="loginBody">
		<div class="topLogin">
			<h2>로그인</h2>
		</div>
		<div class="top_font">아트박스 통합 멤버십 회원은 한 아이디로 모든 쇼핑몰 로그인이 가능합니다.
		</div>

		<form action="login.member" method="post" name="loginForm"
			class="IdPass" onsubmit="return check()">
			<div>
				<input type="text" id="id" name="id" placeholder="아이디를 입력해주세요.">
			</div>
			<div>
				<input type="password" id="pw" name="pw" placeholder="비밀번호를 입력해주세요.">
			</div>


			<div class="joinLink">
				<span class="leftWrap"><input type="checkbox" id="idSaveCheck">&nbsp;아이디 저장하기</span>
				<div class="rightWrap">
					<a href="findId.member">아이디/비밀번호 찾기</a> | <a href="memberJoinForm.member">회원가입</a>
				</div>
			</div>
			<input type="submit" value="로그인" class="loginButton">
		</form>


		<script src="js/jquery-3.5.0.js"></script>
		<script type="text/javascript">
			function check() {
				var flag = true;
				var id = $('#id').val();
				var pw = $('#pw').val();
				if (id == '') {
					alert('아이디를 입력해주세요.')
					return false;
				} else if (pw == '') {
					alert('비밀번호를 입력해주세요.')
					return false;
				} else {
					$.ajax({
						type : 'POST',
						url : "loginPro.member",
						data : {
							id : id,
							pw : pw
						},
						async : false,
						success : function(data) {
							console.log(data);
							var result = JSON.parse(data);
							var suc = result.data

							if (suc==1) {
								flag = true;
							} else if(suc==0){
								alert('패스워드가 틀립니다.')
								flag = false;
							} else{
								alert('존재하지 않는 아이디입니다.')
								flag = false;
							}
						}
					});
				}
				return flag;
			}
		</script>
		
		
		
		
		
<!--                                         아이디 저장하기                                                   -->


<script type="text/javascript">
$(document).ready(function(){
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("input[name='id']").val(userInputId); 
     
    if($("input[name='id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name='id']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='id']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
});
 
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

</script>
<!--                                         아이디 저장하기 끝                                                   -->

<!-- 		<div class="simpleLogin">간편 로그인</div> -->
<!-- 		<div class="img"> -->
<!-- 			<a href=""><img alt="네이버" src="Images/img/naver.png" -->
<!-- 				style="padding-left: 50px;"></a> <a href=""><img alt="카카오" -->
<!-- 				src="Images/img/kakao.png"></a> <a href=""><img alt="페이스북" -->
<!-- 				src="Images/img/facebook.png"></a> <a href=""><img alt="구글" -->
<!-- 				src="Images/img/google.png"></a> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->

</body>
</html>