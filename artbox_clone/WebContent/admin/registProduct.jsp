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

/* summernote에서 이미지 업로드시 실행할 함수 */
function sendFile(file, editor) {
   // 파일 전송을 위한 폼생성
	data = new FormData();
    data.append("uploadFile", file);
    $.ajax({ // ajax를 통해 파일 업로드 처리
        data : data,
        type : "POST",
        url : "summernote_imageUpload.jsp",
        cache : false,
        contentType : false,
        processData : false,
        success : function(data) { // 처리가 성공할 경우
           // 에디터에 이미지 출력
//         	$(editor).summernote('editor.insertImage', data.url);
        	var image = $('<img>').attr('src', '' + data.url).attr('style',"width:500px; hieght:500px;"); // 에디터에 img 태그로 저장을 하기 위함
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
	<li><a href="#">상품 목록</a></li>
 	<li><a href="#">상품 등록</a></li>
 	<li><a href="#">상품 수정</a></li>
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
<p><% out.print(request.getRealPath("/upload")); %></p>

 <!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>