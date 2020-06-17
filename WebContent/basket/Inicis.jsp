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
<script type="text/javascript">

IMP.init('imp92896832'); // 가맹점식별코드

IMP.request_pay({
 pg : 'inicis', // version 1.1.0부터 지원.
 pay_method : 'card',
 merchant_uid : 'merchant_' + new Date().getTime(),
 name : '주문명:결제테스트',
 amount : 14000,
 buyer_email : 'iamport@siot.do',
 buyer_name : '구매자이름',
 buyer_tel : '010-1234-5678',
 buyer_addr : '서울특별시 강남구 삼성동',
 buyer_postcode : '123-456',
 m_redirect_url : 'https://www.yourdomain.com/payments/complete'
}, function(rsp) {
 if ( rsp.success ) {
     var msg = '결제가 완료되었습니다.';
     msg += '고유ID : ' + rsp.imp_uid;
     msg += '상점 거래ID : ' + rsp.merchant_uid;
     msg += '결제 금액 : ' + rsp.paid_amount;
     msg += '카드 승인번호 : ' + rsp.apply_num;
 } else {
     var msg = '결제에 실패하였습니다.';
     msg += '에러내용 : ' + rsp.error_msg;
 }
 alert(msg);
});
</script>
</head>
<body>
</body>
</html>