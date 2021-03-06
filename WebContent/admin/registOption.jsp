<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#product_category_code option").each(function() {
		var text = $(this).text();
		
		if(text.indexOf('DT') != -1) {
			$(this).html(text.replace('DT', '인형/토이'));
		}else if(text.indexOf('FA') != -1) {
			$(this).html(text.replace('FA', '문구'));	
		}else if(text.indexOf('FS') != -1){
			$(this).html(text.replace('FS', '패션'));
		}else if(text.indexOf('KB') != -1){
			$(this).html(text.replace('KB', '주방/욕실'));
		}else if(text.indexOf('LD') != -1){
			$(this).html(text.replace('LD', '리빙/데코'));
		}else if(text.indexOf('DI') != -1){
			$(this).html(text.replace('DI', '디지털/가전'));
		}else if(text.indexOf('TR') != -1){
			$(this).html(text.replace('TR', '여행'));
		}else if(text.indexOf('BE') != -1){
			$(this).html(text.replace('BE', '뷰티'));	
		}
		
		});
	
	
	// 검색 기능 추가
	$(".search_space").css("display","none");
	$(".search_btn1").click(function(){
		$(".search_space").toggle();
	});
	
	var search = "";
	$("#search_product").keydown(function(key) { 
		search = $(this).val();
		if (key.keyCode == 13) {
		$('#prod_list option').each(function(){
			if(search == ""){
				$(this).css('display','block');
			}else if (!$(this).text().match(search)) {
				$(this).css('display','none');
			} 
		});	
		}else if(search.length <= 1){
			$('#prod_list option').each(function(){
				$(this).css('display','block');
			});	
		}
	});
	
	$(".search_btn2").click(function(){
		search = $("#search_product").val();
		$('#prod_list option').each(function(){
			if(search == ""){
				$(this).css('display','block');
			}else if (!$(this).text().match(search)) {
				$(this).css('display','none');
			} 
		});	
	});
	
	 
})
</script>

<!-- 구글 폰트  -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script>

/* summernote에서 이미지 업로드시 실행할 함수 */
function sendFile(file, editor) {
   // 파일 전송을 위한 폼생성
	data = new FormData();
    data.append("uploadFile", file);
    $.ajax({ // ajax를 통해 파일 업로드 처리
        data : data,
        type : "POST",
        url : "admin/summernote_imageUpload.jsp",
        cache : false,
        contentType : false,
        processData : false,
        success : function(data) { // 처리가 성공할 경우
           // 에디터에 이미지 출력
//         	$(editor).summernote('editor.insertImage', data.url);
        	var image = $('<img>').attr('src', '' + data.url.replace('..\\', '')).attr('style',"width:500px; hieght:500px;"); // 에디터에 img 태그로 저장을 하기 위함
            $('#summernote').summernote("insertNode", image[0]); // summernote 에디터에 img 태그를 보여줌
        }
    });
};

$(document).ready(function() {
	jQuery.noConflict();
  $('#summernote').summernote({
      placeholder: '',
      height: 600,
      callbacks: { // 콜백을 사용
          // 이미지를 업로드할 경우 이벤트를 발생
		    onImageUpload: function(files, editor, welEditable) {
			    sendFile(files[0], this);
			}
  		},
      lang: 'ko-KR',
      toolbar: [
                  // [groupName, [list of button]]
                  ['Font Style', ['fontname']],
                  ['style', ['bold', 'italic', 'underline']],
                  ['font', ['strikethrough']],
                  ['fontsize', ['fontsize']],
                  ['color', ['color']],
                  ['para', ['paragraph']],
                  ['height', ['height']],
                  ['Insert', ['picture']],
                  ['Insert', ['link']],
                  ['Misc', ['fullscreen']]
               ]
  });
});

</script>

<link href="${pageContext.request.contextPath}/css/admin/adminRegist.css" rel="stylesheet" type="text/css">
</head>
<body>

<!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->
  <c:choose>
<c:when test="${empty grade}">
	<script>
		alert("관리자만 접근이 가능한 페이지입니다.");
		location.href="Home.home";
	</script>
</c:when>
<c:otherwise>
	<c:if test="${grade ne 'ADMIN'}">
	<script>
		alert("관리자만 접근이 가능한 페이지입니다.");
		location.href="Home.home";
	</script>
	</c:if>
</c:otherwise>
</c:choose> 

<div class="pageContent">

<h1 class="registTitle">옵션 상품 등록</h1>
<form action="OptionWritePro.admin" method="post" enctype="multipart/form-data">
<table class="reg_tab">
	<tr><th>상품 검색</th><td><select name="product_code_base" id="prod_list"><c:out value="${productSelectList}" escapeXml="false"/></select><input type="button" class="search_btn1" value="검색사용"></td></tr>
	<tr class="search_space"><th>&nbsp;</th><td><input type="text" id="search_product" placeholder="검색어를 입력해주세요"><input type="button" class="search_btn2" value="검색하기"></td></tr>
	<tr><th>상품명</th><td><input type="text" name="product_name" required></td></tr>
	<tr><th>옵션 설명</th><td><input name="option_name" type="text" placeholder="옵션명을 입력해주세요" style="padding-left:5px " required></td></tr>
	<tr><th>추가 가격</th><td><input name="add_price" type="text" placeholder="추가금액을 입력해주세요" style="padding-left:5px " required></td></tr>
	<tr><th>상품상세</th><td style="margin-left:100px"><textarea id="summernote" name="product_description" required></textarea></td></tr>
	<tr><th>재고수량</th><td><input type="number" name="product_stock_count" required></td></tr>
	<tr><th>세일가격</th><td><input type="text" name="product_sale_price" required></td></tr>
	<tr><th>대표 이미지</th><td><input type="file" name="product_image" accept="image/*" required></td></tr>
	<tr><th>대표 이미지2</th><td><input type="file" name="product_image2" accept="image/*" required></td></tr>
	<tr><th>키워드 입력</th><td><input type="text" name="product_keywords" placeholder=" ex) #키워드1 #키워드2" required></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="button" value="돌아가기" onclick="history.back();"><input type="submit" value="옵션 등록"></td></tr>
</table>
</form>
</div>


 <!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>