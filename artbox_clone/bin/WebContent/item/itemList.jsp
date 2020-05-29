<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="../css/item/itemList.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
    <div class="content">
        <div class="head_img">

        </div>
        <div class="category">
            <span><a href="">전체</a></span>
            <span class="category_menu"><a href="">텀블러</a></span>
            <span class="category_menu"><a href="">컴/머그/잔</a></span>
            <span class="category_menu"><a href="">술잔</a></span>
            <span class="category_menu"><a href="">도시락</a></span>
            <span class="category_menu"><a href="">기타 주방용품</a></span>
            <span class="category_menu"><a href="">푸드</a></span>
            <span class="category_menu"><a href="">칫솔케이스/살균기</a></span>
            <span class="category_menu"><a href="">욕실용품</a></span>
        </div>

        <div class="info">
            <span class="total_count">
                <p>총 <b>300</b>개의 상품이 조회되었습니다.</p>
            </span>
            <span class="select_box">
                <select>
                    <option>
                        신상품순
                    </option>
                    <option>
                        인기상품순
                    </option>
                    <option>
                        낮은가격순
                    </option>
                    <option>
                        높은가격순
                    </option>
                    <option>
                        높은할인율순
                    </option>
                    <option>
                        상품평순
                    </option>

                </select>
            </span>
        </div>

        <div class="item_list">
            <ul class="ul_list">
                <li>
                    <span class="item">
                        <a href="">
                            <div class="shopping_basket">
                                <div class="shopping_basket_icon">
                                    <i class="far fa-heart"></i>
                                    <i class="fas fa-shopping-cart"></i>
                                    <i class="far fa-comment-dots"></i>
                                </div>
                                <img src="detail1.jpg" class="item_img">
                            </div>
                            <p>
                                상품제모오오오옥
                            </p>
                        </a>
                        <span>
                            상품가격 원
                        </span>
                        <span>
                            &nbsp;
                            <!-- 기본값으로 공백 꼭 들어가야함 -->
                        </span>
                    </span>
                </li>
            </ul>
        </div>

        <div class="paging">
            <a href=""><span class="pager-left_box"></span></a>
            <span class="page_num"><a href="">1</a></span>
            <a href=""><span class="pager-right_box"></span></a>
        </div>
    </div>
 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>
