<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<link href="css/member/deliveryAdd.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 -->
	
	<article>
		<p class="title">나의 배송지 추가/수정</p>
		<p class="message">*자주 쓰는 배송지를 등록하고 관리할 수 있습니다.</p>
		<div class="main">
			<form action="deliveryModifyPro.member" method="post">
				<div>
					<span class="left">배송지명</span><input type="text" name="receiver" value="${rb.receiver }">
					<input type="hidden" name="id" value="${id }">
					<input type="hidden" name="num" value="${rb.receiver_num }">
				</div>
				<div>
					<span class="left">받는사람</span><input type="text" name="receiver_name" value="${rb.receiver_name }">
				</div>
				<div>
					<span class="left">휴대전화</span><input type="text" name="receiver_phone" value="${rb.receiver_phone }">
				</div>

				<!-- 			-------------------------------우편번호 API-----------------------------------          -->
				<div class="post">
					<table>
						<tr>
							<td rowspan="3" style="width: 131px; color: #646464;">주소</td>
							<td><input type="text" id="sample6_postcode" value="${rb.receiver_postcode }"
								placeholder="우편번호" name="postcode" style="width: 285px;"></td>
							<td><input type="button"
								onclick="sample6_execDaumPostcode()" value="주소 찾기"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" id="sample6_address" value="${rb.receiver_addr }"
								placeholder="주소" name="addr"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" value="${rb.receiver_addr_detail }"
								id="sample6_detailAddress" name="addr_detail" placeholder="상세주소"
								style="margin-bottom: 40px;"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" id="sample6_extraAddress"
								placeholder="참고항목" style="display: none;"></td>
						</tr>
					</table>
				</div>
				<script
					src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script>
					function sample6_execDaumPostcode() {
						new daum.Postcode(
								{
									oncomplete : function(data) {
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
										if (data.userSelectedType === 'R') {
											// 법정동명이 있을 경우 추가한다. (법정리는 제외)
											// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											if (data.bname !== ''
													&& /[동|로|가]$/g
															.test(data.bname)) {
												extraAddr += data.bname;
											}
											// 건물명이 있고, 공동주택일 경우 추가한다.
											if (data.buildingName !== ''
													&& data.apartment === 'Y') {
												extraAddr += (extraAddr !== '' ? ', '
														+ data.buildingName
														: data.buildingName);
											}
											// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											if (extraAddr !== '') {
												extraAddr = ' (' + extraAddr
														+ ')';
											}
											// 조합된 참고항목을 해당 필드에 넣는다.
											document
													.getElementById("sample6_extraAddress").value = extraAddr;

										} else {
											document
													.getElementById("sample6_extraAddress").value = '';
										}

										// 우편번호와 주소 정보를 해당 필드에 넣는다.
										document
												.getElementById('sample6_postcode').value = data.zonecode;
										document
												.getElementById("sample6_address").value = addr;
										// 커서를 상세주소 필드로 이동한다.
										document.getElementById(
												"sample6_detailAddress")
												.focus();
									}
								}).open();
					}
				</script>
				<!-- 									우편번호 API 끝 							-->
				<div class="button">
					<span class="cancel" onclick="location.href='delivery.member'">취소</span>
					<input type="submit" name="submit" value="저장">
				</div>
			</form>
		</div>
	</article>

	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>