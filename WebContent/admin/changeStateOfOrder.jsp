<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>


<link href="${pageContext.request.contextPath}/css/admin/adminChorder.css" rel="stylesheet" type="text/css">
<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if(${param.status} == 0){
		$("#status_select").val("0").prop("selected", true);
		$("#status_now").text('배송준비중')
	}else if(${param.status} == 1){
		$("#status_select").val("1").prop("selected", true);
		$("#status_now").text('배송진행중')
	}else if(${param.status} == 2){
		$("#status_select").val("2").prop("selected", true);
		$("#status_now").text('배송완료')
	}else if(${param.status} == -1){
		$("#status_select").val("-1").prop("selected", true);
		$("#status_now").text('배송취소')
	}
})
</script>


</head>
<body>
<h1><img src="${pageContext.request.contextPath}/Images/admin/otto.png" width="50px" height="50px"/>현재 진행상태는 '<span id="status_now"></span>' 입니다.<img src="${pageContext.request.contextPath}/Images/admin/otto.png" width="50px" height="50px"/></h1>
<form action="changeStatePro.admin" method="post">
<select id="status_select" name="state">
<option value="0">배송준비중</option>
<option value="1">배송진행중</option>
<option value="2">배송완료</option>
<option value="-1">배송취소</option>
</select><br>
<input type="hidden" name="num" value="${param.num}"/>
<input class="viewBtn" type="submit" value="변경"/>
<input class="viewBtn deleteBtn" type="button" value="취소" onclick="javascript:self.close();"/>
</form>
</body>
</html>