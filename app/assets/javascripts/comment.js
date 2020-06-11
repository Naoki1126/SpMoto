$(document).ready(function(){
	$('.show-comment-count').click(function(){
		$('.image-show-comment-box').fadeIn();
	});

	$('.fa-window-close').click(function(){
		$('.image-show-comment-box').fadeOut();
	});
});
