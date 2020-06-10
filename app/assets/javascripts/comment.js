$(document).ready(function(){
	$('.show-comment-count').click(function(){
		$('.image-show-comment-box').fadeIn();
	});

	$('.show-comment-count').click(function(){
		$('html, body').animate(
        	{ scrollTop: $('body').get(0).scrollHeight },
    	);
    });

	$('.fa-window-close').click(function(){
		$('.image-show-comment-box').fadeOut();
	});
});