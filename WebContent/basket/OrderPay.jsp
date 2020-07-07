<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/order/Order.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script> <!-- 결제연동 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 우편번호찾기 API -->
<script src="https://code.jquery.com/jquery-latest.js"></script> 

<script type="text/javascript">
$(document).ready(function(){
	

	IMP.init('imp92896832'); // 가맹점식별코드(결제 API 에서 필요)

	/* 배송지 입력 - 직접입력 - 주문고객과 동일 클릭시 자동완성 */
	$("#i_copyorderinfo").click(function(){
		if ($(this).prop("checked")) {
			var ShipName, ShipCpNum1, ShipCpNum2, ShipCpNum3;
			ShipName = $("#i_memname").val();
			ShipCpNum1 = $("#i_memcpnum1").val();
			ShipCpNum2 = $("#i_memcpnum2").val();
			ShipCpNum3 = $("#i_memcpnum3").val();
			$("#i_shipname").val(ShipName);
			$("#i_shipzipcode").val("");
			$("#i_shipaddr").val("");
			$("#i_shipaddrD").val("");
			$("#i_shipcpnum1").val(ShipCpNum1);
			$("#i_shipcpnum2").val(ShipCpNum2);
			$("#i_shipcpnum3").val(ShipCpNum3);
		}
	});

	
	
	$("input[name=UseMileagePrice]").focus(function(){
		TempScrollTop = $(window).scrollTop();
		var inputValue = parseInt($(this).val(), 10);
		if (inputValue == 0) {
			$(this).val("");
		}
		$(window).scrollTop(TempScrollTop);
	});
	
	$("input[name=UseMileagePrice]").blur(function(){
		var Event_350won = $("[name=Event_350won]").val();
		if (Event_350won == "Y") {
			alert("이벤트 상품은 마일리지 사용이 불가합니다.");
			$(this).val("0");
			return false;
		}
		var inputValue = parseInt($(this).val(), 10);
		if (!inputValue) {
			inputValue = 0;
		}
		$(this).val(parseInt(inputValue, 10));
		var maxValue = parseInt($("input[id=UseMileageAll]").attr("alt"), 10);
		var minValue = 0;
		if (inputValue > maxValue) {
			alert("현재 주문에서 사용 가능한 꿈캔디 갯수는 " + maxValue + "개 입니다.");
			if (maxValue <= 0) {
				maxValue = 0;
			}
			$(this).val(maxValue);
		}
		$("input[name=TotalUseMileage]").val($(this).val(),10);
		$("#TotalUseMileage").text("- " + parseInt($(this).val(), 10));
		fnTotalPriceAmount();
	});
	
	// 약관동의 전체선택 및 해제 이벤트
	$("#i_OrderPayAgree").click(function(){
		if ($(this).prop("checked")) { // 전체선택
			$("#i_OrderPayAgree").prop("checked", true);
			$("input[name=OrderAgreeThird]").prop("checked", true);
			$("input[name=OrderAgreePayment]").prop("checked", true);
			$("input[name=OrderAgreeRule]").prop("checked", true);
		} else { // 전체해제
			$("#i_OrderPayAgree").prop("checked", false);
			$("input[name=OrderAgreeThird]").prop("checked", false);
			$("input[name=OrderAgreePayment]").prop("checked", false);
			$("input[name=OrderAgreeRule]").prop("checked", false);
		}
	});
	fnOrderInfoTitle = function(obj, obj2, obj3){
		var PayTypeText;
		if ($("#"+obj).css("display") == "block" ) {
			$("#"+obj).css("display", "none");
			$("#"+obj+"Summary").css("display", "block");
			$("#"+obj+"Arrow").attr("class", "Close");
			if (obj2 != "" && obj3 != "") {
				$("#"+obj3).val($("#"+obj2).val());
			}
		} else {
			$("#"+obj).css("display", "block");
			$("#"+obj+"Summary").css("display", "none");
			$("#"+obj+"Arrow").attr("class", "Open");
		}
	}
	fnTotalDiscountPriceSum = function(){
		var obj = "DiscountPriceInfo";
		if ($("#"+obj).css("display") == "block" ) {
			$("#"+obj).css("display", "none");
			$("#"+obj+"Arrow").attr("class", "Close");
		} else {
			$("#"+obj).css("display", "block");
			$("#"+obj+"Arrow").attr("class", "Open");
		}
	}
	fnDeliveryInfo = function(x){
		if (x==1) {
			$("#DeliveryInfo1").attr("class", "On");
			$("#DeliveryInfo2").attr("class", "Off");
			$("#DeliveryInfo3").attr("class", "Off");
			$("#MyDelivery1").css("display", "block");
			$("#MyDelivery2").css("display", "none");
			$("#MyDelivery3").css("display", "none");
		} else if (x==2) {
			$("#DeliveryInfo1").attr("class", "Off");
			$("#DeliveryInfo2").attr("class", "On");
			$("#DeliveryInfo3").attr("class", "Off");
			$("#MyDelivery1").css("display", "none");
			$("#MyDelivery2").css("display", "block");
			$("#MyDelivery3").css("display", "none");
		} else if (x==3) {
			$("#DeliveryInfo1").attr("class", "Off");
			$("#DeliveryInfo2").attr("class", "Off");
			$("#DeliveryInfo3").attr("class", "On");
			$("#MyDelivery1").css("display", "none");
			$("#MyDelivery2").css("display", "none");
			$("#MyDelivery3").css("display", "block");
		}
	}
	fnSelectMyDelivery = function (obj) {
		if (obj.value) {
			var receiverArr = obj.value.split("||");
			var Receiver, ShipName, ShipPostcode, ShipAddr, ShipAddrD;
			var ShipPhoneArr = receiverArr[2].split("-");
			var ShipPhone1, ShipPhone2, ShipPhone3;

			Receiver = receiverArr[0];
			ShipName = receiverArr[1];
			ShipPhone1 = ShipPhoneArr[0];
			ShipPhone2 = ShipPhoneArr[1];
			ShipPhone3 = ShipPhoneArr[2];
			ShipPostcode = receiverArr[3];
			ShipAddr = receiverArr[4];
			ShipAddrD = receiverArr[5];

			$('#receiver').val(Receiver);
			$("#i_shipname").val(ShipName);
			$("#i_shipzipcode").val(ShipPostcode);
			$("#i_shipaddr").val(ShipAddr);
			$("#i_shipaddrD").val(ShipAddrD);
			$("#i_shipcpnum1").val(ShipPhone1);
			$("#i_shipcpnum2").val(ShipPhone2);
			$("#i_shipcpnum3").val(ShipPhone3);
			$("#i_copyorderinfo").prop("checked", false);
		} else {
			$("#i_shipname").val('');
			$("#i_shipzipcode").val('');
			$("#i_shipaddr").val('');
			$("#i_shipaddrD").val('');
			$("#i_shipcpnum1").val('');
			$("#i_shipcpnum2").val('');
			$("#i_shipcpnum3").val('');
		}
	}

	fnShipAlertDesc = function (obj) {
		if (obj.value) {
			document.Order.shipalertdesc.value = '';
			document.Order.shipalertdesc.value += obj.value + "\n";
		} else {
			document.Order.shipalertdesc.value = '';
		}
	}
	fnCouponSelect = function(obj) {
		var DcNumber = $(obj).find(":selected").attr("alt");
		var MemberCouponIdx = $(obj).find(":selected").val();
		if ($(obj).attr("name") == "BonusCouponIdx") {
			if (DcNumber == "0" && MemberCouponIdx != "") { // DcNumber=0 이면 꿈캔디 적립쿠폰으로 인식
				alert("꿈캔디는 상품 구매 확정 시 자동으로 적립됩니다.");
			}
			$("input[name=TotalUseBonusCoupon]").val(DcNumber);
			$("#TotalUseBonusCoupon").text("- " + parseInt(DcNumber, 10));
			fnTotalPriceAmount();
		} else if ($(obj).attr("name") == "FreeCouponIdx") {
			$("input[name=TotalUseFreeCoupon]").val(DcNumber);
			$("#TotalUseFreeCoupon").text("- " + setComma(parseInt(DcNumber, 10)));
			fnTotalPriceAmount();
		}
	}
	
	fnUseMileageAll = function(x) {
		var UsableMileage;
		if (x==1) {
			if (parseInt($("input[name=MemMileage]").val(), 10) >= parseInt($("input[id=UseMileageAll]").val(), 10)) {
				UsableMileage = $("input[id=UseMileageAll]").val();
			} else {
				UsableMileage = $("input[name=MemMileage]").val();
			}
			if (parseInt(UsableMileage,10) <= 0) {
				UsableMileage = 0;
			}
			$("input[name=UseMileagePrice]").val(UsableMileage);
			$("input[name=TotalUseMileage]").val(UsableMileage);
			$("#TotalUseMileage").text("- " + UsableMileage);
		} else {
			$("input[name=UseMileagePrice]").val("0");
			$("input[name=TotalUseMileage]").val("0");
			$("#TotalUseMileage").text("- " + setComma("0"));
		}
	fnTotalPriceAmount();
	}

	fnInitDiscountTable = function(){

		$("select[name=BonusCouponIdx] option:eq(0)").prop("selected", true); // 보너스쿠폰 초기화, 상품쿠폰 추가시 상품쿠폰 초기화 추가해야 함
		$("select[name=FreeCouponIdx] option:eq(0)").prop("selected", true); // 무료배송쿠폰 초기화

		$("#UseMileageAll").prop("checked", false); // 꿈캔디 초기화
		$("input[name=UseMileagePrice]").val(0);
		$("#TotalUseMileage").text("- 0"); 

		$("input[name=TotalUseBonusCoupon]").val(0); // 실제값들
		$("input[name=TotalUseGoodsCoupon]").val(0);
		$("input[name=TotalUseFreeCoupon]").val(0);

		$("#CouponTypeNull").prop("checked", true);
		$("#CouponIdxSelect_Null").attr("class", "");
		$("#CouponIdxSelect_Bonus").attr("class", "none");
		$("#CouponIdxSelect_Goods").attr("class", "none");

		fnCouponType();
	}

	
	if($("#BasicAddr").is(":checked")) {
		$("#BasicAddr").val(1);
	} else {
		$("#BasicAddr").val(0);
	}
	
//     fnDeliveryInfo(3); // 배송지정보 '직접 입력'을 기본으로 설정
		fnDeliveryInfo(1); // 배송지 정보 - '기본'으로 설정된 배송지를 기본으로 설정
		$("#MyDelivery1 select option:eq(1)").prop("selected", true);
		$("#MyDelivery1 select").trigger("change");
		fnTotalPriceAmount();
});

// 우편번호 (API)
function execDaumPostCode() {
	new daum.Postcode({
		oncomplete: function(data) {
		// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		var addr = ''; // 주소 변수
		if (data.userSelectedType == 'R') { // 사용자가 도로명 주소를 선택했을 경우
			addr = data.roadAddress;
		} else { // 사용자가 지번 주소를 선택했을 경우(J)
			addr = data.jibunAddress;
		}
		// 우편번호와 주소 정보를 해당 필드에 넣는다.
		document.getElementById("i_shipzipcode").value = data.zonecode;
		document.getElementById("i_shipaddr").value = addr;
		// 커서를 상세주소 필드로 이동한다.
		document.getElementById("i_shipaddrD").focus();
		}
	}).open();
	
}
	// 전체 가격 계산
	fnTotalPriceAmount = function(){
		var TotalPriceSum                 = parseInt($("input[name=TotalPriceSum]").val(), 10);
		var TotalPriceDelivery            = parseInt($("input[name=TotalPriceDelivery]").val(), 10);
		var TotalPriceMemberLevelDiscount = parseInt($("input[name=TotalPriceMemberLevelDiscount]").val(), 10);
		var TotalUseMileage               = parseInt($("input[name=TotalUseMileage]").val(),10);
		
		var TotalUseBonusCoupon           = parseInt($("input[name=TotalUseBonusCoupon]").val(), 10);
		var TotalUseGoodsCoupon           = parseInt($("input[name=TotalUseGoodsCoupon]").val(), 10);
		var TotalUseFreeCoupon            = parseInt($("input[name=TotalUseFreeCoupon]").val(), 10);
		
		var TotalPriceAmount = TotalPriceSum+TotalPriceDelivery-TotalPriceMemberLevelDiscount-TotalUseMileage-TotalUseBonusCoupon-TotalUseGoodsCoupon-TotalUseFreeCoupon;
		var TotalMileageAmount = Math.ceil((TotalPriceAmount/100)*parseFloat($("#MemMileageSaveRate").val()));
		if (TotalPriceAmount < 0)
		{
			alert("총 합계금액은 0원 이상이어야 합니다.");
			fnInitDiscountTable();
			return;
		}
		
		$("#TotalDiscountPriceSum").text(setComma(TotalUseBonusCoupon + TotalUseGoodsCoupon + TotalUseFreeCoupon + TotalPriceMemberLevelDiscount));
		$("input[name=RealTotalPrice]").val(TotalPriceAmount);
		$("#TotalPriceAmount").text(setComma(TotalPriceAmount));
		$("#UseMileageAll").val(TotalPriceAmount);
	}
	
	// 팝업 open
	function open_pop(flag) {
	    $('#myModal').show();
	};
	
	// 팝업 Close 기능
	function close_pop(sum) {
		
		var total_sum = document.getElementById("total_sum").value;
		total_sum = parseInt(total_sum);
		
		$("#i_TotalDiscountPriceInfo_summary").val("- " + total_sum + " 원"); // 접혔을 때 할인금액
		$("#i_TotalDiscountPriceInfo").val("- " + total_sum+ " 원"); // 펼쳤을 때 할인금액
		
		fnTotalPriceAmount();
		
		$('#myModal').hide();
		
//	  	var total_sum = document.getElementById("total_sum");
	};
	
	function clear_pop() {
		$("#i_TotalDiscountPriceInfo_summary").val("- " + 0 + " 원"); // 접혔을 때 할인금액
		$("#i_TotalDiscountPriceInfo").val("- " + 0+ " 원"); // 펼쳤을 때 할인금액
		
		$("input[name=TotalUseBonusCoupon]").val(parseInt(0));
		$("#TotalUseBonusCoupon").text("- "+0);
		
		$("input[name=TotalUseGoodsCoupon]").val(parseInt(0));
		$("#TotalUseGoodsCoupon").text("- "+0);
		
		var total_sum = document.getElementById("total_sum").value;
		total_sum = parseInt(0);
		
		fnTotalPriceAmount();
		
		 $('input:checkbox[name="f_couponmemberno"]').each(function() {
			 $('input:checkbox[name=f_couponmemberno]').prop('checked', false);
		 });
		 
		 $('input:radio[name="f_coupongroup"]').each(function() {
			 $('input:radio[name=f_coupongroup]').prop('checked', false);
		 });
		
		 $('#myModal').hide();
	};
	
	// 할인가격 sum
	function sumCouponTotal(b, g){ // sumCouponTotal(bonus, goods)
		var sum = document.getElementById("total_sum");
		if(b == 0){
			sum.value =  parseInt(g);
		}else{
			sum.value =  parseInt(b);
		}
		
		$("input[name=TotalUseBonusCoupon]").val(parseInt(b));
		$("#TotalUseBonusCoupon").text("- "+setComma(b));
		
		$("input[name=TotalUseGoodsCoupon]").val(parseInt(g));
		$("#TotalUseGoodsCoupon").text("- "+setComma(g));
	};
	
	function selectCouponGroup(s){ // 라디오 버튼 선택(bonus)
		// bonus 
		$("#TotalUseGoodsCoupon").text("- 0");
		var total_sum = document.getElementById("bonus_goods");
		var st = $(":input:radio[name=f_coupongroup]:checked").val();
		total_sum.value = 0;
		
		 var select_coupon = document.getElementById("select_coupon");
		 select_coupon.value ="";
		 var c_name= $(":input:radio[name=f_coupongroup]:checked").attr("coup_num");
		 select_coupon.value = c_name;
		
		 
		if(st !="bonus"){ // bonus가 아니면 check 초기화
			 
			 $('input:checkbox[name="f_couponmemberno"]').each(function() {
				 $('input:checkbox[name=f_couponmemberno]').prop('checked', false);
				 
				total_sum.value =parseInt(st);
				sumCouponTotal(st,0);
				
//	 			$("#TotalUseBonusCoupon").text(st);
			 });
		}
		 
	}
		
	function selectCouponMember(s, v){ // check 버튼 선택(goods)
		// goods 
		$('input:radio[name=f_coupongroup]:input[value=' + s + ']').prop("checked", true);
		 $("#TotalUseBonusCoupon").text("- 0");
		 var ch = $(":input:checkbox[id=f_couponmemberno_3_"+v+"]:checked").val();
		 
		 var sum = 0;
		 var total_sum = document.getElementById("bonus_goods");
		 var select_coupon = document.getElementById("select_coupon");
		 select_coupon.value ="";
		 
		// checkbox의 name값이 current_product이면서 체크되어 있는 함수를 each함수로 호출한다.
		$("input[name=f_couponmemberno]:checked").each(function() { 
			
			var test = $(this).val(); 
			 sum += parseInt(test);
			 total_sum.value = sum;
			 
			 sumCouponTotal(0,sum);
			 
			 var c_name= $(this).attr("coup_num");
			 select_coupon.value += c_name+",";
			 
			 
//	 		 $("#TotalUseGoodsCoupon").text(sum);
		});
	
	}
	
	function setComma(number) { // asp의 formatnumber 사용법 -> var xxx = setComma(parseInt(변수));
		var minusYN = "N";
		if (parseInt(number,10)<0) {
			minusYN = "Y";
			number = parseInt(number,10)*-1;
		}
		var nArr = String(number).split("").join(",").split("");
		for (var i=nArr.length-1, j=1; i>=0; i--, j++) {
			 if( j%6 != 0 && j%2 == 0) {
				 nArr[i] = "";
			 }
		}
		if (minusYN=="Y") {
			return "-"+nArr.join("");
		} else {
			return nArr.join("");
		}
	}
	
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
</script>
<style type="text/css">
 .btn_c_cancle {display:block; width:100%; padding:0; text-align:center; margin:0; line-height:56px; height:56px; color:#ffffff; font-size:21px; border:0; background-color:#000000; border-radius:5px; font-weight:bold; } 
 .btn_c_use {display:block; width:100%; padding:0; text-align:center; margin:0; line-height:54px; height:56px; color:#000000; font-size:21px; border:1px solid #646464; background-color:#ffffff; border-radius:5px;} 
.c_select_td {
	width: 150px;
	text-align: center;
}
td.c_select_td_name {
	width: 170px;
	/* text-align: center; */
}
#total_sum, #bonus_goods, #plus {
	border-style: none;
	width: 50px;
	color: #fc2c03;
}
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: fit-content; /* Could be more or less, depending on screen size */
}
span.scoup { /*     쿠폰 팝업 창  */
	display: inline-block;
	width: 100px;
	height: 56px;
	line-height: 56px;
	background-color: #424242;
	text-align: center;
	color: #ffffff;
	font-size: 16px;
	border-radius: 5px;
}
	.couponTotal{
	margin: 10px 10%;
	font-size: 20px;
	font-weight: bold;
	}
</style>
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

<form method="post" name="Order" action="orderComplete.order">
<div class="OrderWrap" id="OrderWrap">
   <h1>주문하기</h1>
   
   <div class="SectionItemList">
      <div class="OrderInfoTitle">
         <h2>주문상품 정보
         <small>
         <c:choose>
    <c:when test="${fn:length(orderList) == 1}">
        <c:set var="Order_Product_Name" value="${orderListOne[0].itemName } (${orderListOne[0].itemCode })"/>
        <c:out value="${Order_Product_Name }"/>
    </c:when>
    <c:otherwise>
         <c:set var="Order_Product_Name" value="${orderListOne[0].itemName } (${orderListOne[0].itemCode }) 외 ${fn:length(orderList)-1}개"/>
         <c:out value="${Order_Product_Name }"/>
    </c:otherwise>
         </c:choose>
         </small>
         <a class="Open" id="OrderItemListArrow" href="javascript:fnOrderInfoTitle('OrderItemList','','');"></a>
         </h2>
         <div class="clear"></div>
      </div>
      <div id="OrderItemList">
      
<c:set var="tps" value="0"/>
<c:forEach var="orderList" items="${orderList }" varStatus="status">
   <c:set var="price" value="${orderList[0].itemprice }"/>
   <c:set var="sale_price" value="${orderList[0].item_sale_price }"/>
   <c:set var="result_price" value="${price}"/>
   <c:set var="qqq" value="${price*orderList[0].quantity }"/>
   
   
         <div class="tableDiv">
            <dl class="trOrderItem 2002200265">
               <dt class="tdImage"><a href="itemDetail.item?product_num=${orderList[0].itemNum }"><img src="${pageContext.request.contextPath}/upload/${orderList[0].itemImage }"/></a></dt>
               <dt class="tdInner">
                  <div class="BasketListItemName">${orderList[0].itemName } (${orderList[0].itemCode })
                  </div>
<!--                   세일안할때 -->
                  <c:if test="${sale_price ==0 }">
                  <div class="BasketListPrice">
                   / <fmt:formatNumber value="${price }" pattern="#,###"/>원 X ${orderList[0].quantity }개
                  </div>
                  </c:if>
<!--                   세일할때 -->
   	                <c:if test="${sale_price > 0 }"> 
			<c:choose>
                  <c:when test="${fn:contains(itemcoupon, orderList[0].itemCategory)}"><!-- 쿠폰이벤트 -->
                     <div class="BasketListPrice">
                   / <fmt:formatNumber value="${price }" pattern="#,###"/>원 X ${orderList[0].quantity }개
                  </div>
                   </c:when>
                   
                    <c:otherwise><!-- 세일이벤트 -->
                  <div class="BasketListPrice">
                     <c:set var="result_price" value="${price- sale_price}"/>
                   / <span style="color:grey;text-decoration: line-through;"><fmt:formatNumber value="${price }" pattern="#,###"/>원</span>
				<span style="color: red;"><fmt:formatNumber value="${result_price}" pattern="#,###"/> 원 </span>
                   X ${orderList[0].quantity }개
                  </div>
                  </c:otherwise>
                  
                  
                  	</c:choose>
                  </c:if>
                  
                  
               </dt>
               <dt class="tdPrice">
                  <fmt:formatNumber value="${result_price*orderList[0].quantity }" pattern="#,###"/>원
                  <c:set var="tps" value="${tps + result_price*orderList[0].quantity }"/>
               </dt>
               
               
               
            </dl>
         </div>
</c:forEach>
      </div>
   </div>

   <div class="SectionMember">
      <div class="OrderInfoTitle">
         <h2>주문고객 정보<a class="Open" id="OrderMemInfoArrow" href="javascript:fnOrderInfoTitle('OrderMemInfo','i_memname','i_memname_summary');"></a><div class="clear"></div></h2>
      </div>
      <div id="OrderMemInfoSummary" class="OrderInfoSummary">
         <div class="gap20px"></div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>이름</dt>
               <dd>
                  <input type="text" id="i_memname_summary" name="memname_summary" maxlength="16" value="" class="readonly" readonly="readonly" />
               </dd>
            </dl>
         </div>
      </div>
      <div id="OrderMemInfo">
         <div class="gap20px"></div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>이름</dt>
               <dd>
                  <input type="text" id="i_memname" name="memname" maxlength="16" value="${orderListOne[0].name }" />
                  <p class="null"></p>
               </dd>
            </dl>
            <dl class="trOrder">
               <dt>이메일</dt>
               <dd>
                  <input type="text" id="i_mememail" name="mememail" maxlength="50" value="${orderListOne[0].email }" placeholder="예) example@artfox.com" />
                  <p class="null"></p>
                  <input type="hidden" name="mememail1" />
                  <input type="hidden" name="mememail2" />
               </dd>
            </dl>
         </div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>휴대전화</dt>
               <c:set var="phonearr" value="${orderListOne[0].phone}" />
               <c:set var="phone" value="${fn:split(phonearr, '-')}" />
               <dd>
	              <input type="hidden" id="tel" name="tel" value="${orderListOne[0].phone}"/>
                  <input type="tel" id="i_memcpnum1" name="memcpnum1" maxlength="3" value="${phone[0] }" />
                  <p class="null"></p>
               </dd>
               <dd class="blank">&#8210;</dd>
               <dd>
                  <input type="tel" id="i_memcpnum2" name="memcpnum2" maxlength="4" value="${phone[1] }" />
                  <p class="null"></p>
               </dd>
               <dd class="blank">&#8210;</dd>
               <dd>
                  <input type="tel" id="i_memcpnum3" name="memcpnum3" maxlength="4" value="${phone[2] }" />
                  <p class="null"></p>
               </dd>
            </dl>
         </div>
      </div>
      <div class="gap20px"></div>
      <div class="gap20px"></div>
      <div class="OrderInfoTitle">
         <h2>배송지 정보<a class="Open clear" id="OrderShipInfoArrow" href="javascript:fnOrderInfoTitle('OrderShipInfo','i_shipname','i_shipname_summary');"></a></h2>
      </div>
      <div id="OrderShipInfoSummary" class="OrderInfoSummary">
         <div class="gap20px"></div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>받는분</dt>
               <dd>
                  <input type="text" id="i_shipname_summary" name="shipname_summary" maxlength="16" value="" class="readonly" readonly="readonly" />
               </dd>
            </dl>
         </div>
      </div>
      
      <div id="OrderShipInfo">
         <div class="gap20px"></div>
         <div class="DeliveryInfo">
            <a href="javascript:fnDeliveryInfo(1);" id="DeliveryInfo1" class="Off">기본 배송지</a>
            <a href="javascript:fnDeliveryInfo(2);" id="DeliveryInfo2" class="Off">최근 배송지</a>
            <a href="javascript:fnDeliveryInfo(3);" id="DeliveryInfo3" class="Off">직접 입력</a>
            <div class="clear"></div>
         </div>
         <div class="DeliverySelect" id="MyDelivery1">
			<select onchange="fnSelectMyDelivery(this);">
				<option value="" selected="selected">선택</option>
				<c:forEach var="receiverBasicList" items="${receiverBasicList }" varStatus="status">
               		<option value="${receiverBasicList.receiver }||${receiverBasicList.receiver_name }||${receiverBasicList.receiver_phone }||${receiverBasicList.receiver_postcode }||${receiverBasicList.receiver_addr }||${receiverBasicList.receiver_addr_detail }">${receiverBasicList.receiver }</option>
				</c:forEach>
<!-- 					<option value="김땡땡||06257||서울특별시 강남구 논현로 311 (역삼동)||101-101||010||1234||5678||||||">자택</option> -->
			</select>
            <p class="null"></p>
         </div>
         <div class="DeliverySelect" id="MyDelivery2">
         	<select onchange="fnSelectMyDelivery(this);">
         	<c:choose>
  				<c:when test="${empty receiverLastList }">
            		<option value="" selected="selected">최근 배송지가 없습니다.</option>
				</c:when>

				<c:otherwise>
               		<option value="" selected="selected">선택</option>
               	<c:forEach var="receiverLastList" items="${receiverLastList }" varStatus="status">
               		<option value="${receiverLastList.receiver }||${receiverLastList.receiver_name }||${receiverLastList.receiver_phone }||${receiverLastList.receiver_postcode }||${receiverLastList.receiver_addr }||${receiverLastList.receiver_addr_detail }">${receiverLastList.receiver_addr }</option>
				</c:forEach>
				</c:otherwise>
			</c:choose>
			</select>
            <p class="null"></p>
         </div>
         <div class="DeliverySelect" id="MyDelivery3">
            <input type="checkbox" id="i_copyorderinfo" name="copyorderinfo" /> 주문고객과 동일
            <p class="null"></p>
         </div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>받는분</dt>
               <dd>
                  <input type="hidden" id="receiver" name="receiver">
                  <input type="text" id="i_shipname" name="shipname" maxlength="16" />
                  <p class="null"></p>
               </dd>
            </dl>
         </div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>휴대전화</dt>
               <dd>
                  <input type="tel" id="i_shipcpnum1" name="shipcpnum1" maxlength="3" />
                  <p class="null"></p>
               </dd>
               <dd class="blank">&#8210;</dd>
               <dd>
                  <input type="tel" id="i_shipcpnum2" name="shipcpnum2" maxlength="4" />
                  <p class="null"></p>
               </dd>
               <dd class="blank">&#8210;</dd>
               <dd>
                  <input type="tel" id="i_shipcpnum3" name="shipcpnum3" maxlength="4" />
                  <p class="null"></p>
               </dd>
            </dl>
         </div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>주소</dt>
               <dd class="zipcode">
                  <input type="text" id="i_shipzipcode" name="shipzipcode" maxlength="6" class="readonly" readonly="readonly" />
                  <p class="null"></p>
               </dd>
               <dd>&nbsp;</dd>
               <dd class="zipcode">
                  <a href="javascript:void(0);" onClick="execDaumPostCode()">주소찾기</a>
                  <p class="null"></p>
               </dd>
            </dl>
         </div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>&nbsp;</dt>
               <dd>
                  <input type="text" id="i_shipaddr" name="shipaddr" maxlength="60" class="readonly" readonly="readonly" />
                  <p class="null"></p>
                  <input type="text" id="i_shipaddrD" name="shipaddrd" maxlength="60" />
                  <p class="null"></p>
               </dd>
            </dl>
            <dl class="trOrder">
               <dt>배송 메시지</dt>
               <dd>
                  <select id="i_shipalertdesc_select" name="shipalertdesc_select" onchange="fnShipAlertDesc(this);">
                     <option value="" selected="selected">선택</option>
                     
                     <option value="문앞에 그냥 두고 가세요.">문앞에 그냥 두고 가세요.</option>
                     <option value="부재시 경비실에 맡겨 주세요.">부재시 경비실에 맡겨 주세요.</option>
                     <option value="부재시 반드시 전화 혹은 문자로 연락주세요.">부재시 반드시 전화 혹은 문자로 연락주세요.</option>
                     <option value="선물용이니 파손되지 않도록 조심히 운반해주세요.">선물용이니 파손되지 않도록 조심히 운반해주세요.</option>
                     <option value="방문 전에 미리 연락주세요.">방문 전에 미리 연락주세요.</option>
                     <option value="재활용 박스에 담긴 상품을 받겠습니다!">재활용 박스에 담긴 상품을 받겠습니다!</option>
                  </select>
                  <p class="null"></p>
                  <div class="textarea"><textarea id="i_shipalertdesc" name="shipalertdesc" style="resize: none;"></textarea></div>
                  <p class="null"></p>
               </dd>
            </dl>
         </div>
         
         <div class="ModifyShipAddr">
            <input type="checkbox" id="BasicAddr" name="BasicAddr"/> 현재 입력된 배송지를 기본 배송지로 설정
         </div>
         
      </div>
      
   </div>

<!-- 쿠폰 선택 팝업 -->
 <div id="myModal" class="modal">
   <c:set var="BonusCoupontCnt" value="0"/>
     <c:set var="GoodsCoupontCnt" value="0"/>
 
      <!-- Modal content -->
      <div class="modal-content">


	<table width="750" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<tr  height="30">
				<td height="33" colspan="2" >
					<table  width="750" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td class="c_select_td">쿠폰유형</td>
								<td class="c_select_td_name">쿠폰이름</td>
								<td class="c_select_td">쿠폰사용조건</td>
								<td class="c_select_td">예상할인금액</td>
								<td class="c_select_td">사용기한</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>

			<tr height="30">
				<td colspan="1" align="center" style="padding: 5px 0 5px 0">
			
					<table width="750" border="0" cellspacing="0" cellpadding="0">
						<tbody>
						 <c:set var="total_price111" value="${tps}" />
			<!--  bonuscoupon 가져오는 for문 -->
			<c:if test="${!empty mycouponList}"> 
			<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
<!-- 			bonus 쿠폰인지 변수에 저장 -->
			 <c:set var="myCoupon" value="${mycouponList[i].coupon_category}" />
			<c:if test="${myCoupon eq 'bonuscoupon' && total_price111 >= mycouponList[i].coupon_condition}">
			  <c:set var="BonusCoupontCnt" value="${BonusCoupontCnt=BonusCoupontCnt+1 }"/>
				<tr>
					<td class="c_select_td">
						<input type="radio" name="f_coupongroup" id="f_coupongroup_b${i}" value="${mycouponList[i].coupon_price}" onclick="selectCouponGroup(${mycouponList[i].coupon_price})" coup_num="${mycouponList[i].coupon_num}"> 
						<label for="f_coupongroup_b${i}" style="cursor: pointer; cursor: hand;">
						<font color="#696969"><b>보너스쿠폰</b></font></label></td>
					<td  class="c_select_td_name">
						
						<label for="f_coupongroup_${i}" style="cursor: pointer; cursor: hand;">${mycouponList[i].coupon_name}</label></td>
					<td class="c_select_td"><font color="#9e9e9e">${mycouponList[i].coupon_condition }</font></td>
					<td class="c_select_td" style="padding-right: 10px"><font color="#fc2c03"><b>${mycouponList[i].coupon_price}</b></font></td>
					<td class="c_select_td"><font color="#9e9e9e">${mycouponList[i].coupon_limit }</font></td>
				</tr>
				</c:if>
				</c:forEach>
			</c:if>		
							<c:if test="${empty mycouponList }">
							<tr><td style="padding: 5px 0 5px 0">해당하는 쿠폰이 없습니다.</td></tr>
							
							</c:if>			
									
									
						</tbody>
					</table>

				</td>
			</tr>
			
			<tr height="1">
				<td colspan="2" align="center" bgcolor="#e1e1e1"></td>
			</tr>

			<tr height="1">
				<td colspan="2" align="center" bgcolor="#e1e1e1"></td>
			</tr>


<c:if test="${!empty mycouponList }">
			<tr>
				<td colspan="2" align="center" style="padding: 5px 0 10px 0">
					<table width="750" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td  class="c_select_td" rowspan="${fn:length(mycouponList)+10}" align="left" valign="top"
									style="padding-left: 10px; letter-spacing: -1px;">
									<input type="radio" name="f_coupongroup" id="f_coupongroup_3" value="bonus" onclick="selectCouponGroup('bonus')"> 
									<label
									for="f_coupongroup_3" style="cursor: pointer; cursor: hand;">
									<font color="#696969"><b>상품쿠폰</b></font></label></td>
								<td height="25" colspan="4" align="left" style="letter-spacing: -1px;">
								<font color="#c6c6c6">상품쿠폰은 상품당 한 쿠폰만 적용되며, 보너스쿠폰과 함께 사용하실 수 없습니다</font></td>
							</tr>
							<tr>
								<td height="5" colspan="4"></td>
							</tr>
							<tr>
								<td height="1" colspan="4" align="left"></td>
							</tr>
							<tr>
								<td height="5" colspan="4" align="left"></td>
							</tr>
<%-- <c:if test="${!empty mycouponList}">  --%>
	<c:forEach items="${orderList}" var="orderList">
	
<%-- 	 ${orderList[0].itemCategory } --%>
	 
              
              
<%--               <jsp:useBean id="itemMap" class="java.util.HashMap"/> --%>
<%--               <c:set var="sss" value="${s+1}" /> --%>
              
<%--               <c:if test="${fn:contains(itemMap,orderList[0].itemCategory)}"> --%>
<%--                <c:set value="${orderList[0].itemprice +itemMap.orderList[0].itemprice}" target="${itemMap}" property="${orderList[0].itemCategory}" /><br> --%>
<%--  				</c:if> --%>
 				
<%--  				  <c:if test="${!fn:contains(itemMap,orderList[0].itemCategory)}"> --%>
<%--                <c:set value="${orderList[0].itemprice }" target="${itemMap}" property="${orderList[0].itemCategory}" /><br> --%>
<%--  				</c:if> --%>
 				
 				
<%--  				<c:out value="${itemMap}" /> // ${orderList[0].itemCategory } --%>


<!-- ---------------------- -->
 				

 				

<%-- <c:forEach var="itemcategory" items="${orderList[0].itemCategory}" varStatus="status"> --%>
	 
<%-- 	   <c:if test="${itemcategory == mycouponList[i].coupon_condition}"> --%>
<%-- 	       ${itemcategory} / ${mycouponList[i].coupon_condition } --%>
<%--     <jsp:useBean id="itemMap1" class="java.util.HashMap"/> --%>
<%-- 	   <c:set value="${orderList[0].itemprice= itemMap1.orderList[0].itemprice+orderList[0].itemprice}" target="${itemMap1}" property="${orderList[0].itemCategory}" /> --%>
	   
<%-- 	  <c:out value="${itemMap1}" /> --%>
	  
<%-- 	  </c:if></c:forEach> --%>
              
              
         <c:forEach var="i" begin="0" end="${fn:length(mycouponList)-1}" step="1">
         <c:set var="myCoupon" value="${mycouponList[i].coupon_category }" />

           
          <c:forEach var="itemcategory" items="${orderList[0].itemCategory}" varStatus="status">
          	 
          	   <c:if test="${itemcategory == mycouponList[i].coupon_condition}">
          	   
          	   <c:set var="s" value="${s+1}"/>
<%--             ${itemcategory} +${s} --%>
           
            
         <c:if test="${myCoupon == 'goodscoupon' }">
             <c:set var="GoodsCoupontCnt" value="${GoodsCoupontCnt= GoodsCoupontCnt+1 }"/>
             <fmt:parseNumber integerOnly="true" var="coup_discount" value="${orderList[0].itemprice * mycouponList[i].coupon_price /100}"/>
             
             
             
               <tr>
                  <td  align="left"  class="c_select_td_name">
                  <input type="checkbox" name="f_couponmemberno" id="f_couponmemberno_3_${i}" value="${coup_discount}" onclick="selectCouponMember('bonus', ${i})" coup_num="${mycouponList[i].coupon_num}" >
                  <label for="f_couponmemberno_3_${i }" style="cursor: pointer; cursor: hand;">
                  <font color="#696969">『${mycouponList[i].coupon_name}』할인 쿠폰
                     </font></label></td>
                  <td  class="c_select_td">
                   <font color="#9e9e9e">${mycouponList[i].coupon_condition}</font></td>
                   
                  <td  class="c_select_td" style="padding-right: 10px">
                  <font color="#fc2c03"><b>${coup_discount}</b></font>
                  </td>
                  
                  <td  class="c_select_td"><font
                     color="#9e9e9e">${mycouponList[i].coupon_limit}</font></td>
               </tr>
               
               
               
               
               
         </c:if>
         
          </c:if>
            
              </c:forEach>
         
         </c:forEach>
         </c:forEach>
<%-- </c:if>			 --%>
						</tbody>
					</table>
				</td>
				<td>

				</td>
				
			</tr>
			</c:if>
			
			<c:if test="${empty mycouponList }">
			
		</c:if>
			
			<tr height="2">
				<td colspan="2" align="center" bgcolor="#e1e1e1"></td>
			</tr>
		</tbody>
	</table>
	
	<div class="couponTotal">
	보너스/상품쿠폰 &nbsp;<input id= "bonus_goods" name="bonus_goods" type="text" size="10" value=0 readonly>원 +
	플러스 쿠폰 &nbsp;<input id= "plus" name="plus" type="text" size="10" value=0 readonly>원 =
	<input id= "total_sum" name="total_sum" type="text" size="20" value=0 readonly>원
	</div>
	
			<div class="tableDiv">
			<dl class="trOrder">
				<dd class="twoBtn">
<!-- 					<a class="btnCancel" href="listBasket.basket">장바구니</a> -->
					<input type="button" class="btn_c_cancle" value="취소" onclick="clear_pop();">
				</dd>
				<dd>&nbsp;</dd>
				<dd class="twoBtn" id="OrderBuyButton1">
					<input type="button" value="사용" class="btn_c_use" onclick="close_pop();">
<!-- 					<a class="btnModify" href="javascript:fnOrderReady();">결제하기</a> -->
<!-- 					<a class="btnModify" href="OrderComplete.complete">결제하기</a> -->
				</dd>
			</dl>
		</div>
	

</div>
</div>

   <div class="SectionDiscount" id="SectionDiscount">
      <div class="OrderInfoTitle">
         <h2>쿠폰/할인/꿈캔디 정보<a class="Open" id="OrderDiscountInfoArrow" href="javascript:fnOrderInfoTitle('OrderDiscountInfo','i_TotalDiscountPriceInfo','i_TotalDiscountPriceInfo_summary');"></a><div class="clear"></div></h2>
      </div>
      <div id="OrderDiscountInfoSummary" class="OrderInfoSummary">
         <div class="gap20px"></div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>할인금액</dt>
               <dd>
                  <input type="text" id="i_TotalDiscountPriceInfo_summary" name="TotalDiscountPriceInfo_summary" maxlength="16" value="- 0 원"  />
               </dd>
            </dl>
         </div>
      </div>
      <div id="OrderDiscountInfo">
         <div class="gap20px"></div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>할인금액</dt>
               <dd>
                  <input type="text" id="i_TotalDiscountPriceInfo" name="TotalDiscountPriceInfo" value="- 0 원" class="readonly" readonly="readonly" />
                  <p class="null"></p>
               </dd>
            </dl>
         </div>
         
         <div class="tableDiv">
            <dl class="trOrderRadio">
               <dt>쿠폰</dt>
               <dd>

                   보너스쿠폰 (<span id="BonusCouponTotCnt">${BonusCoupontCnt }</span>장)
                  &nbsp;&nbsp;<span class="MobileBr"></span>
                  상품쿠폰 (<span id="GoodsCouponTotCnt">${GoodsCoupontCnt }</span>장)
                   &nbsp;&nbsp;<span class="MobileBr"></span>
            <span class="scoup" style="font-size: 13pt;" onClick="open_pop();">쿠폰사용</span>
               </dd>
            </dl>
         </div>
         
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>무료배송쿠폰</dt>
               <dd>
               
                  
               <c:if test="${empty mycouponList}"> <!-- 쿠폰 없을때 -->
				<select name="FreeCouponIdx" id="CouponIdxSelect_Null" onchange="fnCouponSelect(this);" class="block">
							<option value="" alt="0" selected="selected">해당 쿠폰이 없습니다.</option>
						</select>
				</c:if>
						
						<c:if test="${!empty mycouponList}">  <!-- 쿠폰 있을때 -->
						<select name="FreeCouponIdx" id="CouponIdxSelect_Free" onchange="fnCouponSelect(this);" class="block" >
<!-- 						style="display: block;"> -->

							<option value="" alt="0" selected="selected">선택</option>
							
							<c:forEach  var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
							<c:set var="Coupon" value="${mycouponList[i].coupon_category}"/>
							<c:if test="${'freecoupon' == Coupon }">
							<option value="53146604" alt="${mycouponList[i].coupon_price }">
							${mycouponList[i].coupon_name}</option>
							</c:if>
						</c:forEach>
						</select>
							</c:if>
                  
               
                  <p class="null"></p>
               </dd>
            </dl>
         </div>
         <div class="tableDiv">
            <dl class="trOrder">
               <dt>꿈캔디</dt>
               <dd>
                  <input type="tel" id="i_UseMileagePrice" name="UseMileagePrice" maxlength="7" value="0" />
                  <input type="hidden" name="MemMileage" value=" ${orderListOne[0].point }" />
                  <p class="null"></p>
               </dd>
               <dt class="mileage">&nbsp;개</dt>
            </dl>
         </div>
         <div class="ModifyShipAddr">
            <input type="checkbox" type="checkbox" id="UseMileageAll" value="$0" alt="${orderListOne[0].point }" onclick="if(this.checked){fnUseMileageAll(1);}else{fnUseMileageAll(0);}" />
             모두사용 (사용 가능 꿈캔디 <fmt:formatNumber value="${orderListOne[0].point }" pattern="#,###"/>개)
            <p class="null"></p>
         </div>
      </div>
   </div>

   <div class="SectionPrice">
      <div class="OrderInfoTitle NoBorder">
         <h2>최종 결제 금액</h2>
      </div>
      <div class="tableDiv">
         <dl class="trPrice">
            <dt>총 상품금액</dt>
            <dd><span id="TotalPriceSum"><fmt:formatNumber value="${tps}" pattern="#,###"/></span> 원
 			<input type="hidden" name="TotalPriceSum" value="${tps}" /></dd>
         </dl>
         <dl class="trPrice">
            <dt>배송비</dt>
            <dd><span id="TotalPriceDelivery"><c:set var="tpd" value="${tps>=30000?0:2500}"/>
            <fmt:formatNumber value="${tpd}" pattern="#,###"/></span> 원
            <input type="hidden" name="TotalPriceDelivery" value="${tps>=30000?0:2500}" /></dd>
         </dl>
         <dl class="trPrice">
            <dt>총 할인금액<a class="Open" id="DiscountPriceInfoArrow" href="javascript:fnTotalDiscountPriceSum();"></a></dt>
            <dd>- <span id="TotalDiscountPriceSum">0</span> 원<input type="hidden" name="TotalDiscountPriceSum" value="" /></dd>
         </dl>
      </div>
      <div id="DiscountPriceInfo">
         <div class="tableDiv">
            <dl class="trPrice"  style="display:none;">
               <dt>회원등급 할인금액</dt>
               <dd class="grade"><span id="TotalPriceMemberLevelDiscount">- 0</span> 원 [<img src="${pageContext.request.contextPath}/Images/order/pc_top_grade5.png" />0%]
               <input type="hidden" name="TotalPriceMemberLevelDiscount" value="0" /></dd>
            </dl>
            <dl class="trPrice">
               <dt>보너스 쿠폰</dt>
               <dd><span id="TotalUseBonusCoupon">- 0</span> 원
               <input type="hidden" name="TotalUseBonusCoupon" value="0" /></dd>
            </dl>
            <dl class="trPrice">
               <dt>상품 쿠폰</dt>
               <dd><span id="TotalUseGoodsCoupon">- 0</span> 원
               <input type="hidden" name="TotalUseGoodsCoupon" value="0" alt="0" />
               <input type="hidden" id="select_coupon" name="select_coupon" value="0" alt="0" /></dd>
            </dl>
            <dl class="trPrice">
               <dt>무료배송 쿠폰</dt>
               <dd><span id="TotalUseFreeCoupon">- 0</span> 원
               <input type="hidden" name="TotalUseFreeCoupon" value="0" /></dd>
            </dl>
            <dl class="trPrice">
               <dt>꿈캔디 사용</dt>
               <dd><span id="TotalUseMileage">- 0</span> 원
               <input type="hidden" name="TotalUseMileage" value="0" /></dd>
            </dl>
         </div>
      </div>
      <div class="TotalPriceAmount">
         총 결제금액 <span id="TotalPriceAmount"><fmt:formatNumber value="${tps+tpd}" pattern="#,###"/></span> 원<br />&nbsp;<br />
         <small>(적립 예정 꿈캔디 <span id="TotalMileageAmount"><fmt:formatNumber value="${tps/100}" pattern="#,###"/></span>개)</small>
         <input type="hidden" name="point" value="${tps/100}">
      </div>

      <div class="OrderAgree">
         <div class="OrderAgreeAll"><input type="checkbox" id="i_OrderPayAgree" name="OrderPayAgree" value="Y" />&nbsp;&nbsp;&nbsp;약관 전체 동의하기</div>
         <div class="OrderAgreeTable">
            <div class="tableDiv">
               <dl class="trOrderAgree">
                  <dd>개인정보 제3자 제공에 동의합니다.</dd>
                  <dt><input type="checkbox" name="OrderAgreeThird" value="Y" /> <p class="null"/></dt>
               </dl>
               <dl class="trOrderAgree">
                  <dd>결제대행서비스 이용약관에 동의합니다.</dd>
                  <dt><input type="checkbox" name="OrderAgreePayment" value="Y" /> <p class="null"/></dt>
               </dl>
               <dl class="trOrderAgree">
                  <dd>주문할 상품설명에 명시된 내용과 사용조건을 확인하였으며, 취소 환불규정에 동의합니다.</dd>
                  <dt><input type="checkbox" name="OrderAgreeRule" value="Y" /> <p class="null"/></dt>
               </dl>
            </div>
         </div>

      </div>

		<div class="tableDiv">
			<dl class="trOrder">
				<dd class="twoBtn">
<!-- 					<a class="btnCancel" href="listBasket.basket">장바구니</a> -->
					<input type="button" id="btn_basket" value="장바구니" onclick="location.href='listBasket.basket'">
				</dd>
				<dd>&nbsp;</dd>
				<dd class="twoBtn" id="OrderBuyButton1">
					<input type="button" value="결제하기" id="btn_order">
<!-- 					<a class="btnModify" href="javascript:fnOrderReady();">결제하기</a> -->
<!-- 					<a class="btnModify" href="OrderComplete.complete">결제하기</a> -->
				</dd>
			</dl>
		</div>

	</div>
	
	<div class="clear"></div>
</div>

<input type="hidden" id="pd_name" name="pd_name" value="${orderListOne[0].itemName }"/>
<input type="hidden" name="stockqty" value="${stockqty}"/>
<input type="hidden" name="product_num" value="${product_num}"/>
<input type="hidden" name="RealTotalPrice" value="0"/>

</form>

<script type="text/javascript">
// '결제하기' 버튼 클릭 이벤트
$("#btn_order").click(function(){

	var fr = document.Order;

	if (!$.trim(fr.memname.value)) {
		alert("주문자명을 입력해주세요.");
		fr.memname.focus();
		return;
	}

	if (!fr.mememail.value) {
		alert("이메일 주소를 입력해주세요.");
		fr.mememail.focus();
		return;
	}

	if (!fr.memcpnum1.value||!fr.memcpnum2.value||!fr.memcpnum3.value) {
		alert("휴대폰 번호를 입력해주세요.");
		fr.memcpnum.focus();
		return;
	}

	if (!$.trim(fr.shipname.value)) {
		alert("수령인명을 입력해주세요.");
		fr.shipname.focus();
		return;
	}

	if (!fr.shipcpnum1.value||!fr.shipcpnum2.value||!fr.shipcpnum3.value) {
		alert("휴대폰 번호를 입력해주세요.");
		fr.shipcpnum3.focus();
		return;
	}

	if (!fr.shipzipcode.value||!fr.shipaddr.value||!fr.shipaddrd.value) {
		alert("주소를 입력해주세요.");
		fr.shipaddrd.focus();
		return;
	}

	if (!$("input:checkbox[name=OrderAgreeThird]").is(":checked")) {
		alert("개인정보 제3자 제공에 동의해주세요.");
		$("input[name=OrderAgreeThird]").focus();
		return;
	}

	if (!$("input:checkbox[name=OrderAgreePayment]").is(":checked")) {
		alert("결제대행서비스 이용약관에 동의해주세요.");
		$("input[name=OrderAgreePayment]").focus();
		return;
	}

	if (!$("input:checkbox[name=OrderAgreeRule]").is(":checked")) {
		alert("상품설명/취소/환불규정에 동의해주세요.");
		$("input[name=OrderAgreeRule]").focus();
		return;
	}
	
	// 아임포트 API
// 	IMP.request_pay({
// 		pg: 'inicis', // version 1.1.0부터 지원.
// 		merchant_uid : 'mid_' + new Date().getTime(),
// 		pay_method: 'card',
// 		name: $("#pd_name").val(),
// 		amount: 100, // $("#Total").val(),
// 	    buyer_email: $("#i_mememail").val(),
// 	    buyer_name: $("#i_memname").val(),
// 		buyer_tel: $("#tel").val(),
//     	buyer_addr: $("#i_shipaddr").val(),
//     	buyer_postcode: $("#i_shipzipcode").val()
// 	}, function(rsp) {
// 		if ( rsp.success ) {
//     		var msg = '결제가 완료되었습니다.';
    		fr.submit();
// 		} else {
// 			var msg = '결제에 실패하였습니다.';
// 			msg += '에러내용 : ' + rsp.error_msg;
// 		}
// 	alert(msg);
// 	})
	
});
</script>
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>



</body>
</html>
