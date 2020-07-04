<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.ProductBean"%>
<%@page import="vo.PrintCategory"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel=" shortcut icon"
	href="${pageContext.request.contextPath}/Images/common/tab.ico"
	type="image/x-icon">
<link rel="icon"
	href="${pageContext.request.contextPath}/Images/common/tab.ico"
	type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/item/itemList.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/front.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.13.1/css/all.css"
	integrity="sha384-xxzQGERXS00kBmZW/6qxqJPyxW3UR0BPsL4c8ILaIWXva5kFi7TxkIIaMiKtqV1Q"
	crossorigin="anonymous">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
	// 장바구니 추가 및 제거 이벤트
	$(document).on("click", ".basket", function() {
		if(${empty sessionScope.id}) {
			var result = confirm("로그인 후 이용가능합니다.\n로그인 페이지로 이동하시겠습니까?");
			if(result==true) {
				location.href = "loginForm.member";
			}
			return false;
		}
		var product_name = $(this).attr("data-pdName"); // 상품이름
		var product_num = $(this).attr("data-pdNum"); // 상품번호
		var stockqty = 1; // 수량
		var result = 'itemList';
		if ($(this).hasClass("on")) { // 장바구니에서 제거할 때
			$(this).css("color", "white"); // 장바구니 이미지 하얗게
			$(this).removeClass("on"); // Class 에서 on 제거
			$(this).addClass("off"); // Class 에 off 추가
			$.ajax({
				url : "/artbox_clone/deleteBasket.basket",
				data : {
					product_num : product_num
				},
				type : "GET"
			}).done(function() { // 장바구니 제거 성공
				alert(product_name + ' 이 장바구니에서 제거되었습니다.');
			}).fail(function() { // 장바구니 제거 실패
				alert("장바구니 제거 실패");
			})
		} else { // 장바구니에 추가할 때
			$(this).css("color", "red"); // 장바구니 이미지 빨갛게
			$(this).removeClass("off"); // Class 에서 off 제거
			$(this).addClass("on"); // Class 에 on 추가
			$.ajax({
				url : "/artbox_clone/insertBasket.basket",
				data : {
					product_num : product_num,
					stockqty : stockqty,
					result : result
				},
				type : "GET"
			})
			//          .done(function() { // 장바구니 추가 성공
			//             alert(product_name + ' 이 장바구니에 추가되었습니다.');
			//            }).fail(function() { // 장바구니 추가 실패
			//                alert("장바구니 담기 실패");
			//            })
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
				<c:choose>
					<c:when test="${empty kwd}">
						<div class="head_img"
							style="background-image: url('${pageContext.request.contextPath}/Images/item/${code}.jpg')">
							<b class="categoryName">${cname }</b>
						</div>
					</c:when>
					<c:when test="${!empty kwd }">
						<c:choose>
							<c:when test="${effectiveness==0 }">
								<div class="nfd">
									<h1>'${kwd }'에 대한 검색 결과가 없습니다.</h1>
									<h2>다시 한번 검색 해 주세요</h2>
									<img style="width: 400px; height: 250px;"
										src="${pageContext.request.contextPath}/Images/item/NFD.png">
								</div>
							</c:when>
							<c:otherwise>
								<div class="head_img">
									<b class="categoryName_search">'${kwd }' 검색 결과 </b>
								</div>
							</c:otherwise>
						</c:choose>
					</c:when>
				</c:choose>
				<div class="category">
					<c:choose>
						<c:when test="${effectiveness==0 }"></c:when>
						<c:otherwise>
							<span><a
								href="${pageContext.request.contextPath}/itemList.item?major=${code}&minor=&kwd=${kwd}&doOrder=&page=1&src=">전체</a></span>
						</c:otherwise>
					</c:choose>
					<c:forEach var="category" items="${printCategory}"
						varStatus="status">
						<c:choose>
							<c:when test="${empty kwd}">
								<span class="category_menu"><a
									href="${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${code}<fmt:formatNumber value="${status.count}" pattern="00" />&kwd=${kwd}&doOrder=&page=1&src=">${category}</a></span>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${effectiveness==0 }">
									</c:when>
									<c:otherwise>
										<span class="category_menu"><a id="atag"
											href="${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${code}<fmt:formatNumber value="${status.count}" pattern="00" />&kwd=${kwd}&doOrder=&page=1&src=${category.code}">${category.category}</a></span>
									</c:otherwise>
								</c:choose>
							</c:otherwise>

						</c:choose>
					</c:forEach>
				</div>
				<c:choose>
					<c:when test="${effectiveness==0 }">
					</c:when>
					<c:otherwise>
						<div class="info">
							<span class="total_count">
								<p>
									총 <b>${count}</b>개의 상품이 조회되었습니다.
								</p>
							</span> <span class="select_box"> <select id="select"
								onchange="if(this.value)location.href=this.value;">

									<option>선택하세요</option>
									<option
										value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=1&page=${page}&src=${src}">
										신상품순</option>
									<option
										value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=2&page=${page}&src=${src}">
										인기상품순</option>
									<option
										value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=3&page=${page}&src=${src}">
										낮은가격순</option>
									<option
										value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=4&page=${page}&src=${src}">
										높은가격순</option>
									<option
										value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=5&page=${page}&src=${src}">
										높은할인율순</option>
									<option
										value="http://localhost:8080${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=6&page=${page}&src=${src}">
										상품평순</option>

							</select>
							</span>
						</div>
					</c:otherwise>
				</c:choose>

				<div class="item_list">
					<ul class="ul_list">
						<c:forEach var="item" items="${productBean }" varStatus="status">
							<li style="margin-right: 50px;"><span class="item">
									<div class="shopping_basket">
										<div class="shopping_basket_icon">
											<i class="far fa-heart"></i> <a class="basket off"
												data-pdNum='${item.product_num }'
												data-pdName='${item.product_name } (${item.product_code })'
												style="color: white;"><i class="fas fa-shopping-cart"></i></a>
											<i class="far fa-comment-dots"></i>
										</div>
										<a
											href="${pageContext.request.contextPath}/itemDetail.item?product_num=${item.product_num }">
											<img
											src="${pageContext.request.contextPath}/upload/${item.product_image}"
											class="item_img">
										</a>
									</div>
									<p class="item_name">${item.product_name }
										(${item.product_code })</p> <span> 
										<c:choose>
											<c:when test="${item.product_sale_price == 0 }">
												<fmt:formatNumber value="${item.product_price }"
													pattern="#,###원" />
											</c:when>
											<c:otherwise>
											
												<del><fmt:formatNumber
													value="${item.product_price }"
													pattern="#,###원" /></del>
												<br>
												<fmt:formatNumber
													value="${item.product_price - item.product_sale_price }"
													pattern="#,###원" />
													
											</c:otherwise>
										</c:choose>
								</span> <span> <c:if test="${status.count<6 }">
											<img
												src="${pageContext.request.contextPath}/Images/item/new.png">
										</c:if> 
										<c:if test="${item.product_sale_price != 0 }">
											<img
												src="${pageContext.request.contextPath}/Images/item/sale.png">
										</c:if> &nbsp; <!-- 기본값으로 공백 꼭 들어가야함 -->
								</span>
							</span></li>
						</c:forEach>
					</ul>
				</div>
				<div class="paging">
					<c:if test="${startPage-5>0}">
						<a href=""><span class="pager-left_box"></span></a>
					</c:if>
					<c:forEach var="i" begin="0" end="4" step="1">
						<c:if test="${(startPage+i)<=lastPage }">
							<span class="page_num"><a
								href="${pageContext.request.contextPath}/itemList.item?major=${code}&minor=${minorCategoryCode }&kwd=${kwd}&doOrder=${doOrder}&page=${startPage+i}&src=${src}">${startPage+i}</a></span>
						</c:if>
					</c:forEach>
					<c:if test="${startPage+5<=lastPage }">
						<a href=""><span class="pager-right_box"></span></a>
					</c:if>
				</div>
			</div>
		</div>
		<!-- 메인 콘텐츠 -->

		<!-- 푸터 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 -->
	</div>
</body>
</html>
