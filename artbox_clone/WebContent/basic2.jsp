<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ARTBOX(포트폴리오)</title>
</head>
<body>
<div class="page">
<span>a</span>
<span>b</span>
<span>c</span>
</div>
<script type="text/javascript">
var currentMenu;
var menuIcon = document.querySelectorAll('.page span');


for(var i=0 ; i < menuIcon.length ; i++){
	console.log('aaaaaaaaaaaaaaaa');
	menuIcon[i].addEventListener('click',function(){
		if(currentMenu){
			currentMenu.classList.remove('on');
		}
		this.classList.add('on');
		currentMenu = this;
	});
}

</script>
</body>
</html>
