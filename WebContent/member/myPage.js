$(document).ready(function(){ 
	  $(".MInfo").click(function(){    
	   $(".MInfo").addClass("on");  
	   $(".Pop_Menu").slideToggle("fast");   
	  });
	 
	  $(".select .sub").mouseleave(function() {
	   $(".MInfo").removeClass("on"); 
	  $(this).hide();
	 });
	});
	

	function Pop_Menu() {
		var pop = document.getElementById("Pop_Menu");
		if(pop.style.display == 'none'){
			pop.style.display = 'block';
		}else{
			pop.style.display = 'none';
		}
	}