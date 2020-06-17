<%@page import="vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<script>
function deleteMember(){
	var del = confirm('회원을 삭제 하시겠습니까?');
	if(del){
		location.href = "MemberDeletePro.admin?num=${memberBean.num}&page=${page}";
	}
	
}


</script>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/admin/adminView.css" rel="stylesheet" type="text/css">

</head>
<body>

 <!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->
 
<%--  <input type = "hidden" name = "page" value = "${page}"/> --%>
 
 
<div class="pageContent">
<h1 class="viewTitle">회원상세보기</h1>
<div class="wrapView">
<table class="viewTable">
<tr><th>회원 번호</th><td><c:out value="${memberBean.num}"/></td></tr>
<tr><th>회원 아이디</th><td><c:out value="${memberBean.id}"/></td></tr>
<tr><th>회원 이름</th><td><c:out value="${memberBean.name}"/></td></tr>
<tr><th>회원 우편번호</th><td><c:out value="${memberBean.postcode}"/></td></tr>
<tr><th>회원 주소1</th><td><c:out value="${memberBean.addr_basic}"/></td></tr>
<tr><th>회원 주소2</th><td><c:out value="${memberBean.addr_detail}"/></td></tr>
<tr><th>회원 이메일</th><td><c:out value="${memberBean.email}"/></td></tr>
<tr><th>회원 포인트</th><td><c:out value="${memberBean.point}"/></td></tr>
<tr><th>회원 생일</th><td><c:out value="${memberBean.birth}"/></td></tr>
<tr><th>회원 등급</th><td><c:out value="${memberBean.grade}"/></td></tr>
<tr><th>회원 상태</th><td><c:out value="${memberBean.status}"/></td></tr>
<tr><th>회원 등록일</th><td><c:out value="${memberBean.regdate}"/></td></tr>
</table>
<button onclick="deleteMember()" class="viewBtn deleteBtn">회원삭제하기</button>
<button onclick="location.href='MemberList.admin?page=${param.page}'" class="viewBtn">목록가기</button>
</div>

<h1>orders 테이블 활용</h1>
구글차트활용<br>
누적금액: => 회원등급 반영 5만원/ 50만원/ 100만원




</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>