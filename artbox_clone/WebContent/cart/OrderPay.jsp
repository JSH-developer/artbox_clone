<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/order/Order.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script> <!-- 결제연동 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
// 	IMP.init('imp92896832'); // 가맹점식별코드
	
// 	IMP.request_pay({
// 	    pg : 'inicis', // version 1.1.0부터 지원.
// 	    pay_method : 'card',
// 	    merchant_uid : 'merchant_' + new Date().getTime(),
// 	    name : '주문명:결제테스트',
// 	    amount : 14000,
// 	    buyer_email : 'iamport@siot.do',
// 	    buyer_name : '구매자이름',
// 	    buyer_tel : '010-1234-5678',
// 	    buyer_addr : '서울특별시 강남구 삼성동',
// 	    buyer_postcode : '123-456',
// 	    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
// 	}, function(rsp) {
// 	    if ( rsp.success ) {
// 	        var msg = '결제가 완료되었습니다.';
// 	        msg += '고유ID : ' + rsp.imp_uid;
// 	        msg += '상점 거래ID : ' + rsp.merchant_uid;
// 	        msg += '결제 금액 : ' + rsp.paid_amount;
// 	        msg += '카드 승인번호 : ' + rsp.apply_num;
// 	    } else {
// 	        var msg = '결제에 실패하였습니다.';
// 	        msg += '에러내용 : ' + rsp.error_msg;
// 	    }
// 	    alert(msg);
// 	});
	

	$("input[type=tel]").keyup(function(e){
		if (!Check_Number(e.currentTarget.value)) {
			alert("숫자값만 입력가능합니다.");
			this.value="";
		}
		if (this.id=="i_memcpnum1"&&this.value.length>=3) {
			document.getElementById("i_memcpnum2").focus();
		}
		if (this.id=="i_memcpnum2"&&this.value.length>=4) {
			document.getElementById("i_memcpnum3").focus();
		}
		if (this.id=="i_memphone1"&&this.value.length>=3) {
			document.getElementById("i_memphone2").focus();
		}
		if (this.id=="i_memphone2"&&this.value.length>=4) {
			document.getElementById("i_memphone3").focus();
		}
		if (this.id=="i_guestmemcpnum1"&&this.value.length>=3) {
			document.getElementById("i_guestmemcpnum2").focus();
		}
		if (this.id=="i_guestmemcpnum2"&&this.value.length>=4) {
			document.getElementById("i_guestmemcpnum3").focus();
		}
		if (this.id=="i_checkmemcpnum1"&&this.value.length>=3) {
			document.getElementById("i_checkmemcpnum2").focus();
		}
		if (this.id=="i_checkmemcpnum2"&&this.value.length>=4) {
			document.getElementById("i_checkmemcpnum3").focus();
		}
	});

 	/* 배송지 입력 - 직접입력 - 주문고객과 동일 클릭시 자동완성 */
	$("#i_copyorderinfo").click(function(){
		if ($(this).prop("checked")) {
			var ShipName,ShipCpNum1,ShipCpNum2,ShipCpNum3,ShipPhone1,ShipPhone2,ShipPhone3;

			ShipName = $("#i_memname").val();
			ShipCpNum1 = $("#i_memcpnum1").val();
			ShipCpNum2 = $("#i_memcpnum2").val();
			ShipCpNum3 = $("#i_memcpnum3").val();
			ShipPhone1 = $("#i_memphone1").val();
			ShipPhone2 = $("#i_memphone2").val();
			ShipPhone3 = $("#i_memphone3").val();

			$("#i_shipname").val(ShipName);
			$("#i_shipzipcode").val("");
			$("#i_shipaddr").val("");
			$("#i_shipaddrd").val("");
			$("#i_shipcpnum1").val(ShipCpNum1);
			$("#i_shipcpnum2").val(ShipCpNum2);
			$("#i_shipcpnum3").val(ShipCpNum3);
			$("#i_shipphone1").val(ShipPhone1);
			$("#i_shipphone2").val(ShipPhone2);
			$("#i_shipphone3").val(ShipPhone3);
		}
	});


	/* 쿠폰 선택 <- 이벤트 페이지랑 연동 */
	$("input[name=CouponType]").click(function(){
		if ($("#CouponTypeNull").prop("checked")) {
			$("#CouponIdxSelect_Null").attr("class","");
			$("#CouponIdxSelect_Bonus").attr("class","none");
			$("#CouponIdxSelect_Goods").attr("class","none");
		} else if ($("#CouponTypeBonus").prop("checked")) {
			$("#CouponIdxSelect_Null").attr("class","none");
			$("#CouponIdxSelect_Bonus").attr("class","");
			$("#CouponIdxSelect_Goods").attr("class","none");
		} else if ($("#CouponTypeGoods").prop("checked")) {
			$("#CouponIdxSelect_Null").attr("class","none");
			$("#CouponIdxSelect_Bonus").attr("class","none");
			$("#CouponIdxSelect_Goods").attr("class","");
		}
		fnCouponType();
	});

	$("input[name=UseMileagePrice]").focus(function(){

		TempScrollTop = $(window).scrollTop();

		var inputValue = parseInt($(this).val(),10);

		if (inputValue == 0)
		{
			$(this).val("");
		}
		$(window).scrollTop(TempScrollTop);
	});

	$("input[name=UseMileagePrice]").blur(function(){

		var Event_350won = $("[name=Event_350won]").val();

		if (Event_350won == "Y")
		{
			alert("이벤트 상품은 마일리지 사용이 불가합니다.");
			$(this).val("0");
			return false;
		}

		var inputValue = parseInt($(this).val(),10);

		if (!inputValue) {
			inputValue = 0;
		}

		$(this).val(parseInt(inputValue,10));
		
		var maxValue = parseInt($("input[id=UseMileageAll]").attr("alt"),10);
		var minValue = 0;
		
		if (inputValue > maxValue)
		{
			alert("현재 주문에서 사용 가능한 꿈캔디 갯수는 " + setComma(maxValue) + "개 입니다.");
			if (maxValue <= 0)	
			{
				maxValue = 0;
			}
			$(this).val(maxValue);
		}


		$("input[name=TotalUseMileage]").val($(this).val());
		$("#TotalUseMileage").text("- " + setComma(parseInt($(this).val(),10)));

		fnTotalPriceAmount();
	});

	$("#i_OrderPayAgree, #i_OrderPayAgree2").click(function(){

		var PayType = $("input[name=PayType]:checked").val();

		if ($(this).prop("checked")) {
			$("#i_OrderPayAgree").prop("checked",true);
			$("#i_OrderPayAgree2").prop("checked",true);

			$("input[name=OrderAgreeThird]").prop("checked",true);
			$("input[name=OrderAgreePayment]").prop("checked",true);
			$("input[name=OrderAgreeRule]").prop("checked",true);


		} else {
			$("#i_OrderPayAgree").prop("checked",false);
			$("#i_OrderPayAgree2").prop("checked",false);

			$("input[name=OrderAgreeThird]").prop("checked",false);
			$("input[name=OrderAgreePayment]").prop("checked",false);
			$("input[name=OrderAgreeRule]").prop("checked",false);
		}

	});


	fnOrderInfoTitle = function(obj,obj2,obj3){

		var PayTypeText;

		if ($("#"+obj).css("display")=="block" ) {
			$("#"+obj).css("display","none");
			$("#"+obj+"Summary").css("display","block");
			$("#"+obj+"Arrow").attr("class","Close");

			if (obj2!=""&&obj3!="") {
				$("#"+obj3).val($("#"+obj2).val());
			}

		} else {
			$("#"+obj).css("display","block");
			$("#"+obj+"Summary").css("display","none");
			$("#"+obj+"Arrow").attr("class","Open");
		}
	}


	fnTotalDiscountPriceSum = function(){
		var obj = "DiscountPriceInfo";
		if ($("#"+obj).css("display")=="block" ) {
			$("#"+obj).css("display","none");
			$("#"+obj+"Arrow").attr("class","Close");
		} else {
			$("#"+obj).css("display","block");
			$("#"+obj+"Arrow").attr("class","Open");
		}

	}

	fnDeliveryInfo = function(x){
		if (x==1) {
			$("#DeliveryInfo1").attr("class","On");
			$("#DeliveryInfo2").attr("class","Off");
			$("#DeliveryInfo3").attr("class","Off");
			$("#MyDelivery1").css("display","block");
			$("#MyDelivery2").css("display","none");
			$("#MyDelivery3").css("display","none");
		} else if (x==2) {
			$("#DeliveryInfo1").attr("class","Off");
			$("#DeliveryInfo2").attr("class","On");
			$("#DeliveryInfo3").attr("class","Off");
			$("#MyDelivery1").css("display","none");
			$("#MyDelivery2").css("display","block");
			$("#MyDelivery3").css("display","none");
		} else if (x==3) {
			$("#DeliveryInfo1").attr("class","Off");
			$("#DeliveryInfo2").attr("class","Off");
			$("#DeliveryInfo3").attr("class","On");
			$("#MyDelivery1").css("display","none");
			$("#MyDelivery2").css("display","none");
			$("#MyDelivery3").css("display","block");
		}
	}

	fnSelectMyDelivery = function (obj) {
		if (obj.value) {

			var arr = obj.value.split("¶¶");
			
			var ShipName,ShipZipCode,ShipAddr,ShipAddrD,ShipCpNum1,ShipCpNum2,ShipCpNum3,ShipPhone1,ShipPhone2,ShipPhone3;

			ShipName = arr[0];
			ShipZipCode = arr[1];
			ShipAddr = arr[2];
			ShipAddrD = arr[3];
			ShipCpNum1 = arr[4];
			ShipCpNum2 = arr[5];
			ShipCpNum3 = arr[6];
			ShipPhone1 = arr[7];
			ShipPhone2 = arr[8];
			ShipPhone3 = arr[9];

			$("#i_shipname").val(ShipName);
			$("#i_shipzipcode").val(ShipZipCode);
			$("#i_shipaddr").val(ShipAddr);
			$("#i_shipaddrD").val(ShipAddrD);
			$("#i_shipcpnum1").val(ShipCpNum1);
			$("#i_shipcpnum2").val(ShipCpNum2);
			$("#i_shipcpnum3").val(ShipCpNum3);
			$("#i_shipphone1").val(ShipPhone1);
			$("#i_shipphone2").val(ShipPhone2);
			$("#i_shipphone3").val(ShipPhone3);

			$("#i_copyorderinfo").prop("checked",false);

		}

	}

	fnShipAlertDesc = function (obj) {
		if (obj.value) {
			document.Order.shipalertdesc.value+=obj.value+"\n";
		}
	}

	fnCouponSelect = function(obj){

		var DcNumber = $(obj).find(":selected").attr("alt");
		var MemberCouponIdx = $(obj).find(":selected").val();


		if ($(obj).attr("name")=="BonusCouponIdx") {

			if (DcNumber=="0"&&MemberCouponIdx!="") { // DcNumber=0 이면 꿈캔디 적립쿠폰으로 인식
				alert("꿈캔디는 상품 구매 확정 시 자동으로 적립됩니다.");
			}

			$("input[name=TotalUseBonusCoupon]").val(DcNumber);
			$("#TotalUseBonusCoupon").text("- " + setComma(parseInt(DcNumber,10)));
			fnTotalPriceAmount();

		} else if ($(obj).attr("name")=="FreeCouponIdx") {

			$("input[name=TotalUseFreeCoupon]").val(DcNumber);
			$("#TotalUseFreeCoupon").text(setComma(parseInt(DcNumber,10)));
			fnTotalPriceAmount();
		}

	}

	fnUseMileageAll = function(x) {

		var UsableMileage;

		if (x==1) {
			if (parseInt($("input[name=MemMileage]").val(),10) >= parseInt($("input[id=UseMileageAll]").val(),10) )
			{
				UsableMileage = $("input[id=UseMileageAll]").val();
			}
			else
			{
				UsableMileage = $("input[name=MemMileage]").val();
			}

			if ( parseInt(UsableMileage,10) <= 0 )	
			{
				UsableMileage = 0;
			}

			$("input[name=UseMileagePrice]").val(UsableMileage);
			$("input[name=TotalUseMileage]").val(UsableMileage);
			$("#TotalUseMileage").text("-" + setComma(UsableMileage));
		} else {
			$("input[name=UseMileagePrice]").val("0");
			$("input[name=TotalUseMileage]").val("0");
			$("#TotalUseMileage").text("-" + setComma("0"));
		}

		fnTotalPriceAmount();

	}

	fnTotalPriceAmount = function(){

		var TotalPriceSum                 = parseInt($("input[name=TotalPriceSum]").val(),10);
		var TotalPriceDelivery            = parseInt($("input[name=TotalPriceDelivery]").val(),10);
		var TotalPriceMemberLevelDiscount = parseInt($("input[name=TotalPriceMemberLevelDiscount]").val(),10);
		var TotalUseMileage               = parseInt($("input[name=TotalUseMileage]").val(),10);
		var TotalUseBonusCoupon           = parseInt($("input[name=TotalUseBonusCoupon]").val(),10);
		var TotalUseGoodsCoupon           = parseInt($("input[name=TotalUseGoodsCoupon]").val(),10);
		var TotalUseFreeCoupon            = parseInt($("input[name=TotalUseFreeCoupon]").val(),10);

		var TotalPriceAmount = TotalPriceSum+TotalPriceDelivery-TotalPriceMemberLevelDiscount-TotalUseMileage-TotalUseBonusCoupon-TotalUseGoodsCoupon-TotalUseFreeCoupon;
		var TotalMileageAmount = Math.ceil((TotalPriceAmount/100)*parseFloat($("#MemMileageSaveRate").val()));

		if (TotalPriceAmount < 0)
		{
			alert("총 합계금액은 0원 이상이어야 합니다.");
			fnInitDiscountTable();
			return;
		}


		$("#i_TotalDiscountPriceInfo_summary").val("- " + setComma(TotalUseMileage+TotalUseBonusCoupon+TotalUseGoodsCoupon+TotalUseFreeCoupon) + " 원"); //접혔을 때 할인금액
		$("#i_TotalDiscountPriceInfo").val("- " + setComma(TotalUseMileage+TotalUseBonusCoupon+TotalUseGoodsCoupon+TotalUseFreeCoupon) + " 원"); //펼쳤을 때 할인금액
		
		$("#TotalDiscountPriceSum").text(setComma(TotalUseMileage+TotalUseBonusCoupon+TotalUseGoodsCoupon+TotalUseFreeCoupon+TotalPriceMemberLevelDiscount));

		$("input[name=TotalPriceAmount]").val(TotalPriceAmount);
		$("#TotalPriceAmount").text(setComma(TotalPriceAmount));
		$("#TotalPriceAmount2").text(setComma(TotalPriceAmount));
		$("#UseMileageAll").val(TotalPriceAmount);

	}

	fnInitDiscountTable = function(){

		$("select[name=BonusCouponIdx] option:eq(0)").prop("selected",true); // 보너스쿠폰 초기화, 상품쿠폰 추가시 상품쿠폰 초기화 추가해야 함
		$("select[name=FreeCouponIdx] option:eq(0)").prop("selected",true); // 무료배송쿠폰 초기화

		$("#UseMileageAll").prop("checked",false); // 꿈캔디 모두사용

		$("input[name=TotalUseMileage]").val(0); // 실제값들
		$("input[name=TotalUseBonusCoupon]").val(0);
		$("input[name=TotalUseGoodsCoupon]").val(0);
		$("input[name=TotalUseFreeCoupon]").val(0);

		$("#CouponTypeNull").prop("checked",true);
		$("#CouponIdxSelect_Null").attr("class","");
		$("#CouponIdxSelect_Bonus").attr("class","none");
		$("#CouponIdxSelect_Goods").attr("class","none");

		fnCouponType();
	}

	fnCouponType = function() {
		var x = document.Order.CouponType;
		var GoodsCouponPrice = document.Order.TotalUseGoodsCoupon.alt;

		if (x[1].checked) // 보너스 쿠폰
		{
			
			// 상품쿠폰 초기화
			$("input[name=TotalUseGoodsCoupon]").val(0);			
			$("#TotalUseGoodsCoupon").text("- 0");
			fnTotalPriceAmount();

			// 보너스쿠폰 회귀
			fnCouponSelect(document.getElementById("CouponIdxSelect_Bonus"));

			$("#CouponIdxSelect_Bonus").css("display","block");
			$("#CouponIdxSelect_Goods").css("display","none");
		}
		else if (x[2].checked) // 상품 쿠폰
		{
			// 보너스쿠폰 초기화
			$("input[name=TotalUseBonusCoupon]").val(0);
			$("#TotalUseBonusCoupon").text("- 0");
			// 상품쿠폰 초기화
			$("input[name=TotalUseGoodsCoupon]").val(GoodsCouponPrice);
			$("#TotalUseGoodsCoupon").text("- "+setComma(GoodsCouponPrice));

			$("[name=BonusCouponIdx] option:eq(0)").prop("selected", true);

			fnTotalPriceAmount();

			$("#CouponIdxSelect_Bonus").css("display","none");
			$("#CouponIdxSelect_Goods").css("display","block");
		}
		else // 사용안함
		{
			// 보너스쿠폰 초기화
			$("input[name=TotalUseBonusCoupon]").val(0);
			$("#TotalUseBonusCoupon").text("- 0");
			// 상품쿠폰 초기화
			$("input[name=TotalUseGoodsCoupon]").val(0);
			$("#TotalUseGoodsCoupon").text("- 0");

			$("[name=BonusCouponIdx] option:eq(0)").prop("selected", true);


			fnTotalPriceAmount();

			$("#CouponIdxSelect_Bonus").css("display","none");
			$("#CouponIdxSelect_Goods").css("display","none");
		}
	}



	fnOrderReady = function() {

		var f = document.Order;

		if (!$.trim(f.memname.value))
		{
			alert("주문자명을 입력해주세요.");
			f.memname.focus();
			return;
		}

//		re= /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
//		re = /[\{\}\[\]\/?.,;:|~`!^\-_+┼<>@\#$%&\'\"\\\=]/gi;
		re = /^[가-힣a-zA-Z0-9\s]+$/;
		var temp=$("[name=memname]").val();
		if(temp.length >= 2){	
			if(!re.test(temp))
			{ 
				alert("주문자명에 특수문자는 입력하실 수 없습니다."); 
				f.memname.focus();
				return;
			}
		}
		else
		{
			alert("주문자명을 2자 이상 입력해주세요."); 
			f.memname.focus();
			return;
		}



		if (!f.mememail.value)
		{
			alert("이메일 주소를 입력해주세요.");
			f.mememail.focus();
			return;
		}

		f.mememail1.value = f.mememail.value.split("@")[0];
		f.mememail2.value = f.mememail.value.split("@")[1];

		if (!f.memcpnum1.value||!f.memcpnum2.value||!f.memcpnum3.value)
		{
			alert("휴대폰 번호를 입력해주세요.");
			f.memcpnum.focus();
			return;
		}
		
		
		if (!$.trim(f.shipname.value))
		{
			alert("수령인명을 입력해주세요.");
			f.shipname.focus();
			return;
		}

		temp=$("[name=shipname]").val();
		if(temp.length >= 2){	
			if(!re.test(temp))
			{ 
				alert("수령인명에 특수문자는 입력하실 수 없습니다."); 
				f.shipname.focus();
				return;
			}
		}
		else
		{
			alert("수령인명을 2자 이상 입력해주세요."); 
			f.shipname.focus();
			return;
		}

		if (!f.shipcpnum1.value||!f.shipcpnum2.value||!f.shipcpnum3.value)
		{
			alert("휴대폰 번호를 입력해주세요.");
			f.shipcpnum3.focus();
			return;
		}

		var ExceptNumber = "000-0000¶¶111-1111¶¶222-2222¶¶333-3333¶¶444-4444¶¶555-5555¶¶666-6666¶¶777-7777¶¶888-8888¶¶999-9999¶¶0000-0000¶¶1111-1111¶¶2222-2222¶¶3333-3333¶¶4444-4444¶¶5555-5555¶¶6666-6666¶¶7777-7777¶¶8888-8888¶¶9999-9999¶¶000-1234¶¶123-1234¶¶1234-1234¶¶0000-1234¶¶";
		var findStr = f.shipcpnum2.value + "-" + f.shipcpnum3.value;
	
		if (ExceptNumber.indexOf(findStr) != -1) 
		{
			alert("연락 가능한 번호로 기재해주세요.");
			f.shipcpnum3.focus();
			return false;
		}

		if (!f.shipzipcode.value||!f.shipaddr.value||!f.shipaddrd.value)
		{
			alert("주소를 입력해주세요.");
			f.shipaddrd.focus();
			return;
		}
		
		
		
		if (($("input:radio[name=PayType]:checked").val() == "HPP" || $("input:radio[name=PayType]:checked").val() == "M_HPP" ) && parseInt($("input[name=TotalPriceAmount]").val(),10) < 100 )
		{
			alert("휴대폰 결제는 실결제액이 100원 이상이어야 합니다.");
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
		

		/*결제하기 한번만 실행되도록.. 기본값 N 20180911 차성환*/
		if ( $("[name=DoubleYn]").val() == "Y" )
		{
			return;
		}

		$("[name=DoubleYn]").val("Y");


		if ($("#OrderPayInfoNonPay").css("display") == "block"){

			var FixTotalPriceAmountText = document.getElementById("FixTotalPriceAmount").innerHTML;

			document.getElementById("OrderBuyButton1").innerHTML = "<a class=\"btnModify\" href=\"javascript:alert('결제가 진행중입니다. 결제가 올바르지 않게 종료된 경우에는 새로고침 후 다시 시도해주세요.\\n\\n계속해서 같은 증상이 반복될 경우 고객센터로 연락바랍니다.');\">결제하기</a>";
			document.getElementById("OrderBuyButton2").innerHTML = "<a href=\"javascript:alert('결제가 진행중입니다. 결제가 올바르지 않게 종료된 경우에는 새로고침 후 다시 시도해주세요.\\n\\n계속해서 같은 증상이 반복될 경우 고객센터로 연락바랍니다.');\" id=\"FixTotalPriceAmount\">" + FixTotalPriceAmountText + "</a>";
		}

		fnGaSend(); 




		
		f.submit();
		
	}

	
	fnDeliveryInfo(1); //배송지 정보 - 기본 배송지로 설정
	$("#MyDelivery1 select option:eq(1)").prop("selected",true);
	$("#MyDelivery1 select").trigger("change");
	//fnSelectMyDelivery($("#MyDelivery1 select"));
	$("#SectionNonMember").css("display","none");

	
	fnPopupCheck();

	fnTotalPriceAmount();

});


function Check_Number(str) { // only number
	var reg = /^[0-9]*$/;
	return reg.test(str);
}

</script>

</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->


<script type="text/javascript">

function execDaumPostCode() { // 우편번호
	new daum.Postcode({
		oncomplete: function(data) {
		// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		// 각 주소의 노출 규칙에 따라 주소를 조합한다.
		// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		var addr = ''; // 주소 변수
		var extraAddr = ''; // 참고항목 변수

		//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
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

</script>


<form method="post" name="Order" enctype="application/x-www-form-urlencoded" target="artboxorderproc" action="OrderPayComplete.jsp">
<div class="OrderWrap" id="OrderWrap">
	<h1>주문하기</h1>
	
	<div class="SectionItemList">
		<div class="OrderInfoTitle">
			<h2>주문상품 정보
			<small>
			<c:choose>
    <c:when test="${fn:length(productList) == 1}">
        ${productList[0].product_name } (${productList[0].product_code })
    </c:when>
    <c:otherwise>
         ${productList[0].product_name } (${productList[0].product_code }) 외 ${fn:length(productList)-1}개
    </c:otherwise>
			</c:choose>
				
			</small><a class="Open" id="OrderItemListArrow" href="javascript:fnOrderInfoTitle('OrderItemList','','');"></a><div class="clear"></div></h2>
		</div>
		<div id="OrderItemList">
			<input type="hidden" name="BuyType" value="Internal" />
			<input type="hidden" id="MemAlwaysRate" value="0" />
			<input type="hidden" id="MemMileageSaveRate" value="1" />
		
<c:forEach var="productList" items="${productList }" varStatus="status">
	<c:set var="price" value="${productList.product_price }"/>
			<div class="tableDiv">
				<dl class="trOrderItem 2002200265">
					<dt class="tdImage"><a href="productDetail.cart?product_num=${productList.product_num }"><img src="cart/${productList.product_image }"/></a></dt>
					<dt class="tdInner">
						<div class="CartListItemName">${productList.product_name } (${productList.product_code })
						</div>
						<div class="CartListPrice">
						 / <fmt:formatNumber value="${price }" pattern="#,###"/>원 X ${cartList[status.index].cart_quantity }개
						</div>
					</dt>
					<dt class="tdPrice">
						<fmt:formatNumber value="${price*cartList[status.index].cart_quantity }" pattern="#,###"/>원
					</dt>
				</dl>
			</div>
</c:forEach>
			<input type="hidden" name="CartIdx" value="3318798" />
			<input type="hidden" name="ItemIdx" value="2002200265" />
			<input type="hidden" name="MileageSave" value="250" />
			<input type="hidden" name="ItemQty" value="1" />
			<input type="hidden" name="ItemPrice" value="25000" />
			<input type="hidden" name="MemDiscount" value="1" />
			<input type="hidden" name="RealPrice" value="25000" />
			<input type="hidden" name="SaleYN" value="N" />
			<input type="hidden" name="TaxFreeYN" value="N" />
			<input type="hidden" name="OptionMixIdx" value="" />
			<input type="hidden" name="OptionMessage" value="" />
			<input type="hidden" name="DoubleYn" value="N" />
		
		</div>
	
		<input type="hidden" name="Event_350won" value="N"/>
		<input type="hidden" name="giftrealcnt" value="0" />
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
						<input type="text" id="i_memname" name="memname" maxlength="16" value="${memberList[0].name }" />
						<p class="null"></p>
					</dd>
				</dl>
				<dl class="trOrder">
					<dt>이메일</dt>
					<dd>
						<input type="text" id="i_mememail" name="mememail" maxlength="50" value="${memberList[0].email }" placeholder="예) example@artbox.co.kr" />
						<p class="null"></p>
						<input type="hidden" name="mememail1" />
						<input type="hidden" name="mememail2" />
					</dd>
				</dl>
			</div>
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>휴대전화</dt>
					<c:set var="phonearr" value="${memberList[0].phone}" />
					<c:set var="phone" value="${fn:split(phonearr, '-')}" />
					<dd>
    
						<input type="tel" id="i_memcpnum1" name="memcpnum1" maxlength="2" value="${phone[0] }" />
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
				<dl class="trOrder">
					<dt>일반전화</dt>
					<dd>
						<input type="tel" id="i_memphone1" name="memphone1" maxlength="3" value="" />
					</dd>
					<dd class="blank">&#8210;</dd>
					<dd>
						<input type="tel" id="i_memphone2" name="memphone2" maxlength="4" value="" />
					</dd>
					<dd class="blank">&#8210;</dd>
					<dd>
						<input type="tel" id="i_memphone3" name="memphone3" maxlength="4" value="" />
					</dd>
				</dl>
			</div>
		</div>
		<div class="gap20px"></div>
		<div class="gap20px"></div>
		<div class="OrderInfoTitle">
			<h2>배송지 정보<a class="Open" id="OrderShipInfoArrow" href="javascript:fnOrderInfoTitle('OrderShipInfo','i_shipname','i_shipname_summary');"></a><div class="clear"></div></h2>
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
					
					<option value="${memberList[0].name}¶¶${memberList[0].postcode}¶¶${memberList[0].addr_basic}¶¶${memberList[0].addr_detail}¶¶${phone[0] }¶¶${phone[1] }¶¶${phone[2] }¶¶¶¶¶¶">자택</option>
					
				</select>
				<p class="null"></p>
			</div>
			<div class="DeliverySelect" id="MyDelivery2">
			
				<select><option value="" selected="selected">최근 배송지가 없습니다.</option></select>
					
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
				<dl class="trOrder">
					<dt>일반전화</dt>
					<dd>
						<input type="tel" id="i_shipphone1" name="shipphone1" maxlength="3" />
						<p class="null"></p>
					</dd>
					<dd class="blank">&#8210;</dd>
					<dd>
						<input type="tel" id="i_shipphone2" name="shipphone2" maxlength="4" />
						<p class="null"></p>
					</dd>
					<dd class="blank">&#8210;</dd>
					<dd>
						<input type="tel" id="i_shipphone3" name="shipphone3" maxlength="4" />
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
				<input type="checkbox" id="i_modifyshipaddr" name="modifyshipaddr" value="Y" /> 현재 입력된 배송지를 기본 배송지로 설정<span class="MobileBr"><p class="null"></p></span>
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
						<input type="text" id="i_TotalDiscountPriceInfo_summary" name="TotalDiscountPriceInfo_summary" maxlength="16" value="- 0 원" class="readonly" readonly="readonly" />
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
						<input type="radio" id="CouponTypeNull" name="CouponType" value="Null" checked="checked" /> 선택안함
						&nbsp;&nbsp;<span class="MobileBr"><p class="null"></p></span>
						<input type="radio" id="CouponTypeBonus" name="CouponType" value="Bonus" /> 보너스쿠폰 (<span id="BonusCouponTotCnt">0</span>장)
						&nbsp;&nbsp;<span class="MobileBr"><p class="null"></p></span>
						<input type="radio" id="CouponTypeGoods" name="CouponType" value="Goods" /> 상품쿠폰 (<span id="GoodsCouponTotCnt">0</span>장)
					</dd>
				</dl>
			</div>
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>&nbsp;</dt>
					<dd>
						<select id="CouponIdxSelect_Null">
							<option value="" selected="selected">사용안함</option>
						</select>
						
						<select name="BonusCouponIdx" id="CouponIdxSelect_Bonus" disabled="disabled" class="none">
							<option value="" alt="0" selected="selected">해당 쿠폰이 없습니다.</option>
						</select>
						
						<input type="hidden" id="NotCoupon" value="N" />

						<div id="CouponIdxSelect_Goods" class="none">
						
							&#10003; 사용 가능한 상품 쿠폰이 없습니다.<br />
						
							<script type="text/javascript">document.getElementById("GoodsCouponTotCnt").innerHTML=setComma("0");</script>
						</div>
						<p class="null"></p>
					</dd>
				</dl>
				<dl class="trOrder">
					<dt>무료배송쿠폰</dt>
					<dd>
					
						<select name="FreeCouponIdx" id="CouponIdxSelect_Free" onchange="fnCouponSelect(this);" >
							<option value="" alt="0" selected="selected">선택</option>
							
							<option value="52183406" alt="2500">가입회원 무료배송쿠폰</option>
							
						</select>
					
						<p class="null"></p>
					</dd>
				</dl>
			</div>
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>꿈캔디</dt>
					<dd>
						<input type="tel" id="i_UseMileagePrice" name="UseMileagePrice" maxlength="7" value="0" />
						<input type="hidden" name="MemMileage" value="0" />
						<p class="null"></p>
					</dd>
					<dt class="mileage">&nbsp;개</dt>
				</dl>
			</div>
			<div class="ModifyShipAddr">
				<input type="checkbox" type="checkbox" id="UseMileageAll" value="0" alt="0" onclick="if(this.checked){fnUseMileageAll(1);}else{fnUseMileageAll(0);}" /> 모두사용 (사용 가능 꿈캔디 0개)
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
				<dd><span id="TotalPriceSum">25,000</span> 원<input type="hidden" name="TotalPriceSum" value="25000" /></dd>
			</dl>
			<dl class="trPrice">
				<dt>배송비</dt>
				<dd><span id="TotalPriceDelivery">2,500</span> 원<input type="hidden" name="TotalPriceDelivery" value="2500" /></dd>
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
					<dd class="grade5"><span id="TotalPriceMemberLevelDiscount">- 0</span> 원 [<img src="../Images/order/pc_top_grade5.png" />0%]<input type="hidden" name="TotalPriceMemberLevelDiscount" value="0" /></dd>
				</dl>
				<dl class="trPrice">
					<dt>보너스 쿠폰</dt>
					<dd><span id="TotalUseBonusCoupon">- 0</span> 원<input type="hidden" name="TotalUseBonusCoupon" value="0" /></dd>
				</dl>
				<dl class="trPrice">
					<dt>상품 쿠폰</dt>
					<dd><span id="TotalUseGoodsCoupon">- 0</span> 원<input type="hidden" name="TotalUseGoodsCoupon" value="0" alt="0" /></dd>
				</dl>
				<dl class="trPrice">
					<dt>무료배송 쿠폰</dt>
					<dd><span id="TotalUseFreeCoupon">- 0</span> 원<input type="hidden" name="TotalUseFreeCoupon" value="0" /></dd>
				</dl>
				<dl class="trPrice">
					<dt>꿈캔디 사용</dt>
					<dd><span id="TotalUseMileage">- 0</span> 원<input type="hidden" name="TotalUseMileage" value="0" /></dd>
				</dl>
			</div>
		</div>
		<div class="TotalPriceAmount">
			총 결제금액 <span id="TotalPriceAmount">27,500</span> 원<br />&nbsp;<br />
			<small>(적립 예정 꿈캔디 <span id="TotalMileageAmount">250</span>개)</small>
			<input type="hidden" name="TotalPriceAmount" value="27500" />
			<input type="hidden" name="TotalMileageAmount" value="250" />
		</div>


		<script>
			$(document).on("click",".TermsInform li", function(){
				var x = $(this).attr("alt");

				$(".TermsInform li").removeClass("on");
				$(this).addClass("on");

				$("#bnbn1").css("display", "none");
				$("#bnbn2").css("display", "none");
				$("#bnbn3").css("display", "none");

				$("#bnbn"+x).css("display", "block");
			});

			$(document).on("mouseleave",".TermsInform", function(){
				if ($(window).width() >= 1200) {
					$(".TermsInform").css("display","none");
				}
			});

			$(document).on("mouseover",".AgreeDetail", function(){
				if ($(window).width() >= 1200) {
					var x = $(this).attr("alt");
					$("#AgreeDetail_"+x).css("display","block");
				}
			});
		</script>


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
					<a class="btnCancel" href="listCart.cart">장바구니</a>
				</dd>
				<dd>&nbsp;</dd>
				<dd class="twoBtn" id="OrderBuyButton1">
<!-- 					<a class="btnModify" href="javascript:fnOrderReady();">결제하기</a> -->
					<a class="btnModify" href="OrderComplete.complete">결제하기</a>
				</dd>
			</dl>
		</div>



	</div>
	
	<div class="clear"></div>
</div>

<div class="BottomFix">
	<div class="OrderPayAgree2"><input type="checkbox" id="i_OrderPayAgree2" name="OrderPayAgree2" value="Y" />약관 전체 동의하기<div class="clear"></div></div>
	<span id="OrderBuyButton2"><a href="javascript:fnOrderReady();" id="FixTotalPriceAmount"><span id="TotalPriceAmount2">0</span>원 결제하기</a></span>
</div>

</form>
<form id="SendPayForm_id" name="SendPayForm_id" method="POST">
	<input type="hidden" name="version" value="1.0" />
	<input type="hidden" name="mid" />
	<input type="hidden" name="goodname" value="핑크 비숑 13인치 노트북파우치 (37002786)" />
	<input type="hidden" name="oid" />
	<input type="hidden" name="price" />
	<input type="hidden" name="tax" />
	<input type="hidden" name="taxfree" />
	<input type="hidden" name="currency" value="WON" />
	<input type="hidden" name="buyername" />
	<input type="hidden" name="buyertel" />
	<input type="hidden" name="buyeremail" />
	<input type="hidden" name="timestamp" />
	<input type="hidden" name="signature" />
	<input type="hidden" name="returnUrl" value="https://www.artboxmall.com:443/Home/Order/OrderPayReturn.asp" />
	<input type="hidden" name="mKey" />
	<input type="hidden" name="gopaymethod" />
	<input type="hidden" name="offerPeriod" />
	<input type="hidden" name="acceptmethod" />
	<input type="hidden" name="languageView" value="ko" />
	<input type="hidden" name="charset" value="UTF-8" />
	<input type="hidden" name="payViewType" value="overlay" /> 
	<input type="hidden" name="closeUrl" value="https://www.artboxmall.com:443/Home/Order/Inicis/close.asp" />
	<input type="hidden" name="popupUrl" value="https://www.artboxmall.com:443/Home/Order/Inicis/popup.asp" />
	<input type="hidden" name="quotabase" value="2:3:4:5:6:7:8:9:10:11:12" />
	<input type="hidden" name="ini_cardcode" />
	<input type="hidden" name="ansim_quota" />
	<input type="hidden" name="vbankRegNo" />
	<input type="hidden" name="merchantData" />
</form>


<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>
