<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<title>Insert title here</title>
<style>
.c_select_td{
width:150px;
/* text-align: center; */
}

</style>
<script type="text/javascript">
$(document).ready(function(){

});


function selectCouponGroup(s){
	var st = $(":input:radio[name=f_coupongroup]:checked").val();
	$('h1').html("");
	$('h1').html(st);
	
	 $('input:checkbox[name="f_couponmemberno"]').each(function() {

	      this.checked = false; //checked 처리

	 });
	}
	
function selectCouponMember(s,v){
	$('input:radio[name=f_coupongroup]:input[value=' + s + ']').prop("checked", true);

	 var ch = $(":input:checkbox[id=f_couponmemberno_3_"+v+"]:checked").val();

// 	 alert(ch);

 var sum = 0;
 var values = document.getElementById("f_coupongroup");
 for(var i=0;i<values.length;i++){
	 if(values[i].checked){
		 alert(values[i].value);
	 }
 }
 
 
 
//checkbox의 name값이 current_product이면서 체크되어 있는 함수를 each함수로 호출한다.
// $("input[name=f_coupongroup]:checked").each(function() { 
// 	var test = $(this).val(); 
// 	alert(test);
// 	 sum += parseInt(test);
// // 	 total_sum.value = sum;
// 	 $('h1').html(sum);
// 	});



}
	
</script>
</head>
<body>
	<table width="1000" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<tr  height="30">
				<td height="33" colspan="2" >
					<table  width="1000" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td class="c_select_td">쿠폰유형</td>
								<td class="c_select_td">쿠폰이름</td>
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
			
					<table width="1000" border="0" cellspacing="0" cellpadding="0">
						<tbody>
						
			<!--  bonuscoupon 가져오는 for문 -->
			<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
			 <c:set var="myCoupon" value="${mycouponList[i].coupon_category}" />
			 <c:if test="${fn:contains(orderList, mycouponList[i].coupon_condition)}"> 
			<c:if test="${myCoupon eq 'bonuscoupon' }">
				<tr>
					<td class="c_select_td">
						<input type="radio" name="f_coupongroup" id="f_coupongroup_${i}" value="${mycouponList[i].coupon_price}" onclick="selectCouponGroup(${mycouponList[i].coupon_price})"> 
						<label for="f_coupongroup_${i}" style="cursor: pointer; cursor: hand;">
						<font color="#696969"><b>${mycouponList[i].coupon_name}</b></font></label></td>
					<td  class="c_select_td">
					<input type="checkbox" name="f_couponmemberno_1_1" id="f_couponmemberno_1_1" value="TI20060493648306" onclick="selectCouponMember(1, 1)" style="display: none;">
						
						<label for="f_coupongroup_${i}" style="cursor: pointer; cursor: hand;">3,000원 할인 쿠폰</label></td>
					<td class="c_select_td"><font color="#9e9e9e">${mycouponList[i].coupon_condition }</font></td>
					<td class="c_select_td" style="padding-right: 10px"><font color="#64ab32"><b>${mycouponList[i].coupon_price}</b></font></td>
					<td class="c_select_td"><font color="#9e9e9e">${mycouponList[i].coupon_limit }</font></td>
				</tr>
				</c:if>
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
					<table width="1000" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td  class="c_select_td" rowspan="${fn:length(mycouponList)+4}" align="left" valign="top"
									style="padding-left: 10px; letter-spacing: -1px;">
									<input type="radio" name="f_coupongroup" id="f_coupongroup_3" value="bonus" onclick="selectCouponGroup('bonus')"> <label
									for="f_coupongroup_3" style="cursor: pointer; cursor: hand;">
									<font color="#696969"><b>상품쿠폰</b></font></label></td>
								<td height="25" colspan="4" align="left" style="letter-spacing: -1px;">
								<font color="#c6c6c6">상품쿠폰은 상품당 한 쿠폰만 적용되며, 보너스쿠폰과 함께 사용하실 수 없습니다</font></td>
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
						<td  align="left"  class="c_select_td">
						<input type="checkbox" name="f_couponmemberno" id="f_couponmemberno_3_${i}" value="${mycouponList[i].coupon_price}" onclick="selectCouponMember('bonus', ${i})" style="display: inline;">
						<label for="f_couponmemberno_3_${i }" style="cursor: pointer; cursor: hand;">
						<font color="#696969">『${mycouponList[i].coupon_name}』상품<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 할인 쿠폰
							</font></label></td>
						<td  class="c_select_td">
						 <font color="#9e9e9e">${mycouponList[i].coupon_condition}</font></td>
						<td  class="c_select_td" style="padding-right: 10px">
						<font color="#64ab32"><b>${mycouponList[i].coupon_price}</b></font>
						</td>
						<td  class="c_select_td"><font
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
	
	<input id= "total_sum" name="total_sum" type="text" size="20" value=0 readonly>
	<span id="c_total"> </span>

</body>
</html>