// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
function upvote(website_id){
	$.post("/website/" + website_id + "/rate/up", function(data){});
}
function downvote(website_id){
	$.post("/website/" + website_id + "/rate/up", function(data){});
}

$(document).ready(
	function(){
		$.each($(".upvote"), function(index, value){
			value.click(upvote(value.attr("website_id"));
		});	
		$.each($(".downvote"), function(index, value){
			value.click(downvote(value.attr("website_id"));
		});	
	}
);
