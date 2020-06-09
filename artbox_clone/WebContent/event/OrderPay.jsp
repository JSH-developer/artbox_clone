<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
ArrayList<CouponBean> myCouponList= (ArrayList<CouponBean>)request.getAttribute("mycouponList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<!-- <link href="../css/order/Common.css" rel="stylesheet" type="text/css"> -->
<link href="${pageContext.request.contextPath}/css/order/Order.css" rel="stylesheet" type="text/css">
<!-- <link href="../css/order/PopZipCode.css" rel="stylesheet" type="text/css"> -->

<!-- <script type="text/javascript" src="../js/PopZipCodeJson.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	function setComma(number) //asp의 formatnumber 사용법 -> var xxx = setComma(parseInt(변수));
	{
		var minusYN = "N";
		if (parseInt(number,10)<0)
		{
			minusYN = "Y";
			number = parseInt(number,10)*-1;
		}

		var nArr = String(number).split("").join(",").split("");
		for (var i=nArr.length-1, j=1; i>=0; i--, j++)
		{
			 if( j%6 != 0 && j%2 == 0)
			 {
				 nArr[i] = "";
			 }
		}
		if (minusYN=="Y")
		{
			return "-"+nArr.join("");
		}
		else
		{
			return nArr.join("");
		}
	}
	

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

	/* 결제타입 선택 */
	$("input[name=PayType]").click(function(){

		var r_val = $(this).val();

		if ( $(this).hasClass("nomootong") )
		{
			if ( $("[name=Event_350won]").val() == "Y" )
			{
				alert("이벤트 상품은 무통장 입금이 불가합니다.");
			}
			else
			{
				alert("해당 상품은 무통장 입금 결제가 불가합니다.");
			}
			$("input[name=PayType]").prop("checked","disabled");
			$("input[name=PayType]:first").prop("checked","checked");
			$("#PayType_Card").css("display","none");
			$("#PayType_DirectBank").css("display","none");
			$("#PayType_VBank").css("display","none");
			$("#PayType_HPP").css("display","none");
			$("#PayType_PAYCO2").css("display","none");
			$("#PayType_SSPAY").css("display","none");
			$("#PayType_KAKAOPAY").css("display","none");
			$("#PayType_E_DirectBank").css("display","none");
			$("#PayType_E_VBank").css("display","none");
			$("#PayType_M_CARD").css("display","none");
			$("#PayType_M_DBANK").css("display","none");
			$("#PayType_M_VBANK").css("display","none");
			$("#PayType_M_HPP").css("display","none");
			$("#PayType_M_PAYCO2").css("display","none");
			$("#PayType_M_SSPAY").css("display","none");
			$("#PayType_M_KAKAOPAY").css("display","none");

			
				$("#PayType_Card").css("display","block");
			
			return;
		}
		else
		{
			$("#PayType_Card").css("display","none");
			$("#PayType_DirectBank").css("display","none");
			$("#PayType_VBank").css("display","none");
			$("#PayType_HPP").css("display","none");
			$("#PayType_PAYCO2").css("display","none");
			$("#PayType_SSPAY").css("display","none");
			$("#PayType_KAKAOPAY").css("display","none");
			$("#PayType_E_DirectBank").css("display","none");
			$("#PayType_E_VBank").css("display","none");
			$("#PayType_M_CARD").css("display","none");
			$("#PayType_M_DBANK").css("display","none");
			$("#PayType_M_VBANK").css("display","none");
			$("#PayType_M_HPP").css("display","none");
			$("#PayType_M_PAYCO2").css("display","none");
			$("#PayType_M_SSPAY").css("display","none");
			$("#PayType_M_KAKAOPAY").css("display","none");

			$("#PayType_"+$("input[name=PayType]:checked").val()).css("display","block");
		}

		switch(r_val){ //ga에서 쓰는 변수
			case "Card": $("#gaPayTypeTextTemp").val("신용카드"); break;
			case "DirectBank": $("#gaPayTypeTextTemp").val("실시간 계좌이체"); break;
			case "VBank": $("#gaPayTypeTextTemp").val("무통장 입금(가상 계좌)"); break;
			case "PAYCO2": $("#gaPayTypeTextTemp").val("PAYCO2"); break;
			case "SSPAY": $("#gaPayTypeTextTemp").val("SSPAY"); break;
			case "KAKAOPAY": $("#gaPayTypeTextTemp").val("KAKAOPAY"); break;
			case "E_DirectBank": $("#gaPayTypeTextTemp").val("에스크로(실시간 계좌이체)"); break;
			case "E_VBank": $("#gaPayTypeTextTemp").val("에스크로(가상 계좌)"); break;
			case "HPP": $("#gaPayTypeTextTemp").val("휴대폰 결제"); break;
			default: $("#gaPayTypeTextTemp").val("신용카드");
		}

		$("#gaPayTypeText").val($("#gaPayTypeTextTemp").val());
	});

	/*
	$("input[name=PayType_Card_Check0],input[name=PayType_M_CARD_Check0],input[name=PayType_M_SSPAY_Check0],input[name=PayType_PAYCO2_Check0],input[name=PayType_M_PAYCO2_Check0],input[name=PayType_SSPAY_Check0]").click(function(){
		var objName = $(this).attr("name").replace("0","");

		if ($(this).prop("checked")) {
			$("input[name="+objName+"1]").prop("checked",true);
			$("input[name="+objName+"2]").prop("checked",true);
			$("input[name="+objName+"3]").prop("checked",true);
			$("input[name="+objName+"4]").prop("checked",true);
		} else {
			$("input[name="+objName+"1]").prop("checked",false);
			$("input[name="+objName+"2]").prop("checked",false);
			$("input[name="+objName+"3]").prop("checked",false);
			$("input[name="+objName+"4]").prop("checked",false);
		}
	});
	*/

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


/* 팝업창 체크 부분
	fnPopupCheck = function() {
		var PopupCheck = window.open("http://www.artboxmall.com/Home/Order/PopupCheck.html","artbox_PopupCheck","width=1,height=1,left=0,top=0,resizable=no,menubar=no,scrollbars=yes,status=no,toolbar=no");
		if ( PopupCheck == null){
			alert("팝업차단 또는 신뢰사이트 설정을 확인 해주세요.\n팝업 차단 기능을 해제한 후 다시 시도하세요.\n설정 이후 [페이지 새로고침]이 필요합니다.");
		}
	}
*/

/* 무통장입금 - 환불계좌
	fnRefundSave = function(){

		if ($("input[name=RefundName]").val() == ""){
			alert('환불 계좌 예금주를 입력해주세요.');
			$("input[name=RefundName]").focus();
			return;
		}
		if ($("select[name=RefundBankCode]").val() == ""){
			alert('환불 계좌 은행명을 선택해주세요.');
			$("select[name=RefundBankCode]").focus();
			return;
		}
		if ($("input[name=RefundAccount]").val() == ""){
			alert('환불 계좌 졔좌번호를 입력해주세요.');
			$("input[name=RefundAccount]").focus();
			return;
		}
		if ($("select[name=RefundRelation]").val() == ""){
			alert('환불 계좌 관계를 선택해주세요.');
			$("select[name=RefundRelation]").focus();
			return;
		}

		var param = "RefundName="+$("input[name=RefundName]").val()+"&RefundBankCode="+$("select[name=RefundBankCode]").val()+"&RefundAccount="+$("input[name=RefundAccount]").val()+"&RefundRelation="+$("select[name=RefundRelation]").val();

		$.ajax({ 
			type: "POST", 
			url: "OrderPayRefundAjax.asp",
			data: param, 
			success: function(data)	{ 
				alert(data);				
				return true;
			}
		});		
	}
*/

	fnOrderInfoTitle = function(obj,obj2,obj3){

		var PayTypeText;

		if ($("#"+obj).css("display")=="block" ) {
			$("#"+obj).css("display","none");
			$("#"+obj+"Summary").css("display","block");
			$("#"+obj+"Arrow").attr("class","Close");

			if (obj2!=""&&obj3!="") {
				if (obj2=="i_PayType_summary") {
					PayTypeText = $("input[name=PayType]:checked").attr("title");
					if (PayTypeText=="신용카드"&&$("select[name=ini_cardcode]").val()!="") {
						PayTypeText = PayTypeText + "(" + $("select[name=ini_cardcode]").find(":selected").text() + ")";
					}

					$("#"+obj3).val(PayTypeText);
				} else {
					$("#"+obj3).val($("#"+obj2).val());
				}
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

	// 쿠폰 선택한거 여기로 옴
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

		if (TotalPriceAmount<=0) { //논페이 열기
			$("#OrderPayInfoNonPay").css("display","block");
			$("#OrderPayInfoArrow").css("display","none");
			$("#OrderPayInfoSummary").css("display","none");
			$("#OrderPayInfo").css("display","none");

			$("#gaPayTypeText").val("포인트 결제");

		} else { //논페이 닫기
			$("#OrderPayInfoNonPay").css("display","none");
			$("#OrderPayInfoArrow").css("display","block");
			$("#OrderPayInfoArrow").attr("class","Open");
			$("#OrderPayInfoSummary").css("display","none");
			$("#OrderPayInfo").css("display","block");

			$("#gaPayTypeText").val($("#gaPayTypeTextTemp").val());
		}
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


		if (parseInt($("input[name=TotalPriceAmount]").val(),10)>0){



			if ($("input[name=PayType]:checked").val() == "M_CARD"){
				if ($("select[name=ini_cardcode]").val()=="") {
					alert("카드종류를 선택해주세요.");
					$("select[name=ini_cardcode]").focus();
					return;
				}
			} else if ($("input[name=PayType]:checked").val() == "Card"){
				if ($("select[name=ini_cardcode]").val()=="") {
					alert("카드종류를 선택해주세요.");
					$("select[name=ini_cardcode]").focus();
					return;
				}
			}
			else if ($("input:radio[name=PayType]:checked").val() == "VBank"){
				if ($("input[name=RefundName]").val() == ""){
					alert('환불 계좌 예금주를 입력해주세요.');
					$("input[name=RefundName]").focus();
					return;
				}
				if ($("select[name=RefundBankCode]").val() == ""){
					alert('환불 계좌 은행명을 선택해주세요.');
					$("select[name=RefundBankCode]").focus();
					return;
				}
				if ($("input[name=RefundAccount]").val() == ""){
					alert('환불 계좌 졔좌번호를 입력해주세요.');
					$("input[name=RefundAccount]").focus();
					return;
				}
				if ($("select[name=RefundRelation]").val() == ""){
					alert('환불 계좌 관계를 선택해주세요.');
					$("select[name=RefundRelation]").focus();
					return;
				}
				if (!$("input[name=SaveRefundCheck]").prop("checked")){
					alert('환불 계좌 전체 내용을 확인해주세요.');
					$("input[name=SaveRefundCheck]").focus();
					return;
				}
			}



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

	fnInicisBegin = function(OrderIdx,OrderNumber,ini_price,ini_tax,ini_taxfree,ini_timestamp,ini_signature) {

		//alert(OrderIdx+"\n"+OrderIdx+"\n"+OrderNumber+"\n"+ini_price+"\n"+ini_tax+"\n"+ini_taxfree+"\n"+ini_timestamp+"\n"+ini_signature);
		//return;

		var f1 = document.Order;
		var f2 = document.SendPayForm_id;
		var PayType = $("input:radio[name=PayType]:checked").val();

		var mid = "artbox0005";
		var mKey = "1d0b635d42f4912d5081e1ae8a7599077d417fb9bf43f25e1e3debaef4fa9fe5";
		
		if (PayType=="E_DirectBank"||PayType=="E_VBank") {
			mid = "IESartbox1";
			mKey = "24da1b96fcc41a62252f909fd467ecf39364bedc86b66ea96a7b04a7db38d5b6";
		}


		f2.mid.value = mid;
		f2.mKey.value = mKey;

		var oid = OrderNumber;
		f2.oid.value = oid;

		var price = ini_price;
		f2.price.value = price;

		var tax = ini_tax;
		f2.tax.value = tax;

		var taxfree = ini_taxfree;
		f2.taxfree.value = taxfree;

		var buyername = f1.memname.value;
		f2.buyername.value = buyername;

		var buyertel = f1.memcpnum1.value+"-"+f1.memcpnum2.value+"-"+f1.memcpnum3.value;
		f2.buyertel.value = buyertel;

		var buyeremail = f1.mememail1.value+"@"+f1.mememail2.value;;
		f2.buyeremail.value = buyeremail;

		var timestamp = ini_timestamp;
		f2.timestamp.value = timestamp;

		var signature = ini_signature;
		f2.signature.value = signature;

		var gopaymethod = "";
		var acceptmethod = "vbank(20200507):va_receipt:vbanknoreg:popreturn:HPP(2):below1000:cardonly";



		if (PayType=="Card") {

			if (f1.ini_cardcode.value=="26") {
				gopaymethod = "Card";
				acceptmethod = acceptmethod + ":ini_onlycardcode(" + f1.ini_cardcode.value + ")";
			} else if (f1.ini_cardcode.value=="06"||f1.ini_cardcode.value=="11"||f1.ini_cardcode.value=="32"||f1.ini_cardcode.value=="33"||f1.ini_cardcode.value=="44"||f1.ini_cardcode.value=="48"||f1.ini_cardcode.value=="51"||f1.ini_cardcode.value=="52"||f1.ini_cardcode.value=="54"||f1.ini_cardcode.value=="56"||f1.ini_cardcode.value=="71"||f1.ini_cardcode.value=="95") {
				gopaymethod = "onlyisp";
			} else {
				gopaymethod = "onlyacard";
			}

			f2.ini_cardcode.value = f1.ini_cardcode.value;
			f2.ansim_quota.value = f1.ansim_quota.value;

		} else if (PayType=="DirectBank") {
			gopaymethod = "DirectBank";
		} else if (PayType=="VBank") {
			gopaymethod = "VBank";
		} else if (PayType=="E_DirectBank") {
			gopaymethod = "DirectBank";
		} else if (PayType=="PAYCO2") {
			gopaymethod = "onlypayco";
		} else if (PayType=="SSPAY") {
			gopaymethod = "onlyssp";
		} else if (PayType=="KAKAOPAY") {
			gopaymethod = "onlykakaopay";
		} else if (PayType=="HPP") {
			gopaymethod = "HPP";
		} else if (PayType=="E_VBank") {
			gopaymethod = "VBank";
		}

		f2.gopaymethod.value = gopaymethod;
		f2.acceptmethod.value = acceptmethod;


		var merchantData = OrderIdx;
		f2.merchantData.value = merchantData;

		var debug = "PayType : " + PayType;
		debug += "\n version : " + f2.version.value;
		debug += "\n mid : " + f2.mid.value;
		debug += "\n goodname : " + f2.goodname.value;
		debug += "\n oid : " + f2.oid.value;
		debug += "\n price : " + f2.price.value;
		debug += "\n tax : " + f2.tax.value;
		debug += "\n taxfree : " + f2.taxfree.value;
		debug += "\n currency : " + f2.currency.value;
		debug += "\n buyername : " + f2.buyername.value;
		debug += "\n buyertel : " + f2.buyertel.value;
		debug += "\n buyeremail : " + f2.buyeremail.value;
		debug += "\n timestamp : " + f2.timestamp.value;
		debug += "\n signature : " + f2.signature.value;
		debug += "\n returnUrl : " + f2.returnUrl.value;
		debug += "\n mKey : " + f2.mKey.value;
		debug += "\n gopaymethod : " + f2.gopaymethod.value;
		debug += "\n offerPeriod : " + f2.offerPeriod.value;
		debug += "\n acceptmethod : " + f2.acceptmethod.value;
		debug += "\n languageView : " + f2.languageView.value;
		debug += "\n charset : " + f2.charset.value;
		debug += "\n payViewType : " + f2.payViewType.value;
		debug += "\n closeUrl : " + f2.closeUrl.value;
		debug += "\n popupUrl : " + f2.popupUrl.value;
		debug += "\n ini_cardcode : " + f2.ini_cardcode.value;
		debug += "\n ansim_quota : " + f2.ansim_quota.value;
		debug += "\n vbankRegNo : " + f2.vbankRegNo.value;
		debug += "\n merchantData : " + f2.merchantData.value;
		//alert(debug);

		INIStdPay.pay("SendPayForm_id");
	}

	
	fnDeliveryInfo(1); //배송지 정보 - 기본 배송지로 설정
	$("#MyDelivery1 select option:eq(1)").prop("selected",true);
	$("#MyDelivery1 select").trigger("change");
	//fnSelectMyDelivery($("#MyDelivery1 select"));
	$("#SectionNonMember").css("display","none");

	
	//선택한 결제수단 처리
	$("input[name=PayType]").each(function(){
		if ($(this).hasClass("nonepay"))
		{
			$(this).prop("checked", false);
		}
		else
		{
			if ($(this).val() == "Card" ||  $(this).attr("data-value") == "Card")
			{
				$(this).prop("checked", true);
			}
			else
			{
				$(this).prop("checked", false);
			}
		}
	});

	if ( $("input:radio[name=PayType]:checked").val() == "" ||  $("input:radio[name=PayType]:checked").val() == undefined)
	{
		$("input:radio[name=PayType]").eq(0).prop("checked", true);
	}

	$(".PayTypeComment").each(function(){
		
		if ($(this).attr("id") == "PayType_"+ $("input:radio[name=PayType]:checked").val() )
		{
			$(this).css("display","block");
		}
		else
		{
			$(this).css("display","none");
		}
	});


	
	fnPopupCheck();
	

	fnTotalPriceAmount();


	



});


function Check_Number(str) { // only number
	var reg = /^[0-9]*$/;
	return reg.test(str);
}

	function fnOrderComplete(OrderIdx)
	{
		location.href = "/Home/Order/OrderCompleteBefore.asp?OrderIdx="+OrderIdx;
	}


$(window).scroll(function(){
	if ( $("#OrderWrap").css("display") == "block" )
	{
		if ( Math.round(($(window).scrollTop() + $(window).height())/ $(document).height() * 100) > 87 )  {						
			$(".BottomFix").css("display","none");
		} else {
			$(".BottomFix").css("display","block");
		}
	}
});

function fnGoHome() {
	location.href="../home/home.jsp";
}
</script>

</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->


<script type="text/javascript">

	// 주소찾기 새 페이지로 넘기기
// 	var root_id;
// 	var zipcode_id;
// 	var addr_id;

// 	function fnZipCodeShow(id_root, id_zipcode, id_addr) 
// 	{

// 		root_id = id_root;
// 		zipcode_id = id_zipcode;
// 		addr_id = id_addr;

// 		$("#"+root_id).css("display", "none");
// 		$(".footer").hide();
// 		$("#zipcode_container").css("display", "block");
		
// 		$("html, body").animate({ scrollTop :0},10);
	
// 	}

// 	function fnZipCodeHide()
// 	{

// 		$("#"+root_id).css("display", "block");
// 		$(".footer").show();
// 		$.fn.ZipcodeInit();
		
// 		$("#"+addr_id+"D").focus();
// 	}

// 	$(document).ready(function(){

// 		$(".btn_tab").click(function(){		

// 			var txt_description;
// 			var txt_placeholder;
			
// 			if (!$(this).hasClass("on")){ 
// 				$(this).addClass("on");
// 				$(".tit").eq($(this).index()).addClass("on");


// 				if ($(this).index() == 1){
// 					txt_description = "- 주소의 동/읍/면 또는 마지막 부분을 입력하신 후 검색을 누르세요.";
// 					txt_placeholder = "지역명을 입력해주세요"
// 					$(".box_zipcode_select").removeClass("on");
// 					$("#btn_tab").val(0);
// 				} else {
// 					txt_description = "- 찾고 싶은 도로명 이름을 입력하신 후 검색을 누르세요.";
// 					txt_placeholder = "도로명을 입력해주세요"
// 					$(".box_zipcode_select").addClass("on");
// 					$("[name=sido]").children("option:eq(0)").attr("selected","selected");
// 					$("#btn_tab").val(1);
// 				}
// 				$("[name=addrkwd]").prop("placeholder",txt_placeholder);
// 				$(".txt_description").html(txt_description);
// 			}
// 			$(this).prev().removeClass("on");
// 			$(this).next().removeClass("on");
// 			$(".tit").eq($(this).index()-1).removeClass("on");
// 			$(".tit").eq($(this).index()+1).removeClass("on");
// 			$(".box_result").html("");
// 		});	
		
		

// 		$("[name=sido]").change(function(){
// 			var jsonSidogun  = JSON.stringify(sidogunJSON);
// 			var jsonSidogunlength = Object.keys(sidogunJSON).length;
// 			var parseSidogun = JSON.parse(jsonSidogun);
// 			var sido_val = $(this).val();		
// 			var sidogun_op = "<option value=\"\">시/군/구</option>";

// 			for (i=0;i<jsonSidogunlength;i++) {
// 				if ( sido_val == parseSidogun[i].province){		
// 					for (j=0;j<parseSidogun[i].districts.length;j++)
// 					{
// 						sidogun_op += "<option value=\""+ parseSidogun[i].districts[j] +"\">"+ parseSidogun[i].districts[j] +"</option>"
// 					} 
// 				}
// 			}

// 			$("[name=sigungu]").html(sidogun_op);
// 			$("[name=sigungu]").attr("disabled",false);
// 		});	
		
// 		$(".btn_addr_search").click(function(){
// 			$.fn.AddrSearch();		
// 		});

// 		$("[name=addrkwd]").keyup(function(e){			
// 			if ( e.which == 13 ) {
// 				$.fn.AddrSearch();				
// 			}
// 		});
// 	});

// 	function fnZipCodeTran(zipcode, addr)
// 	{
// 		$("#"+zipcode_id).val(zipcode);
// 		$("#"+addr_id).val(addr);

// 		fnZipCodeHide();
// 	}


// 	function fnGoPage(page)
// 	{
// 		$.fn.AddrSearch(page);
// 	}


// 	$.fn.AddrSearch = function(page) {
// 		var addrkwd;
// 		if ( page == "" || page == undefined ){ page = "1"; }
// 		if ( $("#btn_tab").val() == "1")
// 		{
// 			if ( $("[name=sido]").val() == "" ) {
// 				alert("시/도를 선택해주세요");
// 				return false;
// 			}

// 			if ( $("[name=sigungu]").val() == "" ) {
// 				alert("시/군/구를 선택해주세요");
// 				return false;
// 			}				
// 		}

// 		if ( $.trim($("[name=addrkwd]").val()) == "" ) {
// 			alert("주소명을 입력해주세요");
// 			return false;
// 		}	

// 		if ( $("#btn_tab").val() == "1")
// 		{
// 			addrkwd = $("[name=sido]").val() + " " + $("[name=sigungu]").val() + " " + $("[name=addrkwd]").val();
// 		}
// 		else 
// 		{
// 			addrkwd = $("[name=addrkwd]").val();
// 		}

// 		var request = $.ajax({
			
			
// 			url : "/Home/Include/ZipCodeSearchAjax.asp",
			
// 			type: "get",
// 			data: "tab="+ $("#btn_tab").val() + "&page="+ page + "&addrkwd=" + encodeURIComponent(addrkwd) + "&sido="+encodeURIComponent($("[name=sido]").val())+"&gugun="+encodeURIComponent($("[name=sigungu]").val())+"&kwd="+encodeURIComponent($("[name=addrkwd]").val())
// 		});

// 		request.done(function(response, textStatus, jqXHR){		

// 			var result = response.split("¶¶");

// //			if (page != "1"){
// //				$(".tbl_zipcode").find("tr:first").parent().html(result[0]);
// //			} else {
// 				$(".box_result").html(result[0]);
// //			}			

// /*			if ( result[1] == "Y" )	{
// 				$(".bar_more").attr("alt",result[2]);
// 			} else {
// 				$(".bar_more").hide();
// 			}
// */
// 			$("[name=addrkwd]").blur();
// 			$("html, body").animate({ scrollTop :0},10);
// 		});	
// 	}

// 	$.fn.ZipcodeInit = function() {
// 		$("#zipcode_container").css("display", "none");
// 		$("[name=sido],[name=sigungu],[name=addrkwd]").val("");
// 		$("[name=sigungu]").attr("disabled",true);
// 		$(".box_result").html("");	
// 		zipcode_height = getOffsetTop(document.getElementById(zipcode_id));
// 		$("body").scrollTop(zipcode_height);
// 	}		

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


<!-- <div class="zipcode_wrap" id="zipcode_container" style="display:none;"> -->
<!-- 	<div class="zipcode_title"> -->
<!-- 		<a onclick="fnZipCodeHide();"><img src="../Images/order/back_pc.png"/></a>주소찾기 -->
<!-- 	</div> -->
<!-- 	<div class="box_tab"> -->
<!-- 		<a class="btn_tab on" href="javascript:;">도로명주소</a>	 -->
<!-- 		<a class="btn_tab"    href="javascript:;">지번주소</a>	 -->
<!-- 		<input type="hidden" id="btn_tab" value="1" /> -->

<!-- 	</div> -->
<!-- 	<div class="desc"> -->
<!-- 		<div class="box_zipcode_ipt"> -->
<!-- 			<span class="box_zipcode_select on"> -->
<!-- 				<select name="sido"> -->
<!-- 					<option value="">시/도</option> -->
<!-- 					<option value="서울특별시">서울특별시</option> -->
<!-- 					<option value="부산광역시">부산광역시</option> -->
<!-- 					<option value="대구광역시">대구광역시</option> -->
<!-- 					<option value="인천광역시">인천광역시</option> -->
<!-- 					<option value="광주광역시">광주광역시</option> -->
<!-- 					<option value="대전광역시">대전광역시</option> -->
<!-- 					<option value="울산광역시">울산광역시</option> -->
<!-- 					<option value="세종특별자치시">세종특별자치시</option> -->
<!-- 					<option value="경기도">경기도</option> -->
<!-- 					<option value="강원도">강원도</option> -->
<!-- 					<option value="충청북도">충청북도</option> -->
<!-- 					<option value="충청남도">충청남도</option> -->
<!-- 					<option value="전라북도">전라북도</option> -->
<!-- 					<option value="전라남도">전라남도</option> -->
<!-- 					<option value="경상북도">경상북도</option> -->
<!-- 					<option value="경상남도">경상남도</option> -->
<!-- 					<option value="제주특별자치도">제주특별자치도</option>				 -->
<!-- 				</select> -->
<!-- 			</span> -->
<!-- 			<span class="box_zipcode_select on"> -->
<!-- 				<select name="sigungu" disabled="disabled" > -->
<!-- 					<option value="">시/군/구</option> -->
<!-- 				</select> -->
<!-- 			</span>			 -->
<!-- 		</div> -->
<!-- 		<span class="box_zipcode_kwd"> -->
<!-- 			<input type="text" name="addrkwd" placeholder="도로명을 입력해주세요" value=""/> -->
<!-- 			<input type="button" class="btn_addr_search" value="검색" /> -->
<!-- 		</span>			 -->
<!-- 		<span class="txt_description">- 찾고 싶은 도로명 이름을 입력하신 후 검색을 누르세요.</span> -->
<!-- 		<div class="box_result"> -->
<!-- 		</div> -->
<!-- 		<span class="zipcode_cancel" onclick="fnZipCodeHide();">취소</span> -->
<!-- 	</div> -->
<!-- </div> -->


<div class="OrderWrap OrderPayLayer" id="InicisQuotaWrap">
	<h1><a href="javascript:fnLayer('OrderWrap');"><img src="../Images/order/back_pc.png"></a>신용카드 무이자혜택</h1>
	<div class="SectionLayer">
		<table class="InicisQuota">
			<thead>
				<col width="36%" />
				<col width="22%" />
				<col width="22%" />
				<col width="20%" />
			</thead>
			<tbody>
				<tr>
					<th class="LT">혜택기간</th>
					<th>카드사</th>
					<th>할부적용금액</th>
					<th class="RT">할부가능기간</th>
				</tr>
				
				<tr>
					<td >2020-04-01 ~ 2020-04-30</td>
					<td >현대카드</td>
					<td >50,000원 이상</td>
					<td >2 ~ 6개월</td>
				</tr>
				
				<tr>
					<td >2020-04-01 ~ 2020-04-30</td>
					<td >국민카드</td>
					<td >50,000원 이상</td>
					<td >2 ~ 6개월</td>
				</tr>
				
				<tr>
					<td >2020-04-01 ~ 2020-04-30</td>
					<td >BC카드</td>
					<td >50,000원 이상</td>
					<td >2 ~ 6개월</td>
				</tr>
				
				<tr>
					<td >2020-04-01 ~ 2020-04-30</td>
					<td >삼성카드</td>
					<td >50,000원 이상</td>
					<td >2 ~ 6개월</td>
				</tr>
				
				<tr>
					<td >2020-04-01 ~ 2020-04-30</td>
					<td >신한카드</td>
					<td >50,000원 이상</td>
					<td >2 ~ 6개월</td>
				</tr>
				
				<tr>
					<td >2020-04-01 ~ 2020-04-30</td>
					<td >NH카드</td>
					<td >50,000원 이상</td>
					<td >2 ~ 6개월</td>
				</tr>
				
				<tr>
					<td >2020-04-01 ~ 2020-04-30</td>
					<td >하나SK카드</td>
					<td >50,000원 이상</td>
					<td >2 ~ 6개월</td>
				</tr>
				
				<tr>
					<td class="BB LB">2020-04-01 ~ 2020-04-30</td>
					<td class="BB">씨티카드</td>
					<td class="BB">50,000원 이상</td>
					<td class="BB RB">2 ~ 6개월</td>
				</tr>
				
			</tbody>
		</table>
		- 유상 카드 할부서비스는 전 카드사 공통 최대 12개월까지 가능<br />
		- 법인 / 체크 / 기프트 / 선불 / 하이브리드 / Non-BC / 계열카드 제외<br />
		- 신한BC / 국민BC / 씨티BC 카드는 BC카드 행사로 적용<br />
		- 무이자 할부 이용 시 카드사 포인트 및 마일리지 정책은 각 카드사 정책에 따라 적립되지 않을 수 있습니다.
	</div>
	<a class="LayerCloseBtn" href="javascript:fnLayer('OrderWrap');">이전으로</a>
</div>

<form method="post" name="Order" enctype="application/x-www-form-urlencoded" target="artboxorderproc" action="OrderPayComplete.jsp">
<div class="OrderWrap" id="OrderWrap">
	<h1>주문하기</h1>
	
	<div class="SectionItemList">
		<div class="OrderInfoTitle">
			<h2>주문상품 정보<small>핑크 비숑 13인치 노트북파우치 (37002786)</small><a class="Open" id="OrderItemListArrow" href="javascript:fnOrderInfoTitle('OrderItemList','','');"></a><div class="clear"></div></h2>
		</div>
		<div id="OrderItemList">
			<input type="hidden" name="BuyType" value="Internal" />
			<input type="hidden" id="MemAlwaysRate" value="0" />
			<input type="hidden" id="MemMileageSaveRate" value="1" />
		
			<div class="tableDiv">
				<dl class="trOrderItem 2002200265">
					<dt class="tdImage"><a href="/Home/Shop/ItemDetail.asp?itemidx=2002200265"><img src="http://www.poom.co.kr/Upload2/Product/202002/2002200265_list.jpg" /></a></dt>
					<dt class="tdInner">
						<div class="CartListItemName">핑크 비숑 13인치 노트북파우치 (37002786)
						</div>
						<div class="CartListPrice">
						 / 25,000원 X 1개
						</div>
					</dt>
					<dt class="tdPrice">
						25,000원
					</dt>
				</dl>
			</div>
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
						<input type="text" id="i_memname" name="memname" maxlength="16" value="최유라" />
						<p class="null"></p>
					</dd>
				</dl>
				<dl class="trOrder">
					<dt>이메일</dt>
					<dd>
						<input type="text" id="i_mememail" name="mememail" maxlength="50" value="yoora213@gmail.com" placeholder="예) example@artbox.co.kr" />
						<p class="null"></p>
						<input type="hidden" name="mememail1" />
						<input type="hidden" name="mememail2" />
					</dd>
				</dl>
			</div>
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>휴대전화</dt>
					<dd>
						<input type="tel" id="i_memcpnum1" name="memcpnum1" maxlength="3" value="010" />
						<p class="null"></p>
					</dd>
					<dd class="blank">&#8210;</dd>
					<dd>
						<input type="tel" id="i_memcpnum2" name="memcpnum2" maxlength="4" value="9729" />
						<p class="null"></p>
					</dd>
					<dd class="blank">&#8210;</dd>
					<dd>
						<input type="tel" id="i_memcpnum3" name="memcpnum3" maxlength="4" value="4972" />
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
	
<!-- 	비회원 주문 -->
<!-- 	<div class="SectionDiscount" id="SectionNonMember"> -->
<!-- 		<div class="OrderInfoTitle"> -->
<!-- 			<h2 style="text-align:center;">“비회원 주문을 위해 휴대폰 인증이 필요합니다.”</h2> -->
<!-- 		</div> -->
<!-- 		<div class="gap20px"></div> -->
<!-- 		<div class="tableDiv"> -->
<!-- 			<dl class="trOrder"> -->
<!-- 				<dd> -->
<!-- 					<input type="tel" id="i_checkmemcpnum1" name="checkmemcpnum1" maxlength="3" /> -->
<!-- 					<p class="null"></p> -->
<!-- 				</dd> -->
<!-- 				<dd class="blank">&#8210;</dd> -->
<!-- 				<dd> -->
<!-- 					<input type="tel" id="i_checkmemcpnum2" name="checkmemcpnum2" maxlength="4" /> -->
<!-- 					<p class="null"></p> -->
<!-- 				</dd> -->
<!-- 				<dd class="blank">&#8210;</dd> -->
<!-- 				<dd> -->
<!-- 					<input type="tel" id="i_checkmemcpnum3" name="checkmemcpnum3" maxlength="4" /> -->
<!-- 					<p class="null"></p> -->
<!-- 				</dd> -->
<!-- 			</dl> -->
<!-- 		</div> -->
<!-- 		<a id="CallSixNum" href="javascript:fnCallSixNum();">인증번호 받기</a> -->
<!-- 		<div class="tableDiv""> -->
<!-- 			<dl class="trOrder"> -->
<!-- 				<dd> -->
<!-- 					<p class="null"></p> -->
<!-- 					<input type="tel" id="i_sixnum" name="sixnum" maxlength="6" placeholder="인증번호 6자리" /> -->
<!-- 					<input type="hidden" id="i_memcpnum_valid" name="memcpnum_valid" /> -->
<!-- 				</dd> -->
<!-- 				<dd class="blank">&nbsp;</dd> -->
<!-- 				<dd class="findpw"> -->
<!-- 					<p class="null"></p> -->
<!-- 					<a id="CheckSixNum" href="javascript:fnCheckSixNum();">인증</a> -->
<!-- 				</dd> -->
<!-- 			</dl> -->
<!-- 		</div> -->
<!-- 		<div class="OrderPayAgree"> -->
<!-- 			<input type="checkbox" id="i_NonMemberAgree" name="NonMemberAgree" /> 비회원 주문을 위한 개인정보 수집에 동의합니다. <a href="javascript:fnLayer('NonMemberAgreeWrap');">[자세히보기]</a><div class="clear"></div> -->
<!-- 		</div> -->
<!-- 	</div> -->

	<div class="SectionDiscount" id="SectionDiscount">
		<div class="OrderInfoTitle">
			<h2>쿠폰/할인/꿈캔디 정보<a class="Open" id="OrderDiscountInfoArrow" 
			href="javascript:fnOrderInfoTitle('OrderDiscountInfo','i_TotalDiscountPriceInfo','i_TotalDiscountPriceInfo_summary');"></a>
			<div class="clear"></div></h2>
		</div>
		<div id="OrderDiscountInfoSummary" class="OrderInfoSummary"> <!-- 접혔을때 할인금액 -->
			<div class="gap20px"></div>
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>할인금액</dt>
					<dd>
						<input type="text" id="i_TotalDiscountPriceInfo_summary" name="TotalDiscountPriceInfo_summary" 
						maxlength="16" value="- 0 원" class="readonly" readonly="readonly" />
					</dd>
				</dl>
			</div>
		</div>
		<div id="OrderDiscountInfo"> 
			<div class="gap20px"></div>  <!-- 펼혔을때 할인금액 -->
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>할인금액</dt>
					<dd>
						<input type="text" id="i_TotalDiscountPriceInfo" name="TotalDiscountPriceInfo" value="- 0 원" 
						class="readonly" readonly="readonly" />
						<p class="null"></p>
					</dd>
				</dl>
			</div>
			<div class="tableDiv">
				<dl class="trOrderRadio">
					<dt>쿠폰</dt>
					<dd>
						<% int bonusCouponCount = 0; int freeCouponCount=0; %>
						<input type="radio" id="CouponTypeNull" name="CouponType" value="Null" checked="checked" /> 선택안함
						&nbsp;&nbsp;<span class="MobileBr"><p class="null"></p></span>
						<input type="radio" id="CouponTypeBonus" name="CouponType" value="Bonus" /> 
						보너스쿠폰 (<span id="BonusCouponTotCnt"><%=bonusCouponCount %></span>장)
						&nbsp;&nbsp;<span class="MobileBr"><p class="null"></p></span>
						<input type="radio" id="CouponTypeGoods" name="CouponType" value="Goods" /> 
						상품쿠폰 (<span id="GoodsCouponTotCnt"><%=freeCouponCount %></span>장)
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
						
			<!-- 			<select name="BonusCouponIdx" id="CouponIdxSelect_Bonus" disabled="disabled" class="none">
							<option value="" alt="0" selected="selected">해당 쿠폰이 없습니다.</option>
						</select> -->
						
						<select name="BonusCouponIdx" id="CouponIdxSelect_Bonus" onchange="fnCouponSelect(this);" class="" 
						style="display: none;">

<%-- 										<c:set var="couponList" value="couponList" /> --%>

										<c:choose>
											<c:when test="${couponList.category eq 'bonuscoupon'}">
       									 <c:out value= "${fn:length(myCouponList)}" />
    										</c:when>
										</c:choose>

										<option value="" alt="0" selected="selected">선택</option>
						<% for(int i=0;i<myCouponList.size();i++){ 	
							String Coupon = myCouponList.get(i).getCoupon_category();
							if(("bonuscoupon").equals(Coupon)){
								bonusCouponCount+=1;
							%>
							
							<option value="53146604" alt=<%=myCouponList.get(i).getCoupon_price() %>>
							<%=myCouponList.get(i).getCoupon_name()%>
						
<!-- 							<option value="53146338" alt="2000">가입회원 2000원 할인 쿠폰</option> -->
						<%}} %>
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
	
	<script> </script>

	<div class="clear"></div>
	<div class="SectionMidLine"></div>
	<div class="SectionPayType">
		<div class="OrderInfoTitle">
			<h2>결제정보<a class="Open" id="OrderPayInfoArrow" href="javascript:fnOrderInfoTitle('OrderPayInfo','i_PayType_summary','i_PayType_summary');"></a><div class="clear"></div></h2>
		</div>
		<div id="OrderPayInfoNonPay" class="OrderInfoSummary">
			<div class="gap20px"></div>
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>결제수단</dt>
					<dd>
						<input type="text" maxlength="99" value="결제시 선택하신 꿈캔디로만 결제됩니다." class="readonly" readonly="readonly" />
					</dd>
				</dl>
			</div>
		</div>
		<div id="OrderPayInfoSummary" class="OrderInfoSummary">
			<div class="gap20px"></div>
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>결제수단</dt>
					<dd>
						<input type="text" id="i_PayType_summary" name="PayType_summary" maxlength="16" value="" class="readonly" readonly="readonly" />
					</dd>
				</dl>
			</div>
		</div>
		<div id="OrderPayInfo">
			<div class="gap20px"></div>
			
				<div class="PayTypeRadio"><input type="radio" name="PayType" value="Card"       data-value="M_CARD"   title="신용카드" checked="checked" /> 신용카드</div>
				<div class="PayTypeRadio"><input type="radio" name="PayType" value="DirectBank" data-value="M_DBANK"  title="실시간 계좌이체" /> 실시간 계좌이체</div>
				<div class="PayTypeRadio"><input type="radio" name="PayType" value="VBank"      data-value="M_VBANK"  title="무통장 입금(가상 계좌)"  /> 무통장 입금(가상 계좌)</div>
				<div class="PayTypeRadio"><input type="radio" name="PayType" value="KAKAOPAY"      data-value="M_KAKAOPAY" title="카카오페이" /> 카카오페이</div>
				<div class="PayTypeRadio"><input type="radio" name="PayType" value="PAYCO2"     data-value="M_PAYCO2" title="PAYCO" /> PAYCO</div>
				<div class="PayTypeRadio"><input type="radio" name="PayType" value="SSPAY"      data-value="M_SSPAY" title="삼성페이" /> 삼성페이</div>
				<div class="PayTypeRadio"><input type="radio" name="PayType" value="E_DirectBank" title="에스크로(실시간 계좌이체)" /> 에스크로(실시간 계좌이체)</div>
				<div class="PayTypeRadio"><input type="radio" name="PayType" value="E_VBank"      title="에스크로(가상 계좌)" /> 에스크로(가상 계좌)</div>
				<div class="PayTypeRadio" style="margin:0 0 20px 0;"><input type="radio" name="PayType" value="HPP"        data-value="M_HPP"    title="휴대폰 결제" /> 휴대폰 결제</div>
				<div class="clear"></div>
			
			<div class="PayTypeRadio" ><input type="checkbox" id="i_SavePayTypeYn" name="SavePayTypeYn" checked="checked" value="Y" /> 선택한 결제수단 저장</div>
			<div class="clear"></div>
			<div class="PayTypeComment" id="PayType_Card">
				<div class="AgreeBox">
					<div class="tableDiv">
						<dl class="trOrder">
							<dt>카드종류</dt>
							<dd>
								<select name="ini_cardcode">
									<option value="">카드선택</option>
									<option value="01">하나(외환)카드</option>
									<option value="03">롯데카드</option>
									<option value="04">현대카드</option>
									<option value="06">국민카드</option>
									<option value="11">BC카드</option>
									<option value="12">삼성카드</option>
									<option value="14">신한카드</option>
									<!--
									<option value="21">해외VISA카드</option> 안심결제
									<option value="22">해외마스터</option> 안심결제
									<option value="23">해외JCB카드</option> 안심결제
									-->
									<option value="26">중국은련카드</option>
									<option value="32">광주카드</option>
									<option value="33">전북카드</option>
									<option value="34">하나카드</option>
									<option value="41">NH카드</option>
									<option value="43">씨티카드</option>
									<option value="44">우리카드</option>
									<option value="48">신협체크카드</option>
									<option value="51">수협카드</option>
									<option value="52">제주카드</option>
									<option value="54">MG새마을금고체크카드</option>
									<option value="56">카카오뱅크카드</option>
									<option value="71">우체국체크카드</option>
									<option value="95">저축은행체크카드</option>
								</select>
								<p class="null"></p>
							</dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trOrder">
							<dt>할부선택</dt>
							<dd>
								<select name="ansim_quota">
									<option value="0">일시불</option>
									<option value="2">2개월</option>
									<option value="3">3개월</option>
									<option value="4">4개월</option>
									<option value="5">5개월</option>
									<option value="6">6개월</option>
									<option value="7">7개월</option>
									<option value="8">8개월</option>
									<option value="9">9개월</option>
									<option value="10">10개월</option>
									<option value="11">11개월</option>
									<option value="12">12개월</option>
								</select>
							</dd>
							<dd class="quota"><a href="javascript:fnLayer('InicisQuotaWrap');" />무이자혜택</a></dd>
						</dl>
					</div>
				</div>
				<div class="AgreeBox BT">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						신용카드 결제의 경우 세금계산서 대용으로 매입세액공제를 받을 수 있는 신용카드 전표가 발행되므로 별도의 세금계산서는 발생하지 않습니다.
					</div>
				</div>
			</div>
			<div class="PayTypeComment" id="PayType_DirectBank">
				<div class="AgreeBox">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						실시간 계좌이체 시 현금영수증을 신청하실 수 있습니다.<br />사업자 증빙용 현금영수증은 세금계산서와 동일한 효력을 가집니다.
					</div>
				</div>
			</div>
			<div class="PayTypeComment" id="PayType_VBank">
				<div class="AgreeBox">
					<div class="AgreeComment">
						<b>환불 계좌 정보</b>
						<p class="null"></p>
					</div>
					<div class="tableDiv">
						<dl class="trOrder">
							<dt>예금주</dt>
							<dd><input type="text" name="RefundName" maxlength="16" value="" />
								<p class="null"></p>
							</dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trOrder">
							<dt>은행명</dt>
							<dd>
								<select class="refund" name="RefundBankCode">
									<option value="" selected="selected">선택하세요</option>
									<option value="02" >한국산업은행</option>
									<option value="03" >기업은행</option>
									<option value="04" >KB국민은행</option>
									<option value="05" >KEB하나은행 (구 외환)</option>
									<option value="07" >수협중앙회</option>
									<option value="11" >농협중앙회</option>
									<option value="12" >단위농협</option>
									<option value="16" >축협중앙회</option>
									<option value="20" >우리은행</option>
									<option value="23" >SC제일은행</option>
									<option value="26" >신한은행</option>
									<option value="31" >대구은행</option>
									<option value="32" >부산은행</option>
									<option value="34" >광주은행</option>
									<option value="35" >제주은행</option>
									<option value="37" >전북은행</option>
									<option value="38" >강원은행</option>
									<option value="39" >경남은행</option>
									<option value="41" >비씨카드</option>
									<option value="53" >한국씨티은행</option>
									<option value="54" >홍콩상하이은행</option>
									<option value="71" >우체국</option>
									<option value="81" >KEB하나은행 (구 하나)</option>
									<option value="87" >신세계</option>
									<option value="89" >케이뱅크</option>
									<option value="90" >카카오뱅크</option>
								</select>
								<p class="null"></p>
							</dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trOrder">
							<dt>계좌번호</dt>
							<dd><input type="text" name="RefundAccount" maxlength="16" value="" />
								<span style="font-size:0.625rem;">"-"없이 숫자만 입력해주세요</span>
								<p class="null"></p>
							</dd>
						</dl>
					</div>
					<div class="tableDiv">
						<dl class="trOrder">
							<dt>관계</dt>
							<dd>
								<select class="refund" name="RefundRelation">
									<option value="" >선택</option>
									<option value="본인" >본인</option>
									<option value="가족" >가족</option>
									<option value="친구" >친구</option>
									<option value="개명" >개명</option>
									<option value="회사" >회사</option>
								</select>
								<p class="null"></p>
							</dd>
						</dl>
					</div>

					
					<div class="tableDiv">
						<dl class="trOrder">
							<dt>&nbsp;</dt>
							<dd class="refund">
								<a href="javascript:fnRefundSave();">환불 계좌 정보 수정</a>
								<p class="null"></p>
							</dd>
						</dl>
					</div>
					
	
					<div class="AgreeTable">
						<div class="tableDiv">
							<dl class="trOrderAgree">
								<dd>고객님이 저장/확인한 환불계좌이며, <br />이후 취소/반품/교환 시 결제방식에 따라<br/>해당 환불 계좌로 입금됩니다.</dd>
								<dt><br /><input type="checkbox" name="SaveRefundCheck" value="Y" /> 동의<p class="null"></p></dt>
							</dl>
						</div>
					</div>
				</div>
	
				<div class="AgreeBox BT">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						무통장 입금 시 현금영수증을 신청하실 수 있습니다.<br />사업자 증빙용 현금영수증은 세금계산서와 동일한 효력을 가집니다.
					</div>
				</div>
			</div>
			<div class="PayTypeComment" id="PayType_HPP">
				<div class="AgreeBox">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						휴대폰 결제 시 현금영수증을 신청하실 수 있습니다.<br />사업자 증빙용 현금영수증은 세금계산서와 동일한 효력을 가집니다.
					</div>
				</div>
			</div>
			<div class="PayTypeComment" id="PayType_PAYCO2">
				<div class="AgreeBox">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						PAYCO 신용카드 결제의 경우 매출 전표 발행이 가능합니다.
					</div>
				</div>
			</div>
			<div class="PayTypeComment" id="PayType_SSPAY">
				<div class="AgreeBox">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						현재 삼성페이 PC 결제 서비스를 지원하는 카드사는 삼성카드, 롯데카드, 하나카드, KB국민카드 입니다. 다른 카드사로도 확대 적용할 계획입니다.
					</div>
				</div>
			</div>
			<div class="PayTypeComment" id="PayType_KAKAOPAY">
				<div class="AgreeBox">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						카카오페이 신용카드 결제의 경우 매출 전표 발행이 가능합니다.
					</div>
				</div>
			</div>
			<div class="PayTypeComment" id="PayType_E_DirectBank">
				<div class="AgreeBox">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						실시간 계좌이체 시 현금영수증을 신청하실 수 있습니다.<br />사업자 증빙용 현금영수증은 세금계산서와 동일한 효력을 가집니다.
					</div>
				</div>
			</div>
			<div class="PayTypeComment" id="PayType_E_VBank">
				<div class="AgreeBox">
					<div class="AgreeComment">
						<b>알아두세요.</b>
						무통장 입금 시 현금영수증을 신청하실 수 있습니다.<br />사업자 증빙용 현금영수증은 세금계산서와 동일한 효력을 가집니다.
					</div>
				</div>
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
						<dd>개인정보 제3자 제공에 동의합니다.<span onclick="fnOrderAgreePop('1');" class="AgreeDetail" alt="1">상세보기</span></dd>
						<dt><input type="checkbox" name="OrderAgreeThird" value="Y" /> <p class="null"></p></dt>
					</dl>
					<dl class="trOrderAgree">
						<dd>결제대행서비스 이용약관에 동의합니다.<span onclick="fnOrderAgreePop('2');" class="AgreeDetail" alt="2">상세보기</span></dd>
						<dt><input type="checkbox" name="OrderAgreePayment" value="Y" /> <p class="null"></p></dt>
					</dl>
					<dl class="trOrderAgree">
						<dd>주문할 상품설명에 명시된 내용과 사용조건을 확인하였으며, 취소 환불규정에 동의합니다.</dd>
						<dt><input type="checkbox" name="OrderAgreeRule" value="Y" /> <p class="null"></p></dt>
					</dl>
				</div>
			</div>

			<div id="AgreeDetail_1" class="TermsInform">
				<span class="tit">개인정보 제3자 정보제공 동의</span>
				<div class="addInform">
					서비스 제공을 위해 아래 정보가 제공됩니다.<br />고객님께서는 정보제공에 동의하지 않을 수 있으며,<br />동의하지 않는 경우 서비스 이용이 제한될 수 있습니다.
				</div>
				<dl>
					<dd>개인정보 제공 받는 자: 아트박스</dd>
					<dd>제공목적: 구매한 상품의 배송</dd>
					<dd>제공정보: 성명, 휴대폰번호, 주소</dd>
					<dd>보유 및 이용기간: 서비스 제공완료 3개월 후 삭제</dd>
				</dl>
			</div>

			<div id="AgreeDetail_2" class="TermsInform" style="width:380px !important; ">
				<span class="tit">결제대행서비스 약관</span>

				<ul>
					<li alt="1" class="on">기본약관</li>
					<li alt="2">개인정보<br>수집·이용</li>
					<li alt="3">개인정보<br>제공·위탁</li>
				</ul>
				<div class="sec">
												<div id="bnbn1" class="secD">

		제1조 (목적)<br />
		이 약관은 주식회사 케이지이니시스(이하 '회사'라 합니다)가 제공하는 전자지급결제대행서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다.<br /><br />
		제2조 (용어의 정의)	<br />
		이 약관에서 정하는 용어의 정의는 다음과 같습니다.	<br />
		1. '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스(이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.<br />
		2. '전자지급결제대행서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.<br />
		3. '결제대금예치서비스'라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제대금'이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등'이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다.<br />
		4. '이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.<br />
		5. '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, 회사에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데<br />
		필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.<br />
		6. '거래지시'라 함은 이용자가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 회사에 대하여 전자금융거래의 처리를 지시하는 것을 말합니다.<br />
		7. '오류'라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다.<br /><br />
		제3조 (약관의 명시 및 변경)<br />
		① 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.<br />
		② 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.<br />
		③ 회사가 약관을 변경하는 때에는 그 시행일 1개월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.<br /><br />
		제4조 (전자지급결제대행서비스의 종류)<br />
		회사가 제공하는 전자지급결제대행서비스는 지급결제수단에 따라 다음과 같이 구별됩니다.<br />
		1. 신용카드결제대행서비스: 이용자가 결제대금의 지급을 위하여 제공한 지급결제수단이 신용카드인 경우로서, 회사가 전자결제시스템을 통하여 신용카드 지불정보를 송,수신하고 결제대금의 정산을 대행하거나 매개하는 서비스를 말합니다.<br />
		2. 계좌이체대행서비스: 이용자가 결제대금을 회사의 전자결제시스템을 통하여 금융기관에 등록한 자신의 계좌에서 출금하여 원하는 계좌로 이체할 수 있는 실시간 송금 서비스를 말합니다.<br />
		3. 가상계좌서비스: 이용자가 결제대금을 현금으로 결제하고자 경우 회사의 전자결제시스템을 통하여 자동으로 이용자만의 고유한 일회용 계좌의 발급을 통하여 결제대금의 지급이 이루어지는 서비스를 말합니다.<br />
		4. 기타: 회사가 제공하는 서비스로서 지급결제수단의 종류에 따라 '휴대폰 결제대행서비스', 'ARS결제대행서비스', '상품권결제대행서비스'등이 있습니다.<br /><br />
		제5조 (결제대금예치서비스의 내용)<br />
		① 이용자(이용자의 동의가 있는 경우에는 재화 등을 공급받을 자를 포함합니다. 이하 본조에서 같습니다)는 재화 등을 공급받은 사실을 재화 등을 공급받은 날부터 3영업일 이내에 회사에 통보하여야 합니다.<br />
		② 회사는 이용자로부터 재화 등을 공급받은 사실을 통보받은 후 회사와 통신판매업자간 사이에서 정한 기일 내에 통신판매업자에게 결제대금을 지급합니다.<br />
		③ 회사는 이용자가 재화 등을 공급받은 날부터 3영업일이 지나도록 정당한 사유의 제시없이 그 공급받은 사실을 회사에 통보하지 아니하는 경우에는 이용자의 동의없이 통신판매업자에게 결제대금을 지급할 수 있습니다.<br />
		④ 회사는 통신판매업자에게 결제대금을 지급하기 전에 이용자에게 결제대금을 환급받을 사유가 발생한 경우에는 그 결제대금을 소비자에게 환급합니다.<br />
		⑤ 회사는 이용자와의 결제대금예치서비스 이용과 관련된 구체적인 권리,의무를 정하기 위하여 본 약관과는 별도로 결제대금예치서비스이용약관을 제정할 수 있습니다.<br /><br />
		제6조 (이용시간)<br />
		① 회사는 이용자에게 연중무휴 1일 24시간 전자금융거래 서비스를 제공함을 원칙으로 합니다. 단, 금융기관 기타 결제수단 발행업자의 사정에 따라 달리 정할 수 있습니다.<br />
		② 회사는 정보통신설비의 보수, 점검 기타 기술상의 필요나 금융기관 기타 결제수단 발행업자의 사정에 의하여 서비스 중단이 불가피한 경우, 서비스 중단 3일 전까지 게시가능한 전자적 수단을 통하여 서비스 중단 사실을 게시한 후 서비스를 일시 중단할 수 있습니다. 다만, 시스템 장애복구, 긴급한 프로그램 보수, 외부요인 등<br />
		불가피한 경우에는 사전 게시없이 서비스를 중단할 수 있습니다.<br /><br />
		제7조 (접근매체의 선정과 사용 및 관리)<br />
		① 회사는 전자금융거래 서비스 제공 시 접근매체를 선정하여 이용자의 신원, 권한 및 거래지시의 내용 등을 확인할 수 있습니다.<br />
		② 이용자는 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공할 수 없습니다.<br />
		③ 이용자는 자신의 접근매체를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며, 접근매체의 도용이나 위조 또는 변조를 방지하기 위하여 충분한 주의를 기울여야 합니다.<br />
		④ 회사는 이용자로부터 접근매체의 분실이나 도난 등의 통지를 받은 때에는 그 때부터 제3자가 그 접근매체를 사용함으로 인하여 이용자에게 발생한 손해를 배상할 책임이 있습니다.<br /><br />
		제8조 (거래내용의 확인)<br />
		① 회사는 이용자와 미리 약정한 전자적 방법을 통하여 이용자의 거래내용(이용자의 '오류정정 요구사실 및 처리결과에 관한 사항'을 포함합니다)을 확인할 수 있도록 하며, 이용자의 요청이 있는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송 등의 방법으로 거래내용에 관한 서면을 교부합니다.<br />
		② 회사가 이용자에게 제공하는 거래내용 중 거래계좌의 명칭 또는 번호, 거래의 종류 및 금액, 거래상대방을 나타내는 정보, 거래일자, 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보와 해당 전자금융거래와 관련한 전자적 장치의 접속기록은 5년간, 건당 거래금액이 1만원 이하인 소액 전자금융거래에 관한 기록,<br />
		전자지급수단 이용시 거래승인에 관한 기록, 이용자의 오류정정 요구사실 및 처리결과에 관한 사항은 1년간의 기간을 대상으로 한다.<br />
		③ 이용자가 제1항에서 정한 서면교부를 요청하고자 할 경우 다음의 주소 및 전화번호로 요청할 수 있습니다.<br />
		주소: 463-400 경기도 성남시 분당구 대왕판교로 660 유스페이스A동 5층 (주)케이지이니시스<br />
		이메일 주소: sm@inicis.com<br />
		전화번호: 1588-4954<br /><br />
		제9조 (오류의 정정 등)<br />
		① 이용자는 전자금융거래 서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대하여 그 정정을 요구할 수 있습니다.<br />
		② 회사는 전항의 규정에 따른 오류의 정정요구를 받은 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받은 날부터 2주 이내에 그 결과를 이용자에게 알려 드립니다.<br /><br />
		제10조 (회사의 책임)<br />
		① 접근매체의 위조나 변조로 발생한 사고로 인하여 이용자에게 발생한 손해에 대하여 배상책임이 있습니다. 다만 이용자가 제6조 제2항에 위반하거나 제3자가 권한 없이 이용자의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 알 수 있었음에도 불구하고 이용자가 자신의 접근매체를 누설 또는 노출하거나 방치한 경우 그 책임의 전부 또는 일부를 이용자가 부담하게 할 수 있습니다.<br />
		② 회사는 계약체결 또는 거래지시의 전자적 전송이나 처리과정에서 발생한 사고로 인하여 이용자에게 그 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다. 다만 본 조 제1항 단서에 해당하거나 법인('중소기업기본법' 제2조 제2항에 의한 소기업을 제외합니다)인 이용자에게 손해가 발생한 경우로서 회사가 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한 경우 그 책임의 전부 또는 일부를 이용자가 부담하게 할 수 있습니다.<br />
		③ 회사는 이용자로부터의 거래지시가 있음에도 불구하고 천재지변, 회사의 귀책사유가 없는 정전, 화재, 통신장애 기타의 불가항력적인 사유로 처리 불가능하거나 지연된 경우로서 이용자에게 처리 불가능 또는 지연사유를 통지한 경우(금융기관 또는 결제수단 발행업체나 통신판매업자가 통지한 경우를 포함합니다)에는 이용자에 대하여 이로 인한 책임을 지지 아니합니다.<br />
		④ 회사는 전자금융거래를 위한 전자적 장치 또는 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’ 제2조 제1항 제1호에 따른 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한 사고로 인하여 이용자에게 그 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다.<br /><br />
		제11조 (전자지급거래계약의 효력)<br />
		① 회사는 이용자의 거래지시가 전자지급거래에 관한 경우 그 지급절차를 대행하며, 전자지급거래에 관한 거래지시의 내용을 전송하여 지급이 이루어지도록 합니다.<br />
		② 회사는 이용자의 전자지급거래에 관한 거래지시에 따라 지급거래가 이루어지지 않은 경우 수령한 자금을 이용자에게 반환하여야 합니다.<br /><br />
		제12조 (거래지시의 철회)<br />
		① 이용자는 전자지급거래에 관한 거래지시의 경우 지급의 효력이 발생하기 전까지 거래지시를 철회할 수 있습니다.<br />
		② 전항의 지급의 효력이 발생 시점이란 (i) 전자자금이체의 경우에는 거래지시된 금액의 정보에 대하여 수취인의 계좌가 개설되어 있는 금융기관의 계좌이체 원장에 입금기록이 끝난 때 (ii) 그 밖의 전자지급수단으로 지급하는 경우에는 거래지시된 금액의 정보가 수취인의 계좌가 개설되어 있는 금융기관의 전자적 장치에 입력이 끝난 때를 말합니다.<br />
		③ 이용자는 지급의 효력이 발생한 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령상 청약의 철회의 방법 또는 본 약관 제5조에서 정한 바에 따라 결제대금을 반환받을 수 있습니다.<br /><br />
		제13조 (전자지급결제대행 서비스 이용 기록의 생성 및 보존)<br />
		① 회사는 이용자가 전자금융거래의 내용을 추적, 검색하거나 그 내용에 오류가 발생한 경우에 이를 확인하거나 정정할 수 있는 기록을 생성하여 보존합니다.<br />
		② 전항의 규정에 따라 회사가 보존하여야 하는 기록의 종류 및 보존방법은 제8조 제2항에서 정한 바에 따릅니다.<br /><br />
		제14조 (전자금융거래정보의 제공금지)<br />
		회사는 전자금융거래 서비스를 제공함에 있어서 취득한 이용자의 인적사항, 이용자의 계좌, 접근매체 및 전자금융거래의 내용과 실적에 관한 정보 또는 자료를 이용자의 동의를 얻지 아니하고 제3자에게 제공,누설하거나 업무상 목적 외에 사용하지 아니합니다.<br /><br />
		제15조 (분쟁처리 및 분쟁조정)<br />
		① 이용자는 다음의 분쟁처리 책임자 및 담당자에 대하여 전자금융거래 서비스 이용과 관련한 의견 및 불만의 제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다.<br />
		담당자: RM팀<br />
		연락처(전화번호, FAX): 3430-5847, 3430-5889<br />
		E-mail : inirm@inicis.com<br />
		② 이용자가 회사에 대하여 분쟁처리를 신청한 경우에는 회사는 15일 이내에 이에 대한 조사 또는 처리 결과를 이용자에게 안내합니다.<br />
		③ 이용자는 '금융감독기구의 설치 등에 관한 법률' 제51조의 규정에 따른 금융감독원의 금융분쟁조정위원회나 '소비자보호법' 제31조 제1항의 규정에 따른 소비자보호원에 회사의 전자금융거래 서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다.<br /><br />
		제16조 (회사의 안정성 확보 의무)<br />
		회사는 전자금융거래의 안전성과 신뢰성을 확보할 수 있도록 전자금융거래의 종류별로 전자적 전송이나 처리를 위한 인력, 시설, 전자적 장치 등의 정보기술부문 및 전자금융업무에 관하여 금융감독위원회가 정하는 기준을 준수합니다.<br /><br />
		제17조 (약관외 준칙 및 관할)<br />
		① 이 약관에서 정하지 아니한 사항에 대하여는 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다.<br />
		② 회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.<br />
		부칙 (2010년 4월 12일)<br />
		최초 시행일자 : 2007년 1월 1일<br />
		변경 공고일자 : 2017년 2월 20일<br />
		변경 시행일자 : 2017년 3월 22일<br /><br />

							</div>
							<div id="bnbn2" class="secD">

		1. 회사는 이용자의 개인정보를 본 개인정보처리방침에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의 없이 동 범위를 초과하여 이용하거나 이용자의 개인 정보를 제3자에게 제공하지 않습니다. 다만, 관련 법령에 의하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관 등에 개인정보를 제공하여야 하는 경우는 예외로 합니다. 회사의 서비스 이행을 위하여 개인정보를 제3자에게 제공하고 있는 경우는 다음과 같습니다.<br /><br />
		<table>
			<tbody>
				<tr>
					<th style="width:28%;">제공목적</th>
					<th style="width:28%;">제공받는 자</th>
					<th style="width:29%;">제공 정보</th>
					<th style="width:15%;">보유 및 이용기간</th>
				</tr>
				<tr>
					<td>신용카드 결제</td>
					<td>
						<p>
							- 국민, 비씨, 롯데, 삼성, NH농협, 현대, 신한, 하나<br />
							- 4개 시중은행:신한, SC제일, 씨티, 하나<br />
							- 8개 특수은행 농협, 기업, 국민, 저축, 수협, 신협, 우체국, 새마을금고<br />
							- 7개 지방은행 대구, 부산, 경남, 광주, 전북, 조흥, 제주<br />
							- 1개 전업카드사:우리
						</p>
						<p>
							- 3개 제휴사: 엔에이치엔페이코 주식회사, 롯데멤버스 주식회사, 주식회사 신세계아이앤씨<br />
							- 12개 VAN사:(주)코밴, KIS정보통신, NICE정보통신, 브이피㈜, 한국신용카드결제(주), 퍼스트데이터코리아,
							㈜케이에스넷, 스타VAN, 제이티넷, KICC, 스마트로, NHN한국사이버결제 주식회사
						</p>
					</td>
					<td>
						거래정보<br />
						(비씨카드:IP포함)
					</td>
					<td style="text-align: center; vertical-align: middle;" rowspan="12">
						건당 1만원 초과 : 5년<br />
						건당 1만원 이하 : 1년
					</td>
				</tr>
				<tr>
					<td>계좌이체 결제</td>
					<td>
						- 금융결제원<br />
						- 경남/ 광주/국민/기업/농협/대구/부산/산업/새마을금고/ 수협/신한/신협/우리/우체국/전북/제주/KEB하나/씨티/SC제일은행/산림조합<br />
						- 유안타/현대/미래에셋/한투/우리투자/하이투자/HMC투자/SK/대신/하나대투/신한금융/동부/유진투자/메리츠/신영/삼성/한화/대우증권<br />
						- 주식회사 신세계아이앤씨<br />
					</td>
					<td>거래정보</td>
				</tr>
				<tr>
					<td>가상계좌 결제</td>
					<td>국민/농협/우리/신한/KEB하나/기업/우체국/부산/경남/ 대구/수협/씨티/삼성증권/SC/광주/전북</td>
					<td>거래정보</td>
				</tr>
				<tr>
					<td>휴대폰 결제</td>
					<td>(주)SKT, ㈜KT, ㈜LGU+, MVNO사업자, ㈜모빌리언스, ㈜다날</td>
					<td>
						거래정보<br />
						(모빌리언스, 다날 IP 포함)<br />
						휴대폰 번호<br />
						고유식별정보
					</td>
				</tr>
				<tr>
					<td>유선전화 결제</td>
					<td>㈜KT, ㈜인포허브</td>
					<td>
						거래정보<br />
						유선전화번호<br />
						고유식별정보
					</td>
				</tr>
				<tr>
					<td>상품권 결제</td>
					<td>한국문화진흥, 한국도서보급, 해피머니아이엔씨, 아이앤플레이</td>
					<td>
						거래정보<br />
						(한국문화진흥,해피머니아이엔씨:IP포함)
					</td>
				</tr>
				<tr>
					<td>M마일리지</td>
					<td>㈜아이엠아이</td>
					<td>거래정보</td>
				</tr>
				<tr>
					<td>포인트 결제</td>
					<td>㈜SK플래닛, GS넥스테이션주식회사, 삼성전자</td>
					<td>거래정보</td>
				</tr>
				<tr>
					<td>전자지갑 결제</td>
					<td>금융결제원, KEB하나은행, 삼성전자, 주식회사 신세계아이앤씨</td>
					<td>
						거래정보<br />
						휴대폰 번호
					</td>
				</tr>
				<tr>
					<td>해외카드(글로벌서비스 포함)</td>
					<td>VISA, MASTER, JCB, Diners, unionpay, 페이팔, 알리바바, 텐센트</td>
					<td>거래정보</td>
				</tr>
				<tr>
					<td>현금영수증 발행</td>
					<td>국세청</td>
					<td>
						거래정보<br />
						고유식별정보<br />
						휴대폰번호<br />
						카드번호
					</td>
				</tr>
				<tr>
					<td>본인 확인 인증</td>
					<td>나이스신용평가정보, 한국신용평가정보㈜, 한국신용정보, SKT, KT, LGU+, (주)코밴, KIS정보통신, NICE정보통신, 브이피㈜, 한국신용카드결제(주), 퍼스트 데이터 코리아, ㈜케이에스넷 국민/비씨/롯데/삼성/NH농협/현대/KEB하나/신한 경남/광주/국민/기업/농협/대구/부산/산업/새마을금고/ 수협/신한/신협/우리/우체국/전북/제주/씨티/SC제일</td>
					<td>
						고유식별정보<br />
						본인확인정보
					</td>
				</tr>
			</tbody>
		</table>
		<br />2. 개인정보 처리 위탁을 하는 업무의 내용 및 수탁자<br />
		회사는 이용자의 동의 없이 이용자의 개인정보를 외부 업체에 위탁하지 않습니다. 하단의 업체는 이용자에게 사전 통지 또는 동의를 얻어 위탁 업무를 대행하고 있습니다.<br /><br />
		<table class="table">
			<tbody>
				<tr>
					<th style="width: 33%;">제공목적</th>
					<th style="width: 34%;">제공받는 자</th>
					<th style="width: 33%;">제공 정보</th>
				</tr>
				<tr>
					<td>배송정보 안내서비스제공</td>
					<td>㈜굿스플로</td>
					<td style="text-align: center; vertical-align: middle;" rowspan="2">거래 정보</td>
				</tr>
				<tr>
					<td>고객상담 업무지원 위탁 수행</td>
					<td>㈜메타넷엠씨씨, ㈜제이디랩</td>
				</tr>
			</tbody>
		</table>
		<br />3. 개인정보의 제3자 제공 및 위탁 거부<br />
		이용자는 개인정보의 제3자 제공 및 위탁 동의를 거부할 수 있습니다. 단, 동의를 거부하는 경우 본 서비스 결제가 정상적으로 이루어질 수 없음을 알려드립니다.<br /><br />


							</div>
							<div id="bnbn3" class="secD">


		※ 개인정보 수집 및 이용동의는 개인정보의 수집 및 이용목적, 수집항목 및 수집방법 개인정보의 보유 및 이용기간으로 별도 구분하여 표시됩니다.<br /><br />
		<table class="table">
			<tbody>
				<tr>
					<th style="width: 33%;">개인정보의 수집 및 이용목적</th>
					<th style="width: 34%;">수집항목 및 수집방법</th>
					<th style="width: 33%;">개인정보의 보유 및 이용 기간</th>
				</tr>
				<tr>
					<td>
						1) 전자금융거래서비스 제공에 관한 결제 정보 등 개인정보 수집<br />
						- 이용자가 구매한 재화나 용역의 대금 결제<br />
						- 결제 과정 중 본인 식별, 인증, 실명확인 및 이용자가 결제한 거래의 내역을 요청하는 경우 응대 및 확인<br />
						- 이용자가 결제한 거래의 취소 또는 환불, 상품 배송 등 전자상거래 관련 서비스 제공<br />
						- 이용자가 결제한 대금의 청구 및 수납<br />
						- 전자금융거래 및 통신과금 서비스 이용 불가능한 이용자(미성년자 등)와 불량, 불법 이용자의 부정 이용 방지<br />
						- 서비스 제공 및 관련 업무 처리에 필요한 동의 또는 철회 등 의사확인<br />
						- 회사가 제공하는 결제알림메일 발송<br />
						- 고객 불만 및 민원처리<br /><br />
						2) 신규 서비스 개발 및 마케팅 광고에의 활용<br />
						- 이용 빈도 파악 및 마케팅 특성에 따른 서비스 제공 및 CRM 용도<br />
						- 신규 서비스 개발 및 맞춤 서비스 제공, 통계학적 특성에 따른 서비스 제공 및 광고 게재,
						서비스의 유효성 확인, <span style="color: red;">이벤트, 광고성 정보 제공(결제알림메일 내) 및 참여기회 제공,</span> 접속빈도 파악, 회원의 서비스이용에 대한 통계<br />
					</td>
					<td>
						1) 수집항목<br />
						가. 전자금융거래서비스 이행과 관련 수집 정보<br />
						- 이용자의 고유식별번호<br />
						- 이용자의 신용카드 정보 또는 지불하고자 하는 금융기관 계좌 정보<br />
						- 이용자의 휴대폰 또는 유선 전화 번호 및 가입 통신사<br />
						- 이용자의 상품권 번호 및 상품권 회원 아이디, 비밀번호 등<br />
						- 이용자의 결제하고자 하는 포인트 카드 정보<br />
						- 이용자의 전자지갑 이용자번호 등 결제 정보<br />
						- 이용자의 접속 IP<br />
						- 이용자의 이메일<br />
						- 이용자의 상품 또는 용역 거래 정보<br />
						나. 회원가입과 관련한 수집 정보<br />
						- 성명, 생년월일, 성별, 아이디, 비밀번호, 연락처(메일주소, 휴대폰 번호), 가입인증정보<br />
						- 만 14세 미만은 법정대리인 정보, 가입인증정보<br />
						- 외국인의 경우 외국인등록번호<br />
						다. “서비스” 이용 또는 처리 과정에서 자동 혹은 수동으로 생성되어 수집되는 정보<br />
						- 이용자 IP Address, 쿠키, 서비스 접속 일시, 서비스 이용기록, 불량 혹은 비정상 이용기록, 결제기록<br /><br />
						2) 수집방법<br />
						가. 회사가 운영하는 웹사이트 혹은 회사가 제공하는 결제창에 이용자가 직접 입력<br />
						나. 회사가 제공하는 정보통신서비스의 이용 혹은 처리 과정에서 쿠키, 서비스 접속 log등이 자동으로 생성 및 수집되는 경우<br />
					</td>
					<td>
						이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기 합니다. 단, 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률 등 관련 법령에 의하여 보존할 필요가 있는 경우 관련 법령에서 정한 일정한 기간 동안 개인정보를 보존합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.<br />
						- 건당 1만원 초과 전자금융거래에 관한 기록<br />
						보존이유: 전자금융거래법<br />
						보존기간: 5년<br />
						- 건당 1만원 이하 전자금융거래에 관한 기록<br />
						보존이유: 전자금융거래법<br />
						보존기간: 1년<br />
						- 계약 또는 청약 철회 등에 관한 기록<br />
						보존이유: 전자상거래 등에서의 소비자보호에 관한 법률<br />
						보존기간: 5년<br />
						- 대금결제 및 재화 등의 공급에 관한 기록<br />
						보존이유: 전자상거래 등에서의 소비자보호에 관한 법률<br />
						보존기간: 5년<br />
						- 소비자의 불만 또는 분쟁 처리에 관한 기록<br />
						보존이유: 전자상거래 등에서의 소비자보호에 관한 법률<br />
						보존기간: 3년<br />
						- 본인확인에 관한 기록<br />
						보존이유: 정보통신 이용촉진 및 정보보호 등에 관한 법률<br />
						보존기간: 6개월<br />
					</td>
				</tr>
			</tbody>
		</table><Br />

							</div>
				</div>
			</div>
		</div>

		<div class="tableDiv">
			<dl class="trOrder">
				<dd class="twoBtn">
					<a class="btnCancel" href="Cart.jsp">장바구니</a>
				</dd>
				<dd>&nbsp;</dd>
				<dd class="twoBtn" id="OrderBuyButton1">
<!-- 					<a class="btnModify" href="javascript:fnOrderReady();">결제하기</a> -->
					<a class="btnModify" href="OrderPayComplete.jsp">결제하기</a>
				</dd>
			</dl>
		</div>



	</div>
	
	<div class="clear"></div>
</div>

<script>
$(document).on("click", ".LayerTit btn", function(){
	$(".AgreeLayerFore").css("display", "none");
	$(".AgreeLayerBack").css("display", "none");
	$(".AgreeLayerFore .LayerBas").css("display", "none");
});

fnOrderAgreePop = function(x){

	if ($(window).width() < 1200) {
		$(".AgreeLayerFore .LayerBas").css("display", "none");

		$(".AgreeLayerFore").css("display", "block");
		$(".AgreeLayerBack").css("display", "block");
		$("#M_AgreeDetail_"+x).css("display", "block");	
		
		$("#M_AgreeDetail_"+x).center();
		fnTermsCtrl('1');
	}
}

fnTermsCtrl = function(x){
	if ($(window).width() < 1200) {
		$(".TermsInformMenus li").removeClass("on");
		$("#TImenu"+x).addClass("on");

		$("#TermsInform_1").css("display","none");
		$("#TermsInform_2").css("display","none");
		$("#TermsInform_3").css("display","none");
		
		$("#TermsInform_"+x).css("display","block");		
	}
}

$.fn.center = function () {		
	this.css("position","fixed");
	this.css("top",Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) ) + "px");
	return this;
}
</script>
<div class="AgreeLayerBack"></div>
<div class="AgreeLayerFore">
	<div id="M_AgreeDetail_2" class="LayerBas">
		<span class="LayerTit">결제대행서비스 약관</span>
		<div class="TermsInform">
			<div class="TermsInformMenus">
				<ol>
				<li id="TImenu1" class="on" onclick="fnTermsCtrl('1');">기본약관</li>
				<li id="TImenu2" onclick="fnTermsCtrl('2');">개인정보 수집·이용</li>
				<li id="TImenu3" onclick="fnTermsCtrl('3');">개인정보 제공·위탁</li>
				</ol>
			</div>
			<div class="TermsInformContents">
				<div id="TermsInform_1" style=" font-size:0.5rem; line-height:0.875rem;">
				제1조 (목적)<br />
				이 약관은 주식회사 케이지이니시스(이하 '회사'라 합니다)가 제공하는 전자지급결제대행서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다.<br /><br />
				제2조 (용어의 정의)	<br />
				이 약관에서 정하는 용어의 정의는 다음과 같습니다.	<br />
				1. '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스(이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.<br />
				2. '전자지급결제대행서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.<br />
				3. '결제대금예치서비스'라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제대금'이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등'이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다.<br />
				4. '이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.<br />
				5. '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, 회사에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데<br />
				필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.<br />
				6. '거래지시'라 함은 이용자가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 회사에 대하여 전자금융거래의 처리를 지시하는 것을 말합니다.<br />
				7. '오류'라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다.<br /><br />
				제3조 (약관의 명시 및 변경)<br />
				① 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.<br />
				② 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.<br />
				③ 회사가 약관을 변경하는 때에는 그 시행일 1개월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.<br /><br />
				제4조 (전자지급결제대행서비스의 종류)<br />
				회사가 제공하는 전자지급결제대행서비스는 지급결제수단에 따라 다음과 같이 구별됩니다.<br />
				1. 신용카드결제대행서비스: 이용자가 결제대금의 지급을 위하여 제공한 지급결제수단이 신용카드인 경우로서, 회사가 전자결제시스템을 통하여 신용카드 지불정보를 송,수신하고 결제대금의 정산을 대행하거나 매개하는 서비스를 말합니다.<br />
				2. 계좌이체대행서비스: 이용자가 결제대금을 회사의 전자결제시스템을 통하여 금융기관에 등록한 자신의 계좌에서 출금하여 원하는 계좌로 이체할 수 있는 실시간 송금 서비스를 말합니다.<br />
				3. 가상계좌서비스: 이용자가 결제대금을 현금으로 결제하고자 경우 회사의 전자결제시스템을 통하여 자동으로 이용자만의 고유한 일회용 계좌의 발급을 통하여 결제대금의 지급이 이루어지는 서비스를 말합니다.<br />
				4. 기타: 회사가 제공하는 서비스로서 지급결제수단의 종류에 따라 '휴대폰 결제대행서비스', 'ARS결제대행서비스', '상품권결제대행서비스'등이 있습니다.<br /><br />
				제5조 (결제대금예치서비스의 내용)<br />
				① 이용자(이용자의 동의가 있는 경우에는 재화 등을 공급받을 자를 포함합니다. 이하 본조에서 같습니다)는 재화 등을 공급받은 사실을 재화 등을 공급받은 날부터 3영업일 이내에 회사에 통보하여야 합니다.<br />
				② 회사는 이용자로부터 재화 등을 공급받은 사실을 통보받은 후 회사와 통신판매업자간 사이에서 정한 기일 내에 통신판매업자에게 결제대금을 지급합니다.<br />
				③ 회사는 이용자가 재화 등을 공급받은 날부터 3영업일이 지나도록 정당한 사유의 제시없이 그 공급받은 사실을 회사에 통보하지 아니하는 경우에는 이용자의 동의없이 통신판매업자에게 결제대금을 지급할 수 있습니다.<br />
				④ 회사는 통신판매업자에게 결제대금을 지급하기 전에 이용자에게 결제대금을 환급받을 사유가 발생한 경우에는 그 결제대금을 소비자에게 환급합니다.<br />
				⑤ 회사는 이용자와의 결제대금예치서비스 이용과 관련된 구체적인 권리,의무를 정하기 위하여 본 약관과는 별도로 결제대금예치서비스이용약관을 제정할 수 있습니다.<br /><br />
				제6조 (이용시간)<br />
				① 회사는 이용자에게 연중무휴 1일 24시간 전자금융거래 서비스를 제공함을 원칙으로 합니다. 단, 금융기관 기타 결제수단 발행업자의 사정에 따라 달리 정할 수 있습니다.<br />
				② 회사는 정보통신설비의 보수, 점검 기타 기술상의 필요나 금융기관 기타 결제수단 발행업자의 사정에 의하여 서비스 중단이 불가피한 경우, 서비스 중단 3일 전까지 게시가능한 전자적 수단을 통하여 서비스 중단 사실을 게시한 후 서비스를 일시 중단할 수 있습니다. 다만, 시스템 장애복구, 긴급한 프로그램 보수, 외부요인 등<br />
				불가피한 경우에는 사전 게시없이 서비스를 중단할 수 있습니다.<br /><br />
				제7조 (접근매체의 선정과 사용 및 관리)<br />
				① 회사는 전자금융거래 서비스 제공 시 접근매체를 선정하여 이용자의 신원, 권한 및 거래지시의 내용 등을 확인할 수 있습니다.<br />
				② 이용자는 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공할 수 없습니다.<br />
				③ 이용자는 자신의 접근매체를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며, 접근매체의 도용이나 위조 또는 변조를 방지하기 위하여 충분한 주의를 기울여야 합니다.<br />
				④ 회사는 이용자로부터 접근매체의 분실이나 도난 등의 통지를 받은 때에는 그 때부터 제3자가 그 접근매체를 사용함으로 인하여 이용자에게 발생한 손해를 배상할 책임이 있습니다.<br /><br />
				제8조 (거래내용의 확인)<br />
				① 회사는 이용자와 미리 약정한 전자적 방법을 통하여 이용자의 거래내용(이용자의 '오류정정 요구사실 및 처리결과에 관한 사항'을 포함합니다)을 확인할 수 있도록 하며, 이용자의 요청이 있는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송 등의 방법으로 거래내용에 관한 서면을 교부합니다.<br />
				② 회사가 이용자에게 제공하는 거래내용 중 거래계좌의 명칭 또는 번호, 거래의 종류 및 금액, 거래상대방을 나타내는 정보, 거래일자, 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보와 해당 전자금융거래와 관련한 전자적 장치의 접속기록은 5년간, 건당 거래금액이 1만원 이하인 소액 전자금융거래에 관한 기록,<br />
				전자지급수단 이용시 거래승인에 관한 기록, 이용자의 오류정정 요구사실 및 처리결과에 관한 사항은 1년간의 기간을 대상으로 한다.<br />
				③ 이용자가 제1항에서 정한 서면교부를 요청하고자 할 경우 다음의 주소 및 전화번호로 요청할 수 있습니다.<br />
				주소: 463-400 경기도 성남시 분당구 대왕판교로 660 유스페이스A동 5층 (주)케이지이니시스<br />
				이메일 주소: sm@inicis.com<br />
				전화번호: 1588-4954<br /><br />
				제9조 (오류의 정정 등)<br />
				① 이용자는 전자금융거래 서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대하여 그 정정을 요구할 수 있습니다.<br />
				② 회사는 전항의 규정에 따른 오류의 정정요구를 받은 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받은 날부터 2주 이내에 그 결과를 이용자에게 알려 드립니다.<br /><br />
				제10조 (회사의 책임)<br />
				① 접근매체의 위조나 변조로 발생한 사고로 인하여 이용자에게 발생한 손해에 대하여 배상책임이 있습니다. 다만 이용자가 제6조 제2항에 위반하거나 제3자가 권한 없이 이용자의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 알 수 있었음에도 불구하고 이용자가 자신의 접근매체를 누설 또는 노출하거나 방치한 경우 그 책임의 전부 또는 일부를 이용자가 부담하게 할 수 있습니다.<br />
				② 회사는 계약체결 또는 거래지시의 전자적 전송이나 처리과정에서 발생한 사고로 인하여 이용자에게 그 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다. 다만 본 조 제1항 단서에 해당하거나 법인('중소기업기본법' 제2조 제2항에 의한 소기업을 제외합니다)인 이용자에게 손해가 발생한 경우로서 회사가 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한 경우 그 책임의 전부 또는 일부를 이용자가 부담하게 할 수 있습니다.<br />
				③ 회사는 이용자로부터의 거래지시가 있음에도 불구하고 천재지변, 회사의 귀책사유가 없는 정전, 화재, 통신장애 기타의 불가항력적인 사유로 처리 불가능하거나 지연된 경우로서 이용자에게 처리 불가능 또는 지연사유를 통지한 경우(금융기관 또는 결제수단 발행업체나 통신판매업자가 통지한 경우를 포함합니다)에는 이용자에 대하여 이로 인한 책임을 지지 아니합니다.<br />
				④ 회사는 전자금융거래를 위한 전자적 장치 또는 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’ 제2조 제1항 제1호에 따른 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한 사고로 인하여 이용자에게 그 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다.<br /><br />
				제11조 (전자지급거래계약의 효력)<br />
				① 회사는 이용자의 거래지시가 전자지급거래에 관한 경우 그 지급절차를 대행하며, 전자지급거래에 관한 거래지시의 내용을 전송하여 지급이 이루어지도록 합니다.<br />
				② 회사는 이용자의 전자지급거래에 관한 거래지시에 따라 지급거래가 이루어지지 않은 경우 수령한 자금을 이용자에게 반환하여야 합니다.<br /><br />
				제12조 (거래지시의 철회)<br />
				① 이용자는 전자지급거래에 관한 거래지시의 경우 지급의 효력이 발생하기 전까지 거래지시를 철회할 수 있습니다.<br />
				② 전항의 지급의 효력이 발생 시점이란 (i) 전자자금이체의 경우에는 거래지시된 금액의 정보에 대하여 수취인의 계좌가 개설되어 있는 금융기관의 계좌이체 원장에 입금기록이 끝난 때 (ii) 그 밖의 전자지급수단으로 지급하는 경우에는 거래지시된 금액의 정보가 수취인의 계좌가 개설되어 있는 금융기관의 전자적 장치에 입력이 끝난 때를 말합니다.<br />
				③ 이용자는 지급의 효력이 발생한 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령상 청약의 철회의 방법 또는 본 약관 제5조에서 정한 바에 따라 결제대금을 반환받을 수 있습니다.<br /><br />
				제13조 (전자지급결제대행 서비스 이용 기록의 생성 및 보존)<br />
				① 회사는 이용자가 전자금융거래의 내용을 추적, 검색하거나 그 내용에 오류가 발생한 경우에 이를 확인하거나 정정할 수 있는 기록을 생성하여 보존합니다.<br />
				② 전항의 규정에 따라 회사가 보존하여야 하는 기록의 종류 및 보존방법은 제8조 제2항에서 정한 바에 따릅니다.<br /><br />
				제14조 (전자금융거래정보의 제공금지)<br />
				회사는 전자금융거래 서비스를 제공함에 있어서 취득한 이용자의 인적사항, 이용자의 계좌, 접근매체 및 전자금융거래의 내용과 실적에 관한 정보 또는 자료를 이용자의 동의를 얻지 아니하고 제3자에게 제공,누설하거나 업무상 목적 외에 사용하지 아니합니다.<br /><br />
				제15조 (분쟁처리 및 분쟁조정)<br />
				① 이용자는 다음의 분쟁처리 책임자 및 담당자에 대하여 전자금융거래 서비스 이용과 관련한 의견 및 불만의 제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다.<br />
				담당자: RM팀<br />
				연락처(전화번호, FAX): 3430-5847, 3430-5889<br />
				E-mail : inirm@inicis.com<br />
				② 이용자가 회사에 대하여 분쟁처리를 신청한 경우에는 회사는 15일 이내에 이에 대한 조사 또는 처리 결과를 이용자에게 안내합니다.<br />
				③ 이용자는 '금융감독기구의 설치 등에 관한 법률' 제51조의 규정에 따른 금융감독원의 금융분쟁조정위원회나 '소비자보호법' 제31조 제1항의 규정에 따른 소비자보호원에 회사의 전자금융거래 서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다.<br /><br />
				제16조 (회사의 안정성 확보 의무)<br />
				회사는 전자금융거래의 안전성과 신뢰성을 확보할 수 있도록 전자금융거래의 종류별로 전자적 전송이나 처리를 위한 인력, 시설, 전자적 장치 등의 정보기술부문 및 전자금융업무에 관하여 금융감독위원회가 정하는 기준을 준수합니다.<br /><br />
				제17조 (약관외 준칙 및 관할)<br />
				① 이 약관에서 정하지 아니한 사항에 대하여는 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다.<br />
				② 회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.<br />
				부칙 (2010년 4월 12일)<br />
				최초 시행일자 : 2007년 1월 1일<br />
				변경 공고일자 : 2017년 2월 20일<br />
				변경 시행일자 : 2017년 3월 22일<br /><br />
				</div>

				<div id="TermsInform_2" style="display:none; font-size:0.5rem; line-height:0.875rem;">
				1. 회사는 이용자의 개인정보를 본 개인정보처리방침에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의 없이 동 범위를 초과하여 이용하거나 이용자의 개인 정보를 제3자에게 제공하지 않습니다. 다만, 관련 법령에 의하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관 등에 개인정보를 제공하여야 하는 경우는 예외로 합니다. 회사의 서비스 이행을 위하여 개인정보를 제3자에게 제공하고 있는 경우는 다음과 같습니다.<br /><br />
				<table border="1">
					<tbody>
						<tr>
							<th style="width:28%;">제공목적</th>
							<th style="width:28%;">제공받는 자</th>
							<th style="width:29%;">제공 정보</th>
							<th style="width:15%;">보유 및 이용기간</th>
						</tr>
						<tr>
							<td>신용카드 결제</td>
							<td>
								<p>
									- 국민, 비씨, 롯데, 삼성, NH농협, 현대, 신한, 하나<br />
									- 4개 시중은행:신한, SC제일, 씨티, 하나<br />
									- 8개 특수은행 농협, 기업, 국민, 저축, 수협, 신협, 우체국, 새마을금고<br />
									- 7개 지방은행 대구, 부산, 경남, 광주, 전북, 조흥, 제주<br />
									- 1개 전업카드사:우리
								</p>
								<p>
									- 3개 제휴사: 엔에이치엔페이코 주식회사, 롯데멤버스 주식회사, 주식회사 신세계아이앤씨<br />
									- 12개 VAN사:(주)코밴, KIS정보통신, NICE정보통신, 브이피㈜, 한국신용카드결제(주), 퍼스트데이터코리아,
									㈜케이에스넷, 스타VAN, 제이티넷, KICC, 스마트로, NHN한국사이버결제 주식회사
								</p>
							</td>
							<td>
								거래정보<br />
								(비씨카드:IP포함)
							</td>
							<td style="text-align: center; vertical-align: middle;" rowspan="12">
								건당 1만원 초과 : 5년<br />
								건당 1만원 이하 : 1년
							</td>
						</tr>
						<tr>
							<td>계좌이체 결제</td>
							<td>
								- 금융결제원<br />
								- 경남/ 광주/국민/기업/농협/대구/부산/산업/새마을금고/ 수협/신한/신협/우리/우체국/전북/제주/KEB하나/씨티/SC제일은행/산림조합<br />
								- 유안타/현대/미래에셋/한투/우리투자/하이투자/HMC투자/SK/대신/하나대투/신한금융/동부/유진투자/메리츠/신영/삼성/한화/대우증권<br />
								- 주식회사 신세계아이앤씨<br />
							</td>
							<td>거래정보</td>
						</tr>
						<tr>
							<td>가상계좌 결제</td>
							<td>국민/농협/우리/신한/KEB하나/기업/우체국/부산/경남/ 대구/수협/씨티/삼성증권/SC/광주/전북</td>
							<td>거래정보</td>
						</tr>
						<tr>
							<td>휴대폰 결제</td>
							<td>(주)SKT, ㈜KT, ㈜LGU+, MVNO사업자, ㈜모빌리언스, ㈜다날</td>
							<td>
								거래정보<br />
								(모빌리언스, 다날 IP 포함)<br />
								휴대폰 번호<br />
								고유식별정보
							</td>
						</tr>
						<tr>
							<td>유선전화 결제</td>
							<td>㈜KT, ㈜인포허브</td>
							<td>
								거래정보<br />
								유선전화번호<br />
								고유식별정보
							</td>
						</tr>
						<tr>
							<td>상품권 결제</td>
							<td>한국문화진흥, 한국도서보급, 해피머니아이엔씨, 아이앤플레이</td>
							<td>
								거래정보<br />
								(한국문화진흥,해피머니아이엔씨:IP포함)
							</td>
						</tr>
						<tr>
							<td>M마일리지</td>
							<td>㈜아이엠아이</td>
							<td>거래정보</td>
						</tr>
						<tr>
							<td>포인트 결제</td>
							<td>㈜SK플래닛, GS넥스테이션주식회사, 삼성전자</td>
							<td>거래정보</td>
						</tr>
						<tr>
							<td>전자지갑 결제</td>
							<td>금융결제원, KEB하나은행, 삼성전자, 주식회사 신세계아이앤씨</td>
							<td>
								거래정보<br />
								휴대폰 번호
							</td>
						</tr>
						<tr>
							<td>해외카드(글로벌서비스 포함)</td>
							<td>VISA, MASTER, JCB, Diners, unionpay, 페이팔, 알리바바, 텐센트</td>
							<td>거래정보</td>
						</tr>
						<tr>
							<td>현금영수증 발행</td>
							<td>국세청</td>
							<td>
								거래정보<br />
								고유식별정보<br />
								휴대폰번호<br />
								카드번호
							</td>
						</tr>
						<tr>
							<td>본인 확인 인증</td>
							<td>나이스신용평가정보, 한국신용평가정보㈜, 한국신용정보, SKT, KT, LGU+, (주)코밴, KIS정보통신, NICE정보통신, 브이피㈜, 한국신용카드결제(주), 퍼스트 데이터 코리아, ㈜케이에스넷 국민/비씨/롯데/삼성/NH농협/현대/KEB하나/신한 경남/광주/국민/기업/농협/대구/부산/산업/새마을금고/ 수협/신한/신협/우리/우체국/전북/제주/씨티/SC제일</td>
							<td>
								고유식별정보<br />
								본인확인정보
							</td>
						</tr>
					</tbody>
				</table>
				<br />2. 개인정보 처리 위탁을 하는 업무의 내용 및 수탁자<br />
				회사는 이용자의 동의 없이 이용자의 개인정보를 외부 업체에 위탁하지 않습니다. 하단의 업체는 이용자에게 사전 통지 또는 동의를 얻어 위탁 업무를 대행하고 있습니다.<br /><br />
				<table border="1">
					<tbody>
						<tr>
							<th style="width: 33%;">제공목적</th>
							<th style="width: 34%;">제공받는 자</th>
							<th style="width: 33%;">제공 정보</th>
						</tr>
						<tr>
							<td>배송정보 안내서비스제공</td>
							<td>㈜굿스플로</td>
							<td style="text-align: center; vertical-align: middle;" rowspan="2">거래 정보</td>
						</tr>
						<tr>
							<td>고객상담 업무지원 위탁 수행</td>
							<td>㈜메타넷엠씨씨, ㈜제이디랩</td>
						</tr>
					</tbody>
				</table>
				<br />3. 개인정보의 제3자 제공 및 위탁 거부<br />
				이용자는 개인정보의 제3자 제공 및 위탁 동의를 거부할 수 있습니다. 단, 동의를 거부하는 경우 본 서비스 결제가 정상적으로 이루어질 수 없음을 알려드립니다.<br /><br />
				</div>

				<div id="TermsInform_3" style="display:none; font-size:0.5rem; line-height:0.875rem;">
				<!-- PAC4 begin -->
				※ 개인정보 수집 및 이용동의는 개인정보의 수집 및 이용목적, 수집항목 및 수집방법 개인정보의 보유 및 이용기간으로 별도 구분하여 표시됩니다.<br /><br />
				<table border="1">
					<tbody>
						<tr>
							<th style="width: 33%;">개인정보의 수집 및 이용목적</th>
							<th style="width: 34%;">수집항목 및 수집방법</th>
							<th style="width: 33%;">개인정보의 보유 및 이용 기간</th>
						</tr>
						<tr>
							<td>
								1) 전자금융거래서비스 제공에 관한 결제 정보 등 개인정보 수집<br />
								- 이용자가 구매한 재화나 용역의 대금 결제<br />
								- 결제 과정 중 본인 식별, 인증, 실명확인 및 이용자가 결제한 거래의 내역을 요청하는 경우 응대 및 확인<br />
								- 이용자가 결제한 거래의 취소 또는 환불, 상품 배송 등 전자상거래 관련 서비스 제공<br />
								- 이용자가 결제한 대금의 청구 및 수납<br />
								- 전자금융거래 및 통신과금 서비스 이용 불가능한 이용자(미성년자 등)와 불량, 불법 이용자의 부정 이용 방지<br />
								- 서비스 제공 및 관련 업무 처리에 필요한 동의 또는 철회 등 의사확인<br />
								- 회사가 제공하는 결제알림메일 발송<br />
								- 고객 불만 및 민원처리<br /><br />
								2) 신규 서비스 개발 및 마케팅 광고에의 활용<br />
								- 이용 빈도 파악 및 마케팅 특성에 따른 서비스 제공 및 CRM 용도<br />
								- 신규 서비스 개발 및 맞춤 서비스 제공, 통계학적 특성에 따른 서비스 제공 및 광고 게재,
								서비스의 유효성 확인, <span style="color: red;">이벤트, 광고성 정보 제공(결제알림메일 내) 및 참여기회 제공,</span> 접속빈도 파악, 회원의 서비스이용에 대한 통계<br />
							</td>
							<td>
								1) 수집항목<br />
								가. 전자금융거래서비스 이행과 관련 수집 정보<br />
								- 이용자의 고유식별번호<br />
								- 이용자의 신용카드 정보 또는 지불하고자 하는 금융기관 계좌 정보<br />
								- 이용자의 휴대폰 또는 유선 전화 번호 및 가입 통신사<br />
								- 이용자의 상품권 번호 및 상품권 회원 아이디, 비밀번호 등<br />
								- 이용자의 결제하고자 하는 포인트 카드 정보<br />
								- 이용자의 전자지갑 이용자번호 등 결제 정보<br />
								- 이용자의 접속 IP<br />
								- 이용자의 이메일<br />
								- 이용자의 상품 또는 용역 거래 정보<br />
								나. 회원가입과 관련한 수집 정보<br />
								- 성명, 생년월일, 성별, 아이디, 비밀번호, 연락처(메일주소, 휴대폰 번호), 가입인증정보<br />
								- 만 14세 미만은 법정대리인 정보, 가입인증정보<br />
								- 외국인의 경우 외국인등록번호<br />
								다. “서비스” 이용 또는 처리 과정에서 자동 혹은 수동으로 생성되어 수집되는 정보<br />
								- 이용자 IP Address, 쿠키, 서비스 접속 일시, 서비스 이용기록, 불량 혹은 비정상 이용기록, 결제기록<br /><br />
								2) 수집방법<br />
								가. 회사가 운영하는 웹사이트 혹은 회사가 제공하는 결제창에 이용자가 직접 입력<br />
								나. 회사가 제공하는 정보통신서비스의 이용 혹은 처리 과정에서 쿠키, 서비스 접속 log등이 자동으로 생성 및 수집되는 경우<br />
							</td>
							<td>
								이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기 합니다. 단, 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률 등 관련 법령에 의하여 보존할 필요가 있는 경우 관련 법령에서 정한 일정한 기간 동안 개인정보를 보존합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.<br />
								- 건당 1만원 초과 전자금융거래에 관한 기록<br />
								보존이유: 전자금융거래법<br />
								보존기간: 5년<br />
								- 건당 1만원 이하 전자금융거래에 관한 기록<br />
								보존이유: 전자금융거래법<br />
								보존기간: 1년<br />
								- 계약 또는 청약 철회 등에 관한 기록<br />
								보존이유: 전자상거래 등에서의 소비자보호에 관한 법률<br />
								보존기간: 5년<br />
								- 대금결제 및 재화 등의 공급에 관한 기록<br />
								보존이유: 전자상거래 등에서의 소비자보호에 관한 법률<br />
								보존기간: 5년<br />
								- 소비자의 불만 또는 분쟁 처리에 관한 기록<br />
								보존이유: 전자상거래 등에서의 소비자보호에 관한 법률<br />
								보존기간: 3년<br />
								- 본인확인에 관한 기록<br />
								보존이유: 정보통신 이용촉진 및 정보보호 등에 관한 법률<br />
								보존기간: 6개월<br />
							</td>
						</tr>
					</tbody>
				</table><Br />
				</div>
			</div>
		</div>
	</div>

	<div id="M_AgreeDetail_1" class="LayerBas">
		<span class="LayerTit">개인정보 제3자 정보제공 동의</span>
		<ul>
			<li>서비스 제공을 위해 아래 정보가 제공됩니다.</li>
			<li>고객님께서는 정보제공에 동의하지 않을 수 있으며,</li>
			<li>동의하지 않는경우 서비스 이용이 제한될 수 있습니다.</li>
		</ul>

		<dl>
			<dt></dt><dd>개인정보 제공 받는 자: 아트박스</dd>
			<dt></dt><dd>제공목적: 구매한 상품의 배송</dd>
			<dt></dt><dd>제공벙보: 성명, 휴대폰번호, 주소</dd>
			<dt></dt><dd>보유 및 이용기간: 서비스 제공완료 3개월 후 삭제</dd>
		</dl>
	</div>

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


<input type="hidden" id="gaPayTypeText" value="신용카드" />
<input type="hidden" id="gaPayTypeTextTemp" value="신용카드" />
<script type="text/javascript">
function fnGaSend(){
	dataLayer.push({
		'event': 'checkout',
		'ecommerce': {
			'checkout': {
				'actionField': {'step': 2, 'option':document.getElementById('gaPayTypeText').value }, //결제 정보
				'products': [ {'id':'2002200265','name':'핑크 비숑 13인치 노트북파우치 (37002786)','brand':'아트박스','category':'ARTBOXMALL > 디지털/가전 > PC 액세서리','price':25000,'quantity':1,'variant':'','coupon':'아트박스 노트북파우치 20%','dimension15':0} ]
			}
		}
	});
}
</script>


 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>
