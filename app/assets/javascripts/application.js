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
	alert("website/" + website_id + "/rate/up");
	$.post("website/" + website_id + "/rate/up");
}
function downvote(website_id){
	alert("website/" + website_id + "/rate/down");
	$.post("website/" + website_id + "/rate/down");
}

$(document).ready(
	function(){	
		$("#testdiv").click(function() {
  		alert("Handler for .click() called.");
		});
		$(".upvote").click(function() {
			//alert($(this).attr("website_id"));
			upvote($(this).attr("website_id"));
		});
		$(".downvote").click(function() {
			//alert("Handler for .click() called.");
			downvote($(this).attr("website_id"));
		});
	}
);
