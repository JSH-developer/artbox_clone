<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
    <title>

    </title>
    <script src="https://kit.fontawesome.com/b2b991ccfb.js" crossorigin="anonymous"></script>
<style>
    .container{
        width: 1000px;
        margin: 0 auto;
        max-width: 1200px;;}
    .info{position: relative;height: 38px;padding: 20px 0px;}
    .info .select_box{
        float: right;
        
    }
    .select_box select{
        border: 1px solid black;
        border-radius: 5px;
        height: 38px;
        width: 140px;
    }
    
    .category{height: 25px;margin-top: 20px;}
    .category .category_menu{
        position: relative;
    }
    .category span a{
        color: #999999;
        display: inline-block;
        font-size: 13px;
        height: 100%;
        text-decoration: none;
        line-height: 100%;
    }
    .category span{
        padding: 0px 15px;
    }
    .category .category_menu::before{
        position: absolute;
        display: block;
        content: " ";
        left: 0;
        top: 0;
        bottom: 0;
        width: 1px;
        background-color: #999999;
    }
    .head_img{
        background-image: url('cate-img.png');
        background-repeat: no-repeat;
        background-size: cover;
        height: 300px;
    }
    .ul_list li{
        list-style: none;
        float: left;
        padding-bottom: 30px;
    }
    .total_count{
        position: absolute;
        left: 30px;
    }
    .total_count b{
        font-size: 25px;
    }
    .item_list{
        background-color: turquoise;
        display: block;
        margin: 0 auto;
        text-align: center;
    }
    
    .item_list .item a{
        text-decoration: none;
        cursor: pointer;
    }
    .item_list .item span{
        display: block;
        content: ' ';
    }
    .item_list .item_img{
        width:215px; height:215px;
    }
    .item_list .shopping_basket{
        position: relative;
        overflow: hidden;
    }
    .item_list .shopping_basket .shopping_basket_icon{
        width: 215px;
        height: 60px;
        position: absolute;
        top: 150%;
        transition: all .35s;
        background:rgba(0, 0, 0, .3);
        font-size: 2em;
        color:white;
        letter-spacing: 10px;
    }
    .item_list .ul_list .item a:hover .shopping_basket_icon{
        top: 70%;
    }
    .paging{
        padding-top: 50px;
        height: 50px;
        display: block;
        margin: 0 auto;
        clear: both;
        text-align: center;
    }
    .pager-left_box, .pager-right_box{
        position: relative;
        display: inline-block;
        margin:0 10px;
        width: 35px;
        height: 35px;
        background-color: transparent;
        border: 1px solid #999999;
        border-radius: 5px;
        cursor: pointer;
    }
    .pager-left_box::before, .pager-left_box::after, .pager-right_box::after, .pager-right_box::before{
        content: ' ';
        display: inline-block;
        width: 2px;
        height: 15px;
        background-color: #999999;
        position: absolute;
        transform-origin: left top;
    }
    .pager-left_box::before{
        top: 18px;
        left: 11px;
        transform:rotate(-135deg);
    }
    .pager-left_box::after{
        top: 17px;
        left: 9.5px;
        transform: rotate(-45deg);
    }
    .pager-right_box::before{
        top: 18px;
        right: 8.5px;
        transform:rotate(135deg);
    }
    .pager-right_box::after{
        top: 17px;
        right: 10px;
        transform: rotate(45deg);
    }
    .paging span{
        cursor: pointer;
    }
    .paging span a{
        text-decoration: none;
        font-size: 19px;
        display: inline-block;
        margin:0 5px 30px 10px;
        line-height: 15px;
        vertical-align: middle;
    }
    
</style>
</head>
<body>
<div class="container">
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
                        &nbsp;    <!-- 기본값으로 공백 꼭 들어가야함 -->
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
</body>