<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/member/memberDelete.css" rel="stylesheet">
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.5.0.js"></script>
<script type="text/javascript">

	function check() {
		var pw = $('#pw').val();
		if (pw == '') {
			alert('비밀번호를 입력해주세요.');
			return false;
		}
	}
</script>

</head>
<body>

 <!-- 헤더 -->
    <jsp:include page="../inc/top.jsp"></jsp:include>
 <!-- 헤더 -->

	<div class="memberwrap">
		<div class="topline">
			<p class="title1">회원 탈퇴</p>
			<p>서비스 이용 중 불편사항은 언제든지 연락 주시면 최선을 다해 해결되도록 노력하겠습니다.</p>
			<span class="topButton">1:1문의 상담</span>
		</div>

		<table>
			<tr class="toptr">
				<td class="left">회원혜택 상실 안내</td>
				<td>보유하고 있는 쿠폰과 꿈캔디는 자동 소멸됩니다.<br> 아트박스 통합 멤버십의 회원 서비스는 더
					이상 이용할 수 없으며, 회원 혜택 또한 받을 수 없습니다.<br> [현재 고객님의 사용 가능 꿈캔디는
					0개이며, 보유하고 있는 쿠폰은 2장 입니다.]
				</td>
			</tr>
			<tr class="bottomtr">
				<td class="left">개인 정보삭제 안내</td>
				<td>회원님의 개인 정보는 절대 복구할 수 없는 방법으로 삭제됩니다. 단 전자상거래 등에서의 소비자보호에 관한
					법률 및 동법 시행령에 의하여 보존할 필요가 있는 경우에 한하여 개인정보취급방침에 명시된 기간 동안 해당 정보가 보존됨을
					알려드립니다.<br> 회원님의 개인 정보는 삭제되나, 회원으로 활동하셨을 때 작성하셨던 게시물과 댓글은 삭제되지
					않습니다.<br> 재가입을 원하실 때는 현재의 아이디로는 가입이 불가능하며, 사용하시던 아이디는 삭제됨과 동시에
					다른 사람에 의해서도 사용되지 못하게 됩니다. 거래내역이 진행 중인 경우 즉시 탈퇴할 수 없습니다.
				</td>
			</tr>
		</table>

		<form action="deleteCheck.member" method="post" onsubmit="return check()">
			<div class="bottomline">
				<div>
					<span class="leftspan">아이디</span><span>${id }</span>
					<input type="hidden" name="id" value="${id }">
				</div>
				<div class="bottompw">
					<span class="leftspan">비밀번호</span><input type="password" id="pw" name="pw">
				</div>
			</div>
			<input type="button" value="취소" onclick="location.href='????????'">
			<input type="submit" value="회원탈퇴">
		</form>

	</div>



	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>