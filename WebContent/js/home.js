$(function(){
	var lnb = $(".pageHeader").offset().top;
	$(window).scroll(function() {
	  	var window = $(this).scrollTop();
	    if(lnb < window) {
	      $(".pageHeader").addClass("fixed");
		document.getElementById("orilogo").style.display="none";
		document.getElementById("scrlogo").style.display="block";
	    } else {
	      $(".pageHeader").removeClass("fixed");
	      document.getElementById("orilogo").style.display="block";
		document.getElementById("scrlogo").style.display="none";
	    }
	})
 
})