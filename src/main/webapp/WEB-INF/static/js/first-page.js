$(function(){
	 MessageTab();
	 ToSolved();
});

function MessageTab(){
	$(".message-type").find("li").map(function(){
		$(this).click(function(){
			$(this).siblings().removeClass("current-tab");
			$(this).addClass("current-tab");
			var type = $(this).attr("data-type");
			$(".show-message").hide();
			$(".tab-"+type).show();
		});
	})
}

function ToSolved(){
	$(".to-be-solved").find("li").map(function(){
		$(this).click(function(){
			$(this).siblings().removeClass("current-tab");
			$(this).addClass("current-tab");
			var type = $(this).attr("data-type");
			$(".tab-div").hide();
			$(".solved-"+type).show();
		});
	})
}