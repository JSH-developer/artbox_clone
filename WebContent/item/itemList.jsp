<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.ArrayList"%>
<%@page import="vo.ProductBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/item/itemList.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
    <div class="content">
        <div class="head_img">

        </div>
        <div class="category">
            <span><a href="${pageContext.request.contextPath}/itemList.item?major=${code}">전체</a></span>
            	<c:forEach var="minorCategory" items="${printCategory}" varStatus="status">
            <span class="category_menu"><a href="${pageContext.request.contextPath}/itemList.item?minor=${code}<fmt:formatNumber value="${status.count}" pattern="00" />">${minorCategory}</a></span>
            </c:forEach>
        </div>

        <div class="info">
            <span class="total_count">
                <p>총 <b>${count}</b>개의 상품이 조회되었습니다.</p>
            </span>
            <span class="select_box">
                <select>
                    <option>
                        신상품순
                    </option>
                    <option>
                        인기상품순
                    </option>
                    <option>
                        낮은가격순
                    </option>
                    <option>
                        높은가격순
                    </option>
                    <option>
                        높은할인율순
                    </option>
                    <option>
                        상품평순
                    </option>

                </select>
            </span>
        </div>

        <div class="item_list">
            <ul class="ul_list">
            	<c:forEach var="item" items="${productBean }" varStatus="status">
                <li>
                    <span class="item">
                        <a href="${pageContext.request.contextPath}/itemDetail.item?product_num=${item.product_num }">
                            <div class="shopping_basket">
                                <div class="shopping_basket_icon">
                                    <i class="far fa-heart"></i>
                                    <i class="fas fa-shopping-cart"></i>
                                    <i class="far fa-comment-dots"></i>
                                </div>
                                <img src="${pageContext.request.contextPath}${item.product_image}" class="item_img">
                            </div>
                            <p>
                               ${item.product_name }
                            </p>
                        </a>
                        <span>
                        
                           <fmt:formatNumber value="${item.product_price }" pattern="0원"/> 
                        </span>
                        <span>
                        <c:choose>
                        <c:when test="${status.count<6 }">
                            new!!!
                        </c:when>
                        <c:otherwise>
                        	&nbsp;
                        </c:otherwise>    
                        </c:choose>
                            <!-- 기본값으로 공백 꼭 들어가야함 -->
                        </span>
                    </span>
                </li>
            </c:forEach>
            </ul>
        </div>

        <div class="paging">
            <a href=""><span class="pager-left_box"></span></a>
            <span class="page_num"><a href="">1</a></span>
            <a href=""><span class="pager-right_box"></span></a>
        </div>
    </div>
 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>
