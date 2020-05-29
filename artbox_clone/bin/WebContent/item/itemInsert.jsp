<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>ARTBOX(포트폴리오)</title>
    <link href="../css/front.css" rel="stylesheet" type="text/css">
</head>

<body>
    <div class="page">
        <!-- 헤더 -->
        <jsp:include page="../inc/top.jsp"></jsp:include>
        <!-- 헤더 -->

        <!-- 메인 콘텐츠  -->
        <div class="pageContent">
            <form action="" method="POST" enctype="multipart/form-data">
            <input type="text" class="itemName" placeholder="상품명">
            <input type="text" class="itemCode" placeholder="상품코드">
            <input type="text" class="itemPrice" placeholder="상품가격">
            <input type="text" class="itemAmount" placeholder="상품수량">

            </form>

            <p>

                상품명 :
                상품 코드 :
                상품 카테고리 :
                상품 판매가 :
                상품 할인율? :
                상품 배송비?? :
                상품 수량 :

                상품 소개 링크(영상 등) :
                상품 소개 텍스트 :
                상품 인덱스 이미지 :
                상품 바디 이미지 :

            </p>


        </div>
        <!-- 메인 콘텐츠  -->

        <!--  푸터 -->
        <jsp:include page="../inc/bottom.jsp"></jsp:include>
        <!--  푸터 -->
    </div>
</body>

</html>