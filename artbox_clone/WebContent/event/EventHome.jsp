
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="vo.PageInfo"%>
<%@page import="vo.EventBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	ArrayList<EventBean> articleList=(ArrayList<EventBean>)request.getAttribute("articleList");
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
p{
text-align : center;
margin:0;
font-size: 18px;}

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
			<li class="eventMiddle"><a href="EventList.event" onclick="GA_event('HEAD', '최상단 메뉴', '인형/토이');">기획전</a></li>
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
 <div class="eventContainer">


		<%
		if(articleList != null && listCount > 0){
			// 오늘 날짜 구함
			Date nowDate = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
			int nowwDate = Integer.parseInt(sf.format(nowDate));
			
		for(int i=0;i<articleList.size();i++){
			// 저장된 이벤트 날짜 구해서 - 빼고 계산
			String startdate = articleList.get(i).getEvent_start().replaceAll("-","");
			String limitdate = articleList.get(i).getEvent_limit().replaceAll("-","");
			int startdate1 = Integer.parseInt(startdate);
			int limitdate1 = Integer.parseInt(limitdate);
			// 오늘 날짜와 이벤트 날짜 비교해서 이벤트 띄우기
			if( startdate1 <= nowwDate && limitdate1 >= nowwDate){
		%>
		
		<div class="event_content" 
		onclick="location.href='EventDetail.event?board_num=<%=articleList.get(i).getEvent_num() %>&page=<%=nowPage%>&condition=<%=articleList.get(i).getCondition()%>'">
			<div style="margin: 0 auto;">
				 
				<p><img src="${pageContext.request.contextPath}/Images/event/<%=articleList.get(i).getEvent_img() %>" width="360px" height="250px"></p>
				<p><span style="font-weight: bold;color: #262729; "><%=articleList.get(i).getEvent_titie()%></span>
				<span style="color:red;">[<%=articleList.get(i).getDiscount()%>%]</span></p>
				<p style="color: grey;font-size: 14px;"><%=articleList.get(i).getEvent_start() %>~<%=articleList.get(i).getEvent_limit() %></p>
			</div>

		</div>
		
		
		<%}else{
			// 종료된 이벤트 내용 %>
			
		<%}} %>
		
		
		
	</div>

				<section id="pageList">
		<%if(nowPage<=1){ %>
		[이전]&nbsp;
		<%}else{ %>
		<a href="EventList.event?page=<%=nowPage-1 %>">[이전]</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		[<%=a %>]
		<%}else{ %>
		<a href="EventList.event?page=<%=a %>">[<%=a %>]
		</a>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		[다음]
		<%}else{ %>
		<a href="EventList.event?page=<%=nowPage+1 %>">[다음]</a>
		<%} %>
	</section>
	<%
    }
	else
	{
	%>
	<section id="emptyArea">등록된 글이 없습니다.</section>
	<%
	}
%>
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