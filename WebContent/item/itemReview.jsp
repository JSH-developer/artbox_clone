<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
    <link href="${pageContext.request.contextPath}/css/item/itemReview.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
	<script type="text/javascript">
	
	// modal버튼 클릭시 팝업
	$(document).on('click','.modal',function(){
		$('.full-screen').css('display','block');
		if($(this).hasClass('btnWrite')){
			$('.review-overlay').css('display','block');
		}
	})
	// 닫기버튼 클릭시 종료
	$(document).on('click','.overlay-close',function(){
		$('.full-screen').css('display','none');
		$('.review-overlay').css('display','none');
	})
	$(document).on('click','.full-screen-close',function(){
		$('.full-screen').css('display','none');
		$('.review-overlay').css('display','none');
	})
	
	
	
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
			result = confirm("상품후기를 작성 하시겠습니까?");
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
			<a class="on" href="#">구매후기 쓰기</a>
			<a href="#">구매후기 수정</a>
		</div>
		<div class="reviewWriteList">
			<ul class="ItemList">
				<c:forEach var="rl" items="${reviewList }">
					<li>
						<a href="itemDetail.item?product_num=${rl.product_num }">
							<img src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png">
						</a>
						<span class="itemname">${rl.product_name }</span>
						<span class="itemname"> </span>
						<span class="itemamt">
							<span class="itemprice sale_N">${rl.product_price }</span>
						</span>
						<a class="btnWrite modal" href="#">구매후기 쓰기</a>
						<span class="deadline">작성기한: 2020.12.02까지</span>
					</li>
				</c:forEach>
				<li>
					<a href="http://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=1901220587">
						<img src="./detail1.jpg">
					</a>
					<span class="itemname">물티슈 썸머튜브패턴(10매) (25014223)</span>
					<span class="itemname"> </span>
					<span class="itemamt">
						<span class="itemprice sale_N">600원</span>
					</span>
					<a class="btnWrite modal" href="#">구매후기 쓰기</a>
					<span class="deadline">작성기한: 2020.12.02까지</span>
				</li>
				<li>
					<a href="http://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=1901220587">
						<img src="./detail1.jpg">
					</a>
					<span class="itemname">물티슈 썸머튜브패턴(10매) (25014223)</span>
					<span class="itemname"> </span>
					<span class="itemamt">
						<span class="itemprice sale_N">600원</span>
					</span>
					<a class="btnWrite modal" href="#">구매후기 쓰기</a>
					<span class="deadline">작성기한: 2020.12.02까지</span>
				</li>
				<li>
					<a href="http://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=1901220587">
						<img src="./detail1.jpg">
					</a>
					<span class="itemname">물티슈 썸머튜브패턴(10매) (25014223)</span>
					<span class="itemname"> </span>
					<span class="itemamt">
						<span class="itemprice sale_N">600원</span>
					</span>
					<a class="btnWrite modal" href="#">구매후기 쓰기</a>
					<span class="deadline">작성기한: 2020.12.02까지</span>
				</li>
				<li>
					<a href="http://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=1901220587">
						<img src="./detail1.jpg">
					</a>
					<span class="itemname">물티슈 썸머튜브패턴(10매) (25014223)</span>
					<span class="itemname"> </span>
					<span class="itemamt">
						<span class="itemprice sale_N">600원</span>
					</span>
					<a class="btnWrite modal" href="#">구매후기 쓰기</a>
					<span class="deadline">작성기한: 2020.12.02까지</span>
				</li>
				<li>
					<a href="http://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=1901220587">
						<img src="./detail1.jpg">
					</a>
					<span class="itemname">물티슈 썸머튜브패턴(10매) (25014223)</span>
					<span class="itemname"> </span>
					<span class="itemamt">
						<span class="itemprice sale_N">600원</span>
					</span>
					<a class="btnWrite modal" href="#">구매후기 쓰기</a>
					<span class="deadline">작성기한: 2020.12.02까지</span>
				</li>
				<li>
					<a href="http://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=1901220587">
						<img src="./detail1.jpg">
					</a>
					<span class="itemname">물티슈 썸머튜브패턴(10매) (25014223)</span>
					<span class="itemname"> </span>
					<span class="itemamt">
						<span class="itemprice sale_N">600원</span>
					</span>
					<a class="btnWrite modal" href="#">구매후기 쓰기</a>
					<span class="deadline">작성기한: 2020.12.02까지</span>
				</li>
				<li>
					<div class="paging">
						<span class="box">
							<a href="#"> <img class="opacity" src="../Images/order/btn_board_prev.gif"> </a>
							<a href="#" class="btn_pageon">1</a>
							<a href="#">2</a>
							<a href="#"> <img class="paging_pc" src="../Images/order/btn_board_next.gif"> </a>
						</span>
					</div>
				</li>
			</ul>
			<div class="clear"></div>
		</div>
		<div class="full-screen">
			<div class="full-screen-close"></div>
			<div class="review-overlay">
			<form action="reviewWrite.item" method="post" enctype="multipart/form-data" onsubmit="return reviewcheck()">
				<div class="overlay-header">상품후기 작성하기<input class="overlay-close" type="button" value=""></div>
				<div class="overlay-body">
					<input type="hidden" name="product_num" value="1">
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
			            alert($(this).attr("value"));
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
							<img id="blah1" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img1" onchange="readURL(this,1);" />
						</label>
						<label>
							<img id="blah2" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img2" onchange="readURL(this,2);" />
						</label>
						<label>
							<img id="blah3" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img3" onchange="readURL(this,3);" />
						</label>
						<label>
							<img id="blah4" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img4" onchange="readURL(this,4);" />
						</label>
						<label>
							<img id="blah5" src="${pageContext.request.contextPath}/Images/item/img_uploadimage.png" alt=" " class="preview" title="선택된 파일 없음"/>
							<input type='file' name="review_img5" onchange="readURL(this,5);" />
						</label>
						<div class="etc">*이미지는 jpg와 png 형식만 가능합니다</div>
					</div>
				</div>
				<div class="overlay-footer">
					<input class="regist" type="submit" value="등록하기">
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
					$("#blah"+x).attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
					$("#blah"+x).attr('title', "선택된 파일 없음");
					input.value="";	
				}else{
					var reader = new FileReader();
					reader.onload = function (e) {
						$("#blah"+x).attr('src', "${pageContext.request.contextPath}/Images/item/BE.jpg");
						$("#blah"+x).attr('src', e.target.result);
						$("#blah"+x).attr('title', "");
					}
					reader.readAsDataURL(input.files[0]);
				}
			}else{
				$("#blah"+x).attr('src', "${pageContext.request.contextPath}/Images/item/img_uploadimage.png");
				$("#blah"+x).attr('title', "선택된 파일 없음");
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