<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script>
$(document).ready(function() {
	 jQuery.noConflict();
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 600,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '상품에 대한 정보를 입력해주세요'	//placeholder 설정
          
	});
});
</script>

<!-- registProduct 페이지에 대한 전용 css, 딴 css 필요없음!!!!!! -->
<link href="../css/admin/registProduct.css" rel="stylesheet" type="text/css">

</head>
<body>

<!-- 헤더 -->
    <jsp:include page="../inc/top.jsp"></jsp:include>
 <!-- 헤더 -->

<center>
<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="adminHome.jsp">관리자 홈</a></li>
	<li><a href="#">상품목록</a></li>
 	<li><a href="#">상품등록</a></li>
</ul>
</div>
<br>

<h1>상품등록</h1>
<form>
<table class="reg_tab">
	<tr><th>상품카테고리</th><td><select><option>1</option></select></td></tr>
	<tr><th>상품옵션</th><td><select><option>1</option></select></td></tr>
	<tr><th>상품명</th><td><input type="text"></td></tr>
	<tr><th>상품코드</th><td><input type="text"></td></tr>
	<tr><th>브랜드</th><td><input type="text"></td></tr>
	<tr><th>상품가격</th><td><input type="text"></td></tr>
	<tr><th>상품상세</th><td style="margin-left:100px"><textarea id="summernote" name="editordata"></textarea></td></tr>
	<tr><th>대표 이미지</th><td><input type="file"></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="submit" value="상품등록"></td></tr>
</table>
</form>
</center>


 <!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>