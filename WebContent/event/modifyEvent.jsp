<%@page import="vo.EventBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%EventBean eventArticle=(EventBean)request.getAttribute("eventArticle"); %>


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
<script type="text/javascript">
$(document).ready(function(){
	$("#event_condition option").each(function() {
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
	
})
</script>
<!-- registProduct 페이지에 대한 전용 css, 딴 css 필요없음!!!!!! -->
<link href="${pageContext.request.contextPath}/css/admin/registProduct.css" rel="stylesheet" type="text/css">

</head>
<body>

<!-- 헤더 -->
    <jsp:include page="/inc/top.jsp"></jsp:include>
 <!-- 헤더 -->

 <div class="pageContent">
<div class="admin_nav_wrap">
<ul class="admin_nav">
	<li><a href="Home.admin">관리자 홈</a></li>
	<li><a href="#">상품 목록</a></li>
 	<li><a href="#">상품 등록</a></li>
 	<li><a href="#">상품 수정</a></li>
</ul>
</div>
<br>

<h1>이벤트 수정</h1>
<form action="EventModifyPro.event" method="post" enctype="multipart/form-data">
<table class="reg_tab">
	<tr><th>이벤트 제목</th><td><input type="text" name="event_title" value="${eventArticle.event_titie}"></td></tr>
	<tr><th>이벤트 내용</th><td style="margin-left:100px"><textarea id="summernote" name="event_content" value="${eventArticle.event_content}"></textarea></td></tr>
	<tr><th>이벤트 할인%</th><td><input type="text" name="event_discount" value="<%=eventArticle.getEvent_discount() %>"></td></tr>
	<tr><th>이벤트 조건</th><td><select id="event_condition" name="event_condition"><option value="${eventArticle.event_condition}" selected>${eventArticle.event_condition}</option>${categorySelectList}</select></td></tr>
	<tr><th>이벤트 시작일</th><td><input type="date" name="event_start" value="${eventArticle.event_start}"></td></tr>
	<tr><th>이벤트 마감일</th><td><input type="date" name="event_limit" value="${eventArticle.event_limit}"></td></tr>
	<tr><th>대표 이미지</th><td><input type="file" name="event_img" accept="image/*" value="${eventArticle.event_img}"></td></tr>
	<tr><th>이벤트 카테고리</th><td><select name="event_category">
    	<option value="${eventArticle.event_category}" selected>${eventArticle.event_category}</option>
    	<option value="sale_event">세일 이벤트</option>
   		<option value="coup_event">쿠폰 이벤트</option></select></td></tr>
	<tr class="btn_tr"><td colspan="2"><input type="submit" value="이벤트 등록"></td></tr>
</table>
<input type="hidden" name="event_num" value="${eventArticle.event_num} %>">
</form>
</div>
<p><% out.print(request.getRealPath("/upload")); %></p>

 <!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>