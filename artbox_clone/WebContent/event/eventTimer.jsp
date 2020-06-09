<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script> 


const countDownTimer = function (id, date) {
	var _vDate = new Date(date); // 전달 받은 일자
	var _second = 1000; 
	var _minute = _second * 60; 
	var _hour = _minute * 60; 
	var _day = _hour * 24; 
	var timer; 
	
	function showRemaining() { 
		var now = new Date(); 
		var distDt = _vDate - now; 
		if (distDt < 0) { 
			
			clearInterval(timer); document.getElementById(id).textContent = '해당 이벤트가 종료 되었습니다!'; 
		return; 
		} 
		
		var days = Math.floor(distDt / _day); 
		var hours = Math.floor((distDt % _day) / _hour); 
		var minutes = Math.floor((distDt % _hour) / _minute); 
		var seconds = Math.floor((distDt % _minute) / _second); 
		
		
		//document.getElementById(id).textContent = date.toLocaleString() + "까지 : "; 
		document.getElementById(id).textContent = days + '일 '; 
		document.getElementById(id).textContent += hours + '시간 '; 
		document.getElementById(id).textContent += minutes + '분 '; 
		document.getElementById(id).textContent += seconds + '초'; 
		} 
	
	timer = setInterval(showRemaining, 1000); } 
	var dateObj = new Date(); 
	dateObj.setDate(dateObj.getDate() + 1); 
	countDownTimer('sample01', dateObj); // 내일까지 
	countDownTimer('sample02', '04/01/2024 00:00 AM'); // 2024년 4월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용한다. 
	countDownTimer('sample03', '04/01/2024'); // 2024년 4월 1일까지 
	countDownTimer('sample04', '04/01/2019'); // 2024년 4월 1일까지 
	
	
	</script>



</head>
<body>
	<h1>Sample01 : 내일까지</h1>
	<h2 id="sample01"></h2>
	<br />
	<h1>Sample02 : 2024년 4월 1일까지</h1>
	<h2 id="sample02"></h2>
	<h2 id="sample03"></h2>
	<br />
	<h1>Sample03 : 종료 케이스</h1>
	<h2 id="sample04"></h2>


</body>
</html>