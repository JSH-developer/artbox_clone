<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link href="css/front.css" rel="stylesheet" type="text/css">
<link href="css/slide.css" rel="stylesheet" type="text/css">
<link href="css/member/delivery.css" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- 헤더 -->
	
	
	<div class="main">
		<div class="mydelivery">
			<p class="title">나의 배송지 관리</p>
			<div>
			<span class="top">배송지명</span>
			<span class="top">받는사람</span>
			<span class="top">주소</span>
			<span class="top">휴대전화</span>
			<span class="top"></span>
			</div>
			
			<c:if test="${empty list }">
				<div class="middle0">
					등록된 배송지가 없습니다.
				</div>
			</c:if>
			<input type="hidden" value="${id }">
			<c:if test="${!empty list }">
				<c:forEach var="rb" items="${list }" varStatus="status">

					<div class="middle1">
						<span class="bottom"><input type="radio" name="box" value="${rb.receiver_num }"></span>
						<span class="bottom">${rb.receiver }</span>
						<span class="bottom">${rb.receiver_name}</span>
						<span class="bottom">${rb.receiver_addr} ${rb.receiver_addr_detail }</span>
						<span class="bottom">${rb.receiver_phone}</span>
						<span class="bottom"><c:if test="${rb.receiver_basic_num eq 1 }"><span class="basicButton">기본</span></c:if></span>
					</div>
	
				</c:forEach>
			</c:if>
			
		</div>
		
		<div class="button">
			<span class="modify" onclick="rModify()">수정</span>
			<span class="delete" onclick="rDelete()">삭제</span>
			<span class="basic" onclick="rBasic()">기본 배송지로 선택</span>
			<span class="add" onclick="location.href='MyPageDeliveryAdd.member'">배송지 추가</span>
		</div>
	
	<script src="js/jquery-3.5.0.js"></script>
	<script type="text/javascript">
	
			function rModify() {
				var boxcheck = $('input[name="box"]:checked').val();
				var rcheck = $('input:radio[name="box"]').is(':checked');
				if(rcheck == true){
					location.href="deliveryModify.member?num="+boxcheck;
				}else {
					alert('수정하실 배송지를 선택해주세요.')
				}
			}
			function rDelete() {
				var rcheck = $('input:radio[name="box"]').is(':checked');
				if(rcheck == true){
				var isDelete = confirm("배송지를 삭제하시겠습니까?")
					if(isDelete == true){
						location.href="deliveryDelete.member?num="+boxcheck;	
					}
				}else{
					alert('삭제하실 배송지를 선택해주세요.')
				}
			}
			function rBasic() {
				var rcheck = $('input:radio[name="box"]').is(':checked');
				if(rcheck == true){
					var boxcheck = $('input[name="box"]:checked').val();
					var id = $('input[type=hidden]').val();
					location.href="deliveryBasic.member?num="+boxcheck+"&id="+id;
				}else{
					alert('배송지를 선택해주세요.')
				}
			}
	</script>

	</div>
	
	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  푸터 -->
</body>
</html>