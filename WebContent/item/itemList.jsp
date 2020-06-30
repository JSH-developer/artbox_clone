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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.13.1/css/all.css" integrity="sha384-xxzQGERXS00kBmZW/6qxqJPyxW3UR0BPsL4c8ILaIWXva5kFi7TxkIIaMiKtqV1Q" crossorigin="anonymous">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">

$(document).on("click",".basket", function(){
	var product_name = $(this).attr("data-pdName");
	var product_num = $(this).attr("data-pdNum");
	var stockqty = 1;
	var result = 'itemList';
		if ($(this).hasClass("on")){
			$(this).css("color", "white");
			$(this).removeClass("on");
			$(this).addClass("off");
			$.ajax({
			    url: "/artbox_clone/deleteDirect.basket",
			    data: { product_num: product_num },
			    type: "GET"
			}).done(function() { // 장바구니 제거 성공
				alert(product_name + ' 이 장바구니에서 제거되었습니다.');
	        }).fail(function() { // 장바구니 제거 실패
	            alert("장바구니 제거 실패");
	        })
		} else {
			$(this).css("color", "red");
			$(this).removeClass("off");
			$(this).addClass("on");
			$.ajax({
			    url: "/artbox_clone/insertBasket.basket",
			    data: { product_num: product_num, stockqty: stockqty, result: result },
			    type: "GET"
			}).done(function() { // 장바구니 추가 성공
				alert(product_name + ' 이 장바구니에 추가되었습니다.');
	        }).fail(function() { // 장바구니 추가 실패
	            alert("장바구니 담기 실패");
	        })
		}
});
</script>
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
    <div class="content">
        <div class="head_img" style="background-image: url('${pageContext.request.contextPath}/Images/item/${code}.jpg')">
        	
		<b class="categoryName">${cname }</b>
        </div>
        <div class="category">
            <span><a href="${pageContext.request.contextPath}/itemList.item?major=${code}">전체</a></span>
            	<c:forEach var="minorCategory" items="${printCategory}" varStatus="status">
            <span class="category_menu"><a href="${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${code}<fmt:formatNumber value="${status.count}" pattern="00" />&page=${page}">${minorCategory}</a></span>
            </c:forEach>
        </div>

        <div class="info">
            <span class="total_count">
                <p>총 <b>${count}</b>개의 상품이 조회되었습니다.</p>
            </span>
            <span class="select_box">
                <select id="select" onchange="if(this.value)location.href=this.value;">
                
					<option>
					선택하세요 
					</option>                
                    <option value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=1&page=1">
                        신상품순
                    </option>
                    <option value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=2&page=1">
                        인기상품순
                    </option>
                    <option value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=3&page=1">
                        낮은가격순
                    </option>
                    <option value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=4&page=1">
                        높은가격순
                    </option>
                    <option value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=5&page=1">
                        높은할인율순
                    </option>
                    <option value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=6&page=1">
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
                            <div class="shopping_basket">
                                <div class="shopping_basket_icon">
                                    <i class="far fa-heart"></i>
                                    <a class="basket off" data-pdNum='${item.product_num }' data-pdName='${item.product_name } (${item.product_code })' style="color: white;"><i class="fas fa-shopping-cart"></i></a>
                                    <i class="far fa-comment-dots"></i>
                                </div>
                        <a href="${pageContext.request.contextPath}/itemDetail.item?product_num=${item.product_num }">
                                <img src="${pageContext.request.contextPath}/upload/${item.product_image}" class="item_img">
                        </a>
                            </div>
                            <p>
                               ${item.product_name } (${item.product_code })
                            </p>
                        <span>
                        <c:choose>
                        	<c:when test="${item.product_sale_price == 0}">
                           <fmt:formatNumber value="${item.product_price }" pattern="#,###원"/>
                           </c:when>
                           <c:otherwise>
                           <del><fmt:formatNumber value="${item.product_price }" pattern="#,###원"/></del><br>
                           <fmt:formatNumber value="${item.product_price - item.product_sale_price }" pattern="#,###원"/>
                           </c:otherwise>
                        </c:choose> 
                        </span>
                        <span>
                        <c:if test="${status.count < 6 }">
                            <img src="${pageContext.request.contextPath}/Images/item/new.png">
                        </c:if>
                        <c:if test="${item.product_sale_price != 0 }">
                        	<img src="${pageContext.request.contextPath}/Images/item/sale.png">
                        </c:if>
                        	&nbsp;
                            <!-- 기본값으로 공백 꼭 들어가야함 -->
                        </span>
                    </span>
                </li>
            </c:forEach>
            </ul>
        </div>

        <div class="paging">
        <c:if test="${startPage-5>0 }">
            <a href=""><span class="pager-left_box"></span></a>
        </c:if>
        <c:forEach var="i" begin="0" end="4" step="1">
            	<c:if test="${(startPage+i)<=lastPage }">
            		<span class="page_num"><a href=""></a></span>
            	</c:if>
		</c:forEach>
			<c:if test="${startPage+5<=lastPage }">
            		<a href=""><span class="pager-right_box"></span></a>
            	</c:if>
        </div>
    </div>
 </div>
 <!-- 메인 콘텐츠 -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>

</body>
</html>