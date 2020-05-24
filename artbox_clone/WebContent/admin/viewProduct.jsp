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
	
	ProductBean productBean = (ProductBean)request.getAttribute("productBean");
%>
상품 번호 : <%=productBean.getProduct_num() %><br>
상품 카테고리 : <%=productBean.getProduct_category_code() %><br>
상품 옵션 : <%=productBean.getProduct_option_code() %><br>
상품 이름 : <%=productBean.getProduct_name() %><br>
상품 코드 : <%=productBean.getProduct_code() %><br>
상품 대표 이미지 : <%=productBean.getProduct_image() %><br>
상품 대표 이미지2 : <%=productBean.getProduct_image2() %><br>
상품 상세 : <%=productBean.getProduct_description() %><br>
상품 가격 : <%=productBean.getProduct_price() %><br>
상품 세일 가격 : <%=productBean.getProduct_sale_price() %><br>
상품 재고수량 : <%=productBean.getProduct_stock_count() %><br>
상품 키워드 : <%=productBean.getProduct_keywords() %><br>

</body>
</html>