<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
// 	if(${ordersBean.orders_state} == 0){
// 		$("#order_state").text('배송준비중');
// 	}else if(${ordersBean.orders_state} == 1){
// 		$("#order_state").text('배송진행중');
// 	}else if(${ordersBean.orders_state} == 2){
// 		$("#order_state").text('배송완료');
// 	}else if(${ordersBean.orders_state} == -1){
// 		$("#order_state").text('배송취소');
// 	}
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
<style>
body{
	text-align: center;
	font-family: 'Noto Sans KR', sans-serif;
}
#status_select{
	width:75%;
	border-radius: 5px;
	margin-bottom: 10px;
	font-size: 20px;
	padding:5px;
}
.viewBtn{
	padding: 10px;
	margin: 10px;
	width: 100px;
	background-color: black;
	color:white;
	border: none;
}

.deleteBtn{
	background-color: red;
	border:none;
	color:white;
	
}
</style>
</head>
<body>
<h1><img src="${pageContext.request.contextPath}/Images/admin/otto.png" width="50px" height="50px"/>현재 진행상태는 '<span id="status_now"></span>' 입니다.<img src="${pageContext.request.contextPath}/Images/admin/otto.png" width="50px" height="50px"/></h1>
<form>
<select id="status_select">
<option value="0">배송준비중</option>
<option value="1">배송진행중</option>
<option value="2">배송완료</option>
<option value="-1">배송취소</option>
</select><br>
<input class="viewBtn" type="submit" value="변경"/>
<input class="viewBtn deleteBtn" type="button" value="취소"/>
</form>
</body>
</html>