<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>ARTBOX(포트폴리오)</title>
    <link href="../css/item/itemDetail.css" rel="stylesheet" type="text/css">
    <link href="../css/front.css" rel="stylesheet" type="text/css">
</head>

<body>
    <div class="page">
        <!-- 헤더 -->
        <jsp:include page="../inc/top.jsp"></jsp:include>
        <!-- 헤더 -->

        <!-- 메인 콘텐츠  -->
        <div class="pageContent">
            <div class="wrap">
                <section class="iteminfo">
                    <div class="slideimg">
                        <ul>
                            <li><img src=detail1.jpg></li>
                        </ul>
                    </div>
                    <div class="inner">
                        <div class="pdtName">클래식 캔디머신 (베이비핑크)(53008340)</div>
                        <div class="pdtCategory line"><a href="#">인형/토이</a><a href="#">FUN/TOY</a></div>
                        <div class="pdtInfo"><span>판매가</span>8500원</div>
                        <div class="pdtInfo"><span>배송비</span>2500원</div>
                        <div class="pdtInfo"><span>꿈캔디</span>58개</div>
                        <div class="pdtInfo"><span>상품코드</span>1805300328</div>
                        <div class="pdtInfo line"><span>OK캐쉬백</span>1% 적립</div>
                        <div class="pdtInfo line"><span>주문수량</span>
                            <span class="ipt_layer">
                                <input type="button" class="btnStockQty Minus" value="-">
                                <input type="button" class="btnStockQty Plus" value="+">
                                <input type="tel" name="stockqty" value="1" maxlength="3">
                            </span>
                        </div>
                        <div class="pdtInfototal">총 합계금액<b>5,800 원</b></div>
                        <div class="pdtBtnList">
                            <span class="btnCart"><input type="button" value="장바구니 담기"></span>
                            <span class="btnOrder"><input type="button" value="바로 구매하기"></span>
                            <span class="btnWish off"></span>
                            <span class="btnOverlay btnShare" data="btnShare"></span>
                        </div>
                    </div>
                </section>

                <section class="item_another">
                    <span class="text">이 상품의 다른 옵션</span>
                    <div class="another">
                        <ul>
                            <li onclick='location.href="#"'>
                                <img src="http://www.poom.co.kr/Upload2/Product/201805/1805300288_detail1.jpg">
                                <span class="itemname">베이비 캔디머신 (레드)(53008338)</span>
                                <span class="itemprice">4,900원</span>
                            </li>
                            <li onclick='location.href="#"'>
                                <img src="http://www.poom.co.kr/Upload2/Product/201805/1805300305_detail1.jpg">
                                <span class="itemname">베이비 캔디머신 (네이비)(53008339)</span>
                                <span class="itemprice">4,900원</span>
                            </li>
                            <li onclick='location.href="#"'>
                                <img src="http://www.poom.co.kr/Upload2/Product/201805/1805300332_detail1.jpg">
                                <span class="itemname">클래식 캔디머신 (베이비블루)(53008341)</span>
                                <span class="itemprice">4,900원</span>
                            </li>
                        </ul>
                    </div>
                </section>

                <section class="item_content_bar">
                    <div class="tabBar">
                        <span class="on">상품상세</span>
                        <span>상품후기(2)</span>
                        <span>상품Q&amp;A(2)</span>
                    </div>
                </section>

                <section class="item_content on">
                    <div class="contentsTopTop">클래식 캔디머신 (베이비핑크)(53008340)</div>
                    <div style="margin: 0 auto; width: 37px; height: 3px; background-color: #000000;"></div>
                    <div class="contentsTopBottom">
                        사탕이나 초코볼 등을 가득 담아놓고 뽑아 먹는 재미가 쏠쏠한 베이비 캔디머신입니다.<br>
                        연인, 친구, 가족 등 사랑하는 사람들에게 사탕, 초코볼, 젤리 등 달콤함을 가득 담아 선물해보세요!<br>
                    </div>
                    <div class="content">
                        <img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503601355265.jpg">
                        <img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503602276476.jpg">
                        <img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503600209719.jpg">
                        <img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503599165375.jpg">
                        <img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503597933043.jpg">
                        <img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503595754264.jpg">
                        <img src="http://www.poom.co.kr/Upload2/Event/Img/poom18530503596887597.jpg">
                        <span>Copyright ⓒ ARTBOX ALL rights reserved.</div>
            </div>
            </section>


        </div>
        <!-- 메인 콘텐츠  -->

        <!--  푸터 -->
        <jsp:include page="../inc/bottom.jsp"></jsp:include>
        <!--  푸터 -->
    </div>
</body>

</html>