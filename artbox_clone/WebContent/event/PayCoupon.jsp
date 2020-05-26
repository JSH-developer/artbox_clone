<%@page import="vo.CouponBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<CouponBean> myCouponList= (ArrayList<CouponBean>)request.getAttribute("mycouponList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(){
	
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
	
})
</script>
</head>
<body>
<div style="float:right;">
	<img src="${pageContext.request.contextPath}/event/cap.JPG"/>
	</div>
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
						<input type="radio" id="CouponTypeNull" name="CouponType" value="Null" checked="checked" /> 선택안함
						&nbsp;&nbsp;<span class="MobileBr"><p class="null"></p></span>
						<input type="radio" id="CouponTypeBonus" name="CouponType" value="Bonus" /> 
						보너스쿠폰 (<span id="BonusCouponTotCnt">0</span>장)
						&nbsp;&nbsp;<span class="MobileBr"><p class="null"></p></span>
						<input type="radio" id="CouponTypeGoods" name="CouponType" value="Goods" /> 
						상품쿠폰 (<span id="GoodsCouponTotCnt">0</span>장)
					</dd>
				</dl>
			</div>
			<div class="tableDiv">
				<dl class="trOrder">
					<dt>&nbsp;</dt>
					<dd>
				<!-- 	사용안함 선택했을때 -->
					<!-- 	<select id="CouponIdxSelect_Null"> 
							<option value="" selected="selected">사용안함</option>
						</select> -->
						
			<!-- 			<select name="BonusCouponIdx" id="CouponIdxSelect_Bonus" disabled="disabled" class="none">
							<option value="" alt="0" selected="selected">해당 쿠폰이 없습니다.</option>
						</select> -->
						
						<select name="BonusCouponIdx" id="CouponIdxSelect_Bonus" onchange="fnCouponSelect(this);" class="" 
						style="display: block;">
						
							<option value="" alt="0" selected="selected">선택</option>
							
							<option value="53146604" alt="5000">생일축하쿠폰</option>
						
							<option value="53146338" alt="2000">가입회원 2000원 할인 쿠폰</option>
						
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
	
</body>
</html>