<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:choose>
	<c:when test="${empty questionList }">
		<div class="empty">등록된 상품 문의 내역이 없습니다.</div>
	</c:when>
	<c:otherwise>
		<c:forEach var="ql" items="${questionList }">
			<div class="table">
				<div class="tr">
					<span class="td">
						<c:choose>
							<c:when test="${empty ql.question_answer }">문의접수</c:when>
							<c:otherwise>답변완료</c:otherwise>
						</c:choose>
					</span>
					<span class="td type2">${ql.question_title }</span>
					<span class="td"><fmt:formatDate value="${ql.question_regdate }" pattern="yyyy-MM-dd"/></span>
					<span class="td">${ql.question_member_id }</span>
				</div>
				<div class="ps">
					<div class="qna">
						<span>Q</span>
						${ql.question_content }
					</div>
					<div class="qna">
					<span>A</span>
						<c:choose>
							<c:when test="${empty ql.question_answer }">답변 준비중입니다.</c:when>
							<c:otherwise>${ql.question_answer }</c:otherwise>
						</c:choose>
					</div>
					<c:if test="${sessionScope.grade eq 'ADMIN'}">
						<c:if test="${empty ql.question_answer }">
							<form action="questionAnswer.item" method="post">
								<input type="hidden" name="product_num" value="${ql.question_product_num }">
								<input type="hidden" name="qnaNum" value="${ql.question_num }">
								<textarea name="qnaContent"></textarea>
								<input type="submit" value="답변하기">
							</form>
						</c:if>
					</c:if>
				</div>
			</div>
		</c:forEach> 
		<div class="paging">
			<span class="box">
				<c:choose>
					<c:when test="${questionPageInfo.pageNum == 1 }">
						<a href="javascript:prev();"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
					</c:when>
					<c:otherwise>
						<a href="javascript:goQuestionPage(${questionPageInfo.pageNum-1 })"> <img src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
					</c:otherwise>
				</c:choose>
				<c:forEach var="i" begin="${questionPageInfo.startPage}" end="${questionPageInfo.endPage}">
					<c:choose>
						<c:when test="${i == questionPageInfo.pageNum }">
							<a href="javascript:goQuestionPage(${i })" class="btn_pageon">${i }</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:goQuestionPage(${i })">${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${questionPageInfo.pageNum == questionPageInfo.pageCount }">
						<a href="javascript:next();"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
					</c:when>
					<c:otherwise>
						<a href="javascript:goQuestionPage(${questionPageInfo.pageNum+1 })"> <img src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
					</c:otherwise>
				</c:choose>
			</span>
		</div>
	</c:otherwise>
</c:choose>