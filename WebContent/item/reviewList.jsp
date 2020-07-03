<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${empty reviewList }">
		<div class="empty">
			첫번째 구매후기의 주인공이 되어주세요.<br>
<!-- 			150자 이상 또는 사진이 첨부된<br> -->
<!-- 			첫번째 후기를 남겨주신 분께 꿈캔디 700개를 드립니다. -->
		</div>
	</c:when>
	<c:otherwise>
		<c:forEach var="rl" items="${reviewList }">
			<div class="table">
				
				<c:set var="score" value="${(rl.review_skill + rl.review_design + rl.review_price + rl.review_quality) / 4 }"/>
				<div class="tr">
					<span class="td">
						<c:forEach var="i" begin="1" end="${score }" step="1">★</c:forEach><c:forEach var="i" begin="${score + 1}" end="5" step="1">☆</c:forEach>
					</span>
					<span class="td type2">${rl.review_content }</span>
					<span class="td"><fmt:formatDate value="${rl.review_regdate }" pattern="yyyy-MM-dd"/></span>
					<span class="td">${rl.review_member_id }</span>
				</div>
				
				<div class="ps">
					<span class="ps_score"><fmt:formatNumber value="${score * 2}" type="number" pattern="0" /></span>
					<div class="ps_sub1">
						<span>기능 <c:forEach var="i" begin="1" end="${rl.review_skill }" step="1">★</c:forEach><c:forEach var="i" begin="${rl.review_skill + 1}" end="5" step="1">☆</c:forEach></span>
						<span>디자인 <c:forEach var="i" begin="1" end="${rl.review_design }" step="1">★</c:forEach><c:forEach var="i" begin="${rl.review_design + 1}" end="5" step="1">☆</c:forEach></span>
						<span>가격 <c:forEach var="i" begin="1" end="${rl.review_price }" step="1">★</c:forEach><c:forEach var="i" begin="${rl.review_price + 1}" end="5" step="1">☆</c:forEach></span>
						<span>품질 <c:forEach var="i" begin="1" end="${rl.review_quality }" step="1">★</c:forEach><c:forEach var="i" begin="${rl.review_quality + 1}" end="5" step="1">☆</c:forEach></span>
					</div>
					<div class="ps_sub2">${rl.review_content }</div>
					<div class="ps_sub3">
						<c:if test="${!empty rl.review_img1 }"><img src="${pageContext.request.contextPath}/upload/${rl.review_img1}"></c:if>
						<c:if test="${!empty rl.review_img2 }"><img src="${pageContext.request.contextPath}/upload/${rl.review_img2}"></c:if>
						<c:if test="${!empty rl.review_img3 }"><img src="${pageContext.request.contextPath}/upload/${rl.review_img3}"></c:if>
						<c:if test="${!empty rl.review_img4 }"><img src="${pageContext.request.contextPath}/upload/${rl.review_img4}"></c:if>
						<c:if test="${!empty rl.review_img5 }"><img src="${pageContext.request.contextPath}/upload/${rl.review_img5}"></c:if>
					</div>
				</div>
			</div>
		</c:forEach> 
		<div class="paging">
			<span class="box">
				<c:choose>
					<c:when test="${reviewPageInfo.page == 1 }">
						<a href="javascript:prev();"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
					</c:when>
					<c:otherwise>
						<a href="javascript:goReviewPage(${reviewPageInfo.page - 1 })"> <img src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
					</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="${reviewPageInfo.startPage}" end="${reviewPageInfo.endPage}">
					<c:choose>
						<c:when test="${i == reviewPageInfo.page }">
							<a href="javascript:goReviewPage(${i })" class="btn_pageon">${i }</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:goReviewPage(${i })">${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${reviewPageInfo.page == reviewPageInfo.maxPage }">
						<a href="javascript:next();"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
					</c:when>
					<c:otherwise>
						<a href="javascript:goReviewPage(${reviewPageInfo.page + 1 })"> <img src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
					</c:otherwise>
				</c:choose>
			</span>
		</div>
	</c:otherwise>
</c:choose>

