<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.CategoryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<CategoryBean> categoryList = (ArrayList<CategoryBean>)request.getAttribute("categoryList");
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

<h1>카테고리 리스트</h1>
<table border="1">
<tr><th>번호</th><th>코드</th><th>대분류</th><th>소분류</th></tr>
<%

	for(CategoryBean cl : categoryList){
		out.print("<tr>");
		out.print("<td>"+cl.getCategory_num()+"</td>");
		out.print("<td>"+cl.getCategory_code()+"</td>");
		out.print("<td>"+cl.getCategory_sup()+"</td>");
		out.print("<td>"+cl.getCategory_sub()+"</td>");		
		out.print("</tr>");
	}
%>
</table>
<a href="CategoryWriteForm.admin"><button>카테고리 등록</button></a>

<section id="pageList">
		<%if(nowPage<=1){ %>
		◁&nbsp;
		<%}else{ %>
		<a href="CategoryList.admin?page=<%=nowPage-1 %>">◁</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		[<%=a %>]
		<%}else{ %>
		<a href="CategoryList.admin?page=<%=a %>">[<%=a %>]
		</a>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		▷
		<%}else{ %>
		<a href="CategoryList.admin?page=<%=nowPage+1 %>">▷</a>
		<%} %>
	</section>




</div>

<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>