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
<script src="https://code.jquery.com/jquery-latest.js"></script> 

<title>Insert title here</title>
<style>
.c_select_td {
	width: 150px;
text-align: center; 
}
td.c_select_td_name {
	width: 170px;
	/* text-align: center; */
}
#total_sum,#bonus_goods,#plus {
	border-style: none;
	width: 50px;
	color: 
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
	width: 60%; /* Could be more or less, depending on screen size */
}
</style>

<script type="text/javascript">
jQuery(document).ready(function() {
    $('#myModal').show();
});
//팝업 Close 기능
function close_pop(flag) {
 $('#myModal').hide();
};


function selectCouponGroup(s){
// 	보너스 쿠폰 bonus
	var total_sum = document.getElementById("bonus_goods");
	var st = $(":input:radio[name=f_coupongroup]:checked").val();
	total_sum.value = 0;
	
	 if(st !="bonus"){
		 
		 $('input:checkbox[name="f_couponmemberno"]').each(function() {

			 $('input:checkbox[name=f_couponmemberno]').prop('checked', false);
			 
			total_sum.value =parseInt(st);
			

		 });
	 }
	 
	}
	
function selectCouponMember(s,v){
// 	상품쿠폰  goods
	$('input:radio[name=f_coupongroup]:input[value=' + s + ']').prop("checked", true);

	 var ch = $(":input:checkbox[id=f_couponmemberno_3_"+v+"]:checked").val();
	 
	 var sum = 0;
	 var total_sum = document.getElementById("bonus_goods");
	// checkbox의 name값이 current_product이면서 체크되어 있는 함수를 each함수로 호출한다.
	$("input[name=f_couponmemberno]:checked").each(function() { 
		
		var test = $(this).val(); 
		 sum += parseInt(test);
		 total_sum.value = sum;
		});

}
	
</script>
</head>
<body>

 <div id="myModal" class="modal">
 
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
						 <c:set var="total_price111" value="25000" />
			<!--  bonuscoupon 가져오는 for문 -->
			<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
			 <c:set var="myCoupon" value="${mycouponList[i].coupon_category}" />
<%-- 			 <c:if test="${fn:contains(orderList, mycouponList[i].coupon_condition)}">  --%>
			<c:if test="${myCoupon eq 'bonuscoupon' || total_price111>mycouponList[i].coupon_condition}">
				<tr>
<!-- 				|| tps>mycouponList[i].coupon_condition} -->
					<td class="c_select_td">
						<input type="radio" name="f_coupongroup" id="f_coupongroup_b${i}" value="${mycouponList[i].coupon_price}" onclick="selectCouponGroup(${mycouponList[i].coupon_price})"> 
						<label for="f_coupongroup_b${i}" style="cursor: pointer; cursor: hand;">
						<font color="#696969"><b>보너스쿠폰</b></font></label></td>
					<td  class="c_select_td_name">
					<input type="checkbox" name="f_couponmemberno_1_1" id="f_couponmemberno_1_1" value="TI20060493648306" onclick="selectCouponMember(1, 1)" style="display: none;">
						
						<label for="f_coupongroup_${i}" style="cursor: pointer; cursor: hand;">${mycouponList[i].coupon_name}</label></td>
					<td class="c_select_td"><font color="#9e9e9e">${mycouponList[i].coupon_condition }</font></td>
					<td class="c_select_td" style="padding-right: 10px"><font color="#fc2c03"><b>${mycouponList[i].coupon_price}</b></font></td>
					<td class="c_select_td"><font color="#9e9e9e">${mycouponList[i].coupon_limit }</font></td>
				</tr>
				</c:if>
<%-- 				</c:if> --%>
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
					<table width="750" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td  class="c_select_td" rowspan="${fn:length(mycouponList)+4}" align="left" valign="top"
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
								<td height="1" colspan="4" align="left"
									background="https://img.1300k.com/order/order_bg_dot.gif"></td>
							</tr>
							<tr>
								<td height="5" colspan="4" align="left"></td>
							</tr>

			<c:forEach var="i" begin="0" end="${fn:length(mycouponList)}" step="1">
			<c:set var="myCoupon" value="${mycouponList[i].coupon_category}" />
			<c:if test="${myCoupon eq 'goodscoupon' }">
					<tr>
						<td  align="left"  class="c_select_td_name">
						<input type="checkbox" name="f_couponmemberno" id="f_couponmemberno_3_${i}" value="${mycouponList[i].coupon_price}" onclick="selectCouponMember('bonus', ${i})" >
						<label for="f_couponmemberno_3_${i }" style="cursor: pointer; cursor: hand;">
						<font color="#696969">『${mycouponList[i].coupon_name}』상품<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 할인 쿠폰
							</font></label></td>
						<td  class="c_select_td">
						 <font color="#9e9e9e">${mycouponList[i].coupon_condition}</font></td>
						<td  class="c_select_td" style="padding-right: 10px">
						<font color="#fc2c03"><b>${mycouponList[i].coupon_price}</b></font>
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
	
	보너스/상품쿠폰<input id= "bonus_goods" name="bonus_goods" type="text" size="20" value=0 readonly>원 +
	플러스 쿠폰 <input id= "plus" name="plus" type="text" size="20" value=0 readonly> =
	<input id= "total_sum" name="total_sum" type="text" size="20" value=0 readonly>
	
          <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 13pt;" > 닫기</span>
            </div>


</div>
</div>
</body>
</html>