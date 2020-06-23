<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="660" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<tr height="30">
				<td height="33" colspan="2"
					background="https://img.1300k.com/order/order_table_bg.gif">
					<table width="660" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td height="14" align="center">쿠폰유형</td>
								<td width="270" align="center" class="odr_txt11">쿠폰이름</td>
								<td width="120" align="center" class="odr_txt11_a">쿠폰사용조건</td>
								<td width="80" align="center" class="odr_txt11_a">예상할인금액</td>
								<td width="70" align="center" class="odr_txt11_a">사용기한</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>

			<tr height="30">
				<td colspan="2" align="center" style="padding: 5px 0 5px 0">
			
					<table width="660" border="0" cellspacing="0" cellpadding="0">
						<tbody>
						
			<!-- 		for문 -->
			<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
			 <c:set var="myCoupon" value="${mycouponList[i].coupon_category}" />
			 
			<c:if test="${myCoupon eq 'bonuscoupon' }">
				<tr>
					<td rowspan="2" align="left" valign="top"
						style="padding-left: 10px; letter-spacing: -1px;">
						<input type="radio" name="f_coupongroup" id="f_coupongroup_1" value="BO,1" onclick="selectCouponGroup(1)"> 
						<label for="f_coupongroup_1" style="cursor: pointer; cursor: hand;">
						<font color="#696969"><b>보너스쿠폰</b></font></label></td>
					<td width="270" align="left" class="odr_txt11_a">
					<input type="checkbox" name="f_couponmemberno_1_1" id="f_couponmemberno_1_1" value="TI20060493648306" onclick="selectCouponMember(1, 1)" style="display: none;">
<!-- 						<input type="hidden" name="f_coupongroup_1_1" id="f_coupongroup_1_1" value="BO">  -->
<!-- 						<input type="hidden" name="f_coupondc_1_1" id="f_coupondc_1_1" value="3000"> -->
<!-- 						<input type="hidden" name="f_coupontitle_1_1" id="f_coupontitle_1_1" value="3,000원 할인 쿠폰">  -->
<!-- 						<input type="hidden" name="f_couponcartseq_1_1" id="f_couponcartseq_1_1" value="49846788,49458290,49846795"> -->
<!-- 						<input type="hidden" name="f_couponpaylist_1_1" id="f_couponpaylist_1_1" value="">  -->
<!-- 						<input type="hidden" name="f_coupontype_1_1" id="f_coupontype_1_1" value="N"> -->
						
						<label for="f_couponmemberno_1_1" style="cursor: pointer; cursor: hand;">3,000원 할인 쿠폰</label></td>
					<td width="120" align="center"><font color="#9e9e9e">50,000원 이상 구매</font></td>
					<td width="70" align="right" class="odr_txt11_a" style="padding-right: 10px"><font color="#64ab32"><b>3,000원</b></font></td>
					<td width="70" align="center" class="odr_txt11_a"><font color="#9e9e9e">2020.06.30</font></td>
				</tr>
				</c:if>
				
				</c:forEach>
							
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




			<tr>
				<td colspan="2" align="center" style="padding: 5px 0 10px 0">
					<table width="660" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td rowspan="6" align="left" valign="top"
									style="padding-left: 10px; letter-spacing: -1px;"><input
									type="radio" name="f_coupongroup" id="f_coupongroup_3"
									value="GD,3" onclick="selectCouponGroup(3)"> <label
									for="f_coupongroup_3" style="cursor: pointer; cursor: hand;"><font
										color="#696969"><b>상품쿠폰</b></font></label></td>
								<td height="25" colspan="4" align="left" class="odr_txt11_a"
									style="letter-spacing: -1px;"><font color="#c6c6c6">상품쿠폰은
										상품당 한 쿠폰만 적용되며, 보너스쿠폰과 함께 사용하실 수 없습니다</font></td>
							</tr>
							<tr>
								<td height="5" colspan="4"></td>
							</tr>
							<tr>
								<td height="1" colspan="4" align="left"
									background="https://img.1300k.com/order/order_bg_dot.gif"></td>
							</tr>
							<tr>
								<td height="5" colspan="4" align="left"></td>
							</tr>

			<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
			<c:set var="myCoupon" value="${mycouponList[i].coupon_category}" />
			<c:if test="${myCoupon eq 'bonuscoupon' }">
							<tr>
								<td width="270" align="left" class="odr_txt11_a">
								<input type="checkbox" name="f_couponmemberno_3_1" id="f_couponmemberno_3_1" value="TI20062259064942" onclick="selectCouponMember(3, 1)" style="display: inline;">
<!-- 								<input type="hidden" name="f_coupongroup_3_1" id="f_coupongroup_3_1" value="GD"> <input type="hidden" name="f_coupondc_3_1" id="f_coupondc_3_1" value="875"> -->
<!-- 								<input type="hidden" name="f_coupontitle_3_1" id="f_coupontitle_3_1" value="『플라워 용돈박스 (장미 목화 2종)』상품 5% 할인 쿠폰"> -->
<!-- 								<input type="hidden" name="f_couponcartseq_3_1" id="f_couponcartseq_3_1" value="49846795">  -->
<!-- 								<input hidden" name="f_couponpaylist_3_1" id="f_couponpaylist_3_1" value="">  -->
<!-- 								<input type="hidden" ntype_3_1" id="f_coupontype_3_1" value="G"> -->
								<label for="f_couponmemberno_3_1" style="cursor: pointer; cursor: hand;">
								<font color="#696969">『${mycouponList[i].coupon_name}』상품<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 할인 쿠폰
									</font></label></td>
								<td width="120" align="center">
								 <font color="#9e9e9e">${mycouponList[i].coupon_condition}</font></td>
								<td width="70" align="right" class="odr_txt11_a" style="padding-right: 10px">
								<font color="#64ab32"><b>${mycouponList[i].coupon_price}</b></font>
								</td>
								<td width="70" align="center" class="odr_txt11_a"><font
									color="#9e9e9e">${mycouponList[i].coupon_limit}</font></td>
							</tr>
			</c:if>
			</c:forEach>

						</tbody>
					</table>
				</td>
				
				
				
			</tr>
			<tr height="2">
				<td colspan="2" align="center" bgcolor="#e1e1e1"></td>
			</tr>
		</tbody>
	</table>

</body>
</html>