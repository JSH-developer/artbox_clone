<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
    <link href="${pageContext.request.contextPath}/css/item/itemReview.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
</head>
<body>
<% %>
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
				<li>
					<a href="http://www.artboxmall.com/home/shop/itemdetail.asp?itemidx=1901220587">
						<img src="./detail1.jpg">
					</a>
					<span class="itemname">물티슈 썸머튜브패턴(10매) (25014223)</span>
					<span class="itemname"> </span>
					<span class="itemamt">
						<span class="itemprice sale_N">600원</span>
					</span>
					<a class="btnWrite" href="#">구매후기 쓰기</a>
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
					<a class="btnWrite" href="#">구매후기 쓰기</a>
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
					<a class="btnWrite" href="#">구매후기 쓰기</a>
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
					<a class="btnWrite" href="#">구매후기 쓰기</a>
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
					<a class="btnWrite" href="#">구매후기 쓰기</a>
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
					<a class="btnWrite" href="#">구매후기 쓰기</a>
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
				<div class="overlay-header">상품후기 작성하기<input class="overlay-close" type="button" value=""></div>
				<div class="overlay-body">
					<img class="candy-img" src="${pageContext.request.contextPath}/Images/item/img_epilogue_bg.png">
					<div class="input">
						<span class="tt">별점</span>
						<span class="score"><span>기능</span><b value="1">★</b> <b value="2">★</b> <b value="3">★</b> <b value="4">★</b> <b value="5">★</b></span>
						<span class="score"><span>디자인</span><b value="1">★</b> <b value="2">★</b> <b value="3">★</b> <b value="4">★</b> <b value="5">★</b></span>
						<span class="score"><span>가격</span><b value="1">★</b> <b value="2">★</b> <b value="3">★</b> <b value="4">★</b> <b value="5">★</b></span>
						<span class="score"><span>품질</span><b value="1">★</b> <b value="2">★</b> <b value="3">★</b> <b value="4">★</b> <b value="5">★</b></span>
					</div>
					<script type="text/javascript">
			        $('.input b').click(function(){
			            $(this).parent().children("b").removeClass("on");  /* 별점의 on 클래스 전부 제거 */ 
			            $(this).addClass("on").prevAll("b").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
			            alert($(this).attr("value"));
			            return false;
			        });
					</script>
					<div class="input">
						<span class="tt">내용</span>
						<textarea placeholder="- 구매/취소/반품하신 상품과 무관한 내용이나 이미지, 비방, 도배성 글 등 부적합한 내용일 때는 통보없이 삭제 및 지급된 꿈캔디가 회수될 수 있습니다."></textarea>
					</div>
					<div class="input">
						<span class="tt">이미지 파일</span>
						&nbsp;&nbsp;&nbsp;${sessionScope.id }
					</div>
					<span class="tt">이메일 주소</span>
					<input type="text" name="email" value="" maxlength="30">
				</div>
				<div class="input">
					<span class="tt">문의분야</span>
					<select name="fild">
						<option value="" selected="selected">선택하세요</option>
						<option value="입고">입고</option>
						<option value="재고">재고</option>
						<option value="기타">기타</option>
					</select>
				</div>
				<div class="input">
					<span class="tt">제목</span>
					<input type="text" name="title" value="" maxlength="30">
				</div>
				<div class="input">
					<span class="tt">문의내용</span>
					<textarea name="content"></textarea>
					<span class="etc">*주문/배송/반품 등 일반 문의는 '고객감동센터 &gt; 1:1 문의/상담'으로 해주시기 바랍니다.</span>
				</div>
				<div class="PrivacyCheck">
					<b>개인정보 수집 및 이용에 동의합니다. <input type="checkbox" name="privacycheck1"></b>
					<p>(주)아트박스에서는 고객상담을 목적으로 개인정보(이름, 휴대폰번호, 이메일)를 수집하며, 수집한 개인정보는 전자상거래 등에서의 소비자보호에 관한 법률에 의거 상담 접수일로부터 3년 또는 5년간 보관 후 파기 합니다. 동의 거부 시 상담이 제한되거나 거부될 수 있습니다.</p>
					<b>제 3자 정보 제공에 동의합니다. <input type="checkbox" name="privacycheck2"></b>
					<p>(주)아트박스에서 고객상담을 목적으로 (주)웅진에 개인정보(이름, 휴대폰번호, 이메일)를 제공하며, 제공한 개인정보는 전자상거래 등에서의 소비자보호에 관한 법률에 의거 상담 접수일로 부터 3년 또는 5년간 보관 후 파기 합니다. 동의 거부 시 상담이 제한되거나 거부될 수 있습니다.</p>
				</div>
				<div class="button">
					<input class="btnRegProductQna" type="submit" value="등록하기">
				</div>
				<div class="clear"></div>
				<label>
					<img id="blah1" src="../Images/item/img_arrow_left.png" alt="" class="im" title="선택된 파일 없음"/>
					<input type='file' onchange="readURL(this,1);" />
				</label>
				<label>
					<img id="blah2" src="../Images/item/img_arrow_left.png" alt="" class="im" title="선택된 파일 없음"/>
					<input type='file' onchange="readURL(this,2);" />
				</label>
				<label>
					<img id="blah3" src="../Images/item/img_arrow_left.png" alt="" class="im" title="선택된 파일 없음"/>
					<input type='file' onchange="readURL(this,3);" />
				</label>
				<label>
					<img id="blah4" src="../Images/item/img_arrow_left.png" alt="" class="im" title="선택된 파일 없음"/>
					<input type='file' onchange="readURL(this,4);" />
				</label>
			</div>
		</div>
	<script type="text/javascript">
		function readURL(input,x) {
			alert(input.value);
			strArray = input.value.split(".");
			strArrayLength = strArray.length -1;
			FileType = strArray[strArrayLength].toLowerCase();
	
			if (input.files && input.files[0]) {
				if (FileType != "jpg" && FileType != "png" && FileType != "jpeg"){
					alert("jpg 또는 png파일만 업로드 가능합니다." + FileType);
					$("#blah"+x).attr('src', "../Images/item/img_arrow_left.png");
					$("#blah"+x).attr('title', "선택된 파일 없음");
					input.value="";	
				}else{
					var reader = new FileReader();
					reader.onload = function (e) {
						$("#blah"+x).attr('src', e.target.result);
						$("#blah"+x).attr('title', "");
					}
					reader.readAsDataURL(input.files[0]);
				}
			}else{
					$("#blah"+x).attr('src', "../Images/item/img_arrow_left.png");
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