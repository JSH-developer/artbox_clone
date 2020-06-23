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
			<div>
				<input type="file" id='upload' name='upload'>
				<div id='preview'> </div>
			</div>
		</div>
		<script type="text/javascript">
    		var upload = document.querySelector('#upload');
   			var preview = document.querySelector('#preview');
 
    		upload.addEventListener('change',function (e) {
        		var get_file = e.target.files;
 
        		var image = document.createElement('img');
 
        		/* FileReader 객체 생성 */
        		var reader = new FileReader();
 
        		/* reader 시작시 함수 구현 */
        		reader.onload = (function (aImg) {
            		console.log(1);
 
            		return function (e) {
                		console.log(3);
                		/* base64 인코딩 된 스트링 데이터 */
                		aImg.src = e.target.result
            		}
        		})(image)
 
        		if(get_file){
            /*  get_file[0] 을 읽어서 read 행위가 종료되면 loadend 이벤트가 트리거 되고 
                onload 에 설정했던 return 으로 넘어간다.
				이와 함게 base64 인코딩 된 스트링 데이터가 result 속성에 담겨진다.
            */
            reader.readAsDataURL(get_file[0]);
            console.log(2);
        }
 
        preview.appendChild(image);
    })
	</script>
	</div>
	<!-- /메인 콘텐츠  -->
	<!--  푸터 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
	<!--  /푸터 -->
</body>
</html>