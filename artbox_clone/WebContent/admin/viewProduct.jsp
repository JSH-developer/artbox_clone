<%@page import="vo.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
</head>
<body>

<h1>view</h1>
<%
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	ProductBean productBean = (ProductBean)request.getAttribute("productBean");
%>
상품 이름 : <%=productBean.getProduct_name() %>


</body>
</html>