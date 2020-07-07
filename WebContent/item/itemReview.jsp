<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
    <link href="${pageContext.request.contextPath}/css/item/itemReview.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
	<script type="text/javascript">
	// 시작시
	window.onload = function (){
		if("${tab }" == "mod"){
			$('.reviewWrite').removeClass("on");
			$('.reviewMod').addClass("on");
			$('.reviewWriteList').css('display','none');
			$('.reviewModList').css('display','block');
		}
	}
	// modal버튼 클릭시 팝업
	$(document).on('click','.modal',function(){
		$('.full-screen').css('display','block');
		$('.review-overlay').css('display','block');
	})
	// 닫기버튼 클릭시 종료
	$(document).on('click','.overlay-close',function(){
		$('.full-screen').css('display','none');
		$('.review-overlay').css('display','none');
		setClose();
	})
	$(document).on('click','.full-screen-close',function(){
		$('.full-screen').css('display','none');
		$('.review-overlay').css('display','none');
		setClose();
	})
	// 모달팝업시 설정
	function setOpen(productnum){
		$('input[name=product_num]').val(productnum);
		$('.overlay-header span').html("상품후기 작성하기");
		$('.regist').val("등록하기");
	}
	function fnPopPostScriptMod(review_num){
		$('input[name=review_num]').val(review_num);
		$('.overlay-header span').html("상품후기 수정하기");
		$('.regist').val("수정하기");
	}
	// 후기 삭제
	function fnDelete(review_num){
		var result = confirm("구매후기를 삭제하시겠습니까?");
		if(result){
			location.href="reviewDelete.item?review_num="+review_num;
		}
	}
	// 모달종료시 설정
	function setClose(){
		$('input[name=product_num]').val("");
		$('input[name=review_num]').val("");
		$('.score').children("b").removeClass("on");
    	$("input[name=skill]").val("");
    	$("input[name=design]").val("");
    	$("input[name=price]").val("");
    	$("input[name=quality]").val("");
		$("#fr")[0].reset();
		$("#img1").attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
		$("#img1").attr('title', "선택된 파일 없음");
		$("#img2").attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
		$("#img2").attr('title', "선택된 파일 없음");
		$("#img3").attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
		$("#img3").attr('title', "선택된 파일 없음");
		$("#img4").attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
		$("#img4").attr('title', "선택된 파일 없음");
		$("#img5").attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
		$("#img5").attr('title', "선택된 파일 없음");
	}
	//reviewTab 클릭시
	$(document).on('click','.reviewWrite',function(){
		$('.reviewMod').removeClass("on");
		$('.reviewWrite').addClass("on");
		$('.reviewModList').css('display','none');
		$('.reviewWriteList').css('display','block');
	})
	$(document).on('click','.reviewMod',function(){
		$('.reviewWrite').removeClass("on");
		$('.reviewMod').addClass("on");
		$('.reviewWriteList').css('display','none');
		$('.reviewModList').css('display','block');
	})
	// 후기 작성시 체크
	function reviewcheck() {
		var result = false;
		if($('input[name=skill]').val() == ""){
			alert("별점(기능)을 입력해 주세요.");
		}else if($('input[name=design]').val() == ""){
			alert("별점(디자인)을 입력해 주세요.");
		}else if($('input[name=price]').val() == ""){
			alert("별점(가격)을 입력해 주세요.");
		}else if($('input[name=quality]').val() == ""){
			alert("별점(품질)을 입력해 주세요.");
		}else if($('textarea[name=content]').val() == ""){
			alert("내용을 입력해 주세요.");
			$('textarea[name=content]').focus();
		}else{
			if($('.regist').val() == "등록하기"){
				result = confirm("상품후기를 작성 하시겠습니까?");
			}else {
				result = confirm("상품후기를 수정 하시겠습니까?");
			}
		}
		return result;
	}
	
	
	</script>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!-- /헤더 -->
	<!-- 메인 콘텐츠  -->
	<div class="reviewWrap">
		<div class="reviewTitle">구매후기</div>
		<div class="reviewInfo">
			<span>- 10자 이상 150자 미만의 상품후기 작성 시 꿈캔디 100개, 150자 이상의 후기 혹은 사진이 첨부된 후기 작성 시 꿈캔디 200개를 적립해 드립니다.</span>
			<span>- 베스트후기로 선정되신 분께는 꿈캔디 3,000개를 추가로 적립해 드립니다.</span>
			<span>- 해당 상품의 첫번째 후기를 남겨주신 분께는 꿈캔디 500개를 추가로 적립해 드립니다.</span>
			<span>- 구매후기는 구매확정일 기준으로 6개월 이내에 작성 가능합니다. 구매후기 작성기한은 아래 리스트에서 확인해 주세요.</span>
			<span class="reviewWarning">* 구매/취소/반품하신 상품과 무관한 내용이나 이미지, 비방, 도배성 글 등 부적합한 내용일 때는 통보없이 삭제 및 지급된 꿈캔디가 회수될 수 있습니다.</span>
		</div>
		<div class="reviewTab">		
			<span class="reviewWrite on">구매후기 쓰기</span>
			<span class="reviewMod ">구매후기 수정</span>
		</div>
		<div class="reviewWriteList">
		<c:choose>
			<c:when test="${empty itemReviewList }">
				<div class="empty">주문 내역이 없습니다.</div>
			</c:when>
			<c:otherwise>
			<ul class="ItemList">
				<c:forEach var="irl" items="${itemReviewList }">
					<li>
						<a href="itemDetail.item?product_num=${irl.product_num }">
							<img src="${pageContext.request.contextPath}/upload/${irl.product_image }">
						</a>
						<span class="itemname">${irl.product_name }</span>
						<span class="itemname"> </span>
						<span class="itemamt">
							<span class="itemprice sale_N">${irl.product_price }원</span>
						</span>
						<a class="btnWrite modal" href="javascript:setOpen(${irl.product_num });">구매후기 쓰기</a>
						<span class="deadline">작성기한: <fmt:formatDate value="${irl.product_regdate }" pattern="yyyy.MM.dd"/>까지</span>
					</li>
				</c:forEach>
				<li>
					<div class="paging">
						<span class="box">
						<c:choose>
							<c:when test="${writePageInfo.page == 1 }">
								<a href="javascript:prev();"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
							</c:when>
							<c:otherwise>
								<a href="itemReview.item?page=${writePageInfo.page-1 }&modPage=${modPageInfo.page }"> <img src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
							</c:otherwise>
						</c:choose>
						<c:forEach var="i" begin="${writePageInfo.startPage}" end="${writePageInfo.endPage}">
							<c:choose>
								<c:when test="${i == writePageInfo.page }">
									<a href="itemReview.item?page=${i }&modPage=${modPageInfo.page }" class="btn_pageon">${i }</a>
								</c:when>
								<c:otherwise>
									<a href="itemReview.item?page=${i }&modPage=${modPageInfo.page }">${i }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${writePageInfo.page == writePageInfo.endPage }">
								<a href="javascript:next();"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
							</c:when>
							<c:otherwise>
								<a href="itemReview.item?page=${writePageInfo.page+1 }&modPage=${modPageInfo.page }"> <img src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
							</c:otherwise>
						</c:choose>
					</span>
					</div>
					
				</li>
			</ul>
			<div class="clear"></div>
			</c:otherwise>
		</c:choose>
		</div>
		<div class="reviewModList">
			<c:choose>
				<c:when test="${empty itemReviewModList }">
					<div class="empty">작성한 후기가 없습니다.</div>
				</c:when>
				<c:otherwise>
					<ul class="ModItemList">
						<c:forEach var="irml" items="${itemReviewModList }">
							<li>
								<span class="img">
									<a href="itemDetail.item?product_num=${irml.review_product_num }">
										<img src="${pageContext.request.contextPath}/upload/${irml.review_re_name }">
									</a>
								</span>
								<span class="modbox">
									<span class="sub1">
										<span class="point s"><c:forEach var="i" begin="1" end="${irml.review_skill }" step="1">★</c:forEach><c:forEach var="i" begin="${irml.review_skill + 1}" end="5" step="1">☆</c:forEach></span>
										<span class="point d"><c:forEach var="i" begin="1" end="${irml.review_design }" step="1">★</c:forEach><c:forEach var="i" begin="${irml.review_design + 1}" end="5" step="1">☆</c:forEach></span>
										<span class="point p"><c:forEach var="i" begin="1" end="${irml.review_price }" step="1">★</c:forEach><c:forEach var="i" begin="${irml.review_price + 1}" end="5" step="1">☆</c:forEach></span>
										<span class="point q"><c:forEach var="i" begin="1" end="${irml.review_quality }" step="1">★</c:forEach><c:forEach var="i" begin="${irml.review_quality + 1}" end="5" step="1">☆</c:forEach></span>	
										<span class="totalpoint"><fmt:formatNumber value="${(irml.review_skill + irml.review_design + irml.review_price + irml.review_quality) / 2 }" type="number" pattern="0" /></span>
									</span>
									<span class="sub2">
										<div><span class="sub2_cont">${irml.review_content }</span></div>
										<span class="sub2_img"><c:if test="${!empty irml.review_img1 }"><img src="${pageContext.request.contextPath}/upload/${irml.review_img1 }"></c:if></span>
										<span class="sub2_img"><c:if test="${!empty irml.review_img2 }"><img src="${pageContext.request.contextPath}/upload/${irml.review_img2 }"></c:if></span>
										<span class="sub2_img"><c:if test="${!empty irml.review_img3 }"><img src="${pageContext.request.contextPath}/upload/${irml.review_img3 }"></c:if></span>
										<span class="sub2_img"><c:if test="${!empty irml.review_img4 }"><img src="${pageContext.request.contextPath}/upload/${irml.review_img4 }"></c:if></span>
										<span class="sub2_img"><c:if test="${!empty irml.review_img5 }"><img src="${pageContext.request.contextPath}/upload/${irml.review_img5 }"></c:if></span>
									</span>
									<input class="btnEpilogueModify modal" type="button" onclick="fnPopPostScriptMod(${irml.review_num })" value="수정">
									<input class="btnEpilogueDelete" type="button" onclick="fnDelete(${irml.review_num });" value="삭제">
								</span>
							</li>
						</c:forEach>
						<li>
							<div class="paging">
								<span class="box">
									<c:choose>
										<c:when test="${ModPageInfo.page == 1 }">
											<a href="javascript:prev();"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
										</c:when>
										<c:otherwise>
											<a href="itemReview.item?page=${writePageInfo.page }&modPage=${ModPageInfo.page-1 }&tab=mod"> <img src="${pageContext.request.contextPath}/Images/order/btn_board_prev.gif"> </a>
										</c:otherwise>
									</c:choose>
									<c:forEach var="i" begin="${ModPageInfo.startPage}" end="${ModPageInfo.endPage}">
										<c:choose>
											<c:when test="${i == ModPageInfo.page }">
												<a href="itemReview.item?page=${writePageInfo.page }&modPage=${i }&tab=mod" class="btn_pageon">${i }</a>
											</c:when>
											<c:otherwise>
												<a href="itemReview.item?page=${writePageInfo.page }&modPage=${i }&tab=mod">${i }</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:choose>
										<c:when test="${ModPageInfo.page == ModPageInfo.endPage }">
											<a href="javascript:next();"> <img class="opacity" src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
										</c:when>
										<c:otherwise>
											<a href="itemReview.item?page=${writePageInfo.page }&modPage=${ModPageInfo.page+1 }&tab=mod"> <img src="${pageContext.request.contextPath}/Images/order/btn_board_next.gif"> </a>
										</c:otherwise>
									</c:choose>
								</span>
							</div>
						</li>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="full-screen">
			<div class="full-screen-close"></div>
			<div class="review-overlay">
			<form action="reviewWrite.item" method="post" id="fr" name="fr" enctype="multipart/form-data" onsubmit="return reviewcheck()">
				<div class="overlay-header"><span>상품후기 작성하기</span><input class="overlay-close" type="button" value=""></div>
				<div class="overlay-body">
					<input type="hidden" name="review_num" value="">
					<input type="hidden" name="product_num" value="">
					<img class="candy-img" src="${pageContext.request.contextPath}/Images/item/img_epilogue_bg.png">
					<div class="input">
						<span class="tt">별점</span>
						<span class="score"><span>기능</span><b value="1">★</b> <b value="2">★</b> <b value="3">★</b> <b value="4">★</b> <b value="5">★</b>
							<input type="hidden" name="skill" value=""></span>
						<span class="score"><span>디자인</span><b value="1">★</b> <b value="2">★</b> <b value="3">★</b> <b value="4">★</b> <b value="5">★</b>
							<input type="hidden" name="design" value=""></span>
						<span class="score"><span>가격</span><b value="1">★</b> <b value="2">★</b> <b value="3">★</b> <b value="4">★</b> <b value="5">★</b>
							<input type="hidden" name="price" value=""></span>
						<span class="score"><span>품질</span><b value="1">★</b> <b value="2">★</b> <b value="3">★</b> <b value="4">★</b> <b value="5">★</b>
							<input type="hidden" name="quality" value=""></span>
					</div>
					<script type="text/javascript">
			        $('.input b').click(function(){
			            $(this).parent().children("b").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
			            $(this).addClass("on").prevAll("b").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
			            $('input[name=skill]').val()
// 			            alert($(this).attr("value"));
			            if($(this).parent().find("input[name=skill]").length){//.length 존재유무 확인
			            	$("input[name=skill]").val($(this).attr("value"));
			            }else if($(this).parent().find("input[name=design]").length){
			            	$("input[name=design]").val($(this).attr("value"));
				        }else if($(this).parent().find("input[name=price]").length){
			            	$("input[name=price]").val($(this).attr("value"));
				        }else if($(this).parent().find("input[name=quality]").length){
			            	$("input[name=quality]").val($(this).attr("value"));
				        }
			        });
					</script>
					<div class="input">
						<span class="tt">내용</span>
						<textarea name="content" placeholder="- 구매/취소/반품하신 상품과 무관한 내용이나 이미지, 비방, 도배성 글 등 부적합한 내용일 때는 통보없이 삭제 및 지급된 꿈캔디가 회수될 수 있습니다."></textarea>
						<span></span>
					</div>
					<div class="input">
						<span class="tt">이미지 파일</span>
						<label>
							<img id="img1" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img1" onchange="readURL(this,1);" />
						</label>
						<label>
							<img id="img2" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img2" onchange="readURL(this,2);" />
						</label>
						<label>
							<img id="img3" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img3" onchange="readURL(this,3);" />
						</label>
						<label>
							<img id="img4" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img4" onchange="readURL(this,4);" />
						</label>
						<label>
							<img id="img5" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img5" onchange="readURL(this,5);" />
						</label>
						<div class="etc">*이미지는 jpg와 png 형식만 가능합니다</div>
					</div>
				</div>
				<div class="overlay-footer">
					<input class="regist" type="submit" value="">
				</div>
			</form>
			</div>
		</div>
	<script type="text/javascript">
		function readURL(input,x) {
			strArray = input.value.split(".");
			strArrayLength = strArray.length -1;
			FileType = strArray[strArrayLength].toLowerCase();
	
			if (input.files && input.files[0]) {
				if (FileType != "jpg" && FileType != "png" && FileType != "jpeg"){
					alert("jpg 또는 png파일만 업로드 가능합니다." + FileType);
					$("#img"+x).attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
					$("#img"+x).attr('title', "선택된 파일 없음");
					input.value="";	
				}else{
					var reader = new FileReader();
					reader.onload = function (e) {
						$("#img"+x).attr('src', "${pageContext.request.contextPath}/Images/item/BE.jpg");
						$("#img"+x).attr('src', e.target.result);
						$("#img"+x).attr('title', "");
					}
					reader.readAsDataURL(input.files[0]);
				}
			}else{
				$("#img"+x).attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
				$("#img"+x).attr('title', "선택된 파일 없음");
			}
		}
	</script>

	</div>
	<!-- /메인 콘텐츠  -->
	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  /푸터 -->
</body>
</html>