<%@page import="java.util.ArrayList"%>
<%@page import="vo.OptionBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<OptionBean> optionList = (ArrayList<OptionBean>)request.getAttribute("optionList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">

</head>
<body>

<!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
<!-- 헤더 -->

<div class="pageContent">

<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="OptionWriteForm.admin">옵션 등록</a></li>
</ul>
</div>

<h1>카테고리 리스트</h1>
<table border="1">
<tr><th>코드</th><th>옵션이름</th><th>추가가격</th></tr>
<%

	for(OptionBean ol : optionList){
		out.print("<tr>");
		out.print("<td>"+ol.getOption_code()+"</td>");
		out.print("<td>"+ol.getOption_name()+"</td>");
		out.print("<td>"+ol.getAdd_price()+"</td>");		
		out.print("</tr>");
	}
%>
</table>

</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>