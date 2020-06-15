<%@page import="vo.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String categorySelectList = (String)request.getAttribute("categorySelectList");
String optionSelectList = (String)request.getAttribute("optionSelectList");
ProductBean productBean = (ProductBean)request.getAttribute("productBean");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#category_code").val('<%=productBean.getProduct_category_code()%>').attr("selected","selected");
	
	var optCode= "<%=productBean.getProduct_option_code()%>"
	
	if(optCode.substring(3) == "00" ){
		$("#option_code").attr("disabled","disabled");
	}else{
		$("#option_code").val('<%=productBean.getProduct_option_code()%>').attr("selected","selected");
		$("select[name='product_option_code'] option[value='00']").remove();
	}
	
	$("#modfSubmit").click(function(){
		$("#option_code").removeAttr("disabled")
	})
	

})
</script>

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
	<li><a href="home.admin">관리자 홈</a></li>
	<li><a href="ProductList.admin">상품 목록</a></li>
</ul>
</div>
<br>

<h1>상품등록</h1>
<form action="ProductModifyPro.admin" method="post" enctype="multipart/form-data">
	<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
	<input type="hidden" name="page" value="<%=request.getParameter("page")%>">
<table class="reg_tab">
	<tr><th>상품카테고리</th><td><select id="category_code" name="product_category_code"><%=categorySelectList %></select></td></tr>
	<tr><th>상품옵션</th><td><select id="option_code" name="product_option_code"><option value="00">기본옵션(+0)</option><%=optionSelectList %></select></td></tr>
	<input type="hidden" name="product_option_code_origin" value=<%=productBean.getProduct_option_code() %>>
	<tr><th>상품명</th><td><input type="text" name="product_name" value="<%=productBean.getProduct_name()%>"></td></tr>
	<tr><th>브랜드</th><td><input type="text" name="product_brand" value="<%=productBean.getProduct_brand()%>"></td></tr>
	<tr><th>상품가격</th><td><input type="text" name="product_price" value="<%=productBean.getProduct_price()%>"></td></tr>
	<tr><th>상품상세</th><td style="margin-left:100px"><textarea id="summernote" name="product_description"><%=productBean.getProduct_description()%></textarea></td></tr>
	<tr><th>재고수량</th><td><input type="number" name="product_stock_count" value="<%=productBean.getProduct_stock_count()%>"></td></tr>
	<tr><th>세일가격</th><td><input type="text" name="product_sale_price" value="<%=productBean.getProduct_sale_price()%>"></td></tr>
	<tr><!--<th>대표 이미지</th>--><td colspan="2"><input type="hidden" name="product_image" accept="image/*" value="<%=productBean.getProduct_image()%>"></td></tr>
	<tr><td colspan="2"> 대표이미지는 아직 변경할 수 없어요 ㅠ </td></tr>
	<tr><!--<th>대표 이미지2</th>--><td colspan="2"><input type="hidden" name="product_image2" accept="image/*" value="<%=productBean.getProduct_image2()%>"></td></tr>
	<tr><th>키워드 입력</th><td><input type="text" name="product_keywords" placeholder=" ex) #키워드1 #키워드2" value="<%=productBean.getProduct_keywords()%>"></td></tr>
	<tr class="btn_tr"><td colspan="2"><input id="modfSubmit" type="submit" value="상품수정"></td></tr>
</table>
</form>
</div>

 <!--  푸터 -->
 <jsp:include page="/inc/bottom.jsp"></jsp:include>
 <!--  푸터 -->

</body>
</html>