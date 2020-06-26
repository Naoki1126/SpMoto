// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require activestorage
//= require turbolinks
//= require jquery
//= require rails-ujs
//= require bootstrap-sprockets
//= require bxslider
//= require_tree .


$(document).ready(function(){
	$('.fa-caret-square-down').click(function(){
		$('.nav-link').slideToggle();
	});
});

$(document).ready(function(){
	$('.fa-caret-square-down').click(function(){
		$('.user-info').animate({'left':'100%'},300);
	});
});

$(document).ready(function(){
	$('.fa-user-circle-o').click(function(){
	  if($('.fa-user-circle-o').hasClass('off')){
	   		$('.fa-user-circle-o').removeClass('off');
	    	$('.user-info').animate({'left':'69%'},300).addClass('on');
	  }else{
	    	$('.fa-user-circle-o').addClass('off');
	    	$('.user-info').animate({'left':'100%'},300);
	  }
	});
});

$(document).ready(function(){
	$('.fa-user-circle-o').click(function(){
		$('.nav-link').slideUp();
	});
});

$(document).ready(function(){
	$('.fa-bars').click(function(){
		$('.head-nav').slideToggle(true);
		
	});

	$('.fa-user').click(function(){
		$('.user-info').slideToggle(true);
	});
});

$(document).ready(function(){
	$('.fa-bars').click(function(){
		$('.user-info').slideUp();
	});

	$('.fa-user').click(function(){
		$('.head-nav').slideUp();
	});
});


$(document).ready(function(){
	$('.fa-bars').click(function(){
		$('body, html').animate({ scrollTop: 0 }, 500, 'linear');
	});
});

$(document).ready(function(){
	$('.fa-user').click(function(){
		$('body, html').animate({ scrollTop: 0 }, 500, 'linear');
	});
});




