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
  <link rel=" shortcut icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
  <link rel="icon" href="${pageContext.request.contextPath}/Images/common/tab.ico" type="image/x-icon">
<title>ARTBOX(포트폴리오)</title>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.0.js"></script>
<script type="text/javascript">

function itemChange(){
	 
	/* var keyboard = ["갈축","청축","적축"];
	var mouse = ["광마우스","유선마우스","비싼마우스","미키마우스"];
	var monitor = ["17인치","22인치","24인치","26인치"]; */
	 
	var selectItem = $("#select1").val();
	alert(selectItem);
	 
	var changeItem;
	  
	if(selectItem == "키보드"){
	  changeItem = keyboard;
	}
	else if(selectItem == "마우스"){
	  changeItem = mouse;
	}
	else if(selectItem == "모니터"){
	  changeItem =  monitor;
	}
	 
	
	 $('#select2').empty(); 
	 
	
// for(int i=0;i<myCouponList.size();i++){ 	
// 	 var s = myCouponList.get(i).getCoupon_name();
// // 	for(var count = 0; count < s.length; count++){                
// // 	                $('#select2').append("<option>"+changeItem[count]+"</option>");
// 	                $('#select2').append("<option>"+s+"</option>");
// 	            }
	 
// 	}
	
	
	 $.ajax('testSelect.event?value'+selectItem,{
		 success:function(rdata){
			 $(rdata).find('coup_name').each(function(){
				 $('#select2').append("<option>"+myCouponList.getCoupon_name()+"</option>");
			 });
		 }
	
	
	
}

</script>
</head>
<body>
   <select id="select1" onchange="itemChange()">
						<option>키보드</option>
						<option>마우스</option>
						<option>모니터</option>
				</select> 
			<select id="select2">
				</select>
	
</body>
</html>