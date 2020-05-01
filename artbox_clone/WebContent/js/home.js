$(document).ready(function(){
	 
    var topBar = $("#topBar").offset();
 
    $(window).scroll(function(){
        
        var docScrollY = $(document).scrollTop()
//        var barThis = $("#topBar")
//        var fixNext = $("#fixNextTag")
// 
//        if( docScrollY > topBar.top ) {
////            barThis.addClass("top_bar_fix");
////            fixNext.addClass("pd_top_80");
//        	barThis.addClass('fixed');
//        }else{
////            barThis.removeClass("top_bar_fix");
////            fixNext.removeClass("pd_top_80");
//        	barThis.removeClass('fixed');
//        }
        
        if ( $( document ).scrollTop() > menu.top ) {
			$( '#topBar' ).addClass( 'fixed' );
		} else {
			$( '#topBar' ).removeClass( 'fixed' );
		}
 
    });
 
})