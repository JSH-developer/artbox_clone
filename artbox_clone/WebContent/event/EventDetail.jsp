
<%@page import="vo.ProductBean"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.EventBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
	ArrayList<ProductBean> itemList=(ArrayList<ProductBean>)request.getAttribute("itemList");
 	EventBean eventArticle=(EventBean)request.getAttribute("eventArticle");
    PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
<link href="${pageContext.request.contextPath}/css/front.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/event/event.css" rel="stylesheet" type="text/css">
<style>
span{
font-weight: bold;
text-align : center;
}

p{
text-align : center;margin:0;
font-size: 20px;}

</style>
</head>
<body>
<div class="page">
<!-- 헤더 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더 -->

 <!-- 메인 콘텐츠  -->
 <div class="pageContent">
 
<h1 style="text-align: center; padding: 10px auto;">이벤트</h1> 

<div id="event_main">
		<ul>
			<li class="eventMiddle"><a href="${pageContext.request.contextPath}/event/basic.jsp" onclick="GA_event('HEAD', '최상단 메뉴', '인형/토이');">기획전</a></li>
			<li class="eventMiddle"><a href="/Home/Shop/Category.asp?cdl=500&amp;cdm=256" onclick="GA_event('HEAD', '최상단 메뉴', '문구');">쿠폰존</a></li>
			<li class="eventMiddle"><a href="${pageContext.request.contextPath}/event/basic.jsp" onclick="GA_event('HEAD', '최상단 메뉴', '패션');">타임이벤트</a></li>
			<li class="eventMiddle"><a href="EventWriteForm.event" onclick="GA_event('HEAD', '최상단 메뉴', '패션');">이벤트 등록</a></li>
		</ul>
</div>

<!-- <div id="event_category"> -->
<!-- 		<ul> -->
<!-- 			<li class="CategoryMiddle"><b><a href="#"onclick="GA_event('HEAD', '최상단 메뉴', '전체');">전체</a></b></li> -->
<!-- 			<li class="CategoryMiddle"><a href="#"onclick="GA_event('HEAD', '최상단 메뉴', '인형/토이');">인형/토이</a></li> -->
<!-- 			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '문구');">문구</a></li> -->
<!-- 			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '패션');">패션</a></li> -->
<!-- 			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '주방/욕실');">주방/욕실</a></li> -->
<!-- 			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '리빙/데코');">리빙/데코</a></li> -->
<!-- 			<li class="CategoryMiddle"><a href="#" onclick="GA_event('HEAD', '최상단 메뉴', '디지털/가전');">디지털/가전</a></li> -->
			
<!-- 		</ul> -->
<!-- </div> -->

<!-- Grid -->

 <div>
 <table style="width: 1200px;height: auto;">
<tr>
<th rowspan="4">
 <img src="${pageContext.request.contextPath}/Images/event/<%=eventArticle.getEvent_img() %>" width="500px" height="250px"> 
				</th>
<th>타이틀</th>
<td><%= eventArticle.getEvent_titie()%></td>
</tr>
<tr>
<th>조건</th>
<td><%= eventArticle.getCondition()%></td>
</tr>
<tr>
<th>할인율</th>
<td><%= eventArticle.getDiscount()%>%</td>
</tr>
<tr>
<th>기간</th>
<td><%= eventArticle.getEvent_start()%>~<%= eventArticle.getEvent_limit()%></td>
</tr>
</table>
 <a href="EventModifyForm.event?board_num=<%=eventArticle.getEvent_num() %>">수정</a>
<% System.out.println("EventDetail - eventNum"+eventArticle.getEvent_num()); %>
 </div>
 <div class="eventContainer">



		<%
		if(eventArticle.getEvent_category().equals("coup_event") || eventArticle.getEvent_category().equals("sale_event")){
		if(itemList != null && listCount > 0){
		for(int i=0;i<itemList.size();i++){
			int discount = eventArticle.getDiscount();
			int realprice = itemList.get(i).getProduct_price();
			int saleprice = realprice - ((realprice * discount) /100);
			%>
			
		<div class="event_content" onclick="location.href='Eventproductview.event?product_num=<%=itemList.get(i).getProduct_num() %>&page=<%=nowPage%>'">
			<div>
				<img src="${pageContext.request.contextPath}/Images/event/<%=itemList.get(i).getProduct_image() %>" width="358px"
				height="250px">
				<p><%=itemList.get(i).getProduct_name()%></p>
				<p style="color:red;"><%=itemList.get(i).getProduct_category_code()%></p>
				<p><span style="text-decoration: line-through;color: grey;"><%=realprice %>원</span>&nbsp;
				<span style="color: black;"><%=saleprice %>원</span>&nbsp;
				<span style="color:red;">[<%=discount %>%]</span></p>
				
			</div>

		</div>
		<%} %>
	</div>

				<section id="pageList">
		<%if(nowPage<=1){ %>
		[이전]&nbsp;
		<%}else{ %>
		<a href="EventDetail.event?page=<%=nowPage-1 %>">[이전]</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		[<%=a %>]
		<%}else{ %>
		<a href="EventDetail.event?page=<%=a %>">[<%=a %>]
		</a>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		[다음]
		<%}else{ %>
		<a href="EventDetail.event?page=<%=nowPage+1 %>">[다음]</a>
		<%} %>
	</section>
	<%
    }
	else
	{
	%>
	<section id="emptyArea">등록된 글이 없습니다.</section>
	<%
	}}else{ // 타임이벤트 들어갈 자리%>
		
<%}%> 
</div>
 <!-- Grid -->
 
 
 
 </div>
 <!-- 메인 콘텐츠  -->
 
<!--  푸터 -->
 <jsp:include page="../inc/bottom.jsp"></jsp:include>
<!--  푸터 -->
</div>
</body>
</html>