// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
function upvote(website_id, up_arrow){
	$.post("/website/" + website_id + "/rate/up", {}, function(data){
		if($.isEmptyObject(data.status)){
			var current_score = parseInt(up_arrow.parent().children(".score").text());
			up_arrow.parent().children(".score").text((current_score + 1).toString());
		} else {
			alert("You can only vote once.");
		}
	}, "json");
}
function downvote(website_id, down_arrow){
	$.post("/website/" + website_id + "/rate/down", {}, function(data){
		if($.isEmptyObject(data.status)){
			var current_score = parseInt(down_arrow.parent().children(".score").text());
			down_arrow.parent().children(".score").text((current_score - 1).toString());
		} else {
			alert("You can only vote once.");
		}
	}, "json");
}

$(document).ready(
	function(){	
		$(".upvote").click(function() {
			upvote($(this).attr("website_id"), $(this));
		});
		$(".downvote").click(function() {
			downvote($(this).attr("website_id"), $(this));
		});
	}
);
