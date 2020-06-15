<%@page import="vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	
	ArrayList<ProductBean> productList = (ArrayList<ProductBean>)request.getAttribute("productList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
%>
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
 	<li><a href="CategoryList.admin">카테고리 목록</a></li>
	<li><a href="OptionList.admin">옵션 목록</a></li>
</ul>
</div>
<br>

<h1>상품리스트</h1>
<table border="1">
<tr><th>번호</th><th>코드</th><th>이름</th><th>카테고리</th><th>옵션</th></tr>
<%

	for(ProductBean pl : productList){
		out.print("<tr>");
		out.print("<td>"+pl.getProduct_num()+"</td>");
		out.print("<td>"+pl.getProduct_code()+"</td>");
		out.print("<td><a href='ProductView.admin?num="+pl.getProduct_num()+"&page="+nowPage+"'>"+pl.getProduct_name()+"</a></td>");
		out.print("<td>"+pl.getProduct_category_code()+"</td>");
		out.print("<td>"+pl.getProduct_option_code()+"</td>");		
		out.print("</tr>");
	}
%>
</table>
<a href="ProductWriteForm.admin"><button>상품 등록</button></a>
<section id="pageList">
		<%if(nowPage<=1){ %>
		◁&nbsp;
		<%}else{ %>
		<a href="ProductList.admin?page=<%=nowPage-1 %>">◁</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		[<%=a %>]
		<%}else{ %>
		<a href="ProductList.admin?page=<%=a %>">[<%=a %>]
		</a>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		▷
		<%}else{ %>
		<a href="ProductList.admin?page=<%=nowPage+1 %>">▷</a>
		<%} %>
	</section>

</div>



<!--  푸터 -->
	<jsp:include page="/inc/bottom.jsp"></jsp:include>
<!--  푸터 -->

</body>
</html>