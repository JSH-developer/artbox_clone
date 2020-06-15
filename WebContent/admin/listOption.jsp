<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.OptionBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<OptionBean> optionList = (ArrayList<OptionBean>)request.getAttribute("optionList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
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
	<li><a href="ProductList.admin">상품 목록</a></li>
</ul>
</div>

<h1>옵션 리스트</h1>
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
<a href="OptionWriteForm.admin"><button>옵션 등록</button></a>
<section id="pageList">
		<%if(nowPage<=1){ %>
		◁&nbsp;
		<%}else{ %>
		<a href="OptionList.admin?page=<%=nowPage-1 %>">◁</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		[<%=a %>]
		<%}else{ %>
		<a href="OptionList.admin?page=<%=a %>">[<%=a %>]
		</a>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		▷
		<%}else{ %>
		<a href="OptionList.admin?page=<%=nowPage+1 %>">▷</a>
		<%} %>
	</section>

</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>